# Wall app API

## API deploy at Heroku:

* [Link to Production environment](https://www.wall-app-api.herokuapp.com/)

## How to run this project on your local environment

### Clone this repository to your local environment:

```bash
git clone git@github.com:vitorguima/wall_app_api.git
```

### Before running the project, certify you have the necessary dependencies installed in your computer:

* [Ruby 3.1.1](https://www.ruby-lang.org/en/)
* [Rails 7.0.2](https://guides.rubyonrails.org/v5.0/getting_started.html)
* [Bundler](https://bundler.io/) 

### After installing all the required dependencies:

* Create a ```.env``` file inside the project's root folder with the same variables that have been defined in the [.env.example](https://github.com/vitorguima/wall_app_api/blob/1c7e59d2a292881418ce437d5f31d79bf32f5cf1/.env.example) file.
* Access the project's root folder, open a new terminal and run the following command: ``` bundle install```
* After installing the project's dependencies, run: ```bin/rails start```

## Tests
The tests are of the integration type. Those were written to validate the behavior of the application for the different endpoints of this API.
As the tests validates the request flow and it's outputs, all of those are based on the expectations for each endpoint and the tested http method.

### To run the tests:
Open a new bash inside the project's root folder and run the command below:

```bash
rspec spec --format documentation
```

## How does Wall API works

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

## External libraries

* [bcrypt](https://github.com/bcrypt-ruby/bcrypt-ruby): to encode passwords.
* [JWT](https://github.com/jwt/ruby-jwt): to handle access tokens.
* [rspec](https://github.com/rspec/rspec-rails): to implement tests.
* [dotenv](https://github.com/bkeepers/dotenv): to import environment variables from .env.
* [Factory bot](https://github.com/thoughtbot/factory_bot): support for multiple build strategies (saved instances, unsaved instances, attribute hashes, and stubbed objects).

## Concerns
* Endpoints that retrieves a generic list with no pagination rule. If this list increase too much, the API will always be retrieving all the data from the database and consuming a lot of resource.
* It's possible to register a new user with a fake email (there's no validation service for that)
* The mailer service is using my personal email (no service like sendgrid was used on this pilot)

## Thank you!
Thanks for the opportunity of building this app, TSL! I hope you like the results!
