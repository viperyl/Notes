import sys
from tqdm import tqdm


import torch
import torch.nn as nn
import torch.optim as optim

# custom package
from utils import dataload
from model import ResNet



def train():
    pass

def get_acc(dataloader, name,device):
    acc = 0.0  # accumulate accurate number / epoch
    with torch.no_grad():
        bar = tqdm(val_loader, file=sys.stdout)
        for data in dataloader:
            images, labels = data
            outputs = net(images.to(device))
            predict_y = torch.argmax(outputs, dim=1).to(device)
            argmax_labels = torch.argmax(labels, dim=1)
            acc += torch.eq(predict_y.to(device), argmax_labels.to(device)).sum().item()

            bar.desc = name + " epoch[{}/{}]".format(epoch + 1, epochs)
    return acc/len(dataloader.dataset)


if __name__ == "__main__":
    raf_DB_path = "/run/media/viper/LSP/Dataset/RAF-DB/basic/numpy"
    task = "RAF-DB"
    train_loader, test_loader, val_loader = dataload.data_prep(task, 16)



    net = ResNet.resnet34(7)

    params = [p for p in net.parameters() if p.requires_grad]
    loss_function = nn.CrossEntropyLoss()
    optimizer = optim.Adam(params, lr=0.0001)

    epochs = 100
    best_acc = 0.0
    save_path = "/run/media/viper/LSP/Dataset/train_res/" + task + "/" + "ResNet34.pth"
    train_steps = len(train_loader)
    if torch.cuda.is_available():
        device = torch.device("cuda:0")
        print("Current device: ", "Cuda:0")
    else:
        device = torch.device("cpu")
        print("Current device: ", "cpu")

    net.to(device)

    for epoch in range(epochs):
        # train
        net.train()
        running_loss = 0.0
        train_bar = tqdm(train_loader, file=sys.stdout)
        for step, data in enumerate(train_bar):
            images, labels = data
            labels = labels.type(torch.float32)

            optimizer.zero_grad()
            logits = net(images.to(device)).softmax(dim=1)
            loss = loss_function(logits, labels.to(device))

            loss.backward()
            optimizer.step()

            # print statistics
            running_loss += loss.item()

            train_bar.desc = "train epoch[{}/{}] loss:{:.3f}".format(epoch + 1,
                                                                     epochs,
                                                                     loss)

        # validate
        net.eval()
        train_accuracte = get_acc(train_loader, "train", device)
        val_accurate = get_acc(val_loader, "valid", device)
        test_accuracte = get_acc(test_loader, "test", device)

        print('[epoch %d] train_loss: %.3f  train_acc: %.3f  val_acc: %.3f  test_acc: %.3f' %
              (epoch + 1, running_loss / train_steps, train_accuracte, val_accurate, test_accuracte))

        if val_accurate > best_acc:
            best_acc = val_accurate
            torch.save(net.state_dict(), save_path)

    print('Finished Training')