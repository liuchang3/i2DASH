AC_INIT([i2dash], [1.0])
#AC_CONFIG_SRCDIR([segmenter/src/DashSegment.cpp])
#AC_CONFIG_SRCDIR([segmenter/test/DemuxerTest.cpp])
AM_INIT_AUTOMAKE([foreign subdir-objects])
AC_PROG_CC
AC_PROG_CXX
AC_CONFIG_HEADERS([config.h])
AC_CONFIG_FILES([
 Makefile
 segmenter/Makefile
])
LDFLAGS="$LDFLAGS -L/usr/local/lib"
AC_CHECK_LIB([avformat], [av_dump_format], [])
AC_CHECK_LIB([avcodec], [av_free_packet], [])
AC_CHECK_LIB([avutil], [av_get_bytes_per_sample], [])
AC_CHECK_LIB([cppunit], [main], [])
AC_CHECK_LIB([tinyxml2], [main], [])
AC_PROG_RANLIB
AC_OUTPUT

