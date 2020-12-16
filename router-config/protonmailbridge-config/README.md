## ProtonMail Forwarding

In order to build the bridge, we'll need `go`:

```bash
$ sudo pacman -S go
```

Then, we'll need to include `go`'s path in our `PATH`. I just do this
temporarily for each build:

```bash
$ export PATH="$PATH:/home/hexdump/go"
```

Then, we clone my fork of the ProtonMail bridge:

```bash
$ git clone https://github.com/hexdump/protonmail-bridge-server
```

And run the following command to build:

```bash
$ make build-nogui
```

### `pass` configuration

ProtonMail bridge requires we have a keychain manager of some sort.
The options are `pass` and `gnome-keychain`, so I decided to go with
`pass`.

First, we have to install `pass`:

```bash
$ sudo pacman -S pass
```

Then, we have to set up `gpg` to use in conjunction with `pass`. We
need to first generate a key:

```bash
$ gpg --full-gen-key
```

Then, we need to initialize `pass` with our key. GPG will recognize
email as a key identifier, so we'll use that:

```bash
$ pass init contact@hexdump.email
```

### Transferring Certificate

Since our certificate won't be trusted by any clients, we'll need to
export our generated key. After you launch the ProtonMail bridge
once (`./Desktop-Bridge --cli`) this will be stored in
`~/.config/protonmail/bridge/cert.pem`. Distribute this to your
devices accordingly.

### Weird Pass Error

For some reason, the Go `pass` library won't work unless you run
the following command first:

```bash
$ export GPG_TTY=$(tty)
```
