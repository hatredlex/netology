# Домашнее задание к занятию «Хранение в K8s»

### Задание 1
Манифест:<br>
https://github.com/hatredlex/netology/blob/kuber-05/containers-data-exchange.yaml<br>
<br>
<img width="1348" height="777" alt="image" src="https://github.com/user-attachments/assets/b1b55562-88d0-4a42-b93b-8ebb033259c7" />
<img width="1348" height="596" alt="image" src="https://github.com/user-attachments/assets/dd47b297-9485-4fc4-be65-6545692ca11e" />
<br><br>
<img width="861" height="210" alt="image" src="https://github.com/user-attachments/assets/d60caa0f-e894-4f42-b730-82be62736911" />
<br>

### Задание 2
Манифесты:<br>
https://github.com/hatredlex/netology/blob/kuber-05/pv-local-manual.yaml<br>
https://github.com/hatredlex/netology/blob/kuber-05/pvc-local-manual.yaml<br>
https://github.com/hatredlex/netology/blob/kuber-05/data-exchange-pvc.yaml<br>
<br><br>
2.<br>
<img width="589" height="90" alt="image" src="https://github.com/user-attachments/assets/03b781d8-0720-4f68-b7d5-f6240f99c7b6" />
<br>
3.<br>
<img width="930" height="189" alt="image" src="https://github.com/user-attachments/assets/21c4a5b4-36a6-4d09-9df7-3558849f3dbe" />
<br>
4.<br>
<img width="1157" height="390" alt="image" src="https://github.com/user-attachments/assets/2c127c96-0383-4e9a-bfca-b9a85dd5d6b0" />
<br>
PV перешел в состояние Released. Мы удалили PVC, к которому был привязан PV. Политика persistentVolumeReclaimPolicy: Retain говорит Kubernetes не удалять само хранилище и не очищать данные после удаления claim. То есть Kubernetes отвязал claim, но сам volume и его содержимое оставил.
<br><br>
5.<br>
<img width="574" height="833" alt="image" src="https://github.com/user-attachments/assets/75c3ea6d-646e-4dbe-a3c2-84a05a5068d2" />
<br>
<img width="682" height="874" alt="image" src="https://github.com/user-attachments/assets/52e13bf2-560c-4c11-aa8a-0e8e5a1237a6" />
<br>
После удаления PV файл на локальном диске ноды сохранился, потому что использовался hostPath. Удаление объекта PV удаляет только объект Kubernetes, но не физическую директорию и не её содержимое на хосте.
<br>

### Задание 3
Манифесты:<br>
https://github.com/hatredlex/netology/blob/kuber-05/sc.yaml<br>
<br><br>
<img width="885" height="268" alt="image" src="https://github.com/user-attachments/assets/ba13663f-0d0d-4091-8dc5-2782dfa77fe4" />
<br><br>

---
