# Homebrew formula for RStudio Server

As [homebrew-science](https://github.com/Homebrew/homebrew-science) has been
deprecated, this tap is now used to host the formula for [RStudio
Server](https://www.rstudio.com/products/rstudio/download-server/). The
bottles are built by CircieCI and uploaded to Github release page.


## Installation guide

Although this tap should also work for Linuxbrew, but we will focus on macOS Homebrew.

1. get Homebrew from https://brew.sh

2. add this tap and install `rstudio-server`

```sh
brew tap randy3k/rstudio-server
brew install rstudio-server
```

3. register RStudio Server daemon

```sh
# unload the daemon if it has previously installed
# sudo launchctl unload -w /Library/LaunchDaemons/com.rstudio.launchd.rserver.plist
sudo cp /usr/local/opt/rstudio-server/extras/launchd/com.rstudio.launchd.rserver.plist /Library/LaunchDaemons/
sudo launchctl load -w /Library/LaunchDaemons/com.rstudio.launchd.rserver.plist
```

4. install the PAM configuration

```sh
sudo cp /usr/local/opt/rstudio-server/extras/pam/rstudio /etc/pam.d/
```

5. authenticate users with id > 500. Add the following line to `/etc/rstudio/rserver.conf`

```sh
auth-minimum-user-id=500
```

6. start `rstudio-server`
```
sudo rstudio-server start
```
