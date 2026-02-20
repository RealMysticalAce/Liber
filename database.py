import os
from motor.motor_asyncio import AsyncIOMotorClient
from dotenv import load_dotenv

# Load variables from .env
load_dotenv()

MONGO_DETAILS = os.getenv("MONGO_DETAILS")

client = AsyncIOMotorClient(MONGO_DETAILS)
db = client.screentime
usage_collection = db.usage