# Prueba 3 : Desafio Latam


## Creación y Gestión de Imágenes Docker
Se crea una imagen Docker para una aplicación web estática, el archivo Dockerfile de este repositorio creará una imagen que contiene y levantará nuestra página con nginx.
Esta imagen posteriormente se almacenará en Amazon ECR y se desplegaráen Amazon ECS en el futuro.

![image](https://github.com/user-attachments/assets/b0fc553c-88b3-452d-b414-08e52fdc057c)

## Configuración de Amazon EC2
Se crea una instancia EC2 que corra una API backend hecha con nodejs. Toda esta configuración la puedes ver en la carpeta terraform, en el archivo "ec2.tf".

![image](https://github.com/user-attachments/assets/8318d55a-16be-4033-b600-9ae3833e8256)

## Logging y Monitoreo con CloudWatch
Se configuran métricas y logs en
Amazon CloudWatch para poder monitorear el rendimiento de la infraestructura y
responder ante eventos críticos.

![image](https://github.com/user-attachments/assets/6be8316c-6d04-4f23-8f30-35a2cec7b875)



## Automatización con GitHub Actions
Dentro de este repositorio, el archivo "ci.yml" con tiene un pipeline que automatiza las tareas de
escaneo de imágenes Docker y archivos Terraform, y desplegar los cambios
automáticamente en AWS.

![image](https://github.com/user-attachments/assets/fef316ac-b22a-4692-8d9f-f4889eeec6a9)


## Creación de recursos en AWS con terraform
Toda la infraestructura, incluidos los
recursos de VPC, EC2, S3 y Lambda, debe ser gestionada mediante Terraform.
el código está dentro de este repositorio en la carpeta "terraform".

![image](https://github.com/user-attachments/assets/7fac6043-0b1e-4722-a0df-38b86b24f014)
