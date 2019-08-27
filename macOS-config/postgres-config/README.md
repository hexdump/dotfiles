# Postgres Setup

I use `brew` to install postgres:

```bash
$ brew install postgres
```

`brew`'s version of postgres, (`stable 11.4` as the time of me writing this), does some things funky. First, sometimes it seems to not properly link its binaries. 
To remedy this, first try relinking `postgres`:

```bash
$ brew unlink postgres && brew link postgres
```

If the `psql`/`pg_ctl`/etc binaries are still not in your `PATH`, you can manually add them:

```bash
$ PATH="$PATH:/usr/local/Cellar/postgresql/11.4
```

Then, it initializes an account under *your username* with all privileges,
instead of one named `postgres`. To create a `postgres` user with all privileges, open `psql` and do the following:

```bash
$ createdb myusername
$ psql
psql (11.4)
Type "help" for help.

myusername=# create user postgres;
CREATE ROLE
myusername=# alter user postgres SUPERUSER CREATEROLE CREATEDB REPLICATION BYPASSRLS
ALTER ROLE
```
