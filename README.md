<img width="574" height="46" alt="image" src="https://github.com/user-attachments/assets/b4f577f0-a266-499d-9745-6f66fbf2b260" />

# Задание 1
2.  Согласно этому .gitignore допустимо сохранить личную, секретную информацию в файле personal.auto.tfvars

3.  "result": "7XY07ubGTmsFwVxW"

4.  1-ая ошибка в том, что имя ресурса 1nginx не может начинаться с цифры, исправим на nginx1  
2 и 3 ошибки - это сылка на несуществующий ресурс random_password.random_string_FAKE.resulT и атрибут с большой буквой, имена регистрозависимые, исправляем на random_password.random_string.result  
4-ая ошибка, у ресурса Terraform обязателен второй label — имя, исправим resource "docker_image" "nginx"

6.
```hl
resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = true
}

resource "docker_container" "nginx1" {
  image = docker_image.nginx.image_id
  name  = "example_${random_password.random_string.result}"
   ```
<img width="1083" height="47" alt="image" src="https://github.com/user-attachments/assets/cd9b764b-81b2-45bc-be32-37638f6e7bf1" />  
  
6. Опасность в том что код применяется без подтверждения, например если изменили имя, то ресурс будет удален и создан заново. auto-approve может быть полезен в скриптах при автоматизации.
<img width="981" height="46" alt="image" src="https://github.com/user-attachments/assets/6e62a258-d15f-43a0-988e-d5f9d2456779" />

7. 
```yaml
{
  "version": 4,
  "terraform_version": "1.12.2",
  "serial": 11,
  "lineage": "c657dbfc-62d4-71e8-7dc0-160277c25a82",
  "outputs": {},
  "resources": [],
  "check_results": null
}
```
