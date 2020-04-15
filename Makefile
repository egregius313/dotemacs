USER_EMACS_CONFIGURATION_DIRECTORY=$(shell emacsclient -e '(expand-file-name user-emacs-directory)' | tr -d \")/configuration
CONFIGURATION_FILES=$(shell find ${USER_EMACS_CONFIGURATION_DIRECTORY} -type f -name '*.el')
CONFIGURATION_FILE_COMPILED=$(CONFIGURATION_FILES:.el=.elc)
EMACS_SERVER_NAME=byte-compile-server
EMACSCLIENT=emacsclient -s ${EMACS_SERVER_NAME}

.PHONY: pre-build post-build all

pre-build:
	emacs --daemon=${EMACS_SERVER_NAME}
post-build:
	${EMACSCLIENT} -e '(kill-emacs)'

config:
	printf "%s\n" ${CONFIGURATION_FILE_COMPILED}

%.elc: %.el
	${EMACSCLIENT} -e '(byte-compile-file "'$<'")'

all: pre-build ${CONFIGURATION_FILE_COMPILED} post-build

sbcl:
	sbcl --load make-sbcl-core.lisp
