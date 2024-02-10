FROM continuumio/miniconda3

# Set working directory
WORKDIR /home/app

# Copy requirements file and install dependencies
COPY requirements.txt /dependencies/requirements.txt
RUN pip install -r /dependencies/requirements.txt

# Copy the entire project directory
COPY . .

# Command to run the API with gunicorn
CMD gunicorn api:app  --bind 0.0.0.0:$PORT --worker-class uvicorn.workers.UvicornWorker 
