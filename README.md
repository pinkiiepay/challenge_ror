# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version ruby 3.3.1 (2024-04-23 revision c56cd86388) [arm64-darwin23]

* System dependencies
    Rails 7.1.3.2

    gem install mime-types
    gem install netrc
    gem install http-accept
    gem install rest-client

* Configuration

* Database creation
    No
* Database initialization
    No
* How to run the test suite
    No


## Deployment instructions (En español)

Se optó por utilizar rest client para hacer llamadas dentro del mismo servicio

https://github.com/rest-client/rest-client

Tiene una forma fácil de utilizar.

Para llamar al servicio en un entorno local:
```bash
  http://127.0.0.1:3000/api/getcity?city=chilp
```
Por ejemplo y el resultado está dentro del proyecto en un archivo llamado test.json

Hice otra prueba con mon, pero ustedes pueden utilizarlo como gusten

Para llamar al servicio en un entorno local:
```bash
  http://127.0.0.1:3000/api/getcity?city=mon
```
y el resultado está dentro del proyecto en un archivo llamado test2.json

Por finalizar tuve algunas complicaciones con el api de OWM así solo me dejaba hacer las consultas de 5 días 40 consultas cada 3 horas, tomé por ese caso el horario de las 12:00:00 de cada día de cada uno de los 5 días por cada ciudad.

La información del código está en:
```
    controllers/application_controller.rb
```

Ahí está lo qué hice y espero me den su feedback y sea de su agrado.