#!/bin/bash

# Função para verificar o sucesso de cada comando
check_command() {
    if [ $? -ne 0 ]; then
        echo "Erro ao executar o comando: $1"
        exit 1
    fi
}

echo "Atualizando o servidor..."
apt-get update
check_command "apt-get update"

apt-get upgrade -y
check_command "apt-get upgrade"

apt-get install apache2 -y
check_command "Instalação do Apache2"

apt-get install unzip -y
check_command "Instalação do unzip"

echo "Baixando e copiando os arquivos da aplicação..."

# Criando e navegando para o diretório temporário
TEMP_DIR="/tmp/app_temp"
mkdir -p $TEMP_DIR
cd $TEMP_DIR

wget https://github.com/denilsonbonatti/linux-site-dio/archive/refs/heads/main.zip
check_command "Download da aplicação"

unzip main.zip
check_command "Extração dos arquivos"

cd linux-site-dio-main

cp -R * /var/www/html/
check_command "Cópia dos arquivos para o diretório do Apache"

echo "Configurando permissões..."
chown -R www-data:www-data /var/www/html/
check_command "Configuração de permissões"

echo "Limpando arquivos temporários..."
rm -rf $TEMP_DIR
check_command "Remoção de arquivos temporários"

echo "Reiniciando o Apache..."
systemctl restart apache2
check_command "Reinício do Apache"

echo "Script concluído com sucesso!"



