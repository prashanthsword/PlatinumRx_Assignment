def convert_minutes(m):
    hours = m // 60
    minutes = m % 60
    if hours == 1:
        return f"{hours} hr {minutes} minutes"
    return f"{hours} hrs {minutes} minutes"

print(convert_minutes(130))  # 2 hrs 10 minutes
print(convert_minutes(110))  # 1 hr 50 minutes
