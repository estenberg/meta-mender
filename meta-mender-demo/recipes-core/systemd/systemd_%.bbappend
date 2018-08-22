PACKAGECONFIG_append = " networkd resolved"
RDEPENDS_${PN}_append = " bash"

FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SYSTEMD_AUTO_ENABLE ?= "enable"
SYSTEMD_SERVICE_${PN} = "blinkenlights.service"

SRC_URI += " \
    file://eth.network \
    file://enp.network \
    file://blinkenlights.service \
    file://blinkenlights.sh \
"


FILES_${PN} += " \
    ${sysconfdir}/systemd/network/eth.network \
    ${sysconfdir}/systemd/network/enp.network \
    ${sysconfdir}/systemd/system/blinkenlights.service \
    ${sbindir}/blinkenlights.sh \
"


do_install_append() {
  if ${@bb.utils.contains('PACKAGECONFIG','networkd','true','false',d)}; then
        install -d ${D}${sysconfdir}/systemd/network
        install -m 0755 ${WORKDIR}/eth.network ${D}${sysconfdir}/systemd/network
        install -m 0755 ${WORKDIR}/enp.network ${D}${sysconfdir}/systemd/network
  fi

  install -d ${D}/${systemd_unitdir}/system
  install -m 0644 ${WORKDIR}/blinkenlights.service ${D}/${systemd_unitdir}/system

  install -d ${D}${sbindir}
  install -m 0755 ${WORKDIR}/blinkenlights.sh ${D}${sbindir}
}
