

# location of required programms
TAR = tar
BZR = bzr
RM   = /bin/rm
XARGS = xargs
ARCH = /bin/true
prefix = /usr/local
datadir= $(prefix)/share
datarootdir= ${prefix}/share
srcdir = ..
lispdir= $(prefix)/share/emacs/site-lisp/dvc

SUBDIRS = lisp texinfo

EMACS_PROG = emacs
EMACS_FLAVOR = emacs
EMACS_VERSION = 23.0.60.1
INSTALL = /usr/bin/install -c

##############################################################################
all: dvc info dvc-load.el dvc-load-install.el

maybe: dvc-maybe info dvc-load.el dvc-load-install.el

Makefile: config.status ../Makefile.in
	./config.status $@

dvc-load.el: config.status ../dvc-load.el.in
	./config.status $@

dvc-load-install.el: config.status ../dvc-load-install.el.in
	./config.status $@

../configure: ../configure.ac
	cd .. ; autoconf
	./config.status --recheck

config.status: ../configure
	./config.status --recheck

info:
	$(MAKE) -C texinfo info
pdf:
	$(MAKE) -C texinfo pdf
dvi:
	$(MAKE) -C texinfo dvi
html:
	$(MAKE) -C texinfo html

dvc: generated-files
	cd lisp; $(MAKE)

dvc-verbose: generated-files
	cd lisp; $(MAKE) all-verbose

install: dvc-load.el
	@for i in $(SUBDIRS) ; do               \
          $(MAKE) -C $$i install;               \
        done
	sed 's|$$(prefix)|$(prefix)|;s!$${datarootdir}!$(datarootdir)!' dvc-load-install.el \
	> ${lispdir}/dvc-load.el

uninstall:
	@for i in $(SUBDIRS) ; do               \
          $(MAKE) -C $$i uninstall;             \
        done
	rmdir $(lispdir) || true

clean:
	@for i in $(SUBDIRS) ; do               \
          $(MAKE) -C $$i clean;                 \
        done
	-$(RM) -f dvc-load.el dvc-load-install.el

distclean: clean
	@for i in $(SUBDIRS) ; do               \
          $(MAKE) -C $$i distclean;             \
        done
	-$(RM) -rf configure config.status config.log autom4te.cache/ Makefile

##############################################################################
TARFILES = configure $(shell cd /home/james/emacs.d/other/dvc/++build/.. && $(ARCH) inventory -s)

lisp/dvc-version.el:
	cd lisp; make dvc-version.el

texinfo/dvc-version.texinfo:
	cd texinfo; make dvc-version.texinfo

generated-files: lisp/dvc-version.el \
		 texinfo/dvc-version.texinfo

ifeq ($(RELEASE_ID),)
TARDIRNAME=dvc-snapshot
else
TARDIRNAME=dvc-$(RELEASE_ID)
endif

dist: tarball

tarball: $(TARFILES:%=/home/james/emacs.d/other/dvc/++build/../%)
	scripts/make-tarball.sh $(TARDIRNAME).tar.gz
	@echo "*** $(TARDIRNAME).tar.gz created ***"

##############################################################################
# for the creation of an XEmacs package
PKGDIR =  $(shell pwd)/,,package/
PKGINFO = $(PKGDIR)/lisp/xtla/_pkg.el
xemacs-package:
# 	cd /home/james/emacs.d/other/dvc/++build/.. && $(TLA) changes || \
# 	(echo ERROR: There are changes in the tree, please commit before creating a tarball\!;\
# 	 echo ERROR: since otherwise lisp/dvc-version.el is not correct\!; exit 1)
	if [ "xemacs" != "xxemacs" ]; then \
		echo "ERROR: Current build dir not configured for XEmacs,"; \
		echo "ERROR: Please re-run configure with --with-emacs=xemacs."; \
		exit 1; \
	fi
	-$(RM) -rf ,,package
	cd lisp; make PACKAGEDIR=$(PKGDIR)/lisp/xtla install-pkg
	cd texinfo; make info_dir=$(PKGDIR)/info install-pkg
	(cd ..; $(TLA) changelog) > $(PKGDIR)/lisp/ChangeLog
	echo ";;;###autoload" > $(PKGINFO)
	echo "(package-provide 'xtla'" > $(PKGINFO)
	echo "         :version 0.7" >> $(PKGINFO)
	echo '         :author-version "'`$(TLA) logs -fr -d ".." | head -1`'"' >> $(PKGINFO)
	echo "         :type 'regular)" >> $(PKGINFO)
	mkdir $(PKGDIR)/pkginfo;
	touch $(PKGDIR)/pkginfo/MANIFEST.xtla;
	cd $(PKGDIR); find -type f | cut -c3- > pkginfo/MANIFEST.xtla
	cd ,,package; $(TAR) -cvzf ../xtla-pkg.tar.gz *
