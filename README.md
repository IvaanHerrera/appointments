#### Clone this repo:

```
git clone https://github.com/IvaanHerrera/appointments
cd appointments
```

#### Copy an example .env file because the real one is git ignored:

```
cp .env.example .env
```

#### Build everything:

*The first time you run this it's going to take 5-10 minutes depending on your internet connection speed and computer's hardware specs. That's because it's going to download a few Docker images and build the Ruby + Yarn dependencies.*

```
docker compose up --build
```

#### Setup the initial database:

```
# You can run this from a 2nd terminal.
./run rails db:setup
```

#### Stopping everything:

```
# Stop the containers and remove a few Docker related resources associated to this project.
docker compose down
```