#!/bin/bash

/usr/local/bin/monero-wallet-cli --wallet-file ~/doc/wallet/monwallet \
                                 --daemon-host 192.168.0.25 \
                                 --trusted-daemon \
                                 --password $(pass show monwallet | head -1)
