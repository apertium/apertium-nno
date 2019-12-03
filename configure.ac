AC_PREREQ(2.52)

AC_INIT([Apertium Norwegian Nynorsk], [1.1.0], [apertium-stuff@lists.sourceforge.net], [apertium-nno], [http://wiki.apertium.org/wiki/Apertium-nno])
AM_INIT_AUTOMAKE
AC_PROG_AWK

PKG_CHECK_MODULES(APERTIUM, apertium >= 3.6.0)
PKG_CHECK_MODULES(LTTOOLBOX, lttoolbox >= 3.5.0)
PKG_CHECK_MODULES(CG3, cg3 >= 1.3.0)

AP_MKINCLUDE

AC_OUTPUT([Makefile apertium-nno.pc])
