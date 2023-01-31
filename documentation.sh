#!/bin/bash

usage="Usage: $0 <target> (generate|memory_map|publish|view)"

target=${1:? "$usage"}
option=${2:? "$usage"}

workpath=../bluenet

source $workpath/source/scripts/_utils.sh

generate() {
	cs_info "Run doxygen with doxygen.config as configuration file"
	cd $workpath
#	doxygen -d markdown doxygen.config
#	doxygen -d printtree doxygen.config
	doxygen doxygen.config
	echo
	cs_info "Generate project version (adjust in doxygen.config if update is required): "
	cat doxygen.config | grep ^PROJECT_NUMBER
}

view() {
	cd $workpath
	cd docs/html
	xdg-open index.html
}

memory_map() {
	cs_info "Get .map file in BLUENET_BUILD_DIR"
	cd $workpath
	cd build/$target

	if  [ -e "crownstone.map" ]; then
		cs_info "Adjust crownstone.map for visualization"
		cp crownstone.map crownstone.tmp.map
		ex -c '%g/\.text\S*[\s]*$/j' -c "wq" crownstone.map
		ex -c '%g/\.rodata\S*[\s]*$/j' -c "wq" crownstone.map
		ex -c '%g/\.data\S*[\s]*$/j' -c "wq" crownstone.map
		ex -c '%g/\.bss\S*[\s]*$/j' -c "wq" crownstone.map
		sed -i 's/\.text\S*/.text/g' crownstone.map
		sed -i 's/\.rodata\S*/.rodata/g' crownstone.map
		sed -i 's/\.data\S*/.data/g' crownstone.map
		sed -i 's/\.bss\S*/.bss/g' crownstone.map
	fi

	cd ../../source/util/memory

	cs_log "Load now file crownstone.map from build directory in your browser"
	cs_log "Doesn't load automatically, load manually from build/$target/crownstone.map"
	xdg-open index.html
#	xdg-open --allow-file-access-from-files index.html
}

publish() {
	cs_log "We assume you have checked out the repository in docs/html again, but then the gh-pages branch"
	cd ../bluenet
	if [ ! -d "docs/html" ]; then
		cs_err "The docs/html directory does not exist."
		exit
	fi
	msg=$(git log -1 --oneline | cat)

	cd docs/html
	if [ ! -d ".git" ]; then
		cs_err "The docs/html directory should be its own git repository. Clone bluenet in separate folder and mv to docs/html."
		cs_err "cd ~; git clone git@github.com:crownstone/bluenet; cd bluenet; git checkout gh-pages; cd ..; mv bluenet \$BLUENET_SOURCE_DIR/docs/html"
		exit
	fi
	branch=$(git rev-parse --abbrev-ref HEAD)
	echo $branch
	if [ "$branch" != "gh-pages" ]; then
		cs_err "The docs/html directory should be its own git repository. Clone bluenet in separate folder, mv to docs/html and checkout gh-pages."
		cs_err "cd ~; git clone git@github.com:crownstone/bluenet; cd bluenet; git checkout gh-pages; cd ..; mv bluenet \$BLUENET_SOURCE_DIR/docs/html"
		exit
	fi

	cs_info "Add all documentation changes to git"
	git add .

	cs_info "Commit changes to git, use as message $msg"
	git commit -m "$msg"

	cs_info "Pull existing changes from remote gh-pages branch"
	git pull

	cs_info "Push new changes"
	git push

	cs_info "Go to https://crownstone.github.io/bluenet"
}

case $option in
	generate)
		generate
	;;
	memory_map)
		memory_map
	;;
	publish)
		publish
	;;
	view)
		view
	;;
	*)
		cs_err "Unknown option: \"$option\""
	;;
esac
