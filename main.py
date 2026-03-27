from fastapi import FastAPI
from models import UsageRecord
from database import usage_collection
from fastapi import HTTPException
from fastapi import Query
from bson import ObjectId, errors
from stats_service import compute_statistics

app = FastAPI()
@app.get("/status")
def status():
    return {"status": "ok"}

@app.get("/test")
def test():
    return {"réponse": "Bonjour SIM!"}

@app.get("/usage/all")
async def get_all_usage():
    usages = []
    async for record in usage_collection.find():
        record["_id"] = str(record["_id"])
        # Show userId in camelCase, or None if missing
        record["userId"] = record.pop("user_id", None)
        record["totalScreenTime"] = record.pop("total_screen_time", 0)
        usages.append(record)
    return usages


@app.get("/usage/{user_id}")
async def get_usage(user_id: str):
    usages = []
    async for record in usage_collection.find({"user_id": user_id}):
        record["_id"] = str(record["_id"])
        record["userId"] = record.pop("user_id")
        record["totalScreenTime"] = record.pop("total_screen_time")
        usages.append(record)
    return usages


@app.post("/usage")
async def create_usage(record: UsageRecord):
    
    total = sum(app.duration for app in record.apps)


    data = record.dict()
    data["total_screen_time"] = total

    try:
        # MongoDB
        result = await usage_collection.insert_one(data)
        return {
            "message": "Usage saved",
            "id": str(result.inserted_id),
            "userId": record.user_id,
            "totalScreenTime": total
        }
    except Exception as e:
        return {"message": "Connection failed", "error": str(e)}
    
@app.delete("/usage/{usage_id}")
async def delete_usage(usage_id: str):
    try:
        obj_id = ObjectId(usage_id)
    except errors.InvalidId:
        raise HTTPException(status_code=400, detail="Invalid ID format")

    result = await usage_collection.delete_one({"_id": obj_id})
    if result.deleted_count == 1:
        return {"message": f"Usage {str(obj_id)} deleted successfully"}
    else:
        raise HTTPException(status_code=404, detail="Usage not found")
    
@app.get("/stats/{user_id}")
async def get_stats(user_id: str):
    stats = await compute_statistics(user_id)
    return stats