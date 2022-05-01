import torch
import torch.nn as nn
from model.ResNet import resnet18



class VTFF(nn.Module):
    def __init__(self, num_classes):
        super(VTFF, self).__init__()
        baseModel_1 = resnet18(num_classes=num_classes, channels=3)
        baseModel_2 = resnet18(num_classes=num_classes, channels=1)
        self.resNet_1 = torch.nn.Sequential(*(list(baseModel_1.children())[:-2]))
        self.resNet_2 = torch.nn.Sequential(*(list(baseModel_2.children())[:-2]))


    def forward(self, x):
        x_rgb = x[:, :3, :, :]
        x_lbp = x[:, 3:, :, :]
        rgb_feature = self.resNet_1(x_rgb)
        lbp_feature = self.resNet_2(x_lbp)
        return rgb_feature, lbp_feature


