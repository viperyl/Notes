from PIL import Image
import torch
from torch.utils.data import Dataset

class MyDataset(Dataset):
    def __init__(self, img_path: list, img_class: list, transform=None):
        self.img_path = img_path
        self.img_class = img_class
        self.transform = transform

    def __len__(self):
        return len(self.img_path)

    def __getitem__(self, item):
        img = Image.open(self.img_path[item])
        if img.mode != "RGB":
            raise ValueError("Image: {} isn't RGB mode.".format(self.img_path[item]))
        label = self.img_class[item]

        if self.transform:
            img = self.transform(img)

        return img, label

    @staticmethod
    def collate_in(batch):
        images, labels = tuple(zip(*batch))
        images = torch.stack(images, dim=0)
        labels = torch.as_tensor(labels)
        return images, labels
