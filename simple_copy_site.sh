#! /bin/bash

read -p "Введите имя старой директории: " old_name_dir
read -p "Введите имя новой директории: " new_name_dir
read -p "Введите имя старой бд: " old_bd_name
read -p "Введите имя новой бд: " new_bd_name
read -p "Введите пароль базы данных: " bd_pass
DT=`date '+%Y%m%d'`

if [ "$old_name_dir" == "public_html" ]; then
  mkdir $new_name_dir && cp -r ~/public_html ~/$new_name_dir
else
  cp -r ~/$old_name_dir ~/$new_name_dir
fi

find ~/$new_name_dir -type f -name '*' -exec sed -i -r 's/'$old_bd_name'/'$new_bd_name'/g' {} \;

mysqldump -u''$old_bd_name'' $old_bd_name -p''$bd_pass'' > $old_bd_name.$DT.sql --no-tablespaces
mysql -u''$new_bd_name'' $new_bd_name -p''$bd_pass'' < $old_bd_name.$DT.sql

rm -rf ~/$old_bd_name.$DT.sql

rm -rf ~/simple_copy_site.sh
