echo "LAMP Stack Installation Script"
sudo apt install apache2 -y
sudo apt install php8.1 -y
sudo apt install libapache2php -y
sudo apt install curl -y
sudo apt install php-curl -y
sudo ufw allow "Apache Full"
sudo apt install mysql-server -y
read -p "Enter password for MySQL root user: " rootpass
sudo mysql -u root -e "UPDATE mysql.user SET Password=PASSWORD('$rootpass') WHERE User='root';"
sudo mysql -u root -e "DELETE FROM mysql.user WHERE User='';"
sudo mysql -u root -e "DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');"
sudo mysql -u root -e "DROP DATABASE IF EXISTS test;"
sudo mysql -u root -e "DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';"
sudo mysql -u root -e "FLUSH PRIVILEGES;"
sudo apt install php libapache2-mod-php php-mysql -y
sudo systemctl restart apache2
touch /var/www/html/index.php
sed -i "<?php phpInfo(); ?>"
sudo systemctl restart apache2
ips=$(hostname -I)
echo "Go to localhost or $ips";
