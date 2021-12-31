#!/bin/bash

/usr/local/bin/monero-wallet-cli --wallet-file ~/doc/wallet/monwallet \
                                 --daemon-address 192.168.0.25:18080 \
                                 --trusted-daemon \
                                 --password $(pass show monwallet | head -1) \
                                 --daemon-login "admin:$(pass show 192.168.0.1/admin)" \

