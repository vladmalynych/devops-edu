FROM python:3-alpine

WORKDIR /app

COPY app .
RUN pip install -r /app/requirements.txt

EXPOSE 8000
EXPOSE 5555

CMD ["python", "/app/app.py"]