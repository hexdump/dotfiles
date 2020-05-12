# backup-github

I typically have most of my GitHub repositories cloned, but just in case I don't I set up a script that backs them all up to my computer and keeps them up to date.

First, set up a folder in which to store the backup-github script as well as the backed up repositories. I chose `/Users/hexdump/github-backups`, and placed `backup-github.sh` in this directory. In the script I set the `USERNAME` and `API_KEY` variables to my GitHub credentials. I ran this script one time to make sure it would run correctly without my supervision.

Then, I used [this site](http://launched.zerowidth.com) to generate a launchd service to run this script daily. I saved this service in the file `com.hexdump.config.backup-github.plist` (which contains a path to `github-backups.sh`) in `~/Library/LaunchAgents`. I then loaded the service with the following command:

```bash
launchctl load -w ~/Library/LaunchAgents/com.hexdump.config.backup-github.plist
```

