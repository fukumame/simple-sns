# Abount this apps
- This is a simple sns service using rails5

# Main features
- User registration
- Post a text to feeds.
- Follow / Unfollow users.
- Like / Unlike to posts and replies.

# How to install
- This service is executable on docker container.

### Docker install
- for mac user
  - https://docs.docker.com/docker-for-mac/
- for windows user
  - https://docs.docker.com/docker-for-windows/

### Deploy the container on docker
- The following commands should be executed to deploy this application as a container on docker

```
cd /path/to/your/workspace
git clone https://github.com/fukumame/simple-sns.git
cd simple-sns
./bin/docker-setup
docker-compose up
```

### Open the application with Browser
- To access this application, Open the following URL with any modern browser
  - http://localhost:3000