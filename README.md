# Godesk

[![Build Status](https://travis-ci.org/jmosouza/godesk_api.svg?branch=master)](https://travis-ci.org/jmosouza/godesk_api)

This is Godesk Support API.
It is a RESTful API with endpoints for managing users and tickets.
The API is restricted to authenticated users.
There is an endpoint for customers to sign up.

## Stack

* Ruby 2.3
* Rails 5.0
* MySQL 5.7

## Setup

First, make sure you have installed all dependencies listed in the stack above.

If your local MySQL database is password protected, please create a `.env` file at the root of the project providing the credentials. Example:

```
DATABASE_USERNAME=your_mysql_username # defaults to root
DATABASE_PASSWORD=your_mysql_password
```

Run the following command to get up and running.

```
bin/setup
```

This will install dependencies, prepare the database and do other things.
See the file at `bin/setup` for detail.

## .env

You may have a `.env` file at the root of the project.
Use it to set local environment variables. Example:

```
DATABASE_PASSWORD=your_mysql_password
```

## Test

Use the following command to run tests.

```
rspec
```

Only models are covered at this point. Write new tests at the `specs` directory.

### What still needs coverage

* Controllers
* Integration

## Deploy

The project uses Continuous Integration and Continuous Deployment.
To deploy, simply make sure that all tests pass then commit to master or merge a Pull Request.

### Continuous Integration

Every new commit will trigger a whole test run on Travis CI.
Note that only the master branch and Pull Requests are covered. Click the "build" badge at the begining of this document to open the project page on Travis.

### Continuous Deployment

Every new commit to master that passes CI will trigger a deploy.
That includes merging Pull Requests.
This behavior is currently configured on Heroku and can be disabled anytime.

## Contributing

1. Code and test
2. Open a Pull Request
3. Wait for code review
4. Your PR will be merged when it's good to go
