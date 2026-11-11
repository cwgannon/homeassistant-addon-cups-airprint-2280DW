# CUPS AirPrint add-on for a Brother HL-2280DW

A Home Assistant add-on that runs a CUPS print server and advertises its
shared printers to iPhones and iPads over AirPrint. Avahi runs in reflector
mode. The add-on is amd64 only and builds locally from the Dockerfile, so the
first install takes several minutes.

It is set up for a Brother HL-2280DW. The image also bundles Brother's HL2240
LPR and CUPS wrapper drivers.

## Paper size (iPhone/iPad picking A4)

Set the add-on's **paper_size** option to the paper in your tray (`letter`,
`a4` or `legal`, default `letter`). On each start the add-on tells CUPS that
this is the only paper loaded, so iOS stops offering A4/A5. After changing it,
restart the add-on, then on the iPhone remove the printer from recent printers
(or toggle Wi-Fi) so iOS re-reads the printer's settings.

## Setup

- CUPS web interface: `http://<home-assistant-ip>:631`
- Administrator login: **print**, password: **print** (set in the Dockerfile)
- CUPS configuration (queues, PPDs) is kept in the add-on's config folder:
  `/addon_configs/<repository-id>_cupsik/cups` on the host (the `addon_configs`
  Samba share), `/config/cups` inside the container.
- The add-on uses host networking on port 631. Don't run another CUPS add-on
  at the same time.

[![Open your Home Assistant instance and show the add add-on repository dialog with a specific repository URL pre-filled.](https://my.home-assistant.io/badges/supervisor_add_addon_repository.svg)](https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https%3A%2F%2Fgithub.com%2Fcwgannon%2Fhomeassistant-addon-cups-airprint-2280DW)

## Credits

Forked from Almidar's HL2240 version, which is based on Grzegorz Zajac's
[homeassistant-addon-cups-airprint](https://github.com/zajac-grzegorz/homeassistant-addon-cups-airprint).
