#!/bin/bash

if sudo ufw status | grep -q "Status: active"; then
    echo "ON 🛡️"
else
    echo "OFF ❌"
fi
