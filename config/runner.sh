# Tambah User
useradd $SSH_USER --create-home --password "$(openssl passwd -1 "$SSH_PASSWORD")" && echo "$SSH_USER ALL=(ALL:ALL) ALL" >> /etc/sudoers

# Timezone (Zona Waktu)
rm -f /etc/localtime;  ln -s /usr/share/zoneinfo/$TIMEZONE /etc/localtime

# Ownership
chown -R $SSH_USER:$SSH_USER /var/www/html

service nginx start && service php7.3-fpm start && service ssh $SSH_SERVICE