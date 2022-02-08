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
    expansion = 4
    def __init__(self, inplanes, planes, stride=1, downsample=None, groups=1, base_width=64, dilation=1, norm_layer=None):
        super(Bottleneck, self).__init__()
        if norm_layer is None:
            norm_layer = nn.BatchNorm2d

        width = int(planes * (base_width/64.)) * groups
        self.conv1 = conv1x1(inplanes, width)
        self.bn1 = norm_layer(width)
        self.conv2 = conv3x3(width, width, stride, groups, dilation)
        self.bn2 = norm_layer(width)
        self.conv3 = conv1x1(width, planes * self.expansion)
        self.bn3 = norm_layer(planes * self.expansion)
        self.relu = nn.ReLU()
        self.downsample = downsample
        self.stride = stride

    def forward(self, x):
        identity = x

        out = self.conv1(x)
        out = self.bn1(out)
        out = self.relu(out)

        out = self.conv2(out)
        out = self.bn2(out)
        out = self.relu(out)

        out = self.conv3(out)
        out = self.bn3(out)

        if self.downsample is not None:
            identity = self.downsample(x)

        out += identity
        out = self.relu(out)
        return out


    class ResNet(nn.Module):
        def __init__(self, block, layers, num_classes=1000, zero_init_residual=False,
                     groups=1, width_per_group=64, replace_stride_with_dilation=None,
                     norm_layer=None):
            super(ResNet, self).__init__()
            if norm_layer is None:
                norm_layer = nn.BatchNorm2d
            self._norm_layer = norm_layer

            self.inplanes = 64
            self.dilation = 1

            if replace_stride_with_dilation is None:
                replace_stride_with_dilation = [False, False, False]

            if len(replace_stride_with_dilation) != 3:
                raise ValueError("replace_stride_with_dilation should be None or a 3-element tuple")

            self.groups = groups
            self.base_width = width_per_group
            self.conv1 = nn.Conv2d(3, self.inplanes, kernel_size=7, stride=2, padding=3, bias=False)































