function nuclearOption

    set cwd (pwd)
    cd $__dotfiles_CODE_DIR

    sudo -uwww-data iats memcached flush
    iats config flush-cache
    iats hooks --rebuild-cache

    sudo service nginx restart
    sudo service php7.0-fpm restart
    sudo -u www-data iats synapser restart

    cd $cwd

end
