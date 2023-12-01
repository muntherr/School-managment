from __future__ import annotations
from datetime import datetime, timedelta
from fastapi.encoders import jsonable_encoder
from pydantic import Field
from pydantic.main import BaseModel

class Course(BaseModel):
    id: str = Field(None, alias="_id")
    courseName: str  # Added type annotation
    instructor: str  # Added type annotation
    startDate: datetime  # Added type annotation
    endDate: datetime  # Added type annotation

    def to_json(self):
        return jsonable_encoder(self, exclude_none=True)

    def to_bson(self):
        data = self.model_dump(by_alias=True, exclude_none=True)
        if data["id"] is None:
            data.pop("id")
        return data
    
