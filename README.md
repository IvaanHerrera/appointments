# Appointment Scheduling System

This project serves as a test for a job application. It is a Rails-based system running inside Docker for managing appointment scheduling.

## Table of Contents
1. [Installation](#installation)
   - [Installing Docker](#installing-docker)
2. [Running the Project](#running-the-project)
3. [Running Tests](#running-the-project)
4. [Technology Stack](#technology-stack)

---

## Installation

### Installing Docker
To run this project, you need to have Docker installed on your system. Follow the official installation guide for your operating system:
- [Docker Installation Guide](https://docs.docker.com/get-docker/)

---

## Running the Project
Once Docker and Docker Compose are installed, clone the repository and navigate into the project directory:
```sh
git clone https://github.com/IvaanHerrera/appointments.git
cd appointments
```

### Copy an example .env file because the real one is git ignored:

```
cp .env.example .env
```

### Start the application with:
```sh
docker compose up --build
```
This command builds and runs the necessary containers.


### To run migrations and prepare the database:
```
# You can run this from a 2nd terminal.
# If you have problems running ./run file, use sudo
./run rails db:setup
```

Access the application at `http://localhost:8000`.

---

### Stopping everything:

```
# Stop the containers and remove a few Docker related resources associated to this project.
docker compose down
```

### Running the Rails console
When the app is already running with `docker-compose` up, attach to the container:
```
# If you have problems running ./run file, use sudo
./run rails c
```

## Running the Tests
When the app is already running with `docker-compose` up, attach to the container:
```
# If you have problems running ./run file, use sudo
./run bundle exec rspec
```

### Static code analysis with Rubocop:
#### You can run this from the same terminal as before.
```
# If you have problems running ./run file, use sudo
./run rubocop
```

## Technology Stack
- **Framework:** Ruby on Rails 8.0.1
- **Database:** PostgreSQL
- **Containerization:** Docker & Docker Compose

### FrontEnd
- **Bootstrap**
- **Hotwire Turbo**
- **StimulusJS**

---

## Project Description
1. **Log in:**
```
# The system is configured with an administrator user for the test case, but new users can also be created from the signup form.
# The credentials are:
email = admin@example.com
password = 'password'
```

2. **Client:**
```
In the user interface, you can see a table with the clients that have been created.
You can create and edit clients as well as add multiple addresses and emails.
```

3. **Location:**
```
In the user interface, you can see a table with the branches/locations that have been created.
You can create and edit locations, as well as add multiple addresses.
```

4. **Appointment:**
```
In the user interface, you can see a table with appointments that have been created.
Appointments can be created and edited, but there is a validation to prevent overlapping schedules with another appointment in the same location.
When creating an appointment, an appointment code is automatically generated, which is calculated based on an algorithm.
```

## Files of interest

```run```

You can run ```./run``` to get a list of commands and each command has documentation in the run file itself.

It's a shell script that has a number of functions defined to help you interact with this project. It's basically a Makefile except with less limitations. For example as a shell script it allows us to pass any arguments to another program.

If you get tired of typing ./run you can always create a shell alias with ```alias run=./run in your ~/.bash_aliases``` or equivalent file. Then you'll be able to run run instead of ```./run```.

If you have problems running ```./run``` file, use sudo
