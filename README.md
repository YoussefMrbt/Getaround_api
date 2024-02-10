# Flask API for Vehicle Price Prediction

This Flask API provides an interface for predicting vehicle prices based on various features including make, mileage, engine power, and more.
The API is built using a machine learning model trained on historical vehicle data.

## Requirements

Docker (if running via Docker container)
Python 3.7 or later (if running locally without Docker)
Flask/FastAPI
Other Python libraries as specified in requirements.txt

## Running the API

### Using Docker

- Build the Docker image:
  docker build -t api .
- Run the Docker container:
  docker run -p 5000:5000 -e PORT=5000 api

### Running Locally

- Install dependencies:
  pip install -r requirements.txt
- Start the Flask application:
  python Getaround_api.py

## Deployed Heroku App

You can make vehicle price predictions by sending POST requests with the appropriate JSON payload. Here's a detailed guide:

1. Heroku URL /docs: https://api-price-pred-a5a89da5de84.herokuapp.com/docs#/
2. **Prepare your POST request** : You need to send a POST request to your Heroku app's `/predict` endpoint with a JSON payload containing the features of the vehicle for which you want to predict the price. Ensure your request is formatted correctly according to the API documentation you provided.
3. **Send the POST request** : Use a tool like `curl` in the command line, Postman, or any HTTP client in a programming language of your choice to send the request. Here is an example using `curl`:

## Making Predictions

To make a prediction, you need to send a POST request with a JSON payload that contains the input features. The expected format and value ranges for each feature are detailed below:

## Request Format

### Locally:

```bash
curl -X POST -H "Content-Type: application/json" -d "{\"features\": [\"Brand\", Mileage, EnginePower, \"Fuel\", \"Paint\", \"Type\", Parking, GPS, AC, Automatic, Connected, SpeedRegulator, WinterTires]}" http://localhost:5000/predict
```

### On Heroku:

```bash
curl -X POST -H "Content-Type: application/json" -d "{\"features\": [\"BMW\", 344599, 89, \"diesel\", \"beige\", \"estate\", 0, 0, 1, 1, 0, 0, 0]}" https://api-price-pred-a5a89da5de84.herokuapp.com/predict
```


- Brand: String. Allowed values include: 'Citroën', 'Peugeot', 'PGO', 'Renault', 'Audi', 'BMW', 'Ford', 'Mercedes', 'Opel', 'Porsche', 'Volkswagen', 'KIA Motors', 'Alfa Romeo', 'Ferrari', 'Fiat', 'Lamborghini', 'Maserati', 'Lexus', 'Honda', 'Mazda', 'Mini', 'Mitsubishi', 'Nissan', 'SEAT', 'Subaru', 'Suzuki', 'Toyota', 'Yamaha'.
- Mileage: Integer. Range: [0, 1000376].
- EnginePower: Integer. Range: [0, 423].
- Fuel: String. Allowed values: 'diesel', 'petrol', 'hybrid_petrol', 'electro'.
- Paint: String. Allowed colors: 'black', 'grey', 'white', 'red', 'silver', 'blue', 'orange', 'beige', 'brown', 'green'.
- Type: String. Allowed types: 'convertible', 'coupe', 'estate', 'hatchback', 'sedan', 'subcompact', 'suv', 'van'.
- Parking: Binary (0 or 1).
- GPS: Binary (0 or 1).
- AC: Binary (0 or 1).
- Automatic: Binary (0 or 1).
- Connected: Binary (0 or 1).
- SpeedRegulator: Binary (0 or 1).
- WinterTires: Binary (0 or 1).

## Response

The API responds with the predicted vehicle price, in a JSON format like:
{
  "predicted_price": VALUE
}

## Note

This API is for demonstration purposes and runs in a development server. For production use, consider deploying with a WSGI server such as Gunicorn.

## License

Specify your license or state that the project is unlicensed.
