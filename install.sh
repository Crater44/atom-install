#!/bin/bash
deb_url="https://download.pulsar-edit.dev/?os=linux&type=linux_deb"
deb_filename="pulsar.deb"
download_dir="/tmp"
custom_packages_dir=($(pwd)/atom-custom-packages)
wget -O "$download_dir/$deb_filename" "$deb_url"
if [ $? -eq 0 ]; then
    deb_path="$download_dir/$deb_filename"
    sudo dpkg -i "$deb_path"
    if [ $? -eq 0 ]; then
        echo "Pulsar installed successfully."
        rm -rf $deb_path
    else
        echo "Failed to install pulsar."
    fi
else
    echo "Failed to download pulsar."
fi
mkdir $custom_packages_dir
cd $custom_packages_dir
git clone https://github.com/Glavin001/atom-beautify .
git clone https://github.com/file-icons/atom .
git clone https://github.com/emmetio/emmet-atom .
git clone https://github.com/TypeStrong/atom-typescript .
git clone https://github.com/Pulsar-Edit-Highlights/selected .
git clone https://github.com/steelbrain/intentions .
git clone https://github.com/abe33/atom-pigments .
directories=($(ls -d */))
for dir in "${directories[@]}"; do
    echo "Directory: $dir"
    cd $dir
    ppm link .
    ppm install
    cd $custom_packages_dir
done