import torch
import torch.nn as nn
from module import CompactLoss

def accuracy():


def accuracy(predicted,real):
    return (predicted.argmax(axis=1) == real).sum() / real.numel()
def eval_acc_gpu(net,data_iter,device =None):
    if isinstance(net,torch.nn.Module):
        net.eval()
        if not device:
            device = next(iter(net.parameters())).device
        total = 0.0
        for X,Y in data_iter:
            X = X.to(device)#加载到GPU
            Y=  Y.to(device)#加载到GPU
            pred,_,_ = net(X)
            total += accuracy(pred,Y)
    return  total / len(data_iter)

def train_FDRL(net,train_iter,test_iter,epochs,lr,lambda1,lambda2 ,lambda3 ,device=torch.device('cpu')):
    net.to(device)
    opt = torch.optim.Adam(net.parameters(),lr=lr,betas=(0.5,0.999))
    # 按区间动态减小学习率，每次降低1/gamma倍
    lr_sche = torch.optim.lr_scheduler.MultiStepLR(opt,[10,18,25,32],gamma=0.1)
    loss = TotalLoss(lambda1,lambda2,lambda3)

    print('-----train start------')
    for e in range(epochs):
        net.train()
        train_ls = 0.0
        train_acc = 0.0
        for X, Y in train_iter:
            X, Y = X.to(device), Y.to(device)
            opt.zero_grad()
            pred,x,w = net(X)
            ls = loss(pred,Y,x,w)
            ls.backward()
            opt.step()
            train_ls += ls
            train_acc += accuracy(pred, Y)
        # 每一个epcho之后更新 lr
        lr_sche.step()
        train_ls /= len(train_iter)
        train_acc /= len(train_iter)
        test_acc = eval_acc_gpu(net, test_iter, device)

        print(("Epoch %d ,loss: %f ,train_acc: %f , valid_acc: %f") % (e, train_ls, train_acc, test_acc))

    print('-----train end------')


