# HuggingFaceToONNX

A docker image built to facilitate the export of [Hugging Face Transformer Models](https://huggingface.co/models) to ONNX.

Uses the `convert_graph_to_onnx.py` tool provided by Hugging Face with parameters passed as part of the docker command line.

## Usage

Run with:

```
docker run --rm -v [LocalOutputDirectory]:/Output ibebbs/huggingfacetoonnx:latest --framework [framework] --opset 12 --pipeline [pipeline] --model [model] /Output/[name]
```

Where:

* LocalOutputDirectory - The local directory to write the ONNX model to
* Framework - `pt` or `tf` for PyTorch or Tensorflow respectively
* Pipeline - The pipeline the model has been trained for; one of: `feature-extraction`, `ner`, `sentiment-analysis`, `fill-mask`, `question-answering`, `text-generation`, `translation_en_to_fr`, `translation_en_to_de`, `translation_en_to_ro`
* Model - The name of the Hugging Face model to convert to ONNX
* Name - The name of the output ONNX file

For example:

```
docker run --rm -v ${PWD}/Output:/Output huggingfacetoonnx:latest --framework pt --opset 12 --pipeline ner --model elastic/distilbert-base-cased-finetuned-conll03-english /Output/distilbert-base-cased-finetuned-conll03-english.onnx
```

Which will produce the following output:

```
2021-05-03 16:18:18.295546: W tensorflow/stream_executor/platform/default/dso_loader.cc:64] Could not load dynamic library 'libcudart.so.11.0'; dlerror: libcudart.so.11.0: cannot open shared object file: No such file or directory
2021-05-03 16:18:18.295629: I tensorflow/stream_executor/cuda/cudart_stub.cc:29] Ignore above cudart dlerror if you do not have a GPU set up on your machine.       distilbert-base-cased-finetuned-conll03-english /Output/elastic/distilbert-base-cased-finetuned-conll03-english.onnx
Downloading: 100%|██████████| 954/954 [00:00<00:00, 697kB/s]                                                                                                        o.11.0: cannot open shared object file: No such file or directory
Downloading: 100%|██████████| 213k/213k [00:00<00:00, 674kB/s]
Downloading: 100%|██████████| 112/112 [00:00<00:00, 51.3kB/s]
Downloading: 100%|██████████| 257/257 [00:00<00:00, 154kB/s]
Downloading: 100%|██████████| 261M/261M [01:39<00:00, 2.61MB/s]
/usr/local/lib/python3.9/site-packages/transformers/modeling_utils.py:1789: TracerWarning: Converting a tensor to a Python boolean might cause the trace to be incorrect. We can't record the data flow of Python values, so this value will be treated as a constant in the future. This means that the trace might not generalize to other inputs!                                                                                                                                                        rect. We can't record the data flow of Python values, so this value will be treated as a constant in the future. This means that the trace might not generalize to other inputs!
  assert all(

====== Converting model to ONNX ======
ONNX opset version set to: 12
Loading pipeline (model: elastic/distilbert-base-cased-finetuned-conll03-english, tokenizer: elastic/distilbert-base-cased-finetuned-conll03-english)
Creating folder /Output/elastic
Using framework PyTorch: 1.8.1+cu102
Found input input_ids with shape: {0: 'batch', 1: 'sequence'}
Found input attention_mask with shape: {0: 'batch', 1: 'sequence'}
Found output output_0 with shape: {0: 'batch', 1: 'sequence'}
Ensuring inputs are in correct order
head_mask is not present in the generated input list.
Generated inputs order: ['input_ids', 'attention_mask']
```

## Hints

1. PyTorch models (`--framework pt`) tend to convert into better ONNX models than Tensorflow (`--framework tf`).
2. The output directory needs to be empty, the `convert_graph_to_onnx.py` tool will fail.