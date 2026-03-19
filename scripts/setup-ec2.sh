#!/bin/bash
# Atualiza os pacotes e instala o Apache no Ubuntu
sudo apt-get update -y
sudo apt-get install -y apache2
sudo systemctl start apache2
sudo systemctl enable apache2

# Cria uma página customizada
echo "<h1>Deploy via Terraform com depends_on realizado com sucesso!</h1>" | sudo tee /var/www/html/index.html
