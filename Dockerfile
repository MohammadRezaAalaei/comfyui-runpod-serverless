FROM runpod/pytorch:2.0.1-py3.10-cuda11.8.0-devel-ubuntu20.04
WORKDIR /comfyui
RUN apt-get update && apt-get install -y git
RUN git clone https://github.com/comfyanonymous/ComfyUI.git .
RUN pip install --upgrade pip && pip install -r requirements.txt
COPY src/rp_handler.py /src/rp_handler.py
ENV SERVERLESS=true
VOLUME /comfyui/models  # Mount point for network volume
CMD ["python", "/src/rp_handler.py"]
