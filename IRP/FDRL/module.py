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
        super(BalanceLoss, self).__init__()

    def forward(self, x):
        w2 = torch.tensor([1.0 / self.M] * self.M).to(w1.device)

        return torch.norm(torch.mean(w1, dim=0) - w2, p=1, dim=-1)

class DistributionLoss(nn.Module):
    def __init__(self):
        super(DistributionLoss, self).__init__()

    def forward(self, w1, Y):
        N = w1.shape[0]
        L2 = 0.0
        for cat in torch.unique(Y):
            avg = torch.mean(w1[Y==cat], dim=0)
            l2 = torch.norm(w1[Y==cat] - torch.unsqueeze(avg, dim=0), p=2, dim=-1)
            l2 = torch.pow(l2, 2)
            L2 += torch.sum(l2)
        return L2 / N




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
            print(f"Class Loss:{cls_loss:.4f}, Compact Loss:{com_loss:.4f}, Balance Loss{bal_loss:.4f}, Distribution Loss:{dis_loss:.4f}")
        return cls_loss + self.l1 * com_loss + self.l2 * bal_loss + self.l3 * dis_loss




class FDN(nn.Module):
    def __init__(self, M=9):
        super(FDN, self).__init__()
        self.M = M
        self.back = models.resnet18(pretrained=True)
        self.back.fc = nn.Sequential()
        self.linears = nn.ModuleList([nn.Linear(512, 128, bias=False) for i in range(M)])


    def forward(self, x):
        x = self.back(x)
        res = []
        for i in range(self.M):
            res.append(torch.relu(self.linears[i](x)))
        res = torch.cat(res, dim=1).view(-1, self.M, 128)
        return res

class Intra_RM(nn.Module):
    def __init__(self, M=9):
        super(Intra_RM, self).__init__()
        self.M = M
        self.linears = nn.ModuleList([nn.Linear(128, 128, bias=False) for i in range(M)])
        for i in range(self.M):
            nn.init.xavier_uniform_(self.linears[i].weight.data)

    def forward(self, I):
        weights = []
        res = []
        for i in range(self.M):
            x = I[:, i, :]
            alpha = torch.sigmoid(self.linears[i](x))
            importance = torch.norm(alpha, p=1, dim=-1, keepdim=True)
            temp = x * importance
            res.append(temp)
            weights.append(importance)
        res = torch.cat(res, dim=1).view((-1, self.M, 128))
        weights = torch.cat(weights, dim=1)
        return res, weights


class Inter_RM(nn.Module):
    def __init__(self, M=9, delta=0.5):
        super(Inter_RM, self).__init__()
        self.M = M
        self.delta = delta
        self.linears = nn.ModuleList([nn.Linear(128, 128, bias=False) for i in range(M)])
        for i in range(M):
            nn.init.xavier_uniform_(self.linears[i].weight.data)

    def forward(self, f):
        nodes = []
        for i in range(self.M):
            x = f[:, i, :]
            g = torch.relu(self.linears[i](x))
            nodes.append(g)

        nodes = torch.cat(nodes, dim=1).view((-1, self.M, 128))
        N = nodes.shape[0]
        edges = torch.zeros((N, self.M, self.M))

        for i in range(N):
            for j in range(self.M):
                for k in range(self.M):
                    edges[i][j][k] = torch.norm(nodes[i][j] - nodes[i][k], p=2, dim=-1)

        edges = torch.tang(edges)

        updates = []

        for i, pic in enumerate(nodes):
            distance = torch.unsqueeze(edges[i], dim=-1) * torch.ones((self.M, self.M, 128))
            distance = distance.to(pic.device)
            pic = torch.unsqueeze(pic, dim=0)
            pic = torch.sum(pic * distance, dim=1)
            updates.append(pic)

        updates = torch.cat(updates, dim=0).view((-1, self.M, 128))
        y = self.delta * f + (1 - self.delta) * updates
        y = torch.sum(y, dim=1)
        return y


class FDRL(nn.Module):
    def __init__(self, M=9, delta=0.5, num_classes=7):
        super(FDRL, self).__init__()
        self.fdn = FDN(M)
        self.intra_rm = Intra_RM(M)
        self.inter_rm = Inter_RM(M, delta)
        self.lin = nn.Linear(128, num_classes)
        nn.init.xavier_uniform_(self.lin.weight.data)


    def forward(self, x):
        x1 = self.fdn(x)
        x2, w = self.intra_rm(x1)
        y = self.inter_rm(x2)
        out = self.lin(y)
        return out, x1, ws










































