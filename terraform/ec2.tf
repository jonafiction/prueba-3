# Security Group para EC2
resource "aws_security_group" "ec2_sg" {
  name        = "${var.prueba_3}-ec2-sg"
  description = "Security group for EC2 instances"
  vpc_id      = aws_vpc.main.id

  # API Node.js
  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Node.js API port"
  }

  # HTTP
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTPS
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # SSH
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.prueba_3}-ec2-sg"
    Environment = var.environment
  }
}

# EC2 Instance
resource "aws_instance" "api_server" {
  ami           = "ami-0e2c8caa4b6378d8c" 
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public.id

  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              # Actualizar el sistema
              yum update -y
              
              # Instalar Node.js
              curl -fsSL https://rpm.nodesource.com/setup_18.x | bash -
              yum install -y nodejs

              # Crear directorio para la aplicación
              mkdir -p /opt/nodejs-app
              
              # Crear un archivo simple de la API
              cat > /opt/nodejs-app/app.js <<'END'
              const http = require('http');
              const server = http.createServer((req, res) => {
                res.statusCode = 200;
                res.setHeader('Content-Type', 'application/json');
                res.end(JSON.stringify({ message: 'Hola Mundo' }));
              });
              server.listen(3000, '0.0.0.0', () => {
                console.log('Server running on port 3000');
              });
              END

              # Instalar PM2 para manejar el proceso de Node.js
              npm install -g pm2
              
              # Iniciar la aplicación con PM2
              pm2 start /opt/nodejs-app/app.js
              pm2 startup
              EOF

  tags = {
    Name        = "${var.prueba_3}-api-server"
    Environment = var.environment
  }
}