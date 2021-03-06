TERMUX_PKG_MAINTAINER="Leonid Plyushch <leonid.plyushch@gmail.com> @xeffyr"

TERMUX_PKG_HOMEPAGE=https://www.wireshark.org/
TERMUX_PKG_DESCRIPTION="Network protocol analyzer"
TERMUX_PKG_VERSION=2.6.3
TERMUX_PKG_SRCURL=https://www.wireshark.org/download/src/wireshark-${TERMUX_PKG_VERSION}.tar.xz
TERMUX_PKG_SHA256=d158a8a626dc0997a826cf12b5316a3d393fb9f93d84cc86e75b212f0044a3ec

TERMUX_PKG_DEPENDS="c-ares, desktop-file-utils, glib, hicolor-icon-theme, libandroid-shmem, libgcrypt, libgnutls, libgtk3, liblua52, liblz4, libmaxminddb, libnghttp2, libnl, libpcap, libssh, libxml2"
TERMUX_PKG_CONFLICTS="tshark, wireshark, wireshark-cli"
TERMUX_PKG_PROVIDES="tshark, wireshark, wireshark-cli"
TERMUX_PKG_REPLACES="tshark, wireshark, wireshark-cli"

TERMUX_PKG_EXTRA_CONFIGURE_ARGS="--with-gtk=3"
TERMUX_PKG_BUILD_IN_SRC=true

termux_step_pre_configure() {
    export CFLAGS=$(echo $CFLAGS | sed 's@-Oz@-Os@g')
    export LIBS=" -landroid-shmem"
}

termux_step_post_configure() {
    ## prebuild libwsutil & libwscodecs for target (needed for plugins/codecs/l16_mono)
    cd ./wsutil && {
        make
        cd -
    }
    cd ./codecs && {
        make
        cd -
    }
}
