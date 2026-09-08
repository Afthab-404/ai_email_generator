from pydantic import BaseModel

class EmailRequest(BaseModel):
    purpose: str
    tone: str
    email_type: str
     