from fastapi import APIRouter
from app.models.email_model import EmailRequest
from app.services.email_service import generate_email

router = APIRouter()

@router.post("/generate-email")
def create_email(data: EmailRequest):
    email = generate_email(
        data.purpose,
        data.tone
    )

    return {
        "generated_email": email
    }