# Дипломный практикум в Yandex.Cloud

### Этапы выполнения:
   * [Создание облачной инфраструктуры](#создание-облачной-инфраструктуры)
   * [Создание Kubernetes кластера](#создание-kubernetes-кластера)
   * [Создание тестового приложения](#создание-тестового-приложения)
   * [Подготовка cистемы мониторинга и деплой приложения](#подготовка-cистемы-мониторинга-и-деплой-приложения)
   * [Установка и настройка CI/CD](#установка-и-настройка-cicd)


### Создание облачной инфраструктуры

Ссылка на коммит по первой части: https://github.com/hatredlex/netol-diplom-terr/commit/8f5630f64cbf03689d437fdb6537bfac52811b7c

<br><br>


Структура репозитория:

<img width="248" height="478" alt="image" src="https://github.com/user-attachments/assets/a59dd24b-f0ca-4dfe-b031-bf194f1cb8ab" />

<br><br>

Создание bootstrap ресурсов:

<img width="604" height="187" alt="image" src="https://github.com/user-attachments/assets/5cbf5e8b-de50-4199-b066-03069518702d" />

<br><br>

Создание основной инфраструктуры:

<img width="547" height="250" alt="image" src="https://github.com/user-attachments/assets/abbd17d7-b18d-4a17-8c4a-b3738ed942ca" />

<img width="1469" height="387" alt="image" src="https://github.com/user-attachments/assets/65f8ed1b-b79b-4fb8-b528-433b5e11ba75" />

<br><br>

state действительно лежит в бакете:

<img width="1513" height="411" alt="image" src="https://github.com/user-attachments/assets/da2e8cdf-0841-4f78-a4a0-be94be2e2236" />

<br><br>

Создание и удаление ресурсов без дополнительных ручных действий:

<img width="1170" height="936" alt="image" src="https://github.com/user-attachments/assets/cbffdab3-bdef-4b67-a989-a5a3d7152482" />

<img width="1175" height="900" alt="image" src="https://github.com/user-attachments/assets/db552162-e180-4bd7-908a-d17119ed0c21" />

<img width="1178" height="944" alt="image" src="https://github.com/user-attachments/assets/baa0500b-db6d-49ef-852a-d9105646c5a9" />

<img width="1169" height="867" alt="image" src="https://github.com/user-attachments/assets/78819c82-01b4-417f-a31a-401ce512f0ed" />

<br><br>

---
### Создание Kubernetes кластера

Ссылка на коммит по второй части: https://github.com/hatredlex/netol-diplom-terr/commit/3a4b5ac1b2c4db16a0980de1e914c1ba4748c662

<br><br>

Структура репозитория:

<img width="236" height="557" alt="image" src="https://github.com/user-attachments/assets/d74a5df1-e1ce-4317-9df0-a873ee931202" />

<br><br>

Создан кластер с тремя нодами в разных зонах:

<img width="971" height="456" alt="image" src="https://github.com/user-attachments/assets/2e090079-a664-428f-9694-daa349206560" />

<img width="1779" height="441" alt="image" src="https://github.com/user-attachments/assets/f696b1b5-4008-427d-b9df-7a3e0400988d" />

<br><br>

Получаем конфиг для подключения к кластеру:

<img width="969" height="443" alt="image" src="https://github.com/user-attachments/assets/4162ee78-c2a2-4d15-bdc8-916447771856" />

<br><br>

Проверяем работоспособность, команды выполняются без ошибок:

<img width="955" height="542" alt="image" src="https://github.com/user-attachments/assets/2d7d29ef-8863-4ca1-baed-4d9cf3fae2d7" />

<br><br>

---
### Создание тестового приложения

Создание Yandex Container Registry добавляем в Terraform.

Ссылка на коммит по третьей части: https://github.com/hatredlex/netol-diplom-terr/commit/e386138bdae74c17309ed93153d8b8ebfab49cd5

Ссылка на репозиторий с Nginx-приложением: https://github.com/hatredlex/netol-diplom-nginx


<br><br>


Структура репозитория:

<img width="247" height="608" alt="image" src="https://github.com/user-attachments/assets/f61aa7ac-a943-4e4d-8a98-6e1fd5b4fbe4" />

<br><br>

Сборка образа:

<img width="1331" height="705" alt="image" src="https://github.com/user-attachments/assets/b4860fe6-1ea2-4ac5-8c1a-881cd11d2f85" />

<br><br>

Проверка:

<img width="939" height="800" alt="image" src="https://github.com/user-attachments/assets/cda90cfb-2437-4696-9eb8-851a6b8e3bbd" />

<br><br>

Загрузка в репозиторий:

<img width="1051" height="366" alt="image" src="https://github.com/user-attachments/assets/416962eb-b214-4812-aa32-24c8a45ac5cd" />

<br><br>

---

### Подготовка cистемы мониторинга и деплой приложения

Ссылка на коммит по четвертой части: 

<br><br>

Структура репозитория:


