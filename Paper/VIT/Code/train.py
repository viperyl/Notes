import os
import math
import argparse

import torch
import torch.optim as optim
import torch.optim.lr_scheduler as lr_schedular
from torch.utils.tensorboard import SummaryWriter
from torchvision import transforms

from my_dataset import MyDataset
from vit_model import vit_base_patch16_224_in21k as create_model
from utils import read_split_data, train_one_epoch, evaluate

def main(args):
    device = torch.device(args.device if torch.cuda.is_available() else "cpu")
    if os.path.exists("/home/yang/Documents/dataset/weights") is False:
        os.makedirs("/home/yang/Documents/dataset/weights")

    tb_writter = SummaryWriter()

    t_img_path, t_img_label, v_img_path, v_img_label = read_split_data(args.data_path)

    data_transfrom = {
        "train": transforms.Compose([transforms.RandomResizedCrop(224),
                                     transforms.RandomHorizontalFlip(),
                                     transforms.ToTensor(),
                                     transforms.Normalize([0.5, 0.5, 0.5], [0.5, 0.5, 0.5])]),
        "val": transforms.Compose([transforms.Resize(256),
                                   transforms.CenterCrop(224),
                                   transforms.ToTensor(),
                                   transforms.Normalize([0.5, 0.5, 0.5], [0.5, 0.5, 0.5])])
    }

    train_dataset = MyDataset(img_path=t_img_path,
                              img_class=t_img_label,
                              transform=data_transfrom["train"])
    val_dataset = MyDataset(img_path=v_img_path,
                            img_class=v_img_label,
                            transform=data_transfrom["val"])

    batch_size = args.batch_size

    nw = min([os.cpu_count(), batch_size if batch_size > 1 else 0, 8])
    print(f"Using {nw} dataloader workers every process")

    train_loader = torch.utils.data.DataLoader(train_dataset,
                                               batch_size=batch_size,
                                               shuffle=True,
                                               pin_memory=nw,
                                               num_workers=nw,
                                               collate_fn=train_dataset.collate_in)

    val_loader = torch.utils.data.DataLoader(val_dataset,
                                             batch_size=batch_size,
                                             shuffle=False,
                                             pin_memory=True,
                                             num_workers=nw,
                                             collate_fn=val_dataset.collate_in)

    model = create_model(num_classes=5, has_logits=False).to(device)

    if args.weights != "":
        assert os.path.exists(args.weights), f"weight file: {args.weights} not exist"
        weights_dict = torch.load(args.weights, map_location=device)

        del_keys = ["head.weight", "head.bias"] if model.has_logits else ["pre_logits.fc.weight", "pre_logits.fc.bias", "head.weight", "head.bias"]

        for k in del_keys:
            del weights_dict[k]
        print(model.load_state_dict(weights_dict, strict=False))

    if args.freeze_layers:
        for name, para in model.named_parameters():
            if "head" not in name and "pre_logits" not in name:
                para.requires_grad_(False)
            else:
                print(f"training {name}")

    pg = [p for p in model.parameters() if p.requires_grad]
    optimizer = optim.SGD(pg, lr=args.lr, momentum=0.9, weight_decay=5e-5)
    lr = lambda x: ((1 + math.cos(x * math.pi /args.epochs))/2) * (1 - args.lrf) + args.lrf
    schedular = lr_schedular.LambdaLR(optimizer, lr_lambda=lr)

    for epoch in range(args.epochs):
        train_loss, train_acc = train_one_epoch(model=model,
                                                optimizer=optimizer,
                                                data_loader=train_loader,
                                                device=device,
                                                epoch=epoch)
        schedular.step()

        val_loss, val_acc = evaluate(model=model,
                                     data_loader=val_loader,
                                     device=device,
                                     epoch=epoch)
        tags = ["train_loss", "train_acc", "val_loss", "val_acc", "learning_rate"]
        tb_writter.add_scalar(tags[0], train_loss, epoch)
        tb_writter.add_scalar(tags[1], train_acc, epoch)
        tb_writter.add_scalar(tags[2], val_loss, epoch)
        tb_writter.add_scalar(tags[3], val_acc, epoch)
        tb_writter.add_scalar(tags[4], optimizer.param_groups[0]["lr"], epoch)

        torch.save(model.state_dict(), "/home/yang/Documents/dataset/weights/model-{}.pth".format(epoch))

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--num_classes", type=int, default=5)
    parser.add_argument("--epochs", type=int, default=10)
    parser.add_argument("--batch-size", type=int, default=256)
    parser.add_argument("--lr", type=float, default=0.001)
    parser.add_argument("--lrf", type=float, default=0.01)

    parser.add_argument("--data-path", type=str, default="/home/yang/Documents/dataset/flower_photos")
    parser.add_argument("--model-name", default="", help="create model name")
    parser.add_argument("--weights", type=str, default="/home/yang/Documents/dataset/weights/vit_base_patch16_224_in21k.pth")
    parser.add_argument("--freeze_layers", type=bool, default=True)
    parser.add_argument("--device", default="cuda:0")

    opt = parser.parse_args()
    main(opt)