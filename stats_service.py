from database import usage_collection

async def compute_statistics(user_id: str):
    user_total = 0
    user_records = 0
    user_app_counts = {}

    global_total = 0
    global_records = 0
    global_app_counts = {}
    all_user_totals = {} 

    async for record in usage_collection.find():
        uid = record.get("user_id")
        total_time = record.get("total_screen_time", 0)

        global_total += total_time
        global_records += 1

        for app in record.get("apps", []):
            name = app["name"]
            global_app_counts[name] = global_app_counts.get(name, 0) + app["duration"]

        if uid:
            all_user_totals[uid] = all_user_totals.get(uid, 0) + total_time

        if uid == user_id:
            user_total += total_time
            user_records += 1
            for app in record.get("apps", []):
                name = app["name"]
                user_app_counts[name] = user_app_counts.get(name, 0) + app["duration"]

    user_avg = round(user_total / user_records, 2) if user_records else 0
    global_avg = round(global_total / global_records, 2) if global_records else 0

    user_top_apps = sorted(user_app_counts.items(), key=lambda x: x[1], reverse=True)[:3]
    global_top_apps = sorted(global_app_counts.items(), key=lambda x: x[1], reverse=True)[:3]


    sorted_totals = sorted(all_user_totals.values())
    users_better = sum(1 for t in sorted_totals if t > user_total)
    percentile = round((users_better / len(sorted_totals)) * 100, 2) if sorted_totals else 0

    return {
        "userStats": {
            "totalScreenTime": user_total,
            "averageScreenTime": user_avg,
            "topApps": [{"name": name, "duration": duration} for name, duration in user_top_apps],
            "percentile": percentile
        },
        "globalStats": {
            "totalScreenTime": global_total,
            "averageScreenTime": global_avg,
            "topApps": [{"name": name, "duration": duration} for name, duration in global_top_apps]
        }
    }