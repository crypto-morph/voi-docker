FROM ubuntu:22.04
EXPOSE 22
ENV ALGORAND_DATA=/var/lib/algorand
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get upgrade -y && \
    mkdir /voi && \
    mkdir /var/run/sshd && \
    apt install -y jq bc git gnupg2 curl nano openssh-server software-properties-common sudo supervisor vim
RUN curl -o - https://releases.algorand.com/key.pub | sudo tee /etc/apt/trusted.gpg.d/algorand.asc && \
    add-apt-repository -y "deb [arch=amd64] https://releases.algorand.com/deb/ stable main" && \
    apt update && \
    apt install -y algorand && \
    algocfg set -p DNSBootstrapID -v "<network>.voi.network" -d /var/lib/algorand/ && \
    algocfg set -p EnableCatchupFromArchiveServers -v true -d /var/lib/algorand/ && \
    chown algorand:algorand /var/lib/algorand/config.json && \
    chmod g+w /var/lib/algorand/config.json && \
    curl -s -o /var/lib/algorand/genesis.json https://testnet-api.voi.nodly.io/genesis && \
    chown algorand:algorand /var/lib/algorand/genesis.json
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
RUN cd /voi && git clone https://github.com/crypto-morph/voi-checker.git
COPY --chmod=777 *.sh /voi/

CMD ["/usr/bin/supervisord"]