init:
	@make build
	@make up
	docker compose exec front bash -c 'npm install'
up:
	docker compose up -d
down:
	docker compose down
stop:
	docker compose stop
build:
	docker compose build --no-cache --force-rm
back:
	docker compose exec -it back sh
front:
	docker compose exec -it front bash
mysql:
	docker compose exec -it db bash
back-serve:
	docker compose exec back sh -c 'go run main.go'
front-serve:
	docker compose exec front bash -c 'npm run dev'