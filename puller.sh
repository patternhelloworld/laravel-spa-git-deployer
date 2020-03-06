your_web_appplication_folder="/var/www/html/my-project"

cd ${your_web_appplication_folder} || exit

# In case you should roll the whole source back to a previous certain point.
# ex) sh puller.sh back 1  (the number after "back" can be checked by running 'git reflog')
if [ "$1" == "back" ]; then

if [ -z "$2" ]
  then
    echo "No backup number supplied"
    exit 0
fi

git reset --hard HEAD@{$2} || (git fetch origin && git reset --hard origin/develop)

else

        git fetch origin
        git reset --hard origin/real

fi

composer dump-autoload
php artisan cache:clear
# This can be :clear or :cache according to your settings.
php artisan config:cache
php artisan route:cache || php artisan route:clear
php artisan view:cache || php artisan view:clear

service php7.3-fpm restart
# apache2 or nginx
service apache2 reload

# In case you use redis
service redis-server stop
redis-server --daemonize yes

# socket, etc.
