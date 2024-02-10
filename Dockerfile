FROM continuumio/miniconda3

COPY . /app

# Set working directory
WORKDIR /app

RUN apt-get update
RUN apt-get install nano unzip
RUN apt install curl -y

RUN pip install -r requirements.txt

EXPOSE $PORT

# Command to run the API with gunicorn
CMD gunicorn --workers=4 --bind 0.0.0.0:$PORT app:app 

