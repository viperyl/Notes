import torch
import torch.nn as nn
from model.ResNet import resnet18
from utils.RAF_DB_loader import dataset_prep

# utils
import wandb
from tqdm import tqdm


def train(model, criterion, optimizer, train_loader, device):
    epoch_loss = 0.0
    model.train()
    for data in train_loader:
        # get the inputs; data is a list of [inputs, labels]
        inputs, labels = data
        inputs = inputs.float().to(device)
        labels = labels.float().to(device)
        optimizer.zero_grad()

        outputs = model(inputs)
        loss = criterion(outputs, labels)

        loss.backward()
        optimizer.step()

        epoch_loss += loss.item()

    return model, optimizer, epoch_loss


@torch.no_grad()
def test(model, test_loader, device):
    model.eval()
    t, f = 0, 0

    for data in test_loader:
        inputs, labels = data
        inputs = inputs.float().to(device)
        labels = labels.float()
        outputs = model(inputs)
        a1 = labels.argmax(dim=1).numpy()
        a2 = outputs.argmax(dim=1).detach().cpu().numpy()
        t += len(a1)
        f += (a1 == a2).sum()
    return f / t



if __name__ == "__main__":
    device = torch.device("cuda:0")

    dataset_name = "RAF-DB"
    batch_size = 256
    train_loader, test_loader, val_loader =dataset_prep(path="/home/viper/Downloads", type="basic", batchsize=batch_size)
    model = resnet18(num_classes=7).to(device)

    epochs = 200
    lr = 1e-3
    criterion = nn.CrossEntropyLoss()
    optimizer = torch.optim.Adam(model.parameters(), lr=lr)
    scheduler = torch.optim.lr_scheduler.MultiStepLR(optimizer, milestones=[30, 70], gamma=0.1)

    wandb.init(project="RAF_DB_ResNet", entity="viper_manjaro")

    wandb.config = {
        "learning_rate": lr,
        "epochs": epochs,
        "batch_size": batch_size,
        "description": "Initial train ResNet-18 model"
    }
    wandb.watch(model)

    for i in tqdm(range(epochs)):
        model, optimizer, epoch_loss = train(model, criterion, optimizer, train_loader, device)
        scheduler.step()
        acc1 = test(model, train_loader, device)
        acc2 = test(model, test_loader, device)
        acc3 = test(model, val_loader, device)
        wandb.log({"loss": epoch_loss, "lr": optimizer.param_groups[0]['lr'],
                   "train_acc": acc1, "test_acc": acc2, "val_acc": acc3})

    wandb.finish()
    torch.save(model.state_dict(), "./resnet18_100.pth")

