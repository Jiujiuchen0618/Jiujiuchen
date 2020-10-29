import webbrowser

import numpy as np
import torch
import torch.nn.functional as F
import torch.optim as optim
import torch.utils.data as data_utils
import torchvision
from PIL import Image, ImageFile
from torch import nn
from torch import optim as optim
from torch.autograd import Variable
from torch.optim import lr_scheduler
from torch.utils.data import DataLoader, Dataset
from torch.utils.data.sampler import SubsetRandomSampler
from torchvision import datasets, models, transforms

import cv2

import matplotlib.pyplot as plt
import os # 存储一些label结果

device = torch.device("cuda" if torch.cuda.is_available() else "cpu") #无GPU
train_on_gpu = torch.cuda.is_available()
if not train_on_gpu:
    print('CUDA is not available.  Training on CPU ...')

else:
    print('CUDA is available!  Training on GPU ...')
ImageFile.LOAD_TRUNCATED_IMAGES = True





test_transforms = transforms.Compose([transforms.Resize(255),
                                      #  transforms.CenterCrop(224),
                                      transforms.ToTensor(),
                                      ])

model = models.densenet161()


model.classifier = nn.Sequential(nn.Linear(2208, 1000),
                                 nn.ReLU(),
                                 nn.Dropout(0.2),
                                 nn.Linear(1000, 2),
                                 nn.LogSoftmax(dim=1))

criterion = nn.NLLLoss()
# Only train the classifier parameters, feature parameters are frozen
optimizer = optim.Adam(model.parameters(), lr=0.001)
scheduler = lr_scheduler.StepLR(optimizer, step_size=7, gamma=0.1)

#model = model.cuda()# 自己改的部分
model = model.to(device)

model.load_state_dict(torch.load('tensorboardexp.pt',map_location = torch.device('cpu')))
classes = ["accident", "noaccident"]
# model.load_state_dict(torch.load('tensorboardexp.pt'))
count = 0
counts = 1
videopath = 'CTO20100506_toAVI.avi' #视频地址
filename = videopath.split('.')[0] #储存label标注
labeltxt = filename + '.txt'

folder_path = r'D:\caltech data\accident_detection\accident-detection-master\img/'
folderpath = folder_path + filename #检测帧结果储存位置
os.makedirs(folderpath, exist_ok=True)

vid = cv2.VideoCapture(videopath)
ret = True
while ret:
    if ret == True:
        ret, frame = vid.read()

        try:
            img = Image.fromarray(frame)
        except ValueError:
            break
        except AttributeError:
            break
        img = test_transforms(img)
        img = img.unsqueeze(dim=0)
        img = img.to(device)
        model.eval()
        with torch.no_grad():
            output = model(img)
            _, predicted = torch.max(output, 1)

            index = int(predicted.item())
            #if index == 0:
                #cv2.imwrite("frame%d.png" % count, frame)
            count += 1
                #if counts == 1:
                #    webbrowser.open('127.0.0.1', new=2)
                #    counts += 1

            labels = 'status: ' + classes[index]
        print("%d" % count + classes[index])
        labelstatus = classes[index]
        #np.savetxt(filename+'.txt', labelstatus)
        f = open(labeltxt, 'a') # 在txt文件中写入数据，a表示文末追加的方式。
        f.write(labelstatus + "\n")
        f.close()
        cv2.putText(frame, labels, (10, 100),
                    cv2.FONT_HERSHEY_DUPLEX, 2, (0, 0, 255), 5, cv2.LINE_AA)
        #cv2.imshow('Frame', frame)
        cv2.imwrite(folderpath + '/' + '%d.png' % count, frame)
        if cv2.waitKey(1) & 0xFF == ord('q'):
            break

vid.release()
cv2.destroyAllWindows()
