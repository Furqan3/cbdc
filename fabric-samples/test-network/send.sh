#!/bin/bash

# Declare the arrays of asset IDs and owners
asset_ids=(1 2 3 4 5 6)
owners=("ali" "umar" "saad" "furqan" "ahmad" "hamza" "sanaullah")

export PATH=${PWD}/../bin:$PATH
# The path to the necessary certificates
ORDERER_CA="${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem"
PEER0_ORG1_CA="${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt"
PEER0_ORG2_CA="${PWD}/organizations/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt"

# Loop to execute the command 100 times
for ((i = 0; i <10; i))
do
    # Select random asset ID and owner
    asset_id=${asset_ids[$RANDOM % ${#asset_ids[@]}]}
    owner=${owners[$RANDOM % ${#owners[@]}]}

    # Execute the chaincode invoke command
    peer chaincode invoke -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls --cafile "$ORDERER_CA" -C mychannel -n basic --peerAddresses localhost:7051 --tlsRootCertFiles "$PEER0_ORG1_CA" --peerAddresses localhost:9051 --tlsRootCertFiles "$PEER0_ORG2_CA" -c "{\"function\":\"TransferAsset\",\"Args\":[\"$asset_id\",\"$owner\"]}"
done
