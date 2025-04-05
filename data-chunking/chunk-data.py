import pandas as pd

df = pd.read_csv("matches.csv")

for season in df["season"].unique().tolist():
    file_name = f"matches_{season.replace('/','_')}.csv"
    print(file_name)
    df_season = df[df["season"] == season].copy()
    df_season.to_csv(file_name, index=False)
