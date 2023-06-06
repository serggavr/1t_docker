Создаем образ:   

`build` - **создать образ**  
`-t` - **тег** или версия_образа (имя_образа:**версия_образа**)  
`test_image:latest` - **имя_образа** (**имя_образа**`:`версия_образа)  
`.` - **путь** к Dockerfile (текущая директория)

```docker
docker build -t test_image:latest . 
```
Создаем контейнер:

`run` - **создать контейнер**  
`--rm` - **удалить контейнер после завершения работы**  
`-d` - **не блокировать командную строку**  
`-p 5432:5432` - **указание портов**, внутри контейнера `:` снаружи контейнера  
`--name test_container` - **имя контейнера**  
`test_image:latest` - **имя образа** на основе которого создается контейнер
```docker
docker run --rm -d -p 5435:5432 --name test_container test_image:latest
```

Запускаем psql в контейнере:

`exec` - **входим в работающий контейнер**  
`-it` - **запускаем терминал**
`psql -U postgres` - запускаем в терминале **psql**  
`-U` - от имени пользователя `postres` 

```docker
docker exec -it test_container psql -U postgres 
```
Запускаем контейнер с volume, для сохранения изменений в контейнере:

`-v` -  
`/data:/var/lib/postgresql/data` - `/data` - путь к volume на локальном компьютере, `/var/lib/postgresql/data` - путь в контейнере


```docker
docker run --rm -d -p 5432:5432 --name test_container -v /data:/var/lib/postgresql/data test_image:latest
```

 
