FILE="$HOME/cron-docker-image-prune"
echo $FILE
if [ -e "$FILE" ]; then
    echo "$FILE exists."
else 
    mkdir ~/cron-docker-image-prune
fi

cat <<EOF > ~/cron-docker-image-prune/del-doc-img-cron.sh
#!/bin/bash
sudo docker image prune -a --force --filter "until=168h"
EOF

crontab -l > prunecron
#echo new cron into cron file"
echo "* * * * * ~/cron-docker-image-prune/del-doc-img-cron.sh > /dev/null 2>&1" >> prunecron
#install new cron file
crontab prunecron
rm prunecron
crontab -l
