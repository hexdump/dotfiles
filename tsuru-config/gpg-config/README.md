# Generating Key

```
$ gpg --full-generate-key
gpg (GnuPG) 2.2.17; Copyright (C) 2019 Free Software Foundation, Inc.
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.

Please select what kind of key you want:
   (1) RSA and RSA (default)
   (2) DSA and Elgamal
   (3) DSA (sign only)
   (4) RSA (sign only)
Your selection? 1
RSA keys may be between 1024 and 4096 bits long.
What keysize do you want? (2048) 4096
Requested keysize is 4096 bits       
Please specify how long the key should be valid.
         0 = key does not expire
      <n>  = key expires in n days
      <n>w = key expires in n weeks
      <n>m = key expires in n months
      <n>y = key expires in n years
Key is valid for? (0) 1y
Key expires at Sat Sep 19 09:19:27 2020 EDT
Is this correct? (y/N) y
                        
GnuPG needs to construct a user ID to identify your key.

Real name: Liam Schumm
Email address: lschumm@protonmail.com
Comment:                             
You selected this USER-ID:
    "Liam Schumm <lschumm@protonmail.com>"

Change (N)ame, (C)omment, (E)mail or (O)kay/(Q)uit? O
We need to generate a lot of random bytes. It is a good idea to perform
some other action (type on the keyboard, move the mouse, utilize the
disks) during the prime generation; this gives the random number
generator a better chance to gain enough entropy.
We need to generate a lot of random bytes. It is a good idea to perform
some other action (type on the keyboard, move the mouse, utilize the
disks) during the prime generation; this gives the random number
generator a better chance to gain enough entropy.
gpg: key 9ADA7429D749F798 marked as ultimately trusted
gpg: directory '/Users/lschumm/.gnupg/openpgp-revocs.d' created
gpg: revocation certificate stored as '/Users/lschumm/.gnupg/openpgp-revocs.d/651A35AF6814CAC3485789829ADA7429D749F798.rev'
public and secret key created and signed.

pub   rsa4096 2019-09-20 [SC] [expires: 2020-09-19]
      651A35AF6814CAC3485789829ADA7429D749F798
uid                      Liam Schumm <lschumm@protonmail.com>
sub   rsa4096 2019-09-20 [E] [expires: 2020-09-19]
```

## Signing a message using this key