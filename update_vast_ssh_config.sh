
#!/usr/bin/env bash
set -eu pipefail

CONFIG_DIR="$HOME/.ssh/config.d"
CONFIG_FILE="$CONFIG_DIR/vastai.conf"
IDENTITY_FILE="$HOME/.ssh/vast_ai_key"

mkdir -p "$CONFIG_DIR"
chmod 700 "$HOME/.ssh" "$CONFIG_DIR"

for cmd in vastai jq; do
    if ! command -v "$cmd" >/dev/null 2>&1; then
        echo "Error: '$cmd' is required." >&2
        exit 1
    fi
done

# Get instance IDs.
instances_json=$(vastai show instances --raw) || {
    echo "Error: failed to retrieve instances." >&2
    exit 1
}

instance_ids=$(printf '%s\n' "$instances_json" | jq -r '.[].id // empty') || {
    echo "Error: failed to parse instance IDs." >&2
    exit 1
}

if [ -z "$instance_ids" ]; then
    echo "Error: no instances found." >&2
    exit 1
fi

tmp_file=$(mktemp "$CONFIG_DIR/.vastai.conf.XXXXXX")
trap 'rm -f "$tmp_file"' EXIT

index=0

while IFS= read -r instance_id; do
    [ -n "$instance_id" ] || continue

    if [ "$index" -eq 0 ]; then
        host="vast"
    else
        host="vast_$index"
    fi

    ssh_url=$(vastai ssh-url "$instance_id") || {
        echo "Error: failed to get SSH URL for instance $instance_id." >&2
        exit 1
    }

    # Parse ssh://root@IP:PORT
    if printf '%s\n' "$ssh_url" |
        grep -Eq '^ssh://root@[^:/]+:[0-9]+$'; then
        address=$(printf '%s\n' "$ssh_url" |
            sed -E 's#^ssh://root@([^:/]+):[0-9]+$#\1#')
        port=$(printf '%s\n' "$ssh_url" |
            sed -E 's#^ssh://root@[^:/]+:([0-9]+)$#\1#')
    else
        echo "Error: unexpected SSH URL: $ssh_url" >&2
        exit 1
    fi

    {
        printf 'Host %s\n' "$host"
        printf '    User root\n'
        printf '    HostName %s\n' "$address"
        printf '    Port %s\n' "$port"
        printf '    ForwardAgent yes\n'
        printf '    IdentityFile %s\n\n' "$IDENTITY_FILE"
    } >> "$tmp_file"

    printf 'Added %s -> %s:%s (instance %s)\n' \
        "$host" "$address" "$port" "$instance_id"

    index=$((index + 1))
done <<EOF
$instance_ids
EOF

chmod 600 "$tmp_file"
mv "$tmp_file" "$CONFIG_FILE"
trap - EXIT

echo "SSH configuration updated: $CONFIG_FILE"
