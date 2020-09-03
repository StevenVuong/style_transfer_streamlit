#! /bin/bash

mkdir data
mkdir data/input 
mkdir data/output

mkdir -p ~/.streamlit/
echo "\
[general]\n\
email = \"your@domain.com\"\n\
" > ~/.streamlit/credentials.toml
echo "\
[server]\n\
headless = true\n\
enableCORS=false\n\
port = $PORT\n\
" > ~/.streamlit/config.toml

# cd data
# wget http://www.vlfeat.org/matconvnet/models/beta16/imagenet-vgg-verydeep-19.mat
# mkdir bin
# wget http://msvocds.blob.core.windows.net/coco2014/train2014.zip
# unzip -q train2014.zip
