import torch
import torch.nn as nn
import torchvision.models as models

# Define the first loss function
class CompactLoss(nn.Module):
    def __init__(self):
        super(CompactLoss, self).__init__()

    def forward(self, x):
        center = torch.mean(x, dim=0).to(x.device)
        N = x.shape[0]
        x = torch.sum(torch.pow(torch.norm(x - torch.unsqueeze(center, dim=0), p=2, dim=-1), 2))
        return x / N

class BalanceLoss(nn.Module):
    def __init__(self):
        pass

class DistributionLoss(nn.Module):
    def __init__(self):
        pass

class TotalLoss(nn.Module):
    def __init__(self, l1, l2, l3):
        self.l1 = l1
        self.l2 = l2
        self.l3 = l3
        self.compact_loss = CompactLoss()
        self.balance_loss = BalanceLoss()
        self.distribution_loss = DistributionLoss()
        self.class_loss = nn.CrossEntropyLoss()

        self.count = 0

    def forward(self, pred, Y, x, w):
        # pred: predicted label
        # Y: true label
        self.count += 1
        cls_loss = self.class_loss(pred, Y)
        com_loss = self.compact_loss(x)
        bal_loss = self.balance_loss(w)
        dis_loss = self.distribution_loss(w, Y)
        if self.count%9 == 0:
            print(f"Class Loss:{%.4f:cls_loss}")
        return cls_loss + self.l1 * com_loss + self.l2 * bal_loss + self.l3 * dis_loss
