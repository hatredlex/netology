# Домашнее задание к занятию 14 «Средство визуализации Grafana»

### 1
<img width="1913" height="1032" alt="image" src="https://github.com/user-attachments/assets/9cd69aeb-4ec7-46b5-965d-889b84246ff0" />

### 2
- утилизация CPU для nodeexporter (в процентах, 100-idle)
```
100 - (avg by (instance) (rate(node_cpu_seconds_total{mode="idle"}[5m])) * 100)
```
- CPULA 1/5/15
```
node_load1
node_load5
node_load15
```
- количество свободной оперативной памяти
```
node_memory_MemAvailable_bytes
```
- количество места на файловой системе
```
node_filesystem_avail_bytes{fstype!~"tmpfs|overlay|squashfs|aufs", mountpoint!~"/(proc|sys|run|dev)($|/)"}
```
<br><br>
<img width="1918" height="1030" alt="image" src="https://github.com/user-attachments/assets/57c0de1f-b297-46df-82e5-3e33703ba202" />

### 3
<img width="1916" height="1028" alt="image" src="https://github.com/user-attachments/assets/8334f8da-94f9-42e5-9e45-72ac725423b2" />

### 4


---
