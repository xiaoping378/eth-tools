#!/bin/bash
# Author: xxp
# start ethereum geth v1.7.3 privatenet and mist v0.9.2
#

# 安装geth和mist的方法，自行google
# genesis.json通过puppeth自动生成的

# 本目录只是init后的产物
# gecho --datadir node0 init genesis.json

set -e
set -u

# 启动挖矿节点，默认启用POA(clique)共识算法
# coinbase账号默认有3780万个Ether
gecho  \
    --datadir ./node0\
    --ws\
    --rpc\
    --rpcapi "eth,net,web3,admin,personal,txpool,miner,clique"\
    --rpccorsdomain "*"\
    --rpcaddr 0.0.0.0\
    --mine\
    --etherbase 0xdbeb69c655b666b3e17b8061df7ea4cc2399df11\
    --unlock 0xdbeb69c655b666b3e17b8061df7ea4cc2399df11\
    --password ./password\
    --nodiscover\
    --maxpeers '50'\
    --networkid 379\
    &

# 再次进入console调试
# geth attach ipc:\./node0/geth.ipc

ethereumwallet\
    --rpc http://127.0.0.1:18545\
    --node geth\
    --gethpath `which gecho`\
    --swarmurl="http://swarm-gateways.net"\
    &
