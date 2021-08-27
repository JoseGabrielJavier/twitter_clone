// starting and stopping docker
1. docker-compose up -d // will start docker containers (must be inside the project folder)
2. docker-compose down // stops docker container

// building docker (when installing gems)
1. docker-compose build ("docker-compose down" first)
2. docker-compose up --build -d // after building, will immediately start docker container

// when executing rails commands
1. docker-compose run web [rails-commands-here]