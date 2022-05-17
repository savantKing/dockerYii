
all: app mysql migrate test

live: app mysql migrate

app: mysql migrate
	docker build -t mashiox/yii-app .

mysql:
	docker build -t mashiox/yii-db -f Dockerfile.mysql .

migrate:
	docker build -t mashiox/yii-migrate -f Dockerfile.migrate .

test: app
	docker build -t mashiox/yii-testing-app -f Dockerfile.test .
