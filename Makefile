.PHONY: nuke init up down ps

up:
	docker-compose up -d

down:
	docker-compose down

ps:
	docker-compose ps

logs:
	docker-compose logs -f

nuke:
	rm -rf app
# 	rm -rf .meteor client imports node_modules server tests package*.json

init: app
	[ ! -f app/package.json ] # Please run `make nuke` if you want to restart with a fresh app
	docker-compose run --rm --entrypoint=/bin/bash --workdir=/home/node app /home/node/.meteor/meteor create --react /app

app:
	mkdir app