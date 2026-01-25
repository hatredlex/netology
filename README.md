# Домашнее задание к занятию 3 «Использование Ansible»

ссылка на Playbook:
https://github.com/hatredlex/mnt-homeworks/releases/tag/08-ansible-03-yandex
<br><br>


# Ansible Playbook: ClickHouse + Vector + LightHouse

Данный репозиторий содержит Ansible playbook для установки и настройки следующих компонентов:

- **ClickHouse** — аналитическая колоночная СУБД  
- **Vector** — агент сбора и обработки логов  
- **LightHouse** — веб-интерфейс для работы с ClickHouse  

Playbook разворачивает каждый компонент на отдельном хосте и обеспечивает идемпотентное выполнение.

---

## Структура репозитория

```
playbook/
├── group_vars/
│   ├── clickhouse/
│   │   └── vars.yml
│   ├── vector/
│   │   └── vars.yml
│   └── lighthouse/
│       └── vars.yml
├── inventory/
│   └── prod.yml
├── templates/
│   ├── vector/
│   │   └── vector.yaml.j2
│   └── nginx/
│       └── lighthouse.conf.j2
└── site.yml
```

---

## Требования

- Ansible >= 2.14  
- Доступ по SSH к хостам  
- Пользователь `ubuntu` с правами `sudo`  
- Поддерживаемые ОС: **Debian / Ubuntu**  
- Интернет-доступ для установки пакетов и загрузки репозиториев  

---

## Inventory

В inventory используются следующие группы:

- `clickhouse` — хост с ClickHouse  
- `vector` — хост с Vector  
- `lighthouse` — хост с LightHouse  

Пример `inventory/prod.yml`:

```yaml
all:
  vars:
    ansible_user: ubuntu
    ansible_python_interpreter: /usr/bin/python3

  children:
    clickhouse:
      hosts:
        clickhouse-01:
          ansible_host: <IP_CLICKHOUSE>

    vector:
      hosts:
        vector-01:
          ansible_host: <IP_VECTOR>

    lighthouse:
      hosts:
        lighthouse-01:
          ansible_host: <IP_LIGHTHOUSE>
```

---

## Описание Playbook

### Install ClickHouse

- Установка ClickHouse из официального APT-репозитория  
- Запуск и включение сервиса `clickhouse-server`  
- Создание тестовой базы данных  
- Корректная работа в `--check` режиме  

Используемые модули:
- `apt`
- `apt_repository`
- `file`
- `systemd`

---

### Install Vector

- Загрузка и установка Vector  
- Деплой конфигурации через Jinja2 template  
- Создание `data_dir`  
- Настройка и запуск systemd-сервиса  
- Идемпотентное выполнение  

Используемые модули:
- `get_url`
- `unarchive`
- `file`
- `template`
- `systemd`
- `find`

---

### Install LightHouse

- Установка `nginx` и `git`  
- Клонирование репозитория LightHouse  
  https://github.com/VKCOM/lighthouse  
- Размещение статики в `/var/www/lighthouse`  
- Настройка nginx через template  
- Включение сайта и запуск nginx  

Используемые модули:
- `apt`
- `git`
- `file`
- `template`
- `systemd`

---

## Переменные

### ClickHouse (`group_vars/clickhouse/vars.yml`)
- `clickhouse_version`
- `clickhouse_packages`

### Vector (`group_vars/vector/vars.yml`)
- `vector_version`
- `vector_install_dir`
- `vector_config_dir`
- `vector_config_file`
- `vector_data_dir`

### LightHouse (`group_vars/lighthouse/vars.yml`)
- `lighthouse_install_dir`
- `nginx_listen_port`
- `nginx_server_name`

---

## Теги

Playbook поддерживает следующие теги:

- `clickhouse` — установка ClickHouse  
- `vector` — установка Vector  
- `lighthouse` — установка LightHouse  
- `nginx` — задачи nginx  
- `config` — деплой конфигураций  

Пример запуска только LightHouse:

```bash
ansible-playbook -i inventory/prod.yml site.yml --tags lighthouse
```

---

## Проверка и запуск

Проверка линтером:

```bash
ansible-lint site.yml
```

Проверка без внесения изменений:

```bash
ansible-playbook -i inventory/prod.yml site.yml --check
```

Основной запуск с отображением изменений:

```bash
ansible-playbook -i inventory/prod.yml site.yml --diff
```

Проверка идемпотентности (повторный запуск):

```bash
ansible-playbook -i inventory/prod.yml site.yml --diff
```

---

## Результат

После выполнения playbook:

- ClickHouse установлен и запущен  
- Vector работает как systemd-сервис  
- LightHouse доступен по HTTP на хосте группы `lighthouse`  

---
