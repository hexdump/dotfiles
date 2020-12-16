# reverseproxy-config

## NGINX Installation

Install using `pacman`:

```bash
$ sudo pacman -S nginx
```

Then set nginx to start at boot (and also start now, via the `--now` flag):

```bash
$ sudo systemctl enable --now nginx.service
```

## certbot Setup

Install using `pacman`:

```bash
$ sudo pacman -S cerbot
```

Now, we manually instantiate `certbot` to generate our certificates:

```bash
$ sudo certbot --nginx certonly -d bitwarden.hexdump.cloud nextcloud.hexdump.cloud trunk.hexdump.cloud
```

After we're done, we'll want to have our system do periodic updates. The systemd unit to refresh our certificates is located in `certbot.service`. To periodically trigger this service, I use a systemd timer, which is located in `certbot.timer`. Move both of these files into `/etc/systemd/system/`, then enable them:

```bash
$ sudo systemctl daemon-reload # make sure systemd is aware of our new files
$ sudo systemctl enable --now certbot.timer
```

## NGINX configuration

Move all of the contents of the `sites-enabled` directory in this config guide into `/etc/nginx/sites-available/`. Symlink them into `/etc/nginx/sites-enabled/`, then restart NGINX:

```bash
$ sudo systemctl restart nginx.service
```
