FROM ubuntu:22.04
RUN apt-get update && apt-get install -y git
WORKDIR /opt
RUN git clone https://github.com/jcrodriguez-dis/vpl-jail-system.git
WORKDIR /opt/vpl-jail-system

# 👇 Thêm dòng này để in ra danh sách file
RUN ls -R

# Dừng lại (để mình xem log)
CMD ["bash"]
