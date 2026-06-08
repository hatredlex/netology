# Дипломный практикум в Yandex.Cloud


### Ссылки на сервисы и конечные варианты файлов:

Репозиторий с конфигурационными файлами Terraform<br>
https://github.com/hatredlex/netol-diplom-terr

Репозиторий тестового приложения<br>
https://github.com/hatredlex/netol-diplom-nginx

Репозиторий с конфигурацией Kubernetes кластера<br>
https://github.com/hatredlex/netol-diplom-kuber


### Этапы выполнения:
   * [Создание облачной инфраструктуры](#создание-облачной-инфраструктуры)
   * [Создание Kubernetes кластера](#создание-kubernetes-кластера)
   * [Создание тестового приложения](#создание-тестового-приложения)
   * [Подготовка cистемы мониторинга и деплой приложения](#подготовка-cистемы-мониторинга-и-деплой-приложения)
   * [Установка и настройка CI/CD](#установка-и-настройка-cicd)


---

### Создание облачной инфраструктуры


В качестве хранения state основной инфраструктуры будем использовать S3 bucket в ЯО.<br>
<br><br>
Ссылка на коммит в репозитории terraform по первой части задания:<br>
https://github.com/hatredlex/netol-diplom-terr/commit/8f5630f64cbf03689d437fdb6537bfac52811b7c
<br><br><br>
Создание bootstrap ресурсов:<br>
<img width="604" height="187" alt="image" src="https://github.com/user-attachments/assets/5cbf5e8b-de50-4199-b066-03069518702d" />
<br><br>
Создание основной инфраструктуры:<br>
<img width="547" height="250" alt="image" src="https://github.com/user-attachments/assets/abbd17d7-b18d-4a17-8c4a-b3738ed942ca" />

<img width="1469" height="387" alt="image" src="https://github.com/user-attachments/assets/65f8ed1b-b79b-4fb8-b528-433b5e11ba75" />
<br><br>
state действительно лежит в бакете:<br>
<img width="1513" height="411" alt="image" src="https://github.com/user-attachments/assets/da2e8cdf-0841-4f78-a4a0-be94be2e2236" />
<br><br>
Создание и удаление ресурсов без дополнительных ручных действий:<br>
<img width="1170" height="936" alt="image" src="https://github.com/user-attachments/assets/cbffdab3-bdef-4b67-a989-a5a3d7152482" />

<img width="1175" height="900" alt="image" src="https://github.com/user-attachments/assets/db552162-e180-4bd7-908a-d17119ed0c21" />

<img width="1178" height="944" alt="image" src="https://github.com/user-attachments/assets/baa0500b-db6d-49ef-852a-d9105646c5a9" />

<img width="1169" height="867" alt="image" src="https://github.com/user-attachments/assets/78819c82-01b4-417f-a31a-401ce512f0ed" />
<br><br>

---

### Создание Kubernetes кластера


Кластер Kubernetes будем разворачивать как Yandex Managed Service for Kubernetes.<br>
<br><br>
Ссылка на коммит в репозитории terraform по второй части задания:<br>
https://github.com/hatredlex/netol-diplom-terr/commit/3a4b5ac1b2c4db16a0980de1e914c1ba4748c662
<br><br><br>
Создан кластер с тремя нодами в разных зонах:<br>
<img width="971" height="456" alt="image" src="https://github.com/user-attachments/assets/2e090079-a664-428f-9694-daa349206560" />

<img width="1779" height="441" alt="image" src="https://github.com/user-attachments/assets/f696b1b5-4008-427d-b9df-7a3e0400988d" />
<br><br>
Получаем конфиг для подключения к кластеру:<br>
<img width="969" height="443" alt="image" src="https://github.com/user-attachments/assets/4162ee78-c2a2-4d15-bdc8-916447771856" />
<br><br>
Проверяем работоспособность, команды выполняются без ошибок:<br>
<img width="955" height="542" alt="image" src="https://github.com/user-attachments/assets/2d7d29ef-8863-4ca1-baed-4d9cf3fae2d7" />
<br><br>

---

### Создание тестового приложения


Для хранения образов будем использовать Yandex Container Registry. Его создание добавим в Terraform.<br>
Для эмуляции основного приложения возьмем Nginx-сервер со статической станицей.<br>
<br><br>
Ссылка на коммит в репозитории terraform по третьей части задания:<br>
https://github.com/hatredlex/netol-diplom-terr/commit/e386138bdae74c17309ed93153d8b8ebfab49cd5

Ссылка на репозиторий с Nginx-приложением:<br>
https://github.com/hatredlex/netol-diplom-nginx
<br><br><br>
Сборка образа:<br>
<img width="1331" height="705" alt="image" src="https://github.com/user-attachments/assets/b4860fe6-1ea2-4ac5-8c1a-881cd11d2f85" />
<br><br>
Проверка:<br>
<img width="939" height="800" alt="image" src="https://github.com/user-attachments/assets/cda90cfb-2437-4696-9eb8-851a6b8e3bbd" />
<br><br>
Загрузка в репозиторий:<br>
<img width="1051" height="366" alt="image" src="https://github.com/user-attachments/assets/416962eb-b214-4812-aa32-24c8a45ac5cd" />
<br><br>

---

### Подготовка cистемы мониторинга и деплой приложения


Воспользуемся пакетом kube-prometheus для развертывания мониторинга.<br>
Для отслеживания изменений инфраструктуры будем использовать Atlantis.<br>
<br><br>
Ссылка на коммит по четвертой части:<br>
https://github.com/hatredlex/netol-diplom-terr/commit/3cfa5ff11075647f529f312dc2473827293dc69b

Ссылка на репозиторий с конфигурацией Kubernetes:<br>
https://github.com/hatredlex/netol-diplom-kuber
<br><br><br>
Деплоим приложение в Kuber:<br>
<img width="1065" height="258" alt="image" src="https://github.com/user-attachments/assets/55706963-e403-4082-90bd-ae448784d512" />

<img width="1078" height="762" alt="image" src="https://github.com/user-attachments/assets/dc3878f4-9d57-4c83-8372-12f1319312ec" />
<br><br>
Клонируем к себе репозиторий с kube-prometheus<br>
<img width="1063" height="466" alt="image" src="https://github.com/user-attachments/assets/3ce34fc3-d10f-46d5-968c-be91a0533824" />
<br><br>
Применяем <br>
<img width="1018" height="206" alt="image" src="https://github.com/user-attachments/assets/9161050b-6218-4cd8-8a46-fd2e4d3c1e77" />

<img width="1078" height="919" alt="image" src="https://github.com/user-attachments/assets/4747fb80-9fb0-482a-b2bb-6661665e3043" />

<img width="1083" height="900" alt="image" src="https://github.com/user-attachments/assets/7c582380-18a1-4404-92f6-22be34e568bf" />

<img width="1061" height="241" alt="image" src="https://github.com/user-attachments/assets/3f844616-c4b3-45f5-862c-fcf392fa6bbe" />
<br><br>
Проверяем:<br>
<img width="580" height="273" alt="image" src="https://github.com/user-attachments/assets/f5cf2e6f-adce-4861-93b4-40e7ac9558b7" />
<br><br>
Не хватило памяти на prometheus<br>
<img width="1340" height="118" alt="image" src="https://github.com/user-attachments/assets/91fbdb97-91f9-4fdd-973f-f0f1fdd6d945" />
<br><br>
Увеличиваем через Terraform с 2х до 4х Гб, применяем, проверяем:<br>
<img width="649" height="298" alt="image" src="https://github.com/user-attachments/assets/ff6c7756-fff1-4ce4-9401-151572a46b50" />
<br><br>
Создаем Load Balancer<br>
<img width="1331" height="935" alt="image" src="https://github.com/user-attachments/assets/22eb7384-9633-42db-b183-83332eebf15f" />
<br><br>
Проверяем доступность<br>
<img width="1006" height="513" alt="image" src="https://github.com/user-attachments/assets/d53097dd-3064-4bfa-b4a9-fe518b03316f" />

<img width="1883" height="975" alt="image" src="https://github.com/user-attachments/assets/ca083125-7933-46e9-a90e-438cef90f779" />

<img width="1424" height="829" alt="image" src="https://github.com/user-attachments/assets/475ebdc5-3755-4fc8-ade9-7d1cdc4639c1" />
<br><br>
Ставим Atlantis<br>
<img width="1202" height="698" alt="image" src="https://github.com/user-attachments/assets/2c982d17-350e-4c97-ac30-5ee5db2bc4da" />

<img width="1209" height="308" alt="image" src="https://github.com/user-attachments/assets/ceb93f7e-a72b-4d79-9815-f37911c11c17" />
<br><br>
Проверяем доступность Atlantis<br>
<img width="1071" height="603" alt="image" src="https://github.com/user-attachments/assets/90dc669a-90a5-46ab-a575-28ae28fb20db" />
<br><br>
PR с комментариями Atlantis<br>
<img width="951" height="1912" alt="image" src="https://github.com/user-attachments/assets/b69810e1-3210-4594-abac-1083bab74768" />
<br><br>

---

### Установка и настройка CI/CD


В качестве CI/CD будем использовать GitHub Actions<br>
<br><br><br>
Добавим токен для Registry и конфиг для Kubernetes:<br>
<img width="1028" height="677" alt="image" src="https://github.com/user-attachments/assets/759d022e-3a43-46d3-a05d-5f14fc9e2c92" />
<br><br>
При коммите запустилась сборка и образ загрузился в Registry:<br>
<img width="1146" height="973" alt="image" src="https://github.com/user-attachments/assets/5819bff8-4400-499c-9cdb-b3c8978dbf80" />

<img width="1330" height="296" alt="image" src="https://github.com/user-attachments/assets/21fae35f-a656-4651-a9c2-12338c0fbab6" />
<br><br>
При добавлении тэга произошел деплой в Kubernetes:<br>
<img width="1313" height="745" alt="image" src="https://github.com/user-attachments/assets/ab776b11-e78b-4fbf-81af-feb9d6ac4102" />

<img width="1329" height="557" alt="image" src="https://github.com/user-attachments/assets/21418cb1-342c-4b7b-a5cf-496b1772200d" />

<img width="1020" height="453" alt="image" src="https://github.com/user-attachments/assets/8f3b2dbc-fe8f-4552-8167-53c90dcfdd53" />


---
