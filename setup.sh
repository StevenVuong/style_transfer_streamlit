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

mkdir ~/.streamlit/models
wget --no-check-certificate 'https://docs.google.com/uc?export=download&id=0B9jhaT37ydSyQU1sYW02Sm9kV3c' -O '~/.streamlit/models/la_muse.ckpt'
wget --no-check-certificate 'hhttps://docs.google.com/uc?export=0B9jhaT37ydSyaEJlSFlIeUxweGs' -O '~/.streamlit/models/rain_princess.ckpt'
wget --no-check-certificate 'https://docs.google.com/uc?export=0B9jhaT37ydSyZ0RyTGU0Q2xiU28' -O '~/.streamlit/models/scream.ckpt'
wget --no-check-certificate 'https://docs.google.com/uc?export=0B9jhaT37ydSyb0NuYmk2ZEpOR0E' -O '~/.streamlit/models/udnie.ckpt'
wget --no-check-certificate 'https://docs.google.com/uc?export=folders/0B9jhaT37ydSyVGk0TC10bDF1S28' -O '~/.streamlit/models/wave.ckpt'
wget --no-check-certificate 'https://docs.google.com/uc?export=folders/0B9jhaT37ydSySjNrM3J5N2gweVk' -O '~/.streamlit/models/wreck.ckpt'

mkdir ~/.streamlit/data
mkdir ~/.streamlit/data/input 
mkdir ~/.streamlit/data/output
