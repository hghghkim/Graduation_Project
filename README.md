# Graduation_Project
 Hyperspecral image classifiation

## test(base_model.ipynb)
 ### Ver 1
  데이터 불러오기  
  데이터 확인  
  Model : HybridSN  
  optimizer : Adam
 ### Ver 2
  train set : 375  
  test set : 125  
  epochs : 30  
  batchsize : 10  
  Model : HybridSN  
  optimizer : Adam  
 ### Ver 3
  epochs : 50  
  batchsize : 8  
  Model : HybridSN  
  optimizer : Rmsprop
 ### Ver 4
  epochs : 100  
  batchsize : 8  
  Model : HybridSN  
  optimizer : Adam
 ### Ver 5
  epochs : 50  
  batchsize : 12  
  Model : HybridSN  
  optimizer : Adam
 ### Ver 6
  Multi Gpu 사용 test  
  Gpu : 2
 ### Ver 7
  Multi Gpu 사용 test  
  Gpu : 4
 ### Ver 8
  Sample 수 증가 : 1536  
  Validation set 추가  
  train set : 1000  
  validation set : 250  
  test set : 286
  
## layers_pooling
 layer + pooling model
 ### Ver 1
  2 layers + 1 pooling x 3 + 3 dense layers  
  optimizer : Adam  
  learning rate : 0.005  
  batch size : 32  
  epoch : 500  
 ### Ver 2
  2 layers + 1 pooling x4 + 2 dense layers  
  optimizer : Adam  
  learning rate : 0.01  
  batch size : 12  
  epoch : 500  
