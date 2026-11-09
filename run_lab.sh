#!/bin/bash

git init

mkdir -p claude_monet/bar
mkdir -p claude_monet/wine_cellar
mkdir -p claude_monet/storage
mkdir -p claude_monet/hall
mkdir -p claude_monet/office
mkdir -p kostya_room
mkdir -p empty_crates

echo -e "Фирменный коктейль от Кости\nЛимонад для Насти без сахара\nКлассический напиток для постоянных гостей\nНовый коктейль показать Вике вечером" > claude_monet/bar/cocktail_menu
echo -e "Столик два заказал три коктейля\nДля банкета подготовить холодные напитки\nНагиев ждёт свой заказ у барной стойки\nПоследний заказ принимает Костя" > claude_monet/bar/evening_orders
echo -e "В погребе осталось двенадцать бутылок вина\nКрасное вино заказано для банкета\nБелое вино подадут к рыбе Феди\nКостя проверит остатки после закрытия" > claude_monet/wine_cellar/inventory
echo -e "Нагиев попросил оставить любимое вино\nБутылку перенесли на отдельную полку\nКостя отвечает за специальный заказ\nПодать вино после приезда владельца" > claude_monet/wine_cellar/nagiev_wine
echo -e "Поставщик привезёт напитки утром\nНовая партия вина отмечена в накладной\nКостя должен проверить количество коробок\nО повреждениях сразу сообщить Вике" > claude_monet/storage/supplier_note
echo -e "Столик четыре забронирован на evening\nУ окна ждут постоянных гостей\nБольшой стол подготовить для банкета\nВика утвердит план рассадки" > claude_monet/hall/reservations
echo -e "Настя передаёт заказы Косте лично\nГостям за пятым столиком нужна вода\nНа банкете напитки подают после закусок\nПоследний заказ проверить перед закрытием" > claude_monet/hall/nastya_note
echo -e "Вика проверяет бар до открытия\nДнём проходит встреча с поставщиком\nПеред банкетом нужно сверить заказы\nПосле смены Костя сдаёт отчёт" > claude_monet/office/vika_schedule
echo -e "Костя открыл бар раньше обычного\nНастя помогла расставить бокалы\nНагиев похвалил новый коктейль\nВечером друзья встретились после смены" > kostya_room/kostya_diary
echo -e "Бар открывается вместе с рестораном\nКостя назначен ответственным за напитки\nВика ждёт отчёт об остатках\nНагиев приедет после восьми часов" > bar_message

chmod 755 claude_monet
chmod u=rwx,g=rx,o= claude_monet/bar
chmod 644 claude_monet/bar/cocktail_menu
chmod u=rw,g=r,o= claude_monet/bar/evening_orders
chmod 750 claude_monet/wine_cellar
chmod u=rw,g=rw,o= claude_monet/wine_cellar/inventory
chmod 640 claude_monet/wine_cellar/nagiev_wine
chmod u=rwx,g=rx,o= claude_monet/storage
chmod 644 claude_monet/storage/supplier_note
chmod 755 claude_monet/hall
chmod 664 claude_monet/hall/reservations
chmod u=r,g=r,o= claude_monet/hall/nastya_note
chmod u=rwx,g=rx,o= claude_monet/office
chmod 640 claude_monet/office/vika_schedule
chmod 750 kostya_room
chmod u=r,g=r,o= kostya_room/kostya_diary
chmod 700 empty_crates
chmod 644 bar_message

git add .
git commit -m "Часть 1: Создано дерево Варианта 9 и настроены права"

chmod 777 kostya_room claude_monet/office claude_monet/storage claude_monet/bar claude_monet/wine_cellar claude_monet/hall

cp kostya_room/kostya_diary claude_monet/office/bartender_report
cp -r claude_monet/wine_cellar claude_monet/storage/cellar_backup
ln -s ../claude_monet/bar/evening_orders kostya_room/today_orders
ln -s claude_monet/bar bar_entrance
ln bar_message claude_monet/bar/owner_message
cat claude_monet/hall/reservations claude_monet/hall/nastya_note > claude_monet/hall/service_plan
cat claude_monet/storage/supplier_note >> claude_monet/wine_cellar/inventory
mv claude_monet/wine_cellar/nagiev_wine claude_monet/office/special_wine

chmod 755 claude_monet
chmod 750 claude_monet/wine_cellar
chmod 750 kostya_room
chmod 755 claude_monet/hall
chmod 640 claude_monet/office/bartender_report
chmod 640 claude_monet/office/special_wine
chmod 664 claude_monet/hall/service_plan

git add .
git commit -m "Часть 2: Выполнены операции копирования, перемещения и создания ссылок"

ls -lR | grep "^-" | grep -v "report" | sort -k5 -rn | head -n 5
grep -e "костя" -e "настя" -e "Костя" -e "Настя" -rih . | grep -v -e "отчёт" -e "Отчёт" | sort -r | head -n 6
grep -rl "вино" claude_monet/wine_cellar claude_monet/storage/cellar_backup 2>/dev/null | wc -l
(head -n 1 claude_monet/bar/cocktail_menu; tail -n 1 claude_monet/bar/cocktail_menu; head -n 1 claude_monet/bar/evening_orders; tail -n 1 claude_monet/bar/evening_orders) | grep -i -e "коктейл" -e "заказ" | sort
grep -v "послед" claude_monet/hall/service_plan | grep -i -e "гост" -e "заказ" | sort -r | head -n 4 | wc -w
ls -liR | grep "^[0-9]" | grep -v "^d" | awk '$4 == 2' | sort -n -k1
ls -lR | grep "^l" | awk '{print $9}' | sort -r | head -n 1

chmod 777 kostya_room claude_monet/storage claude_monet/bar .

rm -f kostya_room/kostya_diary
rm -f kostya_room/today_orders
rm -f bar_entrance
rm -f bar_message
rm -f claude_monet/bar/owner_message
rm -f claude_monet/storage/supplier_note
rmdir empty_crates
rm -rf claude_monet/storage/cellar_backup

chmod 750 kostya_room
chmod 755 claude_monet

git add .
git commit -m "Часть 3 и 4: Выполнен поиск данных и удаление временных файлов"

git push origin main || git push origin master
