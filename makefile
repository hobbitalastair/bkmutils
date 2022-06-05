PREFIX := ${DESTDIR}/usr
BINDIR := ${PREFIX}/bin
DESKTOPDIR := ${PREFIX}/share/applications
MIMEDIR := ${PREFIX}/share/mime/packages
COMPLETION_DIR_BASH := ${PREFIX}/share/bash-completion
LIBS =
CC = gcc
CFLAGS = -Wall -Werror -O2 -g
OBJS = bkm-create bkm-open
COMPLETION = completion/bash_completion.sh
MIME = x-bkmutils.xml
DESKTOP = bkm-open.desktop

all: $(OBJS)

%: %.c
	$(CC) -o $@ $< $(LIBS) $(CFLAGS)

%: %.sh
	cp -f $< $@
	chmod +x $@

install: install_objs install_completion install_mime install_desktop
	
install_objs: $(OBJS)
	mkdir -p "${BINDIR}/"
	for obj in ${OBJS}; do \
	    install -m755 "$$obj" "${BINDIR}/"; \
	done

install_completion: $(COMPLETION)
	mkdir -p "${COMPLETION_DIR_BASH}/completions/"
	for obj in ${OBJS}; do \
	    ln $(COMPLETION) \
	        "${COMPLETION_DIR_BASH}/completions/$$obj"; \
	done

install_mime: $(MIME)
	install -Dm644 "${MIME}" "${MIMEDIR}/${MIME}"

install_desktop: $(DESKTOP)
	mkdir -p "${DESKTOPDIR}/"
	for obj in ${DESKTOP}; do \
		install -m644 "$$obj" "${DESKTOPDIR}/"; \
	done

clean:
	rm -f $(OBJS)
