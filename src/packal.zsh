#! /bin/zsh -f
npm pack && # unpack
tar -xf *.tgz &&

npm run icon && mv icon.png package
cd $_

copy-node-modules .. .
#mkdir -p node_modules/.bin
#ln -s ../run-node/run-node $_

cake -w plist > info.plist
rm package.json

zip -qryXm ../${1:-test}.alfredworkflow * #$npm_package_config_name

trap 'npm run clean' EXIT
