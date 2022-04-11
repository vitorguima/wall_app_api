# Wall app API

## How to run this project on your computer

### Before running the project, certify you have the necessary dependencies installed in your computer:

* [Ruby 3.1.1](https://www.ruby-lang.org/en/)
* [Rails 7.0.2](https://guides.rubyonrails.org/v5.0/getting_started.html)
* [Bundler](https://bundler.io/) 

### After installing all the required dependencies:

* Create a ```.env``` file inside the project's root folder with the same variables that have been defined in the [.env.example](https://github.com/vitorguima/wall_app_api/blob/1c7e59d2a292881418ce437d5f31d79bf32f5cf1/.env.example) file.

## How does wall api works

### Registering
The first step to use the Wall API is to create a user by sending a request to the following endpoint:

* [Create a new user](https://documenter.getpostman.com/view/17493490/UVyswbBW#da418252-3fd1-4ac3-bcf8-b0296113aa9f)

### Authenticating
After creating an user, you must authenticate yourself before start making new requests to the Wall API.
As the API works with JWT credentials, every request that changes data in our database must cointain a valid token at it's header.

* [Get a valid token](https://documenter.getpostman.com/view/17493490/UVyswbBW#6f251e28-1d47-4cc5-abe1-d99e16c8043c)

### API complete documentation
After registering and authenticating an user will be able to CREATE, DELETE and UPDATE new posts.
All available endpoints and it's required parameters are documented in the link below:

* [Postman Collection](https://documenter.getpostman.com/view/17493490/UVyswbBW)

## Endpoints collection

## Tests
```bash
rspec spec --format documentation
```

## External libraries
* 
