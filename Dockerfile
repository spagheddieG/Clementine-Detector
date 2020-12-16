# For more information, please refer to https://aka.ms/vscode-docker-python
FROM tensorflow/tensorflow:2.3.0-gpu

# Keeps Python from generating .pyc files in the container
ENV PYTHONDONTWRITEBYTECODE=1

# Turns off buffering for easier container logging
ENV PYTHONUNBUFFERED=1

# Install pip requirements
COPY requirements.txt .
RUN python -m pip install -r requirements.txt

WORKDIR /app
COPY . /app

# Install system libraries for python packages
RUN apt-get update &&  DEBIAN_FRONTEND=noninteractive apt-get install -y ffmpeg \
    # matplotlib in a container
    python3-tk \
    # Keras plotting
    graphviz

# Switching to a non-root user
RUN useradd appuser && chown -R appuser /app
USER appuser

# Run python file
CMD ["python", "src/main.py"]
