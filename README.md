# SRE Bootcamp - CIDR/Mask Converter
## _Wizeline SRE Upskiling_

[![Build Status](https://travis-ci.org/joemccann/dillinger.svg?branch=master)](https://travis-ci.org/joemccann/dillinger)


## Installation

First clone the repository in your local machine
```sh
git clone git@github.com:lscantillowl/mask-converter.git
cd mask-converter
```

Install the images from docker.

```sh
docker pull lscantillo/academy-sre-bootcamp-luis-cantillo
```

Then run docker compose to start the containers

```sh
docker-compose up
```

## Documentation

The route http://localhost:3000/api-docs/index.html has the api reference

## Endpoints
### Login
 ```sh
/api/v1/auth/login
```
- Response:
```sh
{
    data: <token>
}
```
- Body params:
  -- username
  -- password
  User for testing:
  --username:noadmin
  --password:noPow3r

### Convert Mask to CIDR
 ```sh
api/v1/converter/mask_to_cidr?mask=255.255.0.0
```
- Authorization: Bearer <Token>
- Response:
```sh
{
    "function": "mask_to_cidr",
    "input": "255.255.0.0",
    "output": 16
}
```
### Convert CIDR to Mask
 ```sh
api/v1/converter/cidr_to_mask?cidr=18
```
- Authorization: Bearer <Token>
- Response:
```sh
{
    "function": "cidr_to_mask",
    "input": "18",
    "output": "255.255.192.0"
}
```

## License

MIT