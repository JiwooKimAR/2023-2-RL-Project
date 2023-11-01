FROM  pytorch/pytorch:2.1.0-cuda12.1-cudnn8-runtime

ENV TZ=Asia/Seoul
ENV LC_ALL C.UTF-8

RUN apt-get update && apt-get install -y git vim

RUN mkdir -p /workspace/
WORKDIR /workspace/

COPY . .

RUN python3 -m pip install -r requirements.txt