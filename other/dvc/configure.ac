# configure.ac --- configuration setup for DVC

# Copyright (C) 2004-2007 by all contributors
# Author: Robert Widhopf-Fenk <hack@robf.de>

# DVC is free software; you can redistribute it and/or modify
# it under the terms of the GNU Library General Public License as published
# by the Free Software Foundation; either version 2 of the License, or (at
# your option) any later version.

# DVC is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Library General Public License for more details.

# You should have received a copy of the GNU Library General Public License
# along with this program; if not, write to the Free Software Foundation,
# Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

# Process this file with autoconf to produce a new configure script

m4_define([DVC_PRE_INIT],
[ m4_define([DVC_VERSION], 0) ])

# DVC_ARG_SUBST(VAR, OPTION, VAL, DESC[, DEFAULT[, ACTION]])
#
# Substitute the autoconf variable VAR to a value specified by the user
# option --with-OPTION[=VAL] (described by DESC), or with a DEFAULT value.
# If an additional ACTION is given, it is executed at the top of the
# ACTION-IF-FOUND part of AC_ARG_WITH.
# #### WARNING: pay attention to the quoting of ACTION if given !!!!!
AC_DEFUN([DVC_ARG_SUBST],
[
  AC_SUBST([$1])
  AC_ARG_WITH([$2],
    AC_HELP_STRING([--with-][$2]ifelse($3, [], [], [=$3]),
      [$4]ifelse($5, [], [], [ [[[$5]]]])),
    [
      ifelse($6, [], [], $6)
      $1="${withval}"
    ],
    ifelse($5, [], [], [$1="$5"]))
])

# DVC_COLON_TO_SPACE(VAR)
#
# Transforms a (possibly) colon separated list VAR into a space separated
# one. VAR needs not be quoted.
AC_DEFUN([DVC_COLON_TO_SPACE],
[ case "$$1" in *:*)
    $1="`echo $$1 | sed -e 's/:/ /g'`";;
  esac ])

# --with-other-dir option
AC_DEFUN([DVC_OTHERDIRS],
  [ DVC_ARG_SUBST([OTHERDIRS], [other-dirs], [DIRS],
    [set other needed directories (a list of space or colon separated paths)],
    [],
    dnl #### WARNING: pay attention to the quoting of ACTION if given !!!!!
    [[ DVC_COLON_TO_SPACE(withval) ]])])

# Find a (g)tar program and make sure it is GNU one. A failure is not fatal
# since tar is needed for non critical targets only.
AC_DEFUN([DVC_PROG_GNU_TAR],
  [ AC_CHECK_PROGS(TAR, gtar tar)
    if test "x${TAR}" = "xtar" ; then
      AC_MSG_CHECKING([that tar is GNU tar])
      ${TAR} --version > /dev/null 2>&1 || TAR=
      if test "x${TAR}" = "x" ; then
        AC_MSG_RESULT(no)
      else
        AC_MSG_RESULT(yes)
      fi
    fi
    if test "x${TAR}" = "x" ; then
      AC_MSG_WARN([*** No GNU tar program found.])
      AC_MSG_WARN([*** Some targets will be unavailable.])
    fi ])

# Find a makeinfo program. A failure is not fatal, only info files won't be
# built.
AC_DEFUN([DVC_PROG_MAKEINFO],
  [ AC_CHECK_PROG(MAKEINFO, makeinfo, makeinfo)
    if test "x${MAKEINFO}" = "x" ; then
      AC_MSG_WARN([*** No makeinfo program found.])
      AC_MSG_WARN([*** Info files will not be built.])
    fi ])

# Find a texi2dvi program. A failure is not fatal, only dvi and pdf files
# won't be built.
AC_DEFUN([DVC_PROG_TEXI2DVI],
  [ AC_CHECK_PROG(TEXI2DVI, texi2dvi, texi2dvi)
    if test "x${TEXI2DVI}" = "x" ; then
      AC_MSG_WARN([*** No texi2dvi program found.])
      AC_MSG_WARN([*** DVI and PDF files will not be built.])
    fi ])

# Find an etags program. A failure is not fatal, only TAGS file won't be
# built.
AC_DEFUN([DVC_PROG_ETAGS],
  [ AC_CHECK_PROG(ETAGS, etags, etags)
    if test "x${ETAGS}" = "x" ; then
      AC_MSG_WARN([*** No etags program found.])
      AC_MSG_WARN([*** Tags file will not be built.])
    fi ])

# Find a program. A failure is not fatal, just issue a warning
AC_DEFUN([DVC_PROG_WARN],
  [ AC_SUBST([$1])
    AC_ARG_WITH([$2],
      AC_HELP_STRING([--with-][$2]=PROG, [$3]),
      [ [$1]=${withval} ],
      [
        AC_CHECK_PROG($1, $2, $2)
        if test "x${$1}" = "x" ; then
          AC_MSG_WARN([*** No $2 program found.])
        fi
      ])
  ])

# Find a program. A failure is not fatal.
AC_DEFUN([DVC_PROG],
  [ AC_SUBST([$1])
    AC_ARG_WITH([$2],
      AC_HELP_STRING([--with-][$2]=PROG, [$3]),
      [ [$1]=${withval} ],
      [
        AC_CHECK_PROG($1, $2, $2)
      ])
  ])

# Find an xargs program. A failure is not fatal, only clean/tarball will not
# work
AC_DEFUN([DVC_PROG_XARGS],
  [ AC_CHECK_PROG(XARGS, xargs, xargs)
    if test "x${XARGS}" = "x" ; then
      AC_MSG_WARN([*** No xargs program found.])
      AC_MSG_WARN([*** make clean/tarball will not work.])
    fi ])

AC_DEFUN([DVC_BAZ_OR_TLA],
  [ AC_MSG_CHECKING([arch branch to use])
    AC_ARG_WITH(arch,
      AC_HELP_STRING([--with-arch={baz|tla|none}]
        [Whether to use tla or baz (or none of them) by default]),
      [ ARCH_BRANCH=${withval} ]
      [ ])
    if test "x${BAZ}" != "x"; then
      if test "x${ARCH_BRANCH}" = "x"; then
        ARCH_BRANCH=baz
      fi
      ARCH=${BAZ}
    else
      if test "x${ARCH_BRANCH}" = "x"; then
        ARCH_BRANCH=tla
      fi
      ARCH=${TLA}
    fi
    if test "x${ARCH_BRANCH}" = "xnone"; then
      ARCH="${TRUE_PROG}"
    fi

    if test "y${ARCH_BRANCH}" = "ytla" -a "y${TLA}" = "y"; then
      ARCH="${TRUE_PROG}"
      ARCH_BRANCH=none
    fi
    if test "y${ARCH_BRANCH}" = "ytla" -a "y${TLA}" = "y"; then
      AC_MSG_ERROR([*** Can't use tla because tla isn't available])
    fi
    if test "x${ARCH_BRANCH}" = "xbaz" -a "x${BAZ}" = "x"; then
      AC_MSG_ERROR([*** Can't use baz because baz isn't available])
    fi
    AC_MSG_RESULT(${ARCH_BRANCH})
    AC_SUBST(ARCH_BRANCH)
    AC_SUBST(ARCH)
  ])


