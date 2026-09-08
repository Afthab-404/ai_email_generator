from ollama import chat

def generate_email(purpose, tone):

    prompt = f"""
    Write a {tone} email.

    Purpose:
    {purpose}
    """

    response = chat(
        model="llama3.2",
        messages=[
            {
                "role": "user",
                "content": prompt
            }
        ]
    )

    return response["message"]["content"]