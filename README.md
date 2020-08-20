# Use FastAI with Azure Machine Learning!
This repository has examples showing you how to use FastAI on Azure ML.

# Create an ML workspace
The [Azure Machine Learning workspace](concept-workspace.md) is the top-level resource for the service. It provides you with a centralized place to work with all the artifacts you create. 

You can create an ML workspace by clicking here - **be sure to change SKU type to a GPU SKU, recommended is "Standard_NC12"**:

[![Deploy To Azure](https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazure.svg?sanitize=true)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fazure-quickstart-templates%2Fmaster%2F101-machine-learning-compute-create-computeinstance%2Fazuredeploy.json)

# Work interactively
Create a compute instance. https://docs.microsoft.com/en-us/azure/machine-learning/concept-compute-instance#create

In the first notebook cell, run:

```python
!pip install fastai
```

In the second notebook cell, run:

```
!git clone https://github.com/fastai/course-v3.git
```

# Submit remote jobs

## Prepare scripts
For this tutorial, the training script **train.py** is provided [here](). In practice, you can take any custom training script, as is, and run it with Azure Machine Learning.

## Define the FastAI environment
Create an environment object and enable Docker. 

```python
from azureml.core import Environment
fastai_env = Environment("fastai2")
fastai_env.docker.enabled = True
fastai_env.docker.base_image = "fastdotai/fastai2:latest"
fastai_env.python.user_managed_dependencies = True
```

## Submit a script run
This ScriptRunConfig will configure your job for execution on the desired [compute target](https://docs.microsoft.com/azure/machine-learning/how-to-set-up-training-targets#compute-targets-for-training).

```python
from azureml.core import ScriptRunConfig, Experiment, Workspace

ws = Workspace.from_config()

fastai_config = ScriptRunConfig(source_directory='fastai-example', script='train.py')
fastai_config.run_config.environment = fastai_env
run = Experiment(ws,'fastai-custom-image').submit(fastai_config)
run.wait_for_completion(show_output=True)
```


# Contributing

This project welcomes contributions and suggestions.  Most contributions require you to agree to a
Contributor License Agreement (CLA) declaring that you have the right to, and actually do, grant us
the rights to use your contribution. For details, visit https://cla.opensource.microsoft.com.

When you submit a pull request, a CLA bot will automatically determine whether you need to provide
a CLA and decorate the PR appropriately (e.g., status check, comment). Simply follow the instructions
provided by the bot. You will only need to do this once across all repos using our CLA.

This project has adopted the [Microsoft Open Source Code of Conduct](https://opensource.microsoft.com/codeofconduct/).
For more information see the [Code of Conduct FAQ](https://opensource.microsoft.com/codeofconduct/faq/) or
contact [opencode@microsoft.com](mailto:opencode@microsoft.com) with any additional questions or comments.


### Submit a notebook run
Coming soon!
