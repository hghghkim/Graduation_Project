import os
import glob
import numpy as np

import re
# 숫자 sort ex. 1,2,3,4,...10,11,12...
numbers = re.compile(r'(\d+)')
def numericalSort(value):
    parts = numbers.split(value)
    parts[1::2] = map(int, parts[1::2])
    return parts

# 종자 .npy 각각의 파일을 불러와 합쳐 하나의 npy 데이터를 만든다.
files = sorted(glob.glob(r'/home/ckwwk/data/germination_data/*.npy'), key=numericalSort)
arrays = []
for f in files:
    print("Current File Being Processed is: " + f)
    arrays.append(np.load(f))
data = np.concatenate(arrays)
