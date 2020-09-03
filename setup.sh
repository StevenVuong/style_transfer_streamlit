#! /bin/bash

mkdir models
# wget --no-check-certificate 'https://drive.google.com/drive/folders/0B9jhaT37ydSyRk9UX0wwX3BpMzQ/la_muse.ckpt' -O 'la_muse.ckpt'
# wget --no-check-certificate 'https://drive.google.com/drive/folders/0B9jhaT37ydSyRk9UX0wwX3BpMzQ/rain_princess.ckpt' -O FILENAME
# wget --no-check-certificate 'https://drive.google.com/drive/folders/0B9jhaT37ydSyRk9UX0wwX3BpMzQ/scream.ckpt' -O FILENAME
# wget --no-check-certificate 'https://drive.google.com/drive/folders/0B9jhaT37ydSyRk9UX0wwX3BpMzQ/udnie.ckpt' -O FILENAME
# wget --no-check-certificate 'https://drive.google.com/drive/folders/0B9jhaT37ydSyRk9UX0wwX3BpMzQ/wreck.ckpt' -O FILENAME

mkdir data
mkdir data/input 
mkdir data/output

mkdir -p ~/.streamlit/
echo "\
[general]\n\
email = \"steven.vuong@foundersfactory.co\"\n\
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
