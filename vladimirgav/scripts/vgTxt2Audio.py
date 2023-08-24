#!/usr/bin/env python # [1]
"""
 * VladimirGav
 * GitHub Website: https://vladimirgav.github.io/
 * GitHub: https://github.com/VladimirGav
 * Source https://github.com/VladimirGav/ai-audio-vg
 * Copyright (c)
"""

import sys, os
import time
import os
import json
from sys import argv
from os.path import abspath
import random

DirCur = os.path.dirname(os.path.abspath(__file__))
DirRoot = DirCur+"/../.."

FilePathJson = DirCur+"/../inputdata/txt2audio.json"
if len(argv) > 1:
    FilePathJson = argv[1]

file_inputdata = FilePathJson
file = open(file_inputdata, 'r')
arrData = json.loads(file.read())
file.close()

audio_id = 0
if 'audio_id' in arrData:
    audio_id = arrData['audio_id']

prompt = 'Hello, my name is Vladimir Gav'
if 'prompt' in arrData:
    prompt = arrData['prompt']

model_id = 'suno/bark-small'
if 'model_id' in arrData:
    model_id = arrData['model_id']

files_dir = DirCur+"/../audio"
if not os.path.exists(files_dir):os.makedirs(files_dir)

if 'files_dir' in arrData:
    files_dir = arrData['files_dir']
    files_dir = files_dir.replace("sdroot", DirRoot)

files_count = 1
if 'files_count' in arrData:
    files_count = arrData['files_count']

voice_preset = ''
if 'voice_preset' in arrData:
    voice_preset = arrData['voice_preset']

resultArr = {
'audio_id': audio_id,
'prompt': prompt,
'model_id': model_id,
'files_dir': files_dir,
'files_count': files_count,
'voice_preset': voice_preset,
}

#print(resultArr)
#exit()

from transformers import AutoProcessor, BarkModel
from scipy.io.wavfile import write as write_wav
import torch
import sys
import os

os.environ["SUNO_OFFLOAD_CPU"] = "True"
os.environ["SUNO_USE_SMALL_MODELS"] = "True"

device = "cuda:0" if torch.cuda.is_available() else "cpu"
#print(device)

processor = AutoProcessor.from_pretrained(model_id)
model = BarkModel.from_pretrained(model_id)

from optimum.bettertransformer import BetterTransformer

# Use bettertransform for flash attention
model = BetterTransformer.transform(model, keep_original_model=False)

# cuda GPU or CPU
model = model.to(device)

# Enable CPU offload
model.enable_cpu_offload()

text_prompt = prompt

for i in range(files_count):
    resultArr['files'] = {}
    resultArr['files'][i] = {}
    FileName = str(int(time.time()))+str(".wav")
    resultArr['files'][i]['FileName'] = FileName
    FilePath = files_dir+"/"+FileName
    resultArr['files'][i]['FilePath'] = FilePath

    #processor
    if voice_preset != '':
        inputs = processor(text_prompt, voice_preset=voice_preset).to(device)
    else:
        inputs = processor(text_prompt).to(device)

    audio_array = model.generate(**inputs, do_sample = True, fine_temperature = 0.4, coarse_temperature = 0.8)
    audio_array = audio_array.cpu().numpy().squeeze()

    sample_rate = model.generation_config.sample_rate
    sampling_rate = sample_rate; fs = 60

    #Save file
    #scipy.io.wavfile.write("bark_out.wav", rate=sampling_rate, data=audio_array)
    write_wav(FilePath, sampling_rate, audio_array)

print(json.dumps(resultArr))