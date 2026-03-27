import asyncio
import random
from datetime import datetime, timedelta
from database import usage_collection

# Configuration
NUM_USERS = 10
APPS = ["Instagram", "YouTube", "Safari", "TikTok", "Balatro", "Facebook", "Snapchat", "Clash Royale", "Chrome", "Grindr"]

async def generate_weekly_data():
    for i in range(1, NUM_USERS + 1):
        user_id = f"{i:04d}"
        print(f"Generating data for user {user_id}...")

        for day_offset in range(7, 0, -1):  
            date = (datetime.now() - timedelta(days=day_offset)).strftime("%Y-%m-%d")
            num_apps = random.randint(3, 5)
            apps = []

            for _ in range(num_apps):
                app_name = random.choice(APPS)
                duration = random.randint(10, 300) 
                apps.append({"name": app_name, "duration": duration})

            total_screen_time = sum(app["duration"] for app in apps)

            record = {
                "user_id": user_id,
                "date": date,
                "apps": apps,
                "total_screen_time": total_screen_time
            }

            await usage_collection.insert_one(record)
            print(f"  Inserted: {date} | total {total_screen_time} mins")

    print("Finished generating weekly test data.")

asyncio.run(generate_weekly_data())