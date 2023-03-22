mount:
	rclone mount onedrive_crypt:/sec local_media \
	--vfs-cache-mode full --allow-other --no-modtime \
	--max-read-ahead 1024k --dir-cache-time 1000h --vfs-read-ahead 1024k &

unmount:
	fusermount -u smol/local_media 

build:
	cd nginx && docker build -t einaeffchen/nginx-smol:dev .
	docker build -t einaeffchen/smol:dev .

up: 
	docker-compose up -d

restart: build up