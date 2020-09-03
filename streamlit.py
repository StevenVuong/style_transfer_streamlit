# Example by: https://github.com/terryz1/Image_Classification_App

import streamlit as st
import os
import subprocess
from PIL import Image

from torchvision import models, transforms
import torch

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

def predict(image):
    resnet = resnet = models.resnet101(pretrained=True)

    # transform image: Resize, Crop, turn to tensor and Normalise
    transform = transforms.Compose([
        transforms.Resize(256),
        transforms.CenterCrop(224),
        transforms.ToTensor(),
        transforms.Normalize(
        mean=[0.485, 0.456, 0.406],
        std=[0.229, 0.224, 0.225]
        )])
    
    batch_t = torch.unsqueeze(transform(image), 0)

    resnet.eval()
    out = resnet(batch_t)

    with open('imagenet_classes.txt') as f:
        classes = [line.strip() for line in f.readlines()]

    prob = torch.nn.functional.softmax(out, dim=1)[0] * 100
    _, indices = torch.sort(out, descending=True)
    return [(classes[idx], prob[idx].item()) for idx in indices[0][:5]]

if file_up is not None:

    # Display image
    image = Image.open(file_up)
    st.image(image, caption="Uploaded Image", use_column_width=True)

    st.write("")
    st.write("Processing..")

    if option_one=='Object Detection':
        # return top 5 predictions by highest probabilities
        labels = predict(image)
        for i in labels:
            st.write(f"Prediction (index, name): {i[0]}, Score: {i[1]}")

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
