FROM docker.io/ubuntu:22.04

WORKDIR /workspace

# For sftp connection from vscode
RUN apt-get update && apt-get install -y openssh-server
RUN echo 'root:1324' | chpasswd
RUN mkdir /run/sshd
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config
EXPOSE 22

RUN apt-get update && apt-get install -y vim g++ gdb cmake linux-tools-common linux-tools-generic \
    && apt-get install -y libssl-dev libgflags-dev libgoogle-glog-dev libprotobuf-dev libprotoc-dev protobuf-compiler libleveldb-dev \
    && apt-get install -y libgoogle-perftools-dev

# ENV PATH="/usr/lib/linux-tools-`uname-r`:$PATH"
COPY . /workspace/

CMD ["/usr/sbin/sshd", "-D"]
