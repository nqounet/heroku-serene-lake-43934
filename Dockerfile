FROM perl:threaded

RUN useradd -m -s /bin/bash appuser \
    && cpanm Carmel --notest

WORKDIR /home/appuser/webapp
RUN chown appuser:appuser /home/appuser/webapp
USER appuser

COPY --chown=appuser:appuser webapp/cpanfile .
RUN carmel install

COPY --chown=appuser:appuser webapp .

CMD carmel exec -- ./myapp.pl daemon -l http://0.0.0.0:$PORT
