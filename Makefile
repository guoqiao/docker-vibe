name := vibe

UID := $(shell id -u)
GID := $(shell id -g)

init:
	touch .env
	sudo chown -R ${UID}:${GID} .

show:
	docker image ls | grep ${name}

build:
	docker build -t ${name} .
	make show

run: init
	bash run.sh

shell: run

sh: run

link:
	ln -sf ${PWD}/run.sh ~/bin/vibe
