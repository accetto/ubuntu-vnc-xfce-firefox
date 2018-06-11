# docker build -t accetto/ubuntu-vnc-xfce-firefox-default .
# docker build --build-arg BASETAG=rolling -t accetto/ubuntu-vnc-xfce-firefox:rolling-default .
# docker build --build-arg ARG_VNC_USER=root:root -t accetto/ubuntu-vnc-xfce-firefox-default:root .
# docker build --build-arg ARG_VNC_RESOLUTION=1360x768 -t accetto/ubuntu-vnc-xfce-firefox-default .

ARG BASETAG=latest

FROM accetto/ubuntu-vnc-xfce:${BASETAG} as stage-install

ENV REFRESHED_AT 2018-06-11

### Be sure to use root user
USER 0

### 'apt-get clean' runs automatically
RUN apt-get update && apt-get install -y \
        firefox \
    && rm -rf /var/lib/apt/lists/*

FROM stage-install as stage-config

### Arguments can be provided during build
ARG ARG_VNC_USER

ENV VNC_USER=${ARG_VNC_USER:-headless:headless}

WORKDIR $HOME
SHELL ["/bin/bash", "-c"]

COPY [ "./src/firefox.desktop", "./Desktop/" ]
COPY [ "./src/create_user_and_fix_permissions.sh", "./" ]

### 'sync' mitigates automated build failures
RUN chmod +x \
        ./create_user_and_fix_permissions.sh \
        ./Desktop/firefox.desktop \
    && sync \
    && ./create_user_and_fix_permissions.sh $STARTUPDIR $HOME \
    && rm ./create_user_and_fix_permissions.sh

FROM stage-config as stage-final

LABEL \
    any.accetto.description="Headless Ubuntu VNC/noVNC container with Xfce desktop and Firefox" \
    any.accetto.display-name="Headless Ubuntu/Xfce VNC/noVNC container with Firefox" \
    any.accetto.tags="ubuntu, xfce, vnc, novnc, firefox"

### Arguments can be provided during build
ARG ARG_VNC_BLACKLIST_THRESHOLD
ARG ARG_VNC_BLACKLIST_TIMEOUT
ARG ARG_VNC_RESOLUTION

ENV \
  VNC_BLACKLIST_THRESHOLD=${ARG_VNC_BLACKLIST_THRESHOLD:-20} \
  VNC_BLACKLIST_TIMEOUT=${ARG_VNC_BLACKLIST_TIMEOUT:-0} \
  VNC_RESOLUTION=${ARG_VNC_RESOLUTION:-1024x768}

### Switch to non-root user
USER $VNC_USER
