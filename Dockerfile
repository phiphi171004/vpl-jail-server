# Base image Ubuntu
FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Cài dependency
RUN apt-get update && apt-get install -y \
    build-essential git make g++ openjdk-17-jdk python3 curl ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# Clone repo gốc
WORKDIR /opt
RUN git clone --depth 1 https://github.com/jcrodriguez-dis/vpl-jail-system.git
WORKDIR /opt/vpl-jail-system

# Cấp quyền và chạy script cài đặt chính thức
RUN chmod +x install-vpl-sh && ./install-vpl-sh --skip-root-check || true

# Mở cổng cho Moodle gọi đến
EXPOSE 8080

# Giữ tiến trình chạy foreground để Render không kill
CMD bash -lc 'VPL_BIN=$(command -v vpl-jail-server || echo "/usr/local/bin/vpl-jail-server"); \
    if [ ! -f "$VPL_BIN" ]; then echo "❌ Không tìm thấy vpl-jail-server"; ls -la /usr/local/bin; exit 1; fi; \
    echo "✅ Starting VPL Jail Server..."; \
    exec "$VPL_BIN" --no-daemon --port 8080'
