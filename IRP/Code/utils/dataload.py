import numpy as np

import torch
from torch.utils.data import DataLoader, Dataset


class dataset(Dataset):
    def __init__(self, image, label):
        self.data = image
        self.label = label

    def __len__(self):
        return len(self.data)

    def __getitem__(self, idx):
        if torch.is_tensor(idx):
            idx = idx.tolist()
        image = torch.from_numpy(self.data[idx].astype(np.float32))
        target = torch.from_numpy(self.label[idx]).type(torch.long)
        sample = (image, target)
        return sample

def convert(label):
    converted_label = label.astype(np.float32).reshape(-1,7)
    return converted_label

def data_prep(dataname: str, batch_size: int):
    print("Data Loading start".center(30," "))
    print("-"*30)

    if dataname == "RAF-DB":
        path = "/run/media/viper/LSP/Dataset/RAF-DB/basic/shuffled/"
    P_X_train, P_X_test, P_X_val = path+'X_train_shuffled.npy', path+'X_test_shuffled.npy', path+'X_val_shuffled.npy'
    P_y_train, P_y_test, P_y_val = path+'Y_train_shuffled.npy', path+'Y_test_shuffled.npy', path+'Y_val_shuffled.npy'

    X_train = np.load(P_X_train, allow_pickle=True)
    X_test = np.load(P_X_test, allow_pickle=True)
    X_val = np.load(P_X_val, allow_pickle=True)

    y_train = np.load(P_y_train, allow_pickle=True)
    y_test = np.load(P_y_test, allow_pickle=True)
    y_val = np.load(P_y_val, allow_pickle=True)


    print('Data Loading completed!'.center(30, " "))
    print('-'*30)


    converted_y_train = convert(y_train)
    converted_y_test = convert(y_test)
    converted_y_val = convert(y_val)


    # create dataset
    trainset = dataset(image=X_train, label=converted_y_train)
    testset = dataset(image=X_test, label=converted_y_test)
    valset = dataset(image=X_val, label=converted_y_val)


    # create dataloader

    train_loader = DataLoader(dataset=trainset, batch_size=batch_size, pin_memory=True, shuffle=True)
    test_loader = DataLoader(dataset=testset, batch_size=batch_size, pin_memory=True, shuffle=False)
    val_loader = DataLoader(dataset=valset, batch_size=batch_size, pin_memory=True, shuffle=False)


    return train_loader, test_loader, val_loader
