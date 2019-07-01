# -*- coding: utf-8 -*-
"""
Created on Tue Jun 18 15:58:20 2019

@author: dav_8
"""

import os
import os.path
import platform
import sys
import shutil
import errno, os, stat
from distutils.dir_util import copy_tree 

def handleRemoveReadonly(func, path, exc):
  excvalue = exc[1]
  if func in (os.rmdir, os.remove) and excvalue.errno == errno.EACCES:
      os.chmod(path, stat.S_IRWXU| stat.S_IRWXG| stat.S_IRWXO) # 0777
      func(path)
  else:
      raise


def cambiaMAIN_so(filepath, tot_dosi, v, cl, w, tc):
    with open(filepath, 'r') as f:
        data = f.readlines()
    
    data[24] = 'Cl = ' + cl + ' ;%[L/h]\n'
    data[26] = 'V  = ' + v + ' ; %[L]\n'
    data[36] = 'C_target = ' + tc + ';\n'
    data[37] = 'C_target2 = ' + tc + ';\n'
    data[62] = 'tot_dosi =' + tot_dosi +';\n'
    data[124] = 'w1 = ' + w[0] + ';\n'
    data[125] = 'w2 = ' + w[1] + ';\n'
    data[126] = 'w3 = ' + w[2] + ';\n'
    data[127] = 'w4 = ' + w[3] + ';\n'
    
    with open(filepath, 'w') as fileW:
        fileW.writelines(data)

def cambiaEfile(filepath, ec50):
    with open(filepath, 'r') as f:
        data = f.readlines()
        
    data[3] = '  ec50 = ' + ec50 + ';\n'
    
    with open(filepath, 'w') as fileW:
        fileW.writelines(data)

dd = int(input("Insert number of doses per day: "))*14

ws = 1
ws = int(input("Please select the working scenario (default = 1):\n 1 = Lower target \n 2 = Optimal target \n 3 = Tumor burden minimization\n"))

if ws < 3:
    tc = input("Insert the target concentration: ")


#Carico file demografic data
with open(os.path.join('data-analysis', 'Settings.txt'), 'r') as f:
    next(f)
    sex = int((f.readline().split('\t')[2]))

#Carico valori calcolati
pc = []
with open(os.path.join('data-analysis', 'Personal.dat'), 'r') as f:
    for l in f:
        pc.append("".join(l.split()))
       
#Modifica i percorsi di redCRAB
RCpath = []
for path, subdirs, files in os.walk('.'):
    for name in files:
        if name == 'RedCRAB.py':
            RCpath.append(os.path.abspath(os.path.join(path)))
            #print(os.path.abspath(os.path.join(path, 'Config', 'Client_config', 'chopped.txt')))
            
            with open(os.path.join(path, 'Config', 'Client_config', 'chopped.txt'), 'r') as f:
                data = f.readlines()
                
            data[-1] = 'MatlabProgPath := ' + os.path.abspath(os.path.join(path, 'CustomMatlabProgFolder')).replace('\\', '/') + '\n'
                
            with open(os.path.join(path, 'Config', 'Client_config', 'chopped.txt'), 'w') as f:
                f.writelines(data)

#Working scenario 1 | LOWER BOUND
if ws == 1:
    w = ['1.0','0.0','0.0','0.0']
    cambiaMAIN_so(os.path.join('RedCRAB_Client', 'CustomMatlabProgFolder', 'Main_so.m'), str(dd), pc[1], pc[0], w, tc)
  
if ws == 2:
    w = ['0.0','1.0','0.0','0.0']
    cambiaMAIN_so(os.path.join('RedCRAB_Client', 'CustomMatlabProgFolder', 'Main_so.m'), str(dd), pc[1], pc[0], w, tc)
  
if ws == 3:
    if sex == 1:
        w = ['0.0','0.0','1.0','42.0']
    else:
        w = ['0.0','0.0','1.0','75.0']
    cambiaMAIN_so(os.path.join('RedCRAB_Client', 'CustomMatlabProgFolder', 'Main_so.m'), str(dd), pc[1], pc[0], w, '1')
    cambiaEfile(os.path.join('RedCRAB_Client', 'CustomMatlabProgFolder','E_target.m'), pc[3])
    cambiaEfile(os.path.join('RedCRAB_Client', 'CustomMatlabProgFolder','E_control.m'), pc[3])

print("RedCRAB ready. Be sure to have a stable internet connection than press ENTER to start the optimization.")
input()

#Inizializza RedCRAB_Client

if os.path.isdir(os.path.join('RedCRAB_Client', 'bin', 'tmp')):
    shutil.rmtree(os.path.join('RedCRAB_Client', 'bin', 'tmp'),  ignore_errors=False, onerror=handleRemoveReadonly)
    #print('Tmp eliminata qui:', os.path.join(path, dir_i))
if not os.path.exists(os.path.join('RedCRAB_Client', 'Config', 'RedCRAB_config', 'Cfg_1.txt')):
    filelist = [ f for f in os.listdir(os.path.join('RedCRAB_Client', 'Config', 'RedCRAB_config')) if f.endswith(".txt") ]
    for f in filelist:
        os.remove(os.path.join(os.listdir(os.path.join('RedCRAB_Client', 'Config', 'RedCRAB_config'), f)))
    shutil.copy(os.path.join('RedCRAB_Client', 'Cfg_1.txt'), os.path.join('RedCRAB_Client', 'Config', 'RedCRAB_config'))
    #print('Cfg ripristinato qui:', os.path.join(path, 'Config', 'RedCRAB_config'))

os.chdir(os.path.join('RedCRAB_Client'))
os.system(sys.executable + ' ' + 'RedCRAB.py')

