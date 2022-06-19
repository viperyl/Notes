import torch.nn as nn
import torch
from torchvision import models

class SE(nn.Module):
    def __init__(self, channel, reduction=16):
        super(SE, self).__init__()
        self.avg_pool = nn.AdaptiveAvgPool2d(1)
        self.fc = nn.Sequential(
            nn.Linear(channel, channel // reduction, bias=False),
            nn.ReLU(inplace=True),
            nn.Linear(channel // reduction, channel, bias=False),
            nn.Sigmoid()
        )

    def forward(self, x):
        b, c, _, _ = x.size()
        y = self.avg_pool(x).view(b, c)
        y = self.fc(y).view(b, c, 1, 1)
        return x * y.expand_as(x)

class ResNetSE(nn.Module):
    def __init__(self, model, num_class):
        super(ResNetSE, self).__init__()
        self.model = nn.Sequential(*list(model.children())[:-2])
        self.squeeze = SE(512)
        self.avgpool = nn.AdaptiveAvgPool2d((1,1))
        self.fc = nn.Linear(512, num_class)

    def forward(self, x):
        x = self.model(x)
        x = self.squeeze(x).squeeze()
        x = self.fc(x)
        return x








def resnetSE18(num_classes=1000, channels=3, include_top=True):
    pass