# Choose an Emacs flavor according to the --with-emacs user option, or try
# emacs and xemacs.
# We use EMACS_PROG instead of EMACS to avoid colliding with Emacs' own
# internal environment.
AC_DEFUN([DVC_PROG_EMACS],
  [ AC_ARG_WITH([emacs],
     AC_HELP_STRING([--with-emacs=PROG],
        [choose which flavor of Emacs to use]),
      [ EMACS_PROG="${withval}" ],
      [ AC_CHECK_PROGS(EMACS_PROG, emacs xemacs) ])
    if test "x${EMACS_PROG}" = "x" ; then
      dnl This is critical enough to generate an error and not a warning...
      AC_MSG_ERROR([*** No Emacs program found.])
    fi
    # EMACS TYPE ##################################################
    AC_MSG_CHECKING([emacs-type of ${EMACS_PROG}])
    cat > conftest.el <<TEST
(princ (format "%s" (if (featurep 'xemacs ) 'xemacs 'emacs)))
TEST
    EMACS_FLAVOR=`${EMACS_PROG} --no-site-file --batch -l conftest.el | ${GREP} .`
    if test "x${EMACS_FLAVOR}" = "xxemacs"; then
        SITEFLAG=-no-site-file
    else
        SITEFLAG=--no-site-file
    fi
    AC_MSG_RESULT([${EMACS_FLAVOR}])
    # EMACS VERSION ###############################################
    AC_MSG_CHECKING([emacs-version of ${EMACS_PROG}])
    cat > conftest.el <<TEST
(if (featurep 'xemacs )
     (princ (format "%d.%d%s"
                 emacs-major-version emacs-minor-version
                 (if (numberp emacs-patch-level)
                     (concat "." (number-to-string emacs-patch-level))
                   "")))
  (princ (format "%s" emacs-version)))
TEST
    EMACS_VERSION=`${EMACS_PROG} ${SITEFLAG} --batch -l conftest.el | ${GREP} .`
    # EMACS DEPENDENT SETTINGS ####################################
    # We may add a version check here ...
    AC_MSG_RESULT([${EMACS_VERSION}])

    # Copied from gnus aclocal.m4
    AC_ARG_WITH(lispdir,[  --with-lispdir=DIR      Where to install lisp files], lispdir=${withval})
    AC_MSG_CHECKING([where .elc files should go])
    if test -z "$lispdir"; then
      dnl Set default value
      theprefix=$prefix
      if test "x$theprefix" = "xNONE"; then
  	theprefix=$ac_default_prefix
      fi
      datadir="\$(prefix)/share"
      if test "$EMACS_FLAVOR" = "xemacs"; then
          datadir="\$(prefix)/lib"
          lispdir="${datadir}/${EMACS_FLAVOR}/site-packages/lisp/dvc"
          if test ! -d "${lispdir}"; then
             if test -d "${theprefix}/share/${EMACS_FLAVOR}/site-lisp"; then
                lispdir="\$(prefix)/lib/${EMACS_FLAVOR}/site-packages/lisp/dvc"
             fi
          fi
      else
          lispdir="${datadir}/${EMACS_FLAVOR}/site-lisp/dvc"
      fi
    fi
    AC_MSG_RESULT($lispdir)
    AC_SUBST(lispdir)

#    if test "x${EMACS_FLAVOR}" = "xemacs" ; then
#      PACKAGEDIR="${prefix}/share/emacs/site-lisp"
#    else
#      PACKAGEDIR="${HOME}/.xemacs/xemacs-packages"
#    fi

    AC_SUBST(EMACS_PROG)
    AC_SUBST(EMACS_FLAVOR)
    AC_SUBST(EMACS_VERSION)
    AC_SUBST(SITEFLAG)
])

# copied from gnus aclocal.m4
AC_DEFUN([DVC_BUILD_FLAGS], [
  AC_MSG_CHECKING([which options to pass on to (X)Emacs])
  if test "x$FLAGS" = "x"; then
    if test "x$EMACS_FLAVOR" = "xxemacs"; then
      FLAGS="-batch ${SITEFLAG} -no-autoloads -l \$(srcdir)/dvc-build.el"
    else
      FLAGS="-batch -q ${SITEFLAG} -no-init-file -l \$(srcdir)/dvc-build.el"
    fi
  else
    FLAGS=$FLAGS
  fi
  AC_MSG_RESULT($FLAGS)
  AC_SUBST(FLAGS)
])


# Copied from gnus aclocal.m4 (AC_PATH_INFO_DIR)
AC_DEFUN([DVC_PATH_INFO_DIR], [
  AC_MSG_CHECKING([where the TeXinfo docs should go])
  dnl Set default value.  This must be an absolute path.
  if test "$infodir" = "\${prefix}/info"; then
    if test "$EMACS_FLAVOR" = "xemacs"; then
      info_dir="\$(prefix)/${thedir}/${EMACS_FLAVOR}/site-packages/info"
    else
      info_dir="\$(prefix)/share/info"
    fi
  else
    info_dir=$infodir
  fi
  AC_MSG_RESULT($info_dir)
  AC_SUBST(info_dir)
])

AC_DEFUN([DVC_HAS_TREE_WIDGET],
  [ AC_MSG_CHECKING([whether tree-widget is in the load-path])
    OTHERDIRS_LIST='"'`echo ${OTHERDIRS} | sed 's/ /" "/g'`'"'
    cat > conftest.el << TEST
(mapcar (lambda (x) (add-to-list 'load-path x))
        '(${OTHERDIRS_LIST}))
(if (locate-library "tree-widget")
    (princ "yes")
    (princ "no"))
TEST
    HAS_TREE_WIDGET=`${EMACS_PROG} ${SITEFLAG} --batch -l conftest.el | ${GREP} .`
    AC_MSG_RESULT([${HAS_TREE_WIDGET}])
    if test "x${HAS_TREE_WIDGET}" = "xno" ; then
      AC_MSG_WARN([*** tree-widget.el not found in 'load-path.])
      AC_MSG_WARN([*** tla-browse.el won't be available unless you install it.])
      AC_MSG_WARN([*** See http://sourceforge.net/projects/emhacks/])
      AC_MSG_WARN([*** Provide the path to tree-widget with --with-other-dirs])
      AC_MSG_WARN([*** if tree-widget.el is already present on your system])
    fi
    AC_SUBST(HAS_TREE_WIDGET)
  ])

dnl dnl AC_DEFUN([DVC_RELEASE_ID],
dnl dnl         [ AC_MSG_CHECKING(for release ID)
dnl dnl           AC_ARG_WITH([release-id],
dnl dnl             AC_HELP_STRING([--with-release-id=ID],
dnl dnl             [Version number for an official release]),
dnl dnl             [ RELEASE_ID="${withval}";
dnl dnl               AC_MSG_RESULT(${RELEASE_ID})],
dnl dnl             [ RELEASE_ID="";
dnl dnl               AC_MSG_RESULT(none)])]
dnl dnl           AC_SUBST(RELEASE_ID))


##############################################################################
DVC_PRE_INIT
AC_INIT([DVC], [DVC_VERSION], [dvc-dev@gna.org])

# It seems that the latest GNU Emacs sets --always-color to GREP_OPTIONS (for M-x grep?).
# So configure will confuse if it is run from emacs's *shell*.
# Clear the environment variable here.
unset GREP_OPTIONS

AC_COPYRIGHT([Copyright (C) 2004-2007 Robert Widhopf-Fenk <hack@robf.de> and the DVC team])

AC_CONFIG_SRCDIR([configure.ac])
AC_CONFIG_FILES([Makefile lisp/Makefile texinfo/Makefile dvc-load.el dvc-load-install.el lisp/dvc-site.el])

# Common system utilities checking:
AC_PROG_MAKE_SET
AC_PROG_INSTALL
AC_PROG_LN_S
AC_PATH_PROG(RM, rm, /bin/rm)
AC_PATH_PROG(LS, ls, /bin/ls)
AC_PATH_PROG(GREP, grep, /bin/grep)
AC_PATH_PROG(TRUE_PROG, true, /bin/true)

# External programs checking:
DVC_PROG_EMACS
DVC_BUILD_FLAGS
DVC_PATH_INFO_DIR


DVC_PROG(TLA, tla, tla program to use)
DVC_PROG(BAZ, baz, baz program to use)
DVC_PROG(BZR, bzr, Bazaar-NG)
if test "x$BZR" = "x" ; then
   BZR=${TRUE_PROG}
fi
DVC_BAZ_OR_TLA

DVC_PROG_WARN(DIFF, diff, diff program to use)
DVC_PROG_WARN(PATCH, patch, patch program to use)
DVC_PROG_ETAGS
DVC_PROG_XARGS
DVC_PROG_GNU_TAR
DVC_PROG_MAKEINFO
DVC_PROG_TEXI2DVI
DVC_OTHERDIRS
DVC_HAS_TREE_WIDGET
dnl dnl DVC_RELEASE_ID

# is there a sane way to set this to a useful default?
DVC_ARG_SUBST([PACKAGEDIR], [package-dir], [DIR],
  [set the Emacs package directory to DIR],)

DVC_ARG_SUBST([SYMLINKS], [symlinks], [],
  [install DVC by linking instead of copying], [no])

DVC_ARG_SUBST([LINKPATH], [linkpath], [PATH],
  [path to symlink from if `pwd' does not work])

AC_OUTPUT

# configure.ac ends here
