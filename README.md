# Тестовое задание для 404 group

## Tech
* Ruby 2.5.1
* Rails 5.1.6
* MongoDB 4.0.3

## Setup
* ```git clone```
* ```bundle install```
* ```cp .env.example .env```
* ```rails s```
* ```sidekiq -C config/sidekiq.yml```

## Usage
Прием входящих запросов на отправку сообщений через очередь sidekiq
```
curl -u dhh:secret -X POST -H "Content-type: application/json" --data '{ "text": "Hello", "recipients": [ { "service": "telegramm", "uid": "tg_id" }, { "service": "viber", "uid": "phone_number" }]}' localhost:3000/send
```
Прием входящих запросов на отложенную отправку сообщений
```
curl -u dhh:secret -X POST -H "Content-type: application/json" --data '{ "text": "Hello", "send_in": 1554588253, "recipients": [ { "service": "telegramm", "uid": "tg_id" }, { "service": "viber", "uid": "phone_number" }]}' localhost:3000/send
```
Прием входящих запросов на отправку сообщений без очереди
```
curl -u dhh:secret -X POST -H "Content-type: application/json" --data '{ "text": "Hello", "recipients": [ { "service": "telegramm", "uid": "tg_id" }, { "service": "viber", "uid": "phone_number" }]}' localhost:3000/send_immediately
```
Получение информации о сообщении
```
curl -u dhh:secret -X GET -H "Content-type: application/json" localhost:3000/info/:message_id
```

## About
Пример параметров запроса для отправки сообщений
```
{
	"text": "Hello",
	"send_in": 1554588253,
	"recipients": [
		{ "service": "viber", "uid": "123456789" },
		{ "service": "telegramm", "uid": "123456789" }
	]
}
```

Даты в запросах и ответах в формате unix timestamp

## TODO
* исключение возможности многократной отправки одного и того же сообщения одному получателю
* покрыть тестами
