FROM perl:5.20.3-threaded

RUN useradd -m -s /bin/bash appuser \
    && cpanm Carton

USER appuser
RUN mkdir -p /home/appuser/webapp
WORKDIR /home/appuser/webapp

COPY --chown=appuser:appuser webapp/cpanfile /home/appuser/webapp
RUN carton install

COPY --chown=appuser:appuser webapp /home/appuser/webapp

CMD carton exec -- /home/appuser/webapp/myapp.pl daemon -l http://0.0.0.0:$PORT
