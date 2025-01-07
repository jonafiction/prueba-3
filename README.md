# Prueba 3


## Creación y Gestión de Imágenes Docker
Se crea una imagen Docker para una aplicación web estática, que posteriormente se almacenará en Amazon ECR y se desplegaráen Amazon ECS en el futuro.
## Configuración de Amazon EC2
Se crea una instancia EC2 que corra una API backend que interactúe con la interfaz web.
## Logging y Monitoreo con CloudWatch
Se configuran métricas y logs en
Amazon CloudWatch para poder monitorear el rendimiento de la infraestructura y
responder ante eventos críticos.

## Automatización con GitHub Actions
Dentro de este repositorio, el archivo "ci.yml" con tiene un pipeline que automatiza las tareas de
escaneo de imágenes Docker y archivos Terraform, y desplegar los cambios
automáticamente en AWS.
## Creación de recursos en AWS con terraform
Toda la infraestructura, incluidos los
recursos de VPC, EC2, S3 y Lambda, debe ser gestionada mediante Terraform.
el código está dentro de este repositorio en la carpeta "terraform".
