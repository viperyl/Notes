import torch
import torch.nn as nn

def conv3x3(in_plane, out_plane, stride=1, groups=1, dilation=1):
    # 3x3 convolution with padding
    return nn.Conv2d(in_plane, out_plane, kernel_size=3, stride=stride,
                     padding=dilation, groups=groups, bias=False,dilation=dilation)


def conv1x1(in_planes, out_planes, stride=1):
    # 1x1 convolution for channel adjustment
    return nn.Conv2d(in_planes, out_planes, kernel_size=1, stride=stride, bias=False)


class Bottleneck(nn.Module):

