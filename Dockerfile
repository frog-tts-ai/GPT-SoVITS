FROM tts:12.4.1_py3.10.13_torch2.5.0_ubuntu22.04

LABEL maintainer="breakstring@hotmail.com"
LABEL version="gpt-sovits:v1"
LABEL description="Docker image for GPT-SoVITS"

ENV NLTK_DATA=/workspace/nltk_data

WORKDIR /workspace
COPY requirements.txt /workspace/

RUN apt-get update && \
    apt-get install -y --no-install-recommends git-lfs && \
    git lfs install && \
    rm -rf /var/lib/apt/lists/*

# Copy only requirements.txt initially to leverage Docker cache
RUN pip install --index-url https://mirrors.aliyun.com/pypi/simple -r requirements.txt

# Define a build-time argument for image type
ARG IMAGE_TYPE=full

# Copy the rest of the application
COPY . /workspace

EXPOSE 9871 9872 9873 9874 9880

CMD ["python", "webui.py", "zh_CN"]
# docker build -t gpt-sovits:v1 .
# docker compose -f "docker-compose.yaml" up -d