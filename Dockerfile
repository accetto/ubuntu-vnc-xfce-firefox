# docker build -t accetto/ubuntu-vnc-xfce-firefox-default .
# docker build -t accetto/ubuntu-vnc-xfce-firefox-default:dev .
# docker build -t accetto/ubuntu-vnc-xfce-firefox-default:dev-68 .
# docker build --build-arg BASETAG=dev -t accetto/ubuntu-vnc-xfce-firefox-default:dev .
# docker build --build-arg ARG_VNC_USER=root:root -t accetto/ubuntu-vnc-xfce-firefox-default:root .
# docker build --build-arg ARG_VNC_RESOLUTION=1360x768 -t accetto/ubuntu-vnc-xfce-firefox-default .
# docker build --build-arg BASETAG=rolling -t accetto/ubuntu-vnc-xfce-firefox-default:rolling .
# docker build --build-arg BASETAG=dev -t dev/ubuntu-vnc-xfce-firefox-default .

ARG BASETAG=latest

FROM accetto/ubuntu-vnc-xfce:${BASETAG} as stage-install

### Be sure to use root user
USER 0

### 'apt-get clean' runs automatically
# RUN apt-get update && apt-get install -y \
#         firefox \
#     && rm -rf /var/lib/apt/lists/*

### Alternatively install an explicit Firefox version
### http://releases.mozilla.org/pub/firefox/releases/67.0.4/linux-x86_64/en-US/firefox-67.0.4.tar.bz2
ENV \
    FIREFOX_VERSION=67.0.4 \
    FIREFOX_DISTRO=linux-x86_64 \
    FIREFOX_PATH=/usr/lib/firefox
RUN mkdir -p ${FIREFOX_PATH} \
    && wget -qO- http://releases.mozilla.org/pub/firefox/releases/${FIREFOX_VERSION}/${FIREFOX_DISTRO}/en-US/firefox-${FIREFOX_VERSION}.tar.bz2 \
        | tar xvj -C /usr/lib/ \
    && ln -s ${FIREFOX_PATH}/firefox /usr/bin/firefox

FROM stage-install as stage-config

### Arguments can be provided during build
ARG ARG_VNC_USER

ENV VNC_USER=${ARG_VNC_USER:-headless:headless}

WORKDIR ${HOME}
SHELL ["/bin/bash", "-c"]

COPY [ "./src/create_user_and_fix_permissions.sh", "./" ]

### 'sync' mitigates automated build failures
RUN chmod +x \
        ./create_user_and_fix_permissions.sh \
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

### Preconfigure Xfce
COPY [ "./src/home/Desktop", "./Desktop/" ]
COPY [ "./src/home/config/xfce4/panel", "./.config/xfce4/panel/" ]
COPY [ "./src/home/config/xfce4/xfconf/xfce-perchannel-xml", "./.config/xfce4/xfconf/xfce-perchannel-xml/" ]

RUN ${STARTUPDIR}/set_user_permissions.sh $STARTUPDIR $HOME

ENV REFRESHED_AT 2019-08-03

### Switch to non-root user
USER ${VNC_USER}

### Issue #7 (base): Mitigating problems with foreground mode
WORKDIR ${STARTUPDIR}
