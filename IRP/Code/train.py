import torch
import torch.nn as nn
from model.ResNet import resnet18
from utils.dataload import data_prep





if __name__ == "__main__":
    dataset_name = "RAF-DB"
    batch_size = 128
    train_loader, test_loader, val_loader = data_prep(dataset_name, batch_size)
    model = resnet18(num_classes=7)

    criterion = nn.CrossEntropyLoss()
    optimizer = torch.optim.Adam(model.parameters(), lr=1e-3)
    scheduler = torch.optim.lr_scheduler.MultiStepLR(optimizer, milestones=[200, 700], gamma=0.1)
