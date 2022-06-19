from PIL import Image
import numpy as np
import random
import os

# data set package
import torch
from sklearn.model_selection import train_test_split
from torch.utils.data import Dataset, DataLoader
from torchvision import transforms
from torchvision.transforms.transforms import Resize, ToTensor, Normalize, ColorJitter, RandomRotation
from torchvision.transforms import InterpolationMode

np.random.seed(114514)
random.seed(114514)
torch.manual_seed(114514)


class CustomImageDataset(Dataset):
    def __init__(self, annotations, img, transform=None, target_transform=None):
        self.img_labels = annotations
        self.img = img
        self.transform = transform
        self.target_transform = target_transform

    def __len__(self):
        return len(self.img_labels)

    def __getitem__(self, idx):
        image = Image.fromarray(self.img[idx, :, :].transpose(1, 2, 0).astype('uint8'), 'RGB')
        label = self.img_labels[idx]
        label = torch.tensor(label).reshape(7)
        if self.transform:
            image = self.transform(image)
        if self.target_transform:
            label = self.target_transform(label)
        return image, label


def dataset_prep(path: str = "/home/viper/Downloads", type: str = "basic", batchsize: int = 64):
    if type == "basic" or type == "compound":
        x_path = os.path.join(path, "X_" + type + ".npy")
        y_path = os.path.join(path, "Y_" + type + ".npy")
    else:
        raise ValueError("type should be 'basic' or 'compound'")
    assert os.path.exists(x_path), f"image file does not exists in {x_path}"
    assert os.path.exists(y_path), f"label file does not exists in {y_path}"

    x = np.load(x_path, allow_pickle=True)
    y = np.load(y_path, allow_pickle=True)

    x_train, x_test, y_train, y_test = train_test_split(x, y, test_size=0.2, random_state=114514)
    x_test, x_valid, y_test, y_valid = train_test_split(x_test, y_test, test_size=0.5, random_state=114514)

    TrainTransform = transforms.Compose([Resize([224, 224]),
                                         RandomRotation(10),
                                         ToTensor()])
    TestTransform = transforms.Compose([Resize([224, 224]),
                                        ToTensor()])

    trainDataset = CustomImageDataset(y_train,
                                      x_train,
                                      TrainTransform)

    testDataset = CustomImageDataset(y_test,
                                     x_test,
                                     TestTransform)

    valDataset = CustomImageDataset(y_valid,
                                    x_valid,
                                    TestTransform)

    trainDataloader = DataLoader(trainDataset, batch_size=batchsize, shuffle=True, num_workers=4)
    testDataloader = DataLoader(testDataset, batch_size=batchsize, shuffle=False, num_workers=4)
    valDataloader = DataLoader(valDataset, batch_size=batchsize, shuffle=False, num_workers=4)

    return trainDataloader, testDataloader, valDataloader
