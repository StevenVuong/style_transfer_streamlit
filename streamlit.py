# Example by: https://github.com/terryz1/Image_Classification_App

import streamlit as st
import os
from PIL import Image

from torchvision import models, transforms
import torch

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

    # return top 5 predictions by highest probabilities
    labels = predict(image)
    for i in labels:
        st.write(f"Prediction (index, name): {i[0]}, Score: {i[1]}")
