import pandas as pd

data = {
    'Name': ['John', 'Mark', 'Bob'],
    'Age': [12, 34, 45],
    'Address': ['123 Main St.', '345 Weldon St', '75 Boylston St']
}

df = pd.DataFrame(data)
df.to_parquet('sample_par.parquet')
