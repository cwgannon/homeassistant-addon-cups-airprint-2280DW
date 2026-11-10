#!/usr/bin/with-contenv bashio

ulimit -n 524288

until [ -e /var/run/avahi-daemon/socket ]; do
  sleep 1s
done

bashio::log.info "Preparing directories"
if [ ! -d /config/cups ]; then cp -v -R /etc/cups /config; fi
rm -v -fR /etc/cups

ln -v -s /config/cups /etc/cups

# --- Paper size -------------------------------------------------------------
# iOS asks CUPS which paper is *loaded* (media-ready) and uses that. With no
# setting, CUPS falls back to the container's libpaper default (A4) and
# reports A4,A3,A5,A6,EnvDL as loaded, so iPhones pick A4 and the printer
# stops with "no paper". Pin the system default, the loaded-paper list and
# every queue's PPD default to the paper actually in the tray.
PAPER="$(bashio::config 'paper_size' 'letter')"
case "${PAPER}" in
  a4)    PPD_SIZE="A4" ;;
  legal) PPD_SIZE="Legal" ;;
  *)     PAPER="letter"; PPD_SIZE="Letter" ;;
esac
bashio::log.info "Paper size: ${PPD_SIZE}"

echo "${PAPER}" > /etc/papersize

CUPSD_CONF=/config/cups/cupsd.conf
sed -i -E '/^[[:space:]]*(DefaultPaperSize|ReadyPaperSizes)[[:space:]]/d' "${CUPSD_CONF}"
printf 'DefaultPaperSize %s\nReadyPaperSizes %s\n' "${PPD_SIZE}" "${PPD_SIZE}" >> "${CUPSD_CONF}"

for ppd in /config/cups/ppd/*.ppd; do
  [ -f "${ppd}" ] || continue
  if grep -q "^\*PageSize ${PPD_SIZE}[/:]" "${ppd}"; then
    sed -i -E "s/^\*Default(PageSize|PageRegion|ImageableArea|PaperDimension):.*/*Default\1: ${PPD_SIZE}/" "${ppd}"
    bashio::log.info "Set default paper to ${PPD_SIZE} in $(basename "${ppd}")"
  else
    bashio::log.warning "$(basename "${ppd}") has no ${PPD_SIZE} page size; left unchanged"
  fi
done

# Saved per-queue media defaults (from lpadmin/web UI) override the PPD default.
if [ -f /config/cups/printers.conf ]; then
  sed -i -E '/^Option (media|PageSize|PageRegion) /d' /config/cups/printers.conf
fi

bashio::log.info "Starting CUPS server as CMD from S6"

cupsd -f
