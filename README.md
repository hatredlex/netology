# Задание 1
<img width="607" height="805" alt="image" src="https://github.com/user-attachments/assets/46fbf7f8-af05-4ad2-9fbb-9b89b42b611d" />
<br/><br/>  
  
<img width="1836" height="317" alt="image" src="https://github.com/user-attachments/assets/5ad2b8c3-2ccc-444e-a27a-28afa1e8931b" />
<br/><br/>  
  
<img width="578" height="942" alt="image" src="https://github.com/user-attachments/assets/3c67505f-6f65-44be-9ae0-a11bba085559" />
<img width="782" height="943" alt="image" src="https://github.com/user-attachments/assets/e3cc06a6-a118-4d0d-9601-4d7db7ac7ef9" />
<img width="547" height="942" alt="image" src="https://github.com/user-attachments/assets/aa13d39c-9ec6-4ab9-b7a4-8f1d88515b88" />
<br/><br/>  
  
# Задание 2
3. <img width="498" height="427" alt="image" src="https://github.com/user-attachments/assets/98ef65d2-5d85-4c43-93ce-fddf20c8a729" />
  

5.  

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~>1.12.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_yandex"></a> [yandex](#provider\_yandex) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [yandex_vpc_network.this](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/vpc_network) | resource |
| [yandex_vpc_subnet.this](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/vpc_subnet) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cidr"></a> [cidr](#input\_cidr) | CIDR для подсети | `string` | n/a | yes |
| <a name="input_network_name"></a> [network\_name](#input\_network\_name) | Имя сети | `string` | n/a | yes |
| <a name="input_zone"></a> [zone](#input\_zone) | Зона доступности | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_network_id"></a> [network\_id](#output\_network\_id) | ID сети |
| <a name="output_subnet"></a> [subnet](#output\_subnet) | объект созданной подсети |
