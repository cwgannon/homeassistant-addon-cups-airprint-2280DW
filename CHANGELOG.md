# Changelog

## [1.2.1] - 2026-11-10

- Correct stale metadata: repository.json, the add-on description, build.yaml
  (now matches the Dockerfile's base image) and the README.
- Remove the unused s6 `cups-server` service and an incorrect image version
  label; cupsd is started only by run.sh.

## [1.2.0] - 2026-11-10

- Fix iPhones/iPads picking A4 (and the printer stopping with "no paper"):
  new `paper_size` option (letter, a4, legal; default letter) sets the CUPS
  default paper, the paper CUPS reports as loaded, and each queue's PPD default.
- Build the add-on locally from the Dockerfile instead of pulling the
  upstream prebuilt image, so changes in this repo actually ship.

## [1.1.0] - 2025-11-21

- Almidar's fork for the Brother HL2240: adds the Brother HL2240 drivers,
  amd64 only, and uses the prebuilt image `docker.io/mluhmann/haos-cups`.

Earlier versions (up to 1.7) are in the upstream
[zajac-grzegorz/homeassistant-addon-cups-airprint](https://github.com/zajac-grzegorz/homeassistant-addon-cups-airprint) repository.
