# The port that docker exposes to the public
HOST_IRC_PORT = 3900

# The port of the ZNC running inside the container
CONTAINER_IRC_PORT = 6697

# The directory that will hold the ZNC data directory
ZNC_DATA_DIR = /var/znc

# Where we plan to store backup data
BACKUPS_DIR = $(shell pwd)/backups

##############################################################################

SHELL = /bin/bash
CURRENT_DATE = $(shell date +"%Y-%m-%d")
USER_ID = $(shell id -u)
GROUP_ID = $(shell id -g)

build: build-znc-image

start: start-znc-image

backup-config: $(BACKUPS_DIR)
	cp $(ZNC_DATA_DIR)/configs/znc.conf $(BACKUPS_DIR)/znc.$(CURRENT_DATE).conf && \
	chown $(USER_ID):$(GROUP_ID) $(BACKUPS_DIR)/znc.$(CURRENT_DATE).conf

backup-data: $(BACKUPS_DIR)
	tar cvf - -C $(ZNC_DATA_DIR) users | gzip -9 > $(BACKUPS_DIR)/znc_data_$(CURRENT_DATE).tar.gz && \
		chown $(USER_ID):$(GROUP_ID) $(BACKUPS_DIR)/znc_data_$(CURRENT_DATE).tar.gz

# Create the backup dir if it doesn't exist, since it's required by backup-config and backup-data
$(BACKUPS_DIR):
	mkdir $(BACKUPS_DIR)

build-%-image: %-image
	docker build --rm -t kennydo/$(<:-image=) ./$<

start-znc-image:
	if [[ $$(docker ps -a | grep -E '\bznc\s*$$' | wc -l) = "1" ]]; \
	then \
		echo "Starting existing znc container"; \
		docker start znc; \
	else \
		echo "Starting new znc container"; \
		docker run -d -p 0.0.0.0:$(HOST_IRC_PORT):$(CONTAINER_IRC_PORT) -v $(ZNC_DATA_DIR):/znc --name znc kennydo/znc; \
	fi

stop:
	docker stop znc

shell:
	docker run --rm -i -t -v $(ZNC_DATA_DIR):/znc  kennydo/znc /bin/bash
