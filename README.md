# Задача 1
https://hub.docker.com/r/hatredlex/custom-nginx/tags

# Задача 2
![2](https://github.com/user-attachments/assets/b3ba70c7-6b8a-4608-83e0-04c51c804d7b)

# Задача 3
![3-1](https://github.com/user-attachments/assets/71c78452-b156-4f69-ad6c-379b77c53519)
Контейнер остановился потому что docker attach подключает наш терминал напрямую к pid1 процессу контейнера и команда ctrl+c отправляет сигнал на завршение этого процесса, если pid1 в контейнере завершается, то контейнер считается остановленным.

![3-2](https://github.com/user-attachments/assets/caf720e7-6033-4bfe-8863-fbabd7d5566b)
У нас порт 8080 хоста проброшен в 80 порт контейнера, мы внутри контейнера изменили порт, который слушает nginx на 81 и curl внутри контейнера возвращает 200 на нем, а с хоста подключение идет по прежнему на порт 80, который nginx уже не слушает.

# Задача 4
<img width="1202" height="467" alt="image" src="https://github.com/user-attachments/assets/ad0c4c04-ecdc-4f08-a139-811fcfa6a76f" />

# Задача 5
По умолчанию новый докер работает с файлом compose.yaml, старое имя docker-compose.yaml тоже поддерживается, но если существуют оба файла приоритет будет отдан compose.yaml
<img width="1341" height="876" alt="image" src="https://github.com/user-attachments/assets/c094a95e-9eb4-4d04-9361-89d0c38b61b2" />
<img width="1663" height="825" alt="image" src="https://github.com/user-attachments/assets/3d30e530-d72f-4159-b429-516cfdb7ebf9" />
В процессе выполнения задания наткнулся на баг, environment local в portainer не открывалось и было в статусе down. Ошибка в docker logs следующая: the Podman environment option doesn't support Docker environments. Please select the Docker option instead.
Думал что в задании подвох, но оказалось что это действующая issue, в новом докере повылиси минимальную версию api, из-за чего подман ен может подключиться к локальному docker. Проблему решил понижением минимальной версии api путем редактирования docker.service, с добавлением Environment=DOCKER_MIN_API_VERSION=1.24. После чего всё заработало.
Ссылка на issue: https://github.com/portainer/portainer/issues/12925?ysclid=mi0offiog9717715495
<img width="1920" height="1276" alt="5" src="https://github.com/user-attachments/assets/f28d9696-0a9f-4738-a07e-4261db1c6059" />
Мы удалили один из файлов compose.yaml и docker compose теперь не знает что делать с контейнерами, которые отсутствуют в текущем проекте, по этому предлагает ключ --remove-orphans чтобы удалить эти лишние контейнеры.
[compose.yaml](https://github.com/hatredlex/netology/blob/docker-intro/compose.yaml)
