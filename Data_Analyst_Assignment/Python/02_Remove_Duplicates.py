def remove_duplicates(s):
    unique = ""
    for ch in s:
        if ch not in unique:
            unique += ch
    return unique

print(remove_duplicates("banana"))  # ban
