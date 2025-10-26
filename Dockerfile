# Sử dụng Ubuntu 22.04
FROM ubuntu:22.04

# Cài thư viện cần thiết
RUN apt-get update && apt-get install -y \
    build-essential openjdk-17-jre openjdk-17-jdk git make curl python3 && \
    apt-get clean

# Tải mã nguồn VPL
WORKDIR /opt
RUN git clone https://github.com/jcrodriguez-dis/moodle-mod_vpl.git
WORKDIR /opt/moodle-mod_vpl/jail

# Build VPL jail system
RUN make

# Cấu hình để chạy server
EXPOSE 8080
CMD ["./vpl-jail-server", "--no-daemon", "--port", "8080"]
