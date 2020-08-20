---
title: Train a model using a FastAI docker image
titleSuffix: Azure Machine Learning
description: Learn how to train models with custom Docker images in Azure Machine Learning.
services: machine-learning
ms.service: machine-learning
ms.subservice: core
ms.author: sagopal
author: saachigopal
ms.date: 08/11/2020
ms.topic: conceptual
ms.custom: how-to
---

# Train a FastAI model using Azure Machine Learning
In this article, learn how to train a FastAI model with Azure Machine Learning. 

The example scripts in this article are used to classify pet images by creating a convolutional neural network. 

While Azure Machine Learning provides a default Docker base image, you can also use Azure Machine Learning environments to specify a specific base image, such as one of the set of maintained [Azure ML base images](https://github.com/Azure/AzureML-Containers) or your own [custom image](https://docs.microsoft.com/azure/machine-learning/how-to-deploy-custom-docker-image#create-a-custom-base-image). In this case, we have added 

### Create an ML workspace
The [Azure Machine Learning workspace](concept-workspace.md) is the top-level resource for the service. It provides you with a centralized place to work with all the artifacts you create. 

You can create an ML workspace by clicking here.


### Work interactively
Create a compute instance. https://docs.microsoft.com/en-us/azure/machine-learning/concept-compute-instance#create

In the first notebook cell, run:

```python
!pip install fastai
```

In the second notebook cell, run:

```
!git clone https://github.com/fastai/course-v3.git
```

### Prepare scripts
For this tutorial, the training script **train.py** is provided [here](). In practice, you can take any custom training script, as is, and run it with Azure Machine Learning.

### Define the FastAI environment
Create an environment object and enable Docker. 

```python
from azureml.core import Environment
fastai_env = Environment("fastai2")
fastai_env.docker.enabled = True
fastai_env.docker.base_image = "fastdotai/fastai2:latest"
fastai_env.python.user_managed_dependencies = True
```

### Submit a script run
This ScriptRunConfig will configure your job for execution on the desired [compute target](https://docs.microsoft.com/azure/machine-learning/how-to-set-up-training-targets#compute-targets-for-training).

```python
from azureml.core import ScriptRunConfig, Experiment, Workspace

ws = Workspace.from_config()

fastai_config = ScriptRunConfig(source_directory='fastai-example', script='train.py')
fastai_config.run_config.environment = fastai_env
run = Experiment(ws,'fastai-custom-image').submit(fastai_config)
run.wait_for_completion(show_output=True)
```

### Submit a notebook run
Coming soon!
