# Use an official RunPod base image with Python and GPU support
FROM runpod/pytorch:2.0.1-py3.10-cuda11.8.0-devel-ubuntu20.04

# Set working directory
WORKDIR /comfyui

# Install system dependencies
RUN apt-get update && apt-get install -y git

# Clone ComfyUI repository
RUN git clone https://github.com/comfyanonymous/ComfyUI.git .

# Install Python dependencies
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# Copy RunPod serverless handler (we’ll add this next)
COPY src/rp_handler.py /src/rp_handler.py

# Set environment variable for serverless mode
ENV SERVERLESS=true

# Command to start the serverless worker
CMD ["python", "/src/rp_handler.py"]
