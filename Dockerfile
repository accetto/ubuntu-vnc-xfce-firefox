# docker build -t accetto/ubuntu-vnc-xfce-firefox .
# docker build --build-arg BASETAG=rolling -t accetto/ubuntu-vnc-xfce-firefox:rolling .
# docker build --build-arg ARG_VNC_USER=root:root -t accetto/ubuntu-vnc-xfce-firefox:root .
# docker build --build-arg ARG_VNC_RESOLUTION=1360x768 -t accetto/ubuntu-vnc-xfce-firefox .

ARG BASETAG=latest

FROM accetto/ubuntu-vnc-xfce:${BASETAG}

### Arguments can be provided during build
ARG ARG_VNC_BLACKLIST_THRESHOLD
ARG ARG_VNC_BLACKLIST_TIMEOUT
ARG ARG_VNC_RESOLUTION
ARG ARG_VNC_USER

ENV REFRESHED_AT 2018-05-15

LABEL vendor="accetto" \
    maintainer="https://github.com/accetto" \
    any.accetto.description="Headless Ubuntu VNC/noVNC container with Xfce desktop and Firefox" \
    any.accetto.display-name="Headless Ubuntu/Xfce VNC/noVNC container with Firefox" \
    any.accetto.expose-services="6901:http,5901:xvnc" \
    any.accetto.tags="ubuntu, xfce, vnc, novnc, firefox"

SHELL ["/bin/bash", "-c"]

### Environment config
ENV \
  VNC_BLACKLIST_THRESHOLD=${ARG_VNC_BLACKLIST_THRESHOLD:-20} \
  VNC_BLACKLIST_TIMEOUT=${ARG_VNC_BLACKLIST_TIMEOUT:-0} \
  VNC_RESOLUTION=${ARG_VNC_RESOLUTION:-1024x768} \
  VNC_USER=${ARG_VNC_USER:-headless:headless}

WORKDIR $HOME

### Be sure to use the root user
USER 0

### Install Firefox browser, patch scripts and fix permissions
COPY ./src/firefox/install/ $INST_SCRIPTS/
COPY ./src/firefox/Desktop/firefox.desktop $HOME/Desktop/
RUN find $INST_SCRIPTS -name '*.sh' -exec chmod a+x {} + \
    && chmod +x $HOME/Desktop/firefox.desktop \
    && $INST_SCRIPTS/firefox.sh \
    && $INST_SCRIPTS/create_user_and_fix_permissions.sh $STARTUPDIR $HOME \
    && rm -r $INST_SCRIPTS

### Switch to the non-root user
USER $VNC_USER
