#!/bin/bash
git clone https://github.com/fastai/fastai.git
git clone https://github.com/fastai/fastbook.git
git clone https://github.com/fastai/course-v4.git
conda create -y --name fastaienv
source /etc/profile.d/conda.sh
conda activate fastaienv
conda install -y pip
conda install -y ipykernel
conda install -y -c fastai -c pytorch fastai
conda install -y -c fastai fastbook
conda install -y -c fastai nbdev
python -m ipykernel install --user --name fastaienv --display-name "Python (fastaienv)"
