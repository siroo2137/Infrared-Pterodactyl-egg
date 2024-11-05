#!/bin/bash
cd /home/container

# Replace Startup Variables
MODIFIED_STARTUP=$(eval echo $(echo ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g'))
# echo "${MODIFIED_STARTUP}"

echo """debug: false
receiveProxyProtocol: false
useRedisConfigs: false
underAttack: false
connectionThreshold: 50
trackBandwidth: false
prometheus:
  enabled: false
  bind: :9070
api:
  enabled: true
  bind: :65534
mojangAPIenabled: false
geoip:
  enabled: false
  databaseFile: GeoLite2-Country.mmdb
  enableIprisk: false
redis:
  host: 172.18.0.1
  pass:
  db: 0
configredis:
  host: 172.18.0.1
  pass:
  db: 0
rejoinMessage: §2Polacz sie ponownie aby sie zweryfikowac.
blockedMessage: §cTwoj adres ip zostal zablokowany ze wzgledu na podejrzany ruch!
genericJoinResponse: §3§lCataclysmProxy\n\n§cTen serwer nie istnieje lub zmienil adres IP!\n\n§9dc.cataclysm.su
genericping:
  version: CataclysmProxy
  description: Ten serwer nie istnieje lub zmienil adres IP!
  iconPath: 
tableflip:
  enabled: false
  pidfile: infrared.pid""" > config.yml

# check if the folder proxies doesn't exists
if [ ! -d "/home/container/configs" ]; then
    # create the folder
    mkdir /home/container/configs
fi

echo """{
    \"domainNames\": [\"localhost\"],
    \"proxyTo\": \"127.0.0.1:25565\"
}""" > configs/temp.json

# Run the Server
${MODIFIED_STARTUP}
