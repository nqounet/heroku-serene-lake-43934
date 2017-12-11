FROM perl:5.20.3-threaded

RUN useradd -m -s /bin/bash appuser \
    && cpanm Carmel --notest

USER appuser
RUN mkdir -p /home/appuser/webapp
WORKDIR /home/appuser/webapp

COPY --chown=appuser:appuser webapp/cpanfile .
RUN carmel install

COPY --chown=appuser:appuser webapp .

CMD carmel exec -- ./myapp.pl daemon -l http://0.0.0.0:$PORT
