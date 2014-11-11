HOST_IRC_PORT = 3900
CONTAINER_IRC_PORT = 6697

build: build-znc-data-image build-znc-image

build-%-image: %-image
	docker build --rm -t kennydo/$(<:-image=) ./$<

start: start-znc-image

start-znc-data-image:
	docker run -d --name znc-data kennydo/znc-data

start-znc-image: start-znc-data-image
	docker run -d -p 0.0.0.0:$(HOST_IRC_PORT):$(CONTAINER_IRC_PORT) --volumes-from znc-data --name znc kennydo/znc
