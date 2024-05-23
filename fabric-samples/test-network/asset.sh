
#!/bin/bash

while true; do
    clear
    peer chaincode query -C mychannel -n basic -c '{"Args":["GetAllAssets"]}'
    sleep 2
done
