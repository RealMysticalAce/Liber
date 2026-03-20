from database import usage_collection

async def compute_statistics():
    total_screen_time = 0
    total_records = 0
    app_usage_counts = {}

    async for record in usage_collection.find():
        total_records += 1
        total_screen_time += record.get("total_screen_time", 0)
        for app in record.get("apps", []):
            name = app["name"]
            app_usage_counts[name] = app_usage_counts.get(name, 0) + app["duration"]

    average_screen_time = total_screen_time / total_records if total_records > 0 else 0
    top_apps = sorted(app_usage_counts.items(), key=lambda x: x[1], reverse=True)[:3]

    return {
        "total_records": total_records,
        "total_screen_time": total_screen_time,
        "average_screen_time": average_screen_time,
        "top_apps": [{"name": name, "duration": duration} for name, duration in top_apps]
    }