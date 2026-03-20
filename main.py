from fastapi import FastAPI
from models import UsageRecord
from database import usage_collection
from fastapi import HTTPException
from bson import ObjectId, errors
from fastapi import FastAPI
from stats_service import compute_statistics

app = FastAPI()

@app.get("/health")
def health():
    return {"status": "ok"}

@app.get("/status")
def status():
    return {"status": "Bonjour SIM!!!!"}

@app.get("/usage")
async def get_usage():
    usages = []
    async for record in usage_collection.find():
        record["_id"] = str(record["_id"])  # Convert ObjectId to string
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
            "total_screen_time": total
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
        return {"message": "Usage deleted successfully"}
    else:
        raise HTTPException(status_code=404, detail="Usage not found")
    
@app.get("/stats")
async def get_stats():
    stats = await compute_statistics()
    return stats