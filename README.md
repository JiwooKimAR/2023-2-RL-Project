# 2023-2-RL-Project

# 1. Docker setting
```
# Docker image build
docker build -f Dockerfile -t rlp:latest . --no-cache

# Docker run
docker run --gpus all --shm-size 16G -it rlp:latest

# Docker exec
docker exec -it <CONTAINER_NAME> bash
```