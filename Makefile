# See LICENSE file for copyright and license details
# $(TARGET) - simple web server
.POSIX:

include config.mk

COMPONENTS = util sock http resp
TARGET = jerk

all: $(TARGET)

util.o: util.c util.h config.mk
sock.o: sock.c sock.h util.h config.mk
http.o: http.c http.h util.h http.h resp.h config.h config.mk
resp.o: resp.c resp.h util.h http.h config.mk
main.o: main.c util.h sock.h http.h arg.h config.h config.mk

$(TARGET): $(COMPONENTS:=.o) $(COMPONENTS:=.h) main.o config.mk
	$(CC) -o $@ $(CPPFLAGS) $(CFLAGS) $(COMPONENTS:=.o) main.o $(LDFLAGS)

config.h:
	cp config.def.h $@

clean:
	rm -f $(TARGET) main.o $(COMPONENTS:=.o)

dist:
	rm -rf "$(TARGET)-$(VERSION)"
	mkdir -p "$(TARGET)-$(VERSION)"
	cp -R LICENSE Makefile arg.h config.def.h config.mk $(TARGET).1 \
		$(COMPONENTS:=.c) $(COMPONENTS:=.h) main.c "$(TARGET)-$(VERSION)"
	tar -cf - "$(TARGET)-$(VERSION)" | gzip -c > "$(TARGET)-$(VERSION).tar.gz"
	rm -rf "$(TARGET)-$(VERSION)"

install: all
	mkdir -p "$(DESTDIR)$(PREFIX)/bin"
	cp -f $(TARGET) "$(DESTDIR)$(PREFIX)/bin"
	chmod 755 "$(DESTDIR)$(PREFIX)/bin/$(TARGET)"
	mkdir -p "$(DESTDIR)$(MANPREFIX)/man1"
	cp $(TARGET).1 "$(DESTDIR)$(MANPREFIX)/man1/$(TARGET).1"
	chmod 644 "$(DESTDIR)$(MANPREFIX)/man1/$(TARGET).1"

uninstall:
	rm -f "$(DESTDIR)$(PREFIX)/bin/$(TARGET)"
	rm -f "$(DESTDIR)$(MANPREFIX)/man1/$(TARGET).1"
