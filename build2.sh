#!/bin/bash
# Copyright cc 2022 anothermi

# Function to clear files and folders inside a directory
function clear_directory() {
    local directory="$1"

    if [ -d "$directory" ]; then
        echo "Clearing contents of $directory..."
        rm -rf "$directory"/*
    else
        echo "Directory $directory not found."
    fi
}

# init
function init() {
    echo "==========================="
    echo "= START COMPILING KERNEL  ="
    echo "==========================="

    # Clear previous build artifacts
    clear_directory "out"
}

# Main 
   function compile() {
    make -j$(nproc --all) O=out ARCH=arm64 SM6375_defconfig
    make -j$(nproc --all) ARCH=arm64 O=out \
                          CROSS_COMPILE=aarch64-linux-gnu- \
                          CROSS_COMPILE_ARM32=arm-linux-gnueabi-
}

# end
function end(){
    echo "==========================="
    echo "   COMPILE KERNEL COMPLETE  "
    echo "==========================="
}

# execute
init
compile
end
