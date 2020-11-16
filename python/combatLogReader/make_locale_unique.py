import pandas as pd
import pyperclip
# This file is only useful if something has gone wrong and locale_dump.txt is filled with non-unique enemies
# Simply run it, and any duplicates will be trimmed to just one of each
locale_unique = pd.read_csv("locale_dump.txt", names=["text"], header=None).text.unique().tolist()
with open("locale_dump.txt", "w") as f:
    for item in locale_unique:
        f.write(f"{item}\n")

output = f"\n".join(locale_unique)
pyperclip.copy(output)

