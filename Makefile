help:
	@echo "Spot Docker Makefile Help"
	@echo "-----------------------"
	@echo ""
	@echo "Build the container"
	@echo "    make build"
	@echo ""
	@echo "Start the container"
	@echo "    make start"
	@echo ""
	@echo "Run tests to ensure current state is good"
	@echo "    make test"
	@echo ""
	@echo "Stop the container"
	@echo "    make stop"
	@echo ""
	@echo "Really, really start over"
	@echo "    make clean"
	@echo ""

build:
	@docker build -t spot_hadoop .

start:
	@docker run -dit -p 8088:8088 --name hadoop spot_hadoop

stop:
	@docker stop hadoop

test:
	@echo "Testing docker container..."

clean:
	@echo "Removing all containers, images, volumes..."
