# Задача 0
<img width="703" height="122" alt="image" src="https://github.com/user-attachments/assets/2195c7e4-75db-42ab-80e1-4073a8de4a3f" />


# Задача 2
<img width="1494" height="462" alt="image" src="https://github.com/user-attachments/assets/6b9c83ea-2882-4d79-832b-055f1dedb06c" />


# Задача 3
<img width="790" height="725" alt="image" src="https://github.com/user-attachments/assets/bbec51a4-9f3d-4183-8184-5bb44fa2f642" />


# Задача 4
<img width="1651" height="820" alt="image" src="https://github.com/user-attachments/assets/294d140d-94f1-4846-a137-493266c6d1be" />
<img width="1652" height="288" alt="image" src="https://github.com/user-attachments/assets/954ede07-3519-497c-834b-57e5855aaca9" />


https://github.com/hatredlex/shvirtd-example-python


# Задача 5
Скрипт:
```bash
#!/bin/bash

PROJECT_DIR="/home/adm1/netology/shvirtd-example-python"
cd "$PROJECT_DIR"

MAIN_ENV="$PROJECT_DIR/.env"
BACKUP_ENV="$PROJECT_DIR/.backup.env"
DOCKER_NETWORK="shvirtd-example-python_backend"

source "$MAIN_ENV"
source "$BACKUP_ENV"

BACKUP_DIR="/opt/backup"
mkdir -p "$BACKUP_DIR"

echo "[INFO] create backup user..."
docker run --rm --network "$DOCKER_NETWORK" mysql:8 \
  mysql -h "$MYSQL_HOST" -uroot -p"$MYSQL_ROOT_PASSWORD" \
  -e "DROP USER IF EXISTS '$MYSQL_BACKUP_USER'@'%';
      CREATE USER '$MYSQL_BACKUP_USER'@'%' IDENTIFIED WITH mysql_native_password BY '$MYSQL_BACKUP_PASSWORD';
      GRANT SELECT, LOCK TABLES, SHOW VIEW, EVENT, TRIGGER
        ON \`$MYSQL_DATABASE\`.* TO '$MYSQL_BACKUP_USER'@'%';
      FLUSH PRIVILEGES;"

TS="$(date +'%Y-%m-%d_%H-%M-%S')"
DUMP_FILE="$BACKUP_DIR/${TS}_${MYSQL_DATABASE}.sql"
DUMP_FILE_IN_CONTAINER="/backup/$(basename "$DUMP_FILE")"

echo "[INFO] creating dump..."
docker run --rm --network "$DOCKER_NETWORK" \
  --entrypoint "" \
  -v "$BACKUP_DIR:/backup" \
  schnitzler/mysqldump \
  mysqldump --opt --no-tablespaces \
    -h "$MYSQL_HOST" \
    -u"$MYSQL_BACKUP_USER" \
    -p"$MYSQL_BACKUP_PASSWORD" \
    "--result-file=$DUMP_FILE_IN_CONTAINER" \
    "$MYSQL_DATABASE"

echo "[INFO] done: $DUMP_FILE"
```
Crontask:
```bash
* * * * * /opt/backup_mysql.sh
```

<img width="577" height="94" alt="image" src="https://github.com/user-attachments/assets/2d265191-1af6-4167-8412-41eb244a5d5c" />
<img width="705" height="881" alt="image" src="https://github.com/user-attachments/assets/abc18d34-57e2-4d6b-b1e0-9393925eb955" />


# Задача 6
<img width="1092" height="880" alt="image" src="https://github.com/user-attachments/assets/fac1eacb-99f5-4949-8fc2-8d48eca28d0a" />


# Задача 6.1
<img width="715" height="399" alt="image" src="https://github.com/user-attachments/assets/0c844106-3de4-4032-a56a-a3d237db6a86" />


# Задача 6.2
<img width="1651" height="595" alt="image" src="https://github.com/user-attachments/assets/73c2c1d7-15b7-4776-ad8c-eed6a8842c80" />


# Задача 7
<img width="1653" height="420" alt="image" src="https://github.com/user-attachments/assets/abdd95a4-c194-4e90-b707-caceded13494" />
<img width="1654" height="348" alt="image" src="https://github.com/user-attachments/assets/05ed2cc8-e6d2-4c1f-9f72-80498c217d43" />
<img width="1655" height="527" alt="image" src="https://github.com/user-attachments/assets/1109431c-25f1-466b-81cf-00f955252186" />
<img width="1655" height="316" alt="image" src="https://github.com/user-attachments/assets/0de33f23-3337-4735-84c2-94cdea610113" />
<img width="1648" height="279" alt="image" src="https://github.com/user-attachments/assets/9f50484c-39c8-43fa-90dd-c458cc4de00f" />
<img width="1658" height="878" alt="image" src="https://github.com/user-attachments/assets/be5b76b2-6425-4df2-847c-a7bbd10492ba" />


