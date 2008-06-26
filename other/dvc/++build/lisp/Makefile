

##############################################################################
# location of required programms
prefix = /usr/local
RM   = /bin/rm
LS   = /bin/ls
XARGS = xargs
ETAGS = etags
ARCH = /bin/true
INSTALL = /usr/bin/install -c
INSTALL_PROGRAM = ${INSTALL}
INSTALL_SCRIPT = ${INSTALL}
INSTALL_DATA = ${INSTALL} -m 644

top_srcdir = ../..
srcdir = ../../lisp

datadir= $(prefix)/share
datarootdir= ${prefix}/share
lispdir = $(prefix)/share/emacs/site-lisp/dvc
contribdir = contrib

EMACS_PROG = emacs
EMACS_FLAVOR = emacs

FLAGS = -batch -q --no-site-file -no-init-file -l $(srcdir)/dvc-build.el

# Other settings

OTHERDIRS = 

EMACS_COMP = lispdir=$(lispdir) srcdir=$(srcdir) otherdirs="$(OTHERDIRS)" $(EMACS_PROG) $(FLAGS)

SYMLINKS = no
LINKPATH = 

all: dvc-version.el dvc-site.el clean-some autoloads
	$(EMACS_COMP) -f package-maint-compile

all-verbose: dvc-version.el clean-some autoloads
	$(EMACS_COMP) -f package-maint-compile-verbosely

install: install-el install-elc

# This entry will never install .el files if there are no .elc files.
install-el: autoloads
	$(INSTALL) -d -m 0755 $(lispdir)/
	for elc in *.elc; do                                                  \
	    el=`basename $$elc c`;                                            \
	    if test -f "$(srcdir)/$$el"; then                                 \
	        echo "Install $$el in $(lispdir)/";                           \
	        $(INSTALL_DATA) ${srcdir}/$$el $(lispdir)/;                   \
	    fi;                                                               \
        done;
	if $(LS) $(contrib)/*.elc > /dev/null 2>&1; then                      \
	    for elc in $(contribdir)/*.elc; do                                \
	        el=`basename $$elc c`;                                        \
	        if test -f "${srcdir}/$(contribdir)/$$el"; then               \
	            echo "Install $(contribdir)/$$el in $(lispdir)/";         \
	            $(INSTALL_DATA) ${srcdir}/$(contribdir)/$$el $(lispdir)/; \
	        fi;                                                           \
	    done;                                                             \
	fi;

install-elc:
	$(INSTALL) -d -m 0755 $(lispdir)/
	for elc in *.elc; do                                 \
	    echo "Install $$elc in $(lispdir)/";             \
	    $(INSTALL_DATA) $$elc $(lispdir)/;               \
        done;
	if $(LS) $(contribdir)/*.elc > /dev/null 2>&1; then  \
	    for elc in $(contribdir)/*.elc; do               \
	        echo "Install $$elc in $(lispdir)";          \
	        $(INSTALL_DATA) $$elc $(lispdir);            \
	    done;                                            \
	fi;


clean:
	-$(RM) -f *.elc ./contrib/*.elc dvc-version.el dvc-site.el \
		dvc-load.el dvc-autoloads.el auto-autoloads.el custom-load.el .build-stamp

clean-some:
	$(EMACS_COMP) -f package-maint-clean-some-elc

Makefile: ../../lisp/Makefile.in ../config.status
	cd ..; ./config.status

distclean: clean
	-$(RM) -f Makefile

TAGS: $(SRCS)
	@if test "x$(ETAGS)" = "x" ; then                 \
           echo "Sorry, no \`etags' program available." ; \
         else                                             \
           $(ETAGS) */*.el                              ; \
         fi

##############################################################################
autoloads:
	$(EMACS_COMP) -f package-maint-make-cus-load $(srcdir)
	$(EMACS_COMP) -f package-maint-make-auto-load $(srcdir)
	$(EMACS_COMP) -f package-maint-make-load


##############################################################################
ARCH_DIR_EXISTS=${shell if [ -r '../../{arch}' ]; then printf "%s" yes; else printf "%s" no; fi }

ifeq ($(ARCH_DIR_EXISTS),yes)
dvc-version.el: ../../{arch} $(SRCS:%=../../lisp/%)
	$(RM) -f $@
	echo ';; do not edit -- automatically generated file' > $@
	echo ';; do not delete -- needed for bug reports' >> $@
	printf "%s" '(defconst dvc-version "' >> $@
	if [ "x$(RELEASE_ID)" != "x" ]; then \
		printf "%s (%s)" $(RELEASE_ID) \
		`$(ARCH) logs -f -d ../.. | tail -1` >> $@; \
	else \
		printf "%s" `$(ARCH) logs -f -d ../.. | tail -1` >> $@; \
	fi
	echo '")' >> $@
	echo "(provide 'dvc-version)" >> $@
	chmod -w $@
else
dvc-version.el: $(SRCS:%=../../lisp/%)
	$(RM) -f $@
	echo ';; do not edit -- automatically generated file' > $@
	echo ';; do not delete -- needed for bug reports' >> $@
	@echo "*** Warning: Unknown Xtla arch release"
	printf "%s" '(defconst dvc-version "' >> $@
	if [ "x$(RELEASE_ID)" != "x" ]; then \
		printf "%s" "$(RELEASE_ID)" >> $@; \
	else \
		printf "%s" "Unknown version" >> $@; \
	fi
	echo '")' >> $@
	echo "(provide 'dvc-version)" >> $@
	chmod -w $@
endif

dvc-site.el: ../config.status ../../lisp/dvc-site.el.in
	(cd .. ; ./config.status lisp/$@)
