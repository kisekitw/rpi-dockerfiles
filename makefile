NS=lojzik

ROOTDIR=.

BUILD=docker build -t $@ --rm  $(ROOTDIR)/$(@F)
PUSH=docker push 

all:  


clean: delete-stopped delete-untagged
  
delete-untagged:
	docker rmi $$(docker images -q -f dangling=true)
delete-stopped:
	docker rm $$(docker ps -a -q)

build-all: $(NS)/rpi-nginx $(NS)/rpi-php-cli $(NS)/rpi-php-fpm $(NS)/rpi-i2c $(NS)/rpi-python $(NS)/rpi-adafruit $(NS)/mariadb 
	
$(NS)/rpi-nginx: 
	$(BUILD)
	$(PUSH)

$(NS)/rpi-php-cli: 
	$(BUILD)
	$(PUSH)
		
$(NS)/rpi-php-fpm: $(NS)/rpi-php-cli
	$(BUILD)
	$(PUSH)

$(NS)/rpi-i2c: 
	$(BUILD)
	$(PUSH)

$(NS)/rpi-python: 
	$(BUILD)
	$(PUSH)
	
$(NS)/rpi-adafruit: $(NS)/rpi-rpi-python
	$(BUILD)
	$(PUSH)


$(NS)/mariadb:
	$(BUILD)
	$(PUSH)

		