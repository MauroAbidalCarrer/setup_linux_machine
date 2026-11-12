# /// script
# requires-python = ">=3.11"
# dependencies = [
#     "pandas>=2.0",
# ]
# ///

import sys
import json

import pandas as pd


COLUMNS = [
       'id',
       'gpu_name',
       'gpu_ram', 
       'geolocation',
       'cpu_ram',
       'dph_total',
       'storage_cost',
]

offers = pd.DataFrame.from_records(json.load(sys.stdin))
print(offers.loc[:, COLUMNS].to_string(index=False))
