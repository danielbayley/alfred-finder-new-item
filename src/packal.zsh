#! /bin/zsh -f
tar -xf *.tgz &&
mv icon.png package

cd $_
copy-node-modules .. .
cake -w plist > info.plist
rm package.json

# cake -n info TODO
zip -qryXm ../${npm_package_config_name:-test}.alfredworkflow *
