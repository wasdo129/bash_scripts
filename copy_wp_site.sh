#! /bin/bash

read -p "Введите имя директории: " name_dir
read -p "Введите имя старой бд: " old_bd_name
read -p "Введите имя новой бд: " new_bd_name
read -p "Введите пароль базы данных: " bd_pass
DT=`date '+%Y%m%d'`

cp -r ~/wordpress_617xh ~/wordpress_617xh.copy

sed -i 's/'$old_bd_name'/'$new_bd_name'/g' ~/$name_dir.copy/public_html/wp-config.php

read -p "Введите имя старого домена: " old_url_name
read -p "Введите имя нового домена: " new_url_name

mysqldump -u''$old_bd_name'' $old_bd_name -p''$bd_pass'' > $old_bd_name.$DT.sql --no-tablespaces
mysql -u''$new_bd_name'' $new_bd_name -p''$bd_pass'' < $old_bd_name.$DT.sql

cd ~/$name_dir.copy/public_html && wp search-replace $old_url_name $new_url_name --all-tables --report-changed-only

find ~/$name_dir.copy -type f -name '*' -exec sed -i -r 's/'$old_url_name'/'$new_url_name'/g' {} \;
