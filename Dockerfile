FROM python:3.7

RUN pip install virtualenv
ENV VIRTUAL_ENV=/venv
RUN virtualenv venv -p python3
ENV PATH="VIRTUAL_ENV/bin:$PATH"

WORKDIR /usr/src/app

# Install dependencies
COPY requirements.txt ./
RUN pip install -r requirements.txt

# copying all files over
COPY app.py ./
COPY evaluate.py ./
COPY examples ./examples
COPY ./scripts ./scripts
COPY src ./src

# Download models
RUN mkdir ./models
RUN mkdir ./data
RUN mkdir ./data/input
RUN mkdir ./data/output

RUN wget --no-check-certificate 'https://docs.google.com/uc?export=download&id=0B9jhaT37ydSyQU1sYW02Sm9kV3c' -O './models/la_muse.ckpt'
RUN wget --no-check-certificate 'https://docs.google.com/uc?export=download&id=0B9jhaT37ydSyaEJlSFlIeUxweGs' -O './models/rain_princess.ckpt'
RUN wget --no-check-certificate 'https://docs.google.com/uc?export=download&id=0B9jhaT37ydSyZ0RyTGU0Q2xiU28' -O './models/scream.ckpt'
RUN wget --no-check-certificate 'https://docs.google.com/uc?export=download&id=0B9jhaT37ydSyb0NuYmk2ZEpOR0E' -O './models/udnie.ckpt'
RUN wget --no-check-certificate 'https://docs.google.com/uc?export=download&id=0B9jhaT37ydSyVGk0TC10bDF1S28' -O './models/wave.ckpt'
RUN wget --no-check-certificate 'https://docs.google.com/uc?export=download&id=0B9jhaT37ydSySjNrM3J5N2gweVk' -O './models/wreck.ckpt'

# Expose port 
ENV PORT 8501

# cmd to launch app when container is run
CMD streamlit run app.py

# streamlit-specific commands for config
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8
RUN mkdir -p /root/.streamlit
RUN bash -c 'echo -e "\
[general]\n\
email = \"\"\n\
" > /root/.streamlit/credentials.toml'

RUN bash -c 'echo -e "\
[server]\n\
enableCORS = false\n\
" > /root/.streamlit/config.toml'
