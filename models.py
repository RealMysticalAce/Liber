from pydantic import BaseModel
from typing import List

class AppUsage(BaseModel):
    name: str
    duration: int # minutes

class UsageRecord(BaseModel):
    date: str
    apps: List[AppUsage]

