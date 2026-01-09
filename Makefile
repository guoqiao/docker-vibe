name := vibe

show:
	docker image ls | grep ${name}

build:
	docker build -t ${name} .
	make show

run:
	bash run.sh

shell: run

sh: run

link:
	ln -sf ${PWD}/run.sh ~/bin/vibe