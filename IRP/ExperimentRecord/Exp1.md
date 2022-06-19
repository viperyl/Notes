## resnet18_601

### warm up 

epoch: 600

lr: 1e-4

### fine tuning

epoch: 100

lr 1e-4

opt: adam

### strcture

ResNet-18 + fc(512, 256) + fc(256, 64) + fc(64, 7)

## resnet_18_602
### warm up 
epoch: 600
lr: 1e-4

### fine tuning
epoch: 100
lr: 4e-4
opt: Adam

### res
avg: around 0.84

## resnet_34_500

```
instance: wobbly-sky-27
```

### warm up 

epoch: 600
lr: 1e-4

### res

avg: around 0.84

## resnet_18_GCN

```
instance: woven-water-28
weight&bias: resnet18_GCN_100
```

### warm up 

epoch: 100

lr: 1e-4

### res



