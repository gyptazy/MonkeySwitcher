MAINTAINER_EMAIL=gyptazy@gyptazy.ch
VERSION="$(shell cat VERSION)"
BUILD_DIR=.build

all: build

build:
	mkdir $(BUILD_DIR)
	mkdir $(BUILD_DIR)/MonkeySwitcher.app
	cp -R Contents $(BUILD_DIR)/MonkeySwitcher.app/
	echo "Your application in version $(VERSION) is located in: $(BUILD_DIR)"

clean:
	@echo "Deleting $(BUILD_DIR) directory for version: $(VERSION)." 
