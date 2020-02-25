# Zé Delivery - Backend Challenge

This repository contains an application design for the requested project in the Zé Delivery - Backend Challenge, better described in [here](https://github.com/ZXVentures/ze-code-challenges/blob/master/backend.md).

## Introduction

The application was developed using Ruby as the programming language, and Rails as the main development framework. As requested, a REST API was created, and its functionalities include creating a partner and fetching it by its ID, as well as searching for the nearest partner by a giving location, while providing coordinates.

**OBS:** I have also created an endpoint to create multiple partners at once, to help the task of correcting the test.

Besides that, and also to make the test easier to correct, I have set up Docker containers in the application infrastructure, making the building process easier. As you can see on the docker-compose file, the application contains two services: one for the application itself, and one for a PostgreSQL database.

## Setup

Since I have used Docker to mount the application's infrasctrucure, it is really easy to set up the project. You will only need `docker` and `docker-compose` installed in your local OS.

With that said, to run the application, you can simply clone this repository and run a couple of docker commands:

```
# docker-compose build
# docker-compose run development rails db:prepare
# docker-compose up
```

That's it!

The above commands will build the application on a development environment, then they will prepare the database to be used, and finally they will run the application on port 3000.

## Running the test suite

As requested, I have developed a unit test suite, using **rspec**, to ensure the application runs smoothly. To run it, use the following command:

```
# docker-compose run development rspec
```

There are tests to ensure that some fields are required, the document is unique, a partner can be created, latitude and longitude have to be float numbers, and etc.

Everything should pass!

## Testing the API endpoints

With the application running, it is time to test the API through its endpoints. With your favourite REST client, it is possible to make the following requests:

### 1. Creating partner(s)

- POST: http://127.0.0.1:3000/partners

This request can be used to create a single partner or several partners at once. It will depend on the data you send. There is an example of a single partner object below:

```json
{
  "tradingName": "Adega da Cerveja - Pinheiros",
  "ownerName": "Zé da Silva",
  "document": "1432132123891/0001",
  "coverageArea": { 
    "type": "MultiPolygon", 
    "coordinates": [
      [[[30, 20], [45, 40], [10, 40], [30, 20]]], 
      [[[15, 5], [40, 10], [10, 20], [5, 10], [15, 5]]]
    ]
  },
  "address": { 
    "type": "Point",
    "coordinates": [-46.57421, -21.785741]
  },
}
```

To create multiple partners at once, just send the whole data from this [json](https://raw.githubusercontent.com/ZXVentures/ze-code-challenges/master/files/pdvs.json) (as it is), via the same POST request. It will create a partner for each object in the array.

**IMPORTANT:** Do not change the data from the json in any way. Just copy everything from the link above and send it in the body of the request - it will work.

### 2. Fetching partner by its ID

- GET - http://127.0.0.1:3000/partners/:id

Once you have created the partners, you can fetch them individually by its ID's, through this second endpoint.

### 3. Searching nearest partner

- GET: http://127.0.0.1:3000/partners/search/:lng/:lat

To search the nearest partner of an address, you can pass the coordinates (longitude and latitude) as the parameters of the request mentioned above. The application will check in which partner's coverageArea the address is inside, and it will return the list of partners available to deliver to it, in order of distance (straight line), with the first one on the list being the closest to the address.

After creating the partners using the json data mentioned on step 1, the following request can be used to search for an address with partners within coverage area: `http://127.0.0.1:3000/partners/search/-46.62345/-23.54321`

## Conclusion

As requested, the API provides a way to search the nearest partner, while giving a specific location. I have tried my best to cover it with tests and to make it easy to deploy in the short time I had to develop it. There are a lot of other unit tests which I was not able to cover, however I hope what I did is enough to show my skills.
