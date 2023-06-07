# general package
import os
import numpy as np
from PIL import Image
import matplotlib.pyplot as plt
import cv2

# ?!CA package
from utils import GradCAM, show_cam_on_image

# torch package
import torch
from torchvision import models
from torchvision import transforms
from torch import nn


def main():
    model = models.resnet18(pretrained=True)
    model.fc = nn.Linear(512, 7)
    model.load_state_dict(torch.load("./resnet18_43.pth"))
    target_layers = [model.layer4]
    data_transform = transforms.Compose([transforms.ToTensor(),
                                         transforms.Resize([224, 224])])


    img_path = "train_00012_aligned.jpg"
    assert os.path.exists(img_path)
    img = Image.open(img_path).convert("RGB")
    img = np.array(img, dtype=np.uint8)
    resized = cv2.resize(img, (224, 224), interpolation=cv2.INTER_AREA)

    # C, H, W
    img_tensor = data_transform(img)

    # B, C, H, W
    input_tensor = torch.unsqueeze(img_tensor, dim=0)

    cam = GradCAM(model=model, target_layers=target_layers, use_cuda=True)
    target_category = 0

    grayscale_cam = cam(input_tensor=input_tensor, target_category=target_category)
    grayscale_cam = grayscale_cam[0, :]
    visualization = show_cam_on_image(resized.astype(dtype=np.float32)/255., grayscale_cam)
    plt.imshow(visualization)
    plt.show()


if __name__ == "__main__":
    main()
