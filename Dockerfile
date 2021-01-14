FROM python:3.8-slim

RUN apt-get update && apt install -y curl libzbar-dev

RUN curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python -


WORKDIR /rasa

COPY ./ /rasa/

RUN ls -alh

RUN python -m pip install -U pip

RUN /bin/bash -c "source $HOME/.poetry/env && cd /rasa &&  poetry install && \
    pip3 install jieba rasa-x --extra-index-url https://pypi.rasa.com/simple && \
    rasa train --num-threads 4 && rasa run actions"



