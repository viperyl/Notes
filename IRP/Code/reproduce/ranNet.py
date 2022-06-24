import torch.nn as nn
import math
import torch.utils.model_zoo as model_zoo
import torch.nn.functional as F
import torch
import numpy as np
import cv2
import pdb
from torchvision.models import resnet18

class RAN(nn.Module):
    def __init__(self, num_classes=7):
        super(RAN, self).__init__()
        self.features = nn.Sequential(*list(resnet18(pretrained=True).children())[:-1])
        self.alpha = nn.Sequential(nn.Linear(512, 1),
                                   nn.Sigmoid())
        self.beta = nn.Sequential(nn.Linear(1024, 1),
                                  nn.Sigmoid())
        self.fc = nn.Linear(1024,7)

    def forward(self, x):
        #print 'input image shape',x.shape
        vs = []
        alphas = []
        for i in range(6):
            f = x[:,:,:,:,i]
            f = self.features(f)
            f = f.squeeze(3).squeeze(2)
            #MN_MODEL
            vs.append(f)
            alphas.append(self.alpha(f))
        vs_stack = torch.stack(vs, dim=2)
        alphas_stack = torch.stack(alphas, dim=2)
        alphas_stack = F.softmax(alphas_stack,dim=2)
        #pdb.set_trace()
        alphas_part_max = alphas_stack[:,:,0:5].max(dim=2)[0]
        # alphas_part_max = alphas_stack[:,:,0:3].mean(dim=2)
        alphas_org = alphas_stack[:,:,5]
        vm = vs_stack.mul(alphas_stack).sum(2).div(alphas_stack.sum(2))
        # pdb.set_trace()
        for i in range(len(vs)):
            vs[i] = torch.cat([vs[i], vm], dim=1)
        vs_stack_4096 = torch.stack(vs, dim=2)
        # pdb.set_trace()
        betas = []
        for index, v in enumerate(vs):
            betas.append(self.beta(v))
        betas_stack = torch.stack(betas, dim=2)
        betas_stack = F.softmax(betas_stack,dim=2)

        #output = vs_stack_4096.mul(betas_stack).sum(2).div(betas_stack.sum(2))
        #index_image = torch.max((betas_stack*alphas_stack),1)
        # pdb.set_trace()
        output = vs_stack_4096.mul(betas_stack*alphas_stack).sum(2)
        output = output.div((betas_stack*alphas_stack).sum(2))
        output = output.view(output.size(0), -1)
        #max, index = torch.max(betas_stack*alphas_stack)
        #pdb.set_trace()
        pred_score = self.fc(output)
        #pred_score = F.dropout(pred_score, p=0.7)
        #x = x.view(x.size(0), -1)
        print("complete")
        return pred_score, alphas_part_max, alphas_org

if __name__ == "__main__":
    model = RAN()
    img = torch.rand(10, 3, 224, 224, 6)
    res = model(img)
