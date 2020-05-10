# rekishiya-config

# On boot, press F2

- Under `General > Boot Sequence`, disable all options except `Manjaro`.
- Under `Power Management > AC Recovery`, select `Power On`. Under `Power Management > Auto On Time`, select `Every Day` and `12:00 AM`. Under `Block Sleep`, enable `Block Sleep (S3 State)`.

# Dynamic DNS Setup with Namecheap

I'm running my server on my home network. This means that I don't have
a static IP, and I'll need to use Dynamic DNS to continuously update
the DNS records to match my changing IP. I use Namecheap as my domain
registrar; under the `Advanced DNS` pane in the domain dashboard
there's an option for Dynamic DNS. Enable it, and create a
`A+ Dynamic DNS Record` mapping from the hosts `@` (which means just
the domain on its own without a subdomain), as well as all subdomains
you'd like to register (in my case `nextcloud`, and `bitwarden`) to
your current IP. Make a note of the Dynamic DNS password provided in
the dashboard.

In order to periodically update the DNS, all you need to do is send an
HTTP request of the following format:

```
GET https://dynamicdns.park-your-domain.com/update?host=HOST&domain=DOMAIN&password=PASSWORD
```

*only* replace the parts in capitals with your information.

I won't be using `cron` for this, instead I'll be using something
called a systemd timer unit. How this works is we first create a
service that updates the DNS over HTTP using cURL and shuts down after
it completes. The file for this service, with placeholder requests,
is located in `dynamic-dns.service`; place it in
`/etc/systemd/system/` once configured.

Instead of doing `systemctl enable` on this service, we instead create
a service called `dynamic-dns.timer` (the file for this timer is
located under the same name). Place the timer in
`/etc/systemd/system/` and enable (and start) it:

```bash
$ sudo systemctl enable dynamic-dns.timer
$ sudo systemctl start dynamic-dns
```

# Docker Installation & Configuration

First, install `docker` and `docker-compose` through `pacman`:

```bash
$ sudo pacman -S docker docker-compose
```

Then, `enable` the docker daemon with `systemctl` and start it:

```bash
$ sudo systemctl enable docker
$ sudo systemctl start docker
```

Then, create the `docker` group:

```bash
$ sudo groupadd docker
```

and add our primary user to this group:

```bash
$ sudo usermod -aG docker hexdump
```

Now log out and log back in for group membership to register.

# Service Scaffolding

Rekishiya runs 3 `docker-compose` groups: one for nextcloud, one for
bitwarden, and one for the reverse proxy that connects these to the
internet with TLS. I've given each of these "services" a directory
in the root of my filesystem.

```bash
$ mkdir /nextcloud /bitwarden /reverse-proxy
```

I chose permissions `770` so only my user (`hexdump`) and other users
in the `docker` group can access the contents of the directory.

```bash
$ sudo chown -R hexdump:docker /nextcloud /bitwarden /reverse-proxy
$ chmod 770 /nextcloud /bitwarden /reverse-proxy
```

In each of these directories is a directory with the name of the
service (to hold the docker resources), as well as a `data` directory
for bind mounts.

```bash
$ mkdir /nextcloud/nextcloud /nextcloud/data
$ mkdir /bitwarden/bitwarden /bitwarden/data
$ mkdir /reverse-proxy/reverse-proxy /reverse-proxy/data
```

# Nextcloud Setup

Copy `nextcloud-db.env` and `nextcloud-docker-compose.yml` from this
configuration guide's directory to `/nextcloud/nextcloud/db.env` and
`/nextcloud/nextcloud/docker-compose.yml`

First, choose a secure database admin password. Paste this into then
`MYSQL_PASSWORD` field in `db.env`, as well as the corresponding
`MYSQL_ROOT_PASSWORD` field in `docker-compose.yml`. Configure
`VIRTUAL_HOST` and `LETSENCRYPT_HOST` both to the URL at which you'll
be hosting the nextcloud instance (in my case
`nextcloud.hexdump.cloud`), and configure `LETSENCRYPT_EMAIL` to the
email at which you'd like to recieve Let's Encrypt emails about your
cert.

# Bitwarden Setup

## Mailjet Configuration

Bitwarden needs an email server from which to send verification
emails. Since I'm going to be the only person using my Bitwarden
instance, security and volume of verification emails is not a concern.
I signed up for Mailjet's free plan.

## Bitwarden Configuration

Copy `bitwarden-docker-compose.yml` from this configuration guide's
directory to `/bitwarden/bitwarden/docker-compose.yml`.

Set `DOMAIN` to the fully-qualified URL to bitwarden (in my case
`https://bitwarden.hexdump.cloud`), `VIRTUAL_HOST` and
`LETSENCRYPT_HOST` to only the domain to bitwarden
(`https://bitwarden.hexdump.cloud`) and configure `LETSENCRYPT_EMAIL`
to the email at which you'd like to recieve Let's Encrypt emails about
your cert. Configure all the `SMTP_` variables to the values that
Mailjet provides, and pick a `SMTP_FROM` that indicates that the
emails being sent are `no-reply` or by a `daemon`.

# Reverse Proxy Setup

Copy `reverse-proxy-docker-compose.yml` and `reverse-proxy` from this
configuration guide's directory to
`/reverse-proxy/reverse-proxy/docker-compose.yml` and
`/reverse-proxy/reverse-proxy/proxy`.

# Service Orchestration with Systemd

Ideally, we'll have Bitwarden, Nextcloud, and the reverse proxy all
started on boot and reboot if they crash. I chose to orchestrate this
through Systemd: this directory has the service files
`nextcloud.service`, `bitwarden.service`, and `reverse-proxy.service`.
Copy all of these files to `/etc/systemd/system`, enable, and start
all of them:

```bash
$ sudo systemctl enable nextcloud bitwarden reverse-proxy
$ sudo systemctl start nextcloud bitwarden reverse-proxy
```

# Automatic Backups with Rsync

Since I'm only using a single internal drive, I'd like to configure
regular backups for my


docker network create proxy-tier