FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    build-essential git automake autoconf g++ openjdk-17-jdk python3 curl ca-certificates \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /opt
RUN git clone https://github.com/jcrodriguez-dis/vpl-jail-system.git
WORKDIR /opt/vpl-jail-system

# Cấp quyền và chạy script cài đặt chuẩn, không dùng tham số --skip-root-check
RUN chmod +x install-vpl-sh && ./install-vpl-sh noninteractive basic

# Mở port
EXPOSE 8080

# Chạy trực tiếp binary nếu có, hoặc fallback
CMD bash -lc 'BINARY=$(command -v vpl-jail-server || echo "/usr/local/bin/vpl-jail-server"); \
    if [ ! -x "$BINARY" ]; then echo "❌ vpl-jail-server không tìm thấy tại $BINARY"; exit 1; fi; \
    exec "$BINARY" --no-daemon --port 8080'
