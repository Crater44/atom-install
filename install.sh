#!/bin/bash
deb_url="https://download.pulsar-edit.dev/?os=linux&type=linux_deb"
deb_filename="pulsar.deb"
download_dir="/tmp"
custom_packages_dir=($(pwd)/atom-custom-packages)
mkdir $custom_packages_dir
github_url="https://github.com"
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

declare -A packages=(
    ["Glavin001"]="atom-beautify"
    ["file-icons"]="atom"
    ["emmetio"]="emmet-atom"
    ["TypeStrong"]="atom-typescript"
    ["Pulsar-Edit-Highlights"]="selected"
    ["steelbrain"]="intentions"
    ["abe33"]="atom-pigments"
)

for owner in "${!packages[@]}"; do
    package=${packages[$owner]}
    git clone $github_url/$owner/$package $custom_packages_dir/$package
done

directories=($(ls -d $custom_packages_dir/*))
for dir in "${directories[@]}"; do
    ppm link $custom_packages_dir/$dir
done
ppm install