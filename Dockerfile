# Sử dụng Ubuntu 22.04
FROM ubuntu:22.04

# Cài thư viện cần thiết
RUN apt-get update && apt-get install -y \
    build-essential openjdk-17-jre openjdk-17-jdk git make curl && \
    apt-get clean

# Tải mã nguồn VPL
WORKDIR /opt
RUN git clone https://github.com/jcrodriguez-dis/moodle-mod_vpl.git
WORKDIR /opt/moodle-mod_vpl/jail

# Cài đặt Jail Server
RUN make install

# Mở port 8080
EXPOSE 8080

# Chạy server
CMD vpl-jail-system start && tail -f /dev/null
