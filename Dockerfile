FROM python:3.11-slim

RUN apt-get update && \
    apt-get install -y curl autoconf automake libtool pkg-config git make g++ \
    && rm -rf /var/lib/apt/lists/*

# Install libpostal
RUN git clone https://github.com/openvenues/libpostal && \
    cd libpostal && \
    ./bootstrap.sh && \
    ./configure && \
    make && \
    make install && \
    ldconfig

# Install Python dependencies
WORKDIR /app
COPY . /app
RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 8000
CMD ["uvicorn", "postal_api:app", "--host", "0.0.0.0", "--port", "8000"]
