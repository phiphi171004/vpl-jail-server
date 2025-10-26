# Ubuntu tối giản
FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Tool cần thiết để build & chạy jail server
RUN apt-get update && apt-get install -y \
    build-essential git make g++ openjdk-17-jdk python3 curl ca-certificates \
 && rm -rf /var/lib/apt/lists/*

# Lấy mã nguồn jail server CHÍNH XÁC
WORKDIR /opt
RUN git clone --depth 1 https://github.com/jcrodriguez-dis/vpl-jail-system.git
WORKDIR /opt/vpl-jail-system

# Chạy script cài đặt (repo KHÔNG dùng `make install`)
# Một số bản dùng "install.sh", bản khác dùng "install" -> thử tuần tự
RUN bash -lc 'chmod +x install.sh 2>/dev/null || true; \
              chmod +x install 2>/dev/null || true; \
              if [ -x ./install.sh ]; then ./install.sh; \
              elif [ -x ./install ]; then ./install; \
              else echo "❌ Không tìm thấy install.sh/install trong repo"; exit 1; fi'

# Mặc định binary được cài vào /usr/bin hoặc /usr/local/bin
# Mở port cho Render nhận
EXPOSE 8080

# Chạy foreground để Render giữ tiến trình sống
CMD bash -lc 'VPL_BIN=$(command -v vpl-jail-server || true); \
              if [ -z "$VPL_BIN" ]; then echo "❌ Không tìm thấy vpl-jail-server sau khi cài"; exit 1; fi; \
              exec "$VPL_BIN" --no-daemon --port 8080'
