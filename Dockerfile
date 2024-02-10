FROM continuumio/miniconda3

# Set working directory
WORKDIR /home/app

RUN apt-get update
RUN apt-get install nano unzip
RUN apt install curl -y

RUN curl -fsSL https://get.deta.dev/cli.sh | sh
# Copy requirements file and install dependencies
COPY requirements.txt /dependencies/requirements.txt
RUN pip install -r /dependencies/requirements.txt


# Copy the entire project directory
COPY . .

# Command to run the API with gunicorn
CMD ["gunicorn", "api:app", "--bind", "0.0.0.0:5000", "--worker-class", "uvicorn.workers.UvicornWorker"]
