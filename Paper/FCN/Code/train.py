import os





class SegmentationPresetTrain:
    def __init__(self, base_size, crop_size, hflip_ratio=0.5, mean=(0.485, 0.456, 0.406), std=(0.229, 0.224, 0.225)):
        min_size = int(0.5 * base_size)
        max_size = int(2.0 * base_size)

        trans = [T.]