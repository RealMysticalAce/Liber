from fastapi import FastAPI
from models import UsageRecord
from database import usage_collection

app = FastAPI()

@app.get("/health")
def health():
    return {"status": "ok"}

@app.get("/status")
def status():
    return {"status": "Bonjour SIM!!!!"}

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