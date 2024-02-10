FROM continuumio/miniconda3

# Copy the current directory contents into the container at /app
COPY . /app

# Set the working directory to /app
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y nano unzip curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install Python dependencies
RUN pip install -r requirements.txt

# Set a default port
ARG PORT=8000
ENV PORT=${PORT}
EXPOSE ${PORT}

# Use Uvicorn workers to run the FastAPI app
CMD gunicorn --workers=4 --worker-class=uvicorn.workers.UvicornWorker --bind 0.0.0.0:${PORT} app:app


