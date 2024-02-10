FROM continuumio/miniconda3

# Set working directory
WORKDIR /home/app

RUN apt-get update
RUN apt-get install nano unzip
RUN apt install curl -y

RUN curl -fsSL https://get.deta.dev/cli.sh | sh

# Copy requirements file and install dependencies
COPY requirements.txt /app/requirements.txt
RUN pip install -r /app/requirements.txt


# Copy the entire project directory
COPY . /app

# Command to run the API with gunicorn
CMD ["gunicorn", "api:app", "--bind", "0.0.0.0:5000", "--worker-class", "uvicorn.workers.UvicornWorker"]

