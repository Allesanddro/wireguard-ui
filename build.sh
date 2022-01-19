#!/usr/bin/env bash
chmod +x prepare_assets.sh
echo "Starting build."
sleep 1
echo "This might fail if you didn't install the dependencies."
sleep 1
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
