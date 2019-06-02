################################
# basic settings
################################
txindex=1
logtimestamps=1
listen=1
daemon=1
staking=0
gen=0
maxconnections=256
#bind=XXX_IPV6_INT_BASE_XXX:XXX_NETWORK_BASE_TAG_XXX::XXX_NUM_XXY:XXX_MNODE_INBOUND_PORT_XXX
externalip=XXX_IPV6_INT_BASE_XXX:XXX_NETWORK_BASE_TAG_XXX::XXX_NUM_XXY:XXX_MNODE_INBOUND_PORT_XXX
#############################
# nodes we want to stick to
#############################
addnode=68.183.65.69:52271
addnode=192.241.142.128:52271
addnode=157.230.137.86:52271
addnode=68.183.185.23:52271
addnode=142.93.34.50:52271
################################
# masternode specific settings
################################
masternode=1
#### INSERT YOUR MASTERNODE PRIVATEKEY BELOW ################   ####################################
masternodeprivkey=XXX_priv_XXX
#################################################################################################
#
#                        b.
#                        88b           Insert your generated masternode privkey here
#                        888b.
#                        88888b
#                        888888b.
#                        8888P"
#                        P" `8.
#                            `8.
#                             `8
#################################################################################################
#############################
# optional indices
#############################
addressindex=1
timestampindex=1
spentindex=1
#############################
# JSONRPC
#############################
server=1
rpcuser=XXX_GIT_PROJECT_XXXrpc
rpcpassword=XXX_PASS_XXX
rpcallowip=127.0.0.1
rpcport=555XXX_NUM_XXX
