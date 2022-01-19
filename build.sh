#!/usr/bin/env bash
echo "Starting build."
sleep 3
echo "This might fail if you didn't install the dependencies."
sleep 3
git pull
systemctl stop wgui-web.service
./prepare_assets.sh
rice embed-go
go build -o wireguard-ui
cp wireguard-ui /etc/wireguard-ui
chmod +x /etc/wireguard-ui

systemctl start wgui-web.service

echo "If there was no error everything should work fine."
sleep 5
