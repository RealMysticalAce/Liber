from pydantic import BaseModel
from pydantic import Field
from typing import List

class AppUsage(BaseModel):
    name: str
    duration: int

class UsageRecord(BaseModel):
    user_id: str = Field(..., alias="userId")
    date: str
    apps: List[AppUsage]