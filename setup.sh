# install requirements
python3 -m pip install tensorflow==2.3.0 --no-cache-dir
python3 -m pip install -r requirements.txt

# download models
mkdir ./models
wget --no-check-certificate 'https://docs.google.com/uc?export=download&id=0B9jhaT37ydSyQU1sYW02Sm9kV3c' -O './models/la_muse.ckpt'
wget --no-check-certificate 'https://docs.google.com/uc?export=download&id=0B9jhaT37ydSyaEJlSFlIeUxweGs' -O './models/rain_princess.ckpt'
wget --no-check-certificate 'https://docs.google.com/uc?export=download&id=0B9jhaT37ydSyZ0RyTGU0Q2xiU28' -O './models/scream.ckpt'
wget --no-check-certificate 'https://docs.google.com/uc?export=download&id=0B9jhaT37ydSyb0NuYmk2ZEpOR0E' -O './models/udnie.ckpt'
wget --no-check-certificate 'https://docs.google.com/uc?export=download&id=0B9jhaT37ydSyVGk0TC10bDF1S28' -O './models/wave.ckpt'
wget --no-check-certificate 'https://docs.google.com/uc?export=download&id=0B9jhaT37ydSySjNrM3J5N2gweVk' -O './models/wreck.ckpt'

mkdir ./data
mkdir ./data/input 
mkdir ./data/output