# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
PYTHON_DEPEND="2"
RESTRICT_PYTHON_ABIS="3"

MY_P=${PN}_${PV}

inherit eutils python

DESCRIPTION="Easy-union is a Nautilus extension which show content of multiple directories merged in a single-one"
HOMEPAGE="https://launchpad.net/nautilus-easy-unionfs"
SRC_URI="http://launchpad.net/${PN}/trunk/${PV}/+download/${MY_P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="libnotify"

DEPEND="dev-python/pyinotify
	dev-python/nautilus-python
	gnome-base/nautilus
	sys-fs/bindfs
	sys-fs/unionfs-fuse
	x11-libs/gtk+:2
	libnotify? ( dev-python/notify-python )"
RDEPEND="${DEPEND}"

DOCS="README"

S="${WORKDIR}/aaa"

src_prepare() {
	epatch "${FILESDIR}/${P}-make.patch" \
		"${FILESDIR}/${P}-pyinotify-0.8.patch" \
		"${FILESDIR}/${P}-unionfs-fuse.patch"
}

src_compile() {
	{ :; }
}

src_install() {
	emake -j1 DESTDIR="${D}" install || die
}

pkg_postinst() {
	elog "You have to restart Nautilus to use ${PN}"
	elog "		nautilus -q"
	elog "		nautilus --no-desktop"
}
