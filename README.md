![](https://github.com/Allesanddro/wireguard-ui/workflows/wireguard-ui%20build%20release/badge.svg)

# wireguard-ui

A web user interface to manage your WireGuard setup.

## Features
- Friendly UI
- Authentication
- Manage extra client's information (name, email, etc)
- Retrieve configs using QR code / file

## Run WireGuard-UI

Default username and password are `admin`.

### Environment Variables


Set the `SESSION_SECRET` environment variable to a random value.

In order to sent the wireguard configuration to clients via email (using sendgrid api) set the following environment variables

```
SENDGRID_API_KEY: Your sendgrid api key
EMAIL_FROM_ADDRESS: the email address you registered on sendgrid
EMAIL_FROM_NAME: the sender's email address
```

### Using binary file

Download the binary file from the release and run it with command:

```
./wireguard-ui
```

## Auto restart WireGuard daemon
WireGuard-UI only takes care of configuration generation. You can use systemd to watch for the changes and restart the service. Following is an example:

### systemd

Create /etc/systemd/system/wgui.service

```
[Unit]
Description=Restart WireGuard
After=network.target

[Service]
Type=oneshot
ExecStart=/usr/bin/systemctl restart wg-quick@wg0.service

[Install]
RequiredBy=wgui.path
```

Create /etc/systemd/system/wgui.path

```
[Unit]
Description=Watch /etc/wireguard/wg0.conf for changes

[Path]
PathModified=/etc/wireguard/wg0.conf

[Install]
WantedBy=multi-user.target
```

Apply it

```
systemctl enable wgui.{path,service}
systemctl start wgui.{path,service}
```

### openrc

Create and `chmod +x` /usr/local/bin/wgui
```
#!/bin/sh
wg-quick down wg0
wg-quick up wg0
```

Create and `chmod +x` /etc/init.d/wgui
```
#!/sbin/openrc-run

command=/sbin/inotifyd
command_args="/usr/local/bin/wgui /etc/wireguard/wg0.conf:w"
pidfile=/run/${RC_SVCNAME}.pid
command_background=yes
```

Apply it

```
rc-service wgui start
rc-update add wgui default
```


### Build binary file

Prepare the assets directory

```
./prepare_assets.sh
```

Then you can embed resources by generating Go source code

```
rice embed-go
go build -o wireguard-ui
```

Or, append resources to executable as zip file

```
go build -o wireguard-ui
rice append --exec wireguard-ui
```

## Screenshot

![wireguard-ui](https://user-images.githubusercontent.com/23656101/150103482-a36b8982-d285-4086-96fc-fd73d01032cc.png)

## License
MIT. See [LICENSE](https://github.com/Allesanddro/wireguard-ui/blob/master/LICENSE).

## Support
If you like the project and want to support it, you can *buy me a coffee* ☕

https://www.paypal.me/skothok
