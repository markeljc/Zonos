FROM python:3.10-slim

# Install PyTorch and dependencies
RUN pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cpu
RUN pip install uv

# Install espeak-ng and Rust compiler dependencies
RUN apt-get update && \
    apt-get install -y espeak-ng g++ curl build-essential && \
    rm -rf /var/lib/apt/lists/*

# Install Rust compiler
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"

WORKDIR /app
COPY . ./
RUN uv pip install --system -e .