# Sử dụng Ubuntu 22.04
FROM ubuntu:22.04

# Cài thư viện cần thiết
RUN apt-get update && apt-get install -y \
    build-essential git make g++ openjdk-17-jdk python3 && \
    apt-get clean

# Tải mã nguồn jail server chính thức
WORKDIR /opt
RUN git clone https://github.com/jcrodriguez-dis/vpl-jail-system.git
WORKDIR /opt/vpl-jail-system

# Build chương trình
RUN make all

# Mở port cho Moodle gọi đến
EXPOSE 8080

# Chạy server (foreground mode để Render không tắt)
CMD ["./vpl-jail-server", "--no-daemon", "--port", "8080"]
