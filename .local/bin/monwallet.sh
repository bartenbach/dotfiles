#!/bin/bash

/usr/local/bin/monero-wallet-cli --wallet-file ~/doc/wallet/monwallet \
                                 --daemon-host epo \
                                 --trusted-daemon \
                                 --password $(pass show monwallet | head -1)
