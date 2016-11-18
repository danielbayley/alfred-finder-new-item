#! /bin/zsh -f
set -- ${1:-test} info.plist

npm pack && # unpack
tar -xf *.tgz &&

npm run icon && mv icon.png package
cd $_

copy-node-modules .. .
#mkdir -p node_modules/.bin
#ln -s ../run-node/run-node $_

cp -f {,.}$2 && cake -w plist < .$2 > $2
rm package.json

zip -qryX ../$1.alfredworkflow * #-m #$npm_package_config_name

#trap 'npm run clean' EXIT
