# ConvLSTM (20 to 1)

##  Exp 1

### Model Structure

```
Image Shape: (128, 128)
Num of Layer: 3
Parameter number:  10,178,497
```
### Training config

```
Optimizer: Adam
Epochs: 10
Loss: MSELoss with sum reduction
```
### Result
![Img](./files/a.png)

### Discussion
The predicted images roughly to be consitent with the target images in terms of motion.
From frame 0 to frame 4, we can obverse a bubble in the upper left approaching the two-phase plane and dieappearing at the end of frame. In addition, there are two bubbles on the right side that fused together during the ascent. Both of these two phenomena can be observed in the predicted frames.

From frame 5 to frame 9, a huge bubble hidden under the surface of the liquid, and then it splits into two large bubbles and eventlally disappears. This phenomena is also predicted by ConvLSTM model.

In the image detail aspect, the predicted images lack texture and quantitative estimation of bubbles size and shape. All of the images demonstrated bubbles are vague and lack of the determinent boundary with the environment.  





## Exp 2

### Model Structure

```
Image Shape: (256, 256)
Num of Layer: 3
Parameter number:  
```
### Training config

```
Optimizer: Adam
Epochs: 100
Loss: MSELoss with sum reduction
```
### Result

![](./files/b.png)



## Exp 3

### Model Structure

```
Image Shape: (256, 256)
Num of Layer: 3
Parameter number:  38,490,049
```

### Training config

```
Optimizer: Adam
Epochs: 20
Loss: MSELoss with sum reduction
```

### Result (Weired)

![](./files/f.png)



Looks like model collapse? But the nozzle and bottom circles are perfectly predicted.



# ConvLSTM (20 to 20)

## Exp 1

### Model Structure

```
Image Shape: (256, 256)
Num of Layer: 3
Parameter number:  10,178,497
```

### Training config

```
Optimizer: Adam
Epochs: 20
Loss: MSELoss with sum reduction
```

### Result

**Input**

![](./files/c.png)

**Target**

![](./files/d.png)



**Output**

![](./files/e.png)





## Exp 2

### Model Structure

```
Image Shape: (256, 256)
Num of Layer: 3
Parameter number:  10,178,497
```

### Training config

```
Optimizer: Adam
Epochs: 120
Loss: MSELoss with sum reduction
```

### Metric

```
Training Loss:661.65 
Validation Loss:617.19
SSIM: 
0.779	0.764	0.761	0.762	0.777	

0.794	0.806	0.798	0.790	0.792	

0.790	0.785	0.780	0.774	0.777	

0.794	0.795	0.774	0.767	0.768	

PSNR: 
18.546	18.312	18.421	18.850	19.351	

19.513	19.529	19.408	19.278	19.182	

19.369	19.133	18.857	18.883	19.314	

19.556	19.509	19.340	19.218	19.408	

VMAF:

Lib Not Work

```

![](./files/h1.png)

# ConvLSTM (5 to 5)

## Exp 1








# Next stage
1. Apply `SSIM`, `PSNR` and `VMAF` to determine the quality of the predicated video.
2. Split video by different initial condition, and test the performance
3. Check paper related to video predcition or motion prediciton.
4. Introduce of spatio-temporal correlation features
5. A refined dataset production