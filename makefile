PREFIX := ${DESTDIR}/usr
BINDIR := ${PREFIX}/bin
COMPLETION_DIR_BASH := ${PREFIX}/share/bash-completion
LIBS =
CC = gcc
CFLAGS = -Wall -Werror -O2 -g
OBJS = bkm-create bkm-open
COMPLETION = completion/bash_completion.sh

all: $(OBJS) $(SYSTEMD)

%: %.c
	$(CC) -o $@ $< $(LIBS) $(CFLAGS)

%: %.sh
	cp -f $< $@
	chmod +x $@

install: install_objs install_systemd install_completion
	
install_objs: $(OBJS)
	mkdir -p "${BINDIR}/"
	for obj in ${OBJS}; do \
	    install -m755 "$$obj" "${BINDIR}/"; \
	done

install_systemd: $(SYSTEMD)
	mkdir -p "${SYSTEMDUSERDIR}/"
	for service in ${SYSTEMD}; do \
	    install -m644 "$$service" "${SYSTEMDUSERDIR}/"; \
	done

install_completion: $(COMPLETION)
	mkdir -p "${COMPLETION_DIR_BASH}/completions/"
	for obj in ${OBJS}; do \
	    ln completion/bash_completion.sh \
	        "${COMPLETION_DIR_BASH}/completions/$$obj"; \
	done

clean:
	rm -f $(OBJS)
