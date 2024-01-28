add-apt-repository -y "deb [arch=amd64] https://releases.algorand.com/deb/ stable main" && \
apt update && \
apt install -y algorand --reinstall
algocfg set -p DNSBootstrapID -v "<network>.voi.network" -d /var/lib/algorand/ && \
algocfg set -p EnableCatchupFromArchiveServers -v true -d /var/lib/algorand/ && \
chown algorand:algorand /var/lib/algorand/config.json && \
chmod g+w /var/lib/algorand/config.json && \
curl -s -o /var/lib/algorand/genesis.json https://testnet-api.voi.nodly.io/genesis && \
chown algorand:algorand /var/lib/algorand/genesis.json