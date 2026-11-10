# homeassistant addon cups airprint, forked and modified by Almidar. 
Many thanks to Zajac.

## Paper size (iPhone/iPad picking A4)

Set the add-on's **paper_size** option to the paper in your tray (`letter`,
`a4` or `legal`, default `letter`). On each start the add-on tells CUPS that
this is the only paper loaded, so iOS stops offering A4/A5. After changing it,
restart the add-on, then on the iPhone remove the printer from recent printers
(or toggle Wi-Fi) so iOS re-reads the printer's settings.

Original Text:
# homeassistant addon cups airprint
CUPS addon with working Avahi in reflector mode 

Tested with Home Assistant version **2025.2.3**

CUPS administrator login: **print**, password: **print** (can be changed in the Dockerfile)

Configuration data is stored in **/addon_configs/<slug>_cups** folder

[![Open your Home Assistant instance and show the add add-on repository dialog with a specific repository URL pre-filled.](https://my.home-assistant.io/badges/supervisor_add_addon_repository.svg)](https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https%3A%2F%2Fgithub.com%2Fzajac-grzegorz%2Fhomeassistant-addon-cups-airprint)
