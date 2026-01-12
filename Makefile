name := vibe

UID := $(shell id -u)
GID := $(shell id -g)

init:
	git pull || true
	touch .env
	sudo chown -R ${UID}:${GID} .

show:
	docker image ls | grep ${name}

build: init
	docker build --platform linux/amd64 -t ${name} .
	make show

run: init
	bash run.sh

shell: run

sh: run

link:
	ln -sf ${PWD}/run.sh ~/bin/vibe
