# The port that docker exposes to the public
HOST_IRC_PORT = 3900

# The port of the ZNC running inside the container
CONTAINER_IRC_PORT = 6697

# Where we plan to store backup data
BACKUPS_DIR = $(shell pwd)/backups


##############################################################################

CURRENT_DATE = $(shell date +"%Y-%m-%d")

build: build-znc-data-image build-znc-image

start: start-znc-image

backup-config: $(BACKUPS_DIR)
	docker run -i --volumes-from znc-data -v $(BACKUPS_DIR):/backup busybox sh -c 'cp /home/znc-user/.znc/configs/znc.conf /backup/znc.$(CURRENT_DATE).conf'

# Create the backup dir if it doesn't exist, since it's required by backup-config and backup-data
$(BACKUPS_DIR):
	mkdir $(BACKUPS_DIR)

build-%-image: %-image
	docker build --rm -t kennydo/$(<:-image=) ./$<

start-znc-data-image:
	docker run -d --name znc-data kennydo/znc-data

start-znc-image: start-znc-data-image
	docker run -d -p 0.0.0.0:$(HOST_IRC_PORT):$(CONTAINER_IRC_PORT) --volumes-from znc-data --name znc kennydo/znc
