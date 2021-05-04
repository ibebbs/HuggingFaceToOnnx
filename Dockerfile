FROM python:latest

RUN pip install tensorflow
RUN pip install torch
RUN pip install transformers
RUN pip install keras2onnx
RUN pip install onnxruntime

ENTRYPOINT [ "python", "/usr/local/lib/python3.9/site-packages/transformers/convert_graph_to_onnx.py" ]