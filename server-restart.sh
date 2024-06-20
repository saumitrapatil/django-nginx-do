#! /bin/bash

uwsgi_id=$(ps -e | grep uwsgi | awk '{print $1}')

if [ -z $uwsgi_id ]; then
	sudo systemctl start django-uwsgi.service
else
	sudo systemctl restart django-uwsgi.service
fi
