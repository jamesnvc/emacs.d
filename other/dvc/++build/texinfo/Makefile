

##############################################################################
# location of required programms
RM   = /bin/rm
XARGS = xargs
ETAGS = etags
ARCH = /bin/true
INSTALL = /usr/bin/install -c
INSTALL_PROGRAM = ${INSTALL}
INSTALL_SCRIPT = ${INSTALL}
INSTALL_DATA = ${INSTALL} -m 644
MAKEINFO = makeinfo
TEXI2DVI = texi2dvi

EMACS_PROG = emacs -no-site-file -no-init-file
EMACS_FLAVOR = emacs
EMACS_VERSION = 23.0.60.1

# Other settings
SYMLINKS = no
LINKPATH = 

datarootdir = ${prefix}/share
prefix = /usr/local
info_dir = ${datarootdir}/info

##############################################################################
all: info dvc.dvi  dvc.html dvc.pdf

dvi: dvc.dvi

pdf: dvc.pdf

html: dvc.html

Makefile: ../../texinfo/Makefile.in ../config.status
	cd ..; ./config.status

install: uninstall info
	$(INSTALL) -d -m 0755 $(info_dir);                             \
	if test "x$(SYMLINKS)" = "xno" ; then                          \
          for i in `ls dvc.info* ` ; do                                \
	    echo "Installing $$i in $(info_dir)" ;                     \
            $(INSTALL_DATA) $$i $(info_dir) ;                          \
          done ;                                                       \
        else                                                           \
          if test "x$(LINKPATH)" = "x" ; then                          \
            for i in `ls dvc.info* ` ; do                              \
              echo "Linking $$i in $(info_dir)" ;                      \
              $(LN_S) `pwd`/$$i $(info_dir)/$$i ;                      \
            done ;                                                     \
          else                                                         \
            for i in `ls dvc.info* ` ; do                              \
              echo "Linking $(LINKPATH)/texinfo/$$i in $(info_dir)" ;  \
              $(LN_S) $(LINKPATH)/texinfo/$$i $(info_dir)/$$i ;        \
            done ;                                                     \
          fi ;                                                         \
        fi
	@echo DVC INFO files successfully installed\!

uninstall:
	-$(RM) -f $(info_dir)/dvc.info*

info: dvc.info

dvc.info: ../../texinfo/dvc.texinfo ./dvc-version.texinfo
	@if test "x$(MAKEINFO)" = "x" ; then                  \
           $(EMACSINFO) ../../texinfo/dvc.texinfo -o $@ ;          \
         else                                                 \
           $(MAKEINFO) ../../texinfo/dvc.texinfo -o $@ ;           \
         fi

dvc.html: ../../texinfo/dvc.texinfo ./dvc-version.texinfo
	@if test "x$(MAKEINFO)" = "x" ; then                    \
           $(EMACSINFO) ../../texinfo/dvc.texinfo ;                  \
         else                                                   \
           $(MAKEINFO) --html --no-split ../../texinfo/dvc.texinfo ; \
         fi

dvc.dvi: ../../texinfo/dvc.texinfo ./dvc-version.texinfo
	@if test "x$(TEXI2DVI)" = "x" ; then                 \
           echo "Sorry, no \`texi2dvi' program available." ; \
         else                                                \
           $(TEXI2DVI) ../../texinfo/dvc.texinfo -o $@ ;          \
         fi

dvc.pdf: ../../texinfo/dvc.texinfo ./dvc-version.texinfo
	@if test "x$(TEXI2DVI)" = "x" ; then                 \
           echo "Sorry, no \`texi2dvi' program available." ; \
         else                                                \
           $(TEXI2DVI) -p ../../texinfo/dvc.texinfo -o $@;        \
         fi

clean:
	-$(RM) -f *.aux *.cp *.cps *.dvi *.pdf *.fn *.fns *.ky *.log *.pg \
	  *.toc *.tp *.vr *.vrs *.html *.info dvc-version.texinfo

distclean: clean
	-$(RM) -f Makefile

.PHONY: pdf dvi html info clean distclean install-pkg uninstall-pkg all

ARCH_DIR_EXISTS=${shell if [ -r '../../{arch}' ]; then printf "%s" yes; else printf "%s" no; fi }

ifeq ($(ARCH_DIR_EXISTS),yes)
dvc-version.texinfo: ../../{arch}
	$(RM) -f $@
	printf "%s" "@verbatim " >> $@
	if [ "x$(RELEASE_ID)" != "x" ]; then                         \
		printf "%s (%s)" $(RELEASE_ID)                       \
		`$(ARCH) logs -f -d "../.." | tail -1` >> $@; \
	else                                                         \
		$(ARCH) logs -f -d "../.." | tail -1 >> $@;   \
	fi
	@echo >> $@
	@echo "@end verbatim" >> $@
	chmod -w $@
else
dvc-version.texinfo:
	$(RM) -f $@
	@echo "*** Warning: Unknown DVC arch release"
	if [ "x$(RELEASE_ID)" != "x" ]; then         \
		printf "%s" "$(RELEASE_ID)" >> $@;   \
	else                                         \
		printf "%s" "Unknown version" >> $@; \
	fi
	chmod -w $@
endif
