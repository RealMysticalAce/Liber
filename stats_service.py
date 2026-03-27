from database import usage_collection

async def compute_statistics(user_id: str):
    total_screen_time = 0
    total_records = 0
    app_usage_counts = {}

    async for record in usage_collection.find({"user_id": user_id}):
        total_records += 1
        total_screen_time += record.get("total_screen_time", 0)

        for app in record.get("apps", []):
            name = app["name"]
            app_usage_counts[name] = app_usage_counts.get(name, 0) + app["duration"]

    average_screen_time = round(total_screen_time / total_records, 2) if total_records > 0 else 0
    top_apps = sorted(app_usage_counts.items(), key=lambda x: x[1], reverse=True)[:3]

    return {
        "totalRecords": total_records,
        "totalScreenTime": total_screen_time,
        "averageScreenTime": average_screen_time,
        "topApps": [{"name": name, "duration": duration} for name, duration in top_apps]
    }