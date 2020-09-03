#! /bin/bash

mkdir models
wget --no-check-certificate 'https://docs.google.com/uc?export=download&id=0B9jhaT37ydSyQU1sYW02Sm9kV3c' -O './models/la_muse.ckpt'
wget --no-check-certificate 'hhttps://docs.google.com/uc?export=0B9jhaT37ydSyaEJlSFlIeUxweGs' -O './models/rain_princess.ckpt'
wget --no-check-certificate 'https://docs.google.com/uc?export=0B9jhaT37ydSyZ0RyTGU0Q2xiU28' -O './models/scream.ckpt'
wget --no-check-certificate 'https://docs.google.com/uc?export=0B9jhaT37ydSyb0NuYmk2ZEpOR0E' -O './models/udnie.ckpt'
wget --no-check-certificate 'https://docs.google.com/uc?export=folders/0B9jhaT37ydSyVGk0TC10bDF1S28' -O './models/wave.ckpt'
wget --no-check-certificate 'https://docs.google.com/uc?export=folders/0B9jhaT37ydSySjNrM3J5N2gweVk' -O './models/wreck.ckpt'

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
