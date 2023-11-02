# 2023-2-RL-Project

# 1. Docker setting
```
# Docker image build
docker build -f Dockerfile -t rlp:latest . --no-cache

# Docker run
docker run --gpus all --shm-size 16G -it rlp:latest

# Docker exec
docker exec -it <CONTAINER_NAME> bash

# ENV
export OPENAI_API_KEY=<API_KEY_for_OPENAI>
```

# 2. Model & Data
## 1. Model
The paper [Dynamic Prompt Learning via Policy Gradient for Semi-structured Mathematical Reasoning](https://arxiv.org/abs/2209.14610) used the `text-davinci-002` model in OpenAI API. But, it is in a Legacy state now and OpenAI recommends the `gpt-3.5-turbo-instruct` model instead of it from this [description](https://platform.openai.com/docs/deprecations/). So, we use `gpt-3.5-turbo-instruct` for this project.
