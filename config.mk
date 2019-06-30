# quark version
VERSION = 0

# Customize below to fit your system.

# Paths.
PREFIX = /usr/local
MANPREFIX = $(PREFIX)/share/man

# Flags.
CPPFLAGS = -DVERSION=\"$(VERSION)\" -D_DEFAULT_SOURCE -D_XOPEN_SOURCE=700 -D_BSD_SOURCE
CFLAGS   = -std=c99 -pedantic -Wall -Wextra -Os
LDFLAGS  = -s

# Compiler and linker.
CC = tcc
