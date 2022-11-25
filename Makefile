PHP_CONTAINER=php
NODE_CONTAINER=node

init:
	docker-compose up --build -d
	docker-compose exec $(PHP_CONTAINER) bash -c "cp .env.example .env"
	docker-compose exec $(PHP_CONTAINER) bash -c "composer install"
	docker-compose exec $(PHP_CONTAINER) bash -c "php artisan key:generate"
	docker-compose exec $(PHP_CONTAINER) bash -c "php artisan migrate --seed"
	docker-compose exec $(NODE_CONTAINER) bash -c "npm i"
	make utility_1

up:
	docker-compose up -d
	make utility_1

dev:
	docker-compose exec $(NODE_CONTAINER) bash -c "npm run dev"

down:
	docker-compose down

php:
	docker-compose exec $(PHP_CONTAINER) bash

node:
	docker-compose exec $(NODE_CONTAINER) bash

utility_1:
	start "http://localhost:8000"
	make dev