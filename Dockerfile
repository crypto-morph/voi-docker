FROM ubuntu:22.04
EXPOSE 22
ENV ALGORAND_DATA=/var/lib/algorand
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get upgrade -y && \
    mkdir /voi && \
    mkdir /var/run/sshd && \
    apt install -y jq bc git gnupg2 curl nano openssh-server python3-pip software-properties-common sudo supervisor vim
RUN curl -o - https://releases.algorand.com/key.pub | sudo tee /etc/apt/trusted.gpg.d/algorand.asc
COPY --chmod=777 setup-algod.sh /voi
RUN /voi/setup-algod.sh
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
RUN cd /voi && git clone https://github.com/crypto-morph/voi-checker.git
RUN cd /voi/voi-checker && pip install -r requirements.txt
COPY --chmod=777 *.sh /voi/

CMD ["/usr/bin/supervisord"]