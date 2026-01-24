# Домашнее задание к занятию 2 «Работа с Playbook»

ссылка на репозиторий с кодом:
https://github.com/hatredlex/08-ansible-02-playbook_02.25
ссылка на тэг:
https://github.com/hatredlex/08-ansible-02-playbook_02.25/releases/tag/08-ansible-02-playbook

5\. <br><img width="775" height="70" alt="image" src="https://github.com/user-attachments/assets/34cef5d6-afe4-4a75-9542-7a6ced459e21" />

6\. <img width="1458" height="799" alt="image" src="https://github.com/user-attachments/assets/1deeecaa-1c15-4913-8a86-417e756c2c66" />

7\. <img width="1593" height="831" alt="image" src="https://github.com/user-attachments/assets/c49eb31c-4805-45ba-896d-9101be2777a5" />
<img width="1590" height="680" alt="image" src="https://github.com/user-attachments/assets/ec22c3ae-e6c1-499d-ad20-72e478982c9b" />

8\. <img width="1590" height="825" alt="image" src="https://github.com/user-attachments/assets/7a11ab02-2122-4e4a-925a-e8bcf095d095" />
<img width="1591" height="119" alt="image" src="https://github.com/user-attachments/assets/a8b4ecda-30d1-410c-9f40-cdd9abaa282b" />

9\. <br>
# Ansible Playbook: ClickHouse + Vector

Данный Ansible playbook предназначен для автоматизированного развёртывания и первичной настройки **ClickHouse** и **Vector** в контейнеризованной среде (Docker).

Playbook написан с упором на **идемпотентность**, повторный запуск не приводит к лишним изменениям в системе.

---

## 📋 Содержание

- [Описание](#описание)
- [Требования](#требования)
- [Структура проекта](#структура-проекта)
- [Описание playbook](#описание-playbook)
  - [Install ClickHouse](#install-clickhouse)
  - [Install Vector](#install-vector)
- [Переменные](#переменные)
- [Теги](#теги)
- [Пример запуска](#пример-запуска)
- [Идемпотентность](#идемпотентность)
- [Примечания](#примечания)

---

## 📖 Описание

Playbook выполняет следующие задачи:

- Устанавливает ClickHouse (server, client, common-static)
- Генерирует конфигурацию ClickHouse при её отсутствии
- Запускает `clickhouse-server`
- Ожидает готовности ClickHouse к приёму соединений
- Создаёт базу данных `logs`
- Устанавливает и настраивает Vector

Playbook рассчитан на учебные и тестовые среды.

---

## ⚙️ Требования

### Управляющая машина
- Ansible >= 2.14
- Python >= 3.8

### Целевые хосты
- Linux (Ubuntu 22.04)
- Python 3
- Сетевой доступ между узлами

---

## ▶️ Описание playbook

### Install ClickHouse

**Хосты:** `ch`

**Описание:**

- Загрузка пакетов ClickHouse
- Установка `clickhouse-server`, `clickhouse-client`
- Генерация конфигурации при отсутствии
- Запуск сервера от пользователя `clickhouse`
- Проверка доступности порта `9000`
- Создание базы данных `logs`

---

### Install Vector

**Хосты:** `vec`

**Описание:**

- Создание директорий установки
- Загрузка архива Vector
- Распаковка бинарника
- Развёртывание конфигурационного файла

---

## 🔧 Переменные

```yaml
clickhouse_database: logs

vector_version: "0.37.0"
vector_install_dir: /opt/vector
vector_config_dir: /etc/vector
```

---

## 🏷 Теги

| Тег        | Описание |
|------------|----------|
| clickhouse | Установка ClickHouse |
| vector     | Установка Vector |
| install    | Установка пакетов |
| config     | Конфигурация |
| start      | Запуск сервисов |

---

## ▶️ Пример запуска

```bash
ansible-playbook -i inventory/prod.yml site.yml
```

```bash
ansible-playbook -i inventory/prod.yml site.yml --diff
```

```bash
ansible-playbook -i inventory/prod.yml site.yml --tags clickhouse
```

---

## ♻️ Идемпотентность

Playbook идемпотентен:

- Повторный запуск не создаёт лишних изменений
- База данных создаётся только при отсутствии
- Сервер запускается только если не запущен

Ожидаемый результат повторного запуска:

```
changed=0
```

---

## 📝 Примечания

- Playbook рассчитан на контейнерную среду
- systemd не используется
- SSL в ClickHouse не настраивается
- Для production рекомендуется официальный Docker-образ ClickHouse
