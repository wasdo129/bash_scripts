#! /bin/bash

read -p "Введите имя старой директории: " old_name_dir
read -p "Введите имя новой директории: " new_name_dir
read -p "Введите имя старой бд: " old_bd_name
read -p "Введите имя новой бд: " new_bd_name
read -p "Введите пароль базы данных: " bd_pass
read -p "Введите имя старого домена: " old_url_name
read -p "Введите имя нового домена: " new_url_name
DT=`date '+%Y%m%d'`

if [ "$old_name_dir" == "public_html" ]; then
  mkdir $new_name_dir && cp -r ~/public_html ~/$new_name_dir
else
  cp -r ~/$old_name_dir ~/$new_name_dir
fi

sed -i 's/'$old_bd_name'/'$new_bd_name'/g' ~/$new_name_dir/public_html/wp-config.php

mysqldump -u''$old_bd_name'' $old_bd_name -p''$bd_pass'' > $old_bd_name.$DT.sql --no-tablespaces
mysql -u''$new_bd_name'' $new_bd_name -p''$bd_pass'' < $old_bd_name.$DT.sql

cd ~/$new_name_dir/public_html && wp search-replace $old_url_name $new_url_name --all-tables --report-changed-only

find ~/$new_name_dir -type f -name '*' -exec sed -i -r 's/'$old_url_name'/'$new_url_name'/g' {} \;
