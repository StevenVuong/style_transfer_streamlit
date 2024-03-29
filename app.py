# Example by: https://github.com/terryz1/Image_Classification_App

import streamlit as st
import os
import subprocess
from PIL import Image
from io import BytesIO
import base64
import numpy as np

CWD=os.getcwd()

# ignore deprecation warning
st.set_option('deprecation.showfileUploaderEncoding', False)
st.title('Style Generator')

style_option = None
image_name = None

option_two = st.selectbox(
    'Select a Style',
    ('La Muse', 'Rain Princess', 'Scream', 'Udnie', 'Wave', 'Wreck')
    )
style_image_name = option_two.lower().replace(' ', '_')
style_image = Image.open(os.path.join(CWD, 'examples/thumbs', style_image_name+'.jpg'))
st.image(style_image, width=250)

# Upload Image
file_up = st.file_uploader("Upload an image", type=["jpg", "png", "jpeg"])

def get_image_download_link(img):
	"""Generates a link allowing the PIL image to be downloaded
	in:  PIL image
	out: href string
	"""
	buffered = BytesIO()
	img.save(buffered, format="JPEG")
	img_str = base64.b64encode(buffered.getvalue()).decode()
	href = f'<a href="data:file/jpg;base64,{img_str}">Download Processed Image</a>'
	return href

if file_up is not None:

    # Display image
    image = Image.open(file_up)

    ### RESIZE
    basewidth=512
    im_width, im_height = image.size
    wpercent = (basewidth/float(im_width))
    hsize = int((float(im_height)*float(wpercent)))
    image = image.resize((basewidth,hsize), Image.ANTIALIAS)
    ###

    st.image(image, caption="Uploaded Image", use_column_width=True)

    st.write("")
    st.write("Processing..")
    try:
        os.remove(os.path.join(CWD, 'data/output', 'tmp.png'))
    except:
        print('No output file!')
    image.save(os.path.join(CWD, 'data/input/tmp.png'))

    subprocess.run([
        'python3', 
        'evaluate.py',
        '--checkpoint',
        f'{CWD}/models/{style_image_name}.ckpt',
        '--in-path',
        os.path.join(CWD, 'data/input/'),
        '--out-path',
        os.path.join(CWD, 'data/output/')
        ])
    image = Image.open(os.path.join(CWD, 'data/output', 'tmp.png'))
    st.image(image, caption="Processed Image", use_column_width=True)
    st.markdown(get_image_download_link(image), unsafe_allow_html=True)
