# Changelog

## [1.2.0] - 2026-11-10

- Fix iPhones/iPads picking A4 (and the printer stopping with "no paper"):
  new `paper_size` option (letter, a4, legal; default letter) sets the CUPS
  default paper, the paper CUPS reports as loaded, and each queue's PPD default.
- Build the add-on locally from the Dockerfile instead of pulling the
  upstream prebuilt image, so changes in this repo actually ship.

## [1.1.0] - 2025-02-20

- Update for HAOS 2025.11.2

## [1.0.0] - 2025-02-20

- Initial release

