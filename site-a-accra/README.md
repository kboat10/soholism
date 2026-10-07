# Site A: Accra

Owner: Kwaku

## Build notes

Record each step as you do it, with the command or menu path and what you saw. Future-you and recruiters both read this.

| Date | Step | Result / notes |
| --- | --- | --- |
| | Installed OpenWrt VM in UTM | |

## Configs

Put **sanitised** exports in `configs/`. Never commit raw exports.

```sh
# on the router
sysupgrade -b /tmp/backup-raw.tar.gz
# on your laptop, after copying it over
bash scripts/sanitise-config.sh site-a-accra/configs/network site-a-accra/configs/network.sanitised
```

## Screenshots

Put them in `screenshots/`, named `YYYY-MM-DD-what-it-shows.png`. Blur public IPs and MAC addresses first.
