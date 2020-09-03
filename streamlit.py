# Example by: https://github.com/terryz1/Image_Classification_App

import streamlit as st
import os
import subprocess
#from src.obj_detect import predict_objs
from PIL import Image


st.title('Image Object Detection and Style Generator')

option_one = st.selectbox(
    'Object Detection or Style Generator?',
    ('Object Detection', 'Style Generator'))

st.write('You selected:', option_one)

option_two = None
image_name = None
if option_one=='Style Generator':
    option_two = st.selectbox(
    'Select a Style',
    ('La Muse', 'Rain Princess', 'Scream', 'Udnie', 'Wave', 'Wreck'))
    image_name = option_two.lower().replace(' ', '_')
    image = Image.open(os.path.join('./examples/thumbs', image_name+'.jpg'))
    st.image(image, width=250)

# ignore deprecation warning
st.set_option('deprecation.showfileUploaderEncoding', False)
# Upload Image
file_up = st.file_uploader("Upload an image", type=["jpg", "png", "jpeg"])

if file_up is not None:

    # Display image
    image = Image.open(file_up)
    st.image(image, caption="Uploaded Image", use_column_width=True)

    st.write("")
    st.write("Processing..")

    if option_one=='Object Detection':
        # return top 5 predictions by highest probabilities
        st.write('Hello')
        # labels = predict_objs(image)
        # for i in labels:
        #     st.write(f"Prediction (index, name): {i[0]}, Score: {i[1]}")

    if option_one=='Style Generator':
        image.save(f'./data/input/tmp.png')
        subprocess.run([
            'python3', 
            'evaluate.py',
            '--checkpoint',
            f'./models/{image_name}.ckpt',
            '--in-path',
            './data/input/',
            '--out-path',
            './data/output/'
            ])
        image = Image.open('./data/output/tmp.png')
        st.image(image, caption="Processed Image", use_column_width=True)
