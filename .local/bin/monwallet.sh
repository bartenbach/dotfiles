#!/bin/bash

/usr/local/bin/monero-wallet-cli --wallet-file ~/doc/wallet/monwallet \
                                 --daemon-host compiler \
                                 --trusted-daemon \
                                 --password $(pass show monwallet | head -1)
