# Homebrew formulas for R and related tools

As [homebrew-science](https://github.com/Homebrew/homebrew-science) has been
deprecated, this tap is now used to host the formula for [RStudio
Server](https://www.rstudio.com/products/rstudio/download-server/) and other related stuffs. The
bottles are built by CircieCI and uploaded to Github release page.

## Installing r with x11 support

<details>
1. add this tap and install `r-x11`

```sh
brew tap randy3k/r
brew install r-x11
```
</details>

## Installing rstudio-server

<details>
Although this formula should also work for Linuxbrew, but we will focus on macOS Homebrew.

1. add this tap and install `rstudio-server`

```sh
brew tap randy3k/r
brew install rstudio-server
```

2. register RStudio Server daemon

```sh
# unload the daemon if it has previously installed
# sudo launchctl unload -w /Library/LaunchDaemons/com.rstudio.launchd.rserver.plist
sudo cp /usr/local/opt/rstudio-server/extras/launchd/com.rstudio.launchd.rserver.plist /Library/LaunchDaemons/
sudo launchctl load -w /Library/LaunchDaemons/com.rstudio.launchd.rserver.plist
```

3. install the PAM configuration

```sh
sudo cp /usr/local/opt/rstudio-server/extras/pam/rstudio /etc/pam.d/
```

4. authenticate users with id > 500. Add the following line to `/etc/rstudio/rserver.conf`

```sh
auth-minimum-user-id=500
```

5. start `rstudio-server`
```
sudo rstudio-server start
```

</details>

