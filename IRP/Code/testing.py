from torchsummary import summary
import torch
from model.VTFF import VTFF

if __name__ == "__main__":
    data = torch.rand(10, 4, 224, 224)
    model = VTFF(5)
    a, b = model(data)
    print(a.shape)
    print(b.shape)