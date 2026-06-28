import pandas as pd
import sys


sys.stdout.reconfigure(encoding="utf-8")


path = r"C:\Users\Usuario\Downloads\Confirmacao Presenca Loja 3437.xlsx"
xl = pd.ExcelFile(path)

print("SHEETS:", xl.sheet_names)

for sheet_name in xl.sheet_names:
    df = pd.read_excel(path, sheet_name=sheet_name, dtype=object)
    print("---", sheet_name, df.shape)
    print("COLUMNS:", [str(column) for column in df.columns])
    print(df.head(8).to_string(index=False))
