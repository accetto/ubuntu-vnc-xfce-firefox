# CHANGELOG

## accetto/ubuntu-vnc-xfce-firefox

[Docker Hub][this-docker] - [Git Hub][this-github] - [Wiki][this-wiki]

**Attention:** The Docker Hub repository is actually named [*ubuntu-vnc-xfce-firefox*-**default**][this-docker] to avoid conflicts with the previous generation image.

***

### Version 19.06.2

- **README** updated
  - reference to [accetto/xubuntu-vnc-firefox][accetto-docker-xubuntu-vnc-firefox] based on [accetto/xubuntu-vnc][accetto-docker-xubuntu-vnc] added - a streamlined and simplified image, without [noVNC][novnc] and [nss_wrapper][nsswrapper], with a growing family of derived images with various applications
  - Firefox version **67.0.4**

### Version 19.06.1

- File manager (Thunar) pre-configured (inherited from the [base image][this-base])
  - *Owner*, *Permissions* and *Group* columns shown by default
  - *Type* column suppressed
- Script **create_user_and_fix_permissions.sh** updated
  - current user group replaced by group zero
- Firefox version **67.0.3**

### Version 19.06

- Script **set_user_permissions.sh** updated (inherited from the [base image][this-base])
  - root group replaced by the current user group
- **TigerVNC Viewer** desktop launcher icon fixed (inherited from the [base image][this-base])
- Firefox version **67.0.1**

### Version 19.05

- Fixed [Issue #2](https://github.com/accetto/ubuntu-vnc-xfce-firefox/issues/2) (Panel icons not visible if changing container default user)
- **Dockerfile** updated
  - user permissions set using `set_user_permissions.sh` script (inherited from the [base image][this-base])
- Launchers for **Vim** and **TigerVNC Viewer** added to the desktop (inherited from the [base image][this-base])
- Utility `util-hdx.sh` updated (using [accetto/argbash-docker][accetto-docker-argbash-docker])

### Version 19.04

- **noVNC** updated to version **1.1.0** (formerly 1.0.0), inherited from the [base image][this-base]
- **ping** utility added, inherited from the [base image][this-base]
- Environment variable **REFRESHED_AT** added back
- Display settings launcher added to the desktop and the panels
  - to make resolution switching more convenient also with **noVNC** lite client
  - inherited from the [base image][this-base]
- **Dockerfile_rolling** file removed
  - it can be easily cloned from the Dockerfile file for the **latest** build
  - **rolling** build will not be maintained on **Docker Hub** any more

### Version 19.01

- **TigerVNC** updated to version **1.9.0** (formerly 1.8.0), inherited from the [base image][this-base]
- **websockify** updated to version **0.8.0** (formerly 0.6.1), inherited from the [base image][this-base]
- Environment variable **REFRESHED_AT** removed
- Xfce panels are pre-configured now
- Container screenshot added to README
- **Firefox Quantum** version **64.0** (gets updated to the current version on each re-build)

### Version 18.10

- Fixed **Issue #7** (Problem with foreground mode) inherited from the [base image][this-base]
  - supported startup options: `--wait` (default), `--skip`, `--debug` (also `--tail-log`) and `--help`
  - getting help: `docker run --rm accetto/ubuntu-vnc-xfce --help`
  - README file is extended

### Version 18.06

- Dockerfile redesigned
  - multi-staged and explicit
  - helper installation scripts mostly removed
- Some other changes inherited from the [base image][this-base]
  - standard *Xfce* desktop, incl. initial panel configuration on the first start
  - editor **leafpad** replaced by more advanced but still lite [mousepad][mousepad]
  - **pulseaudio** and **pavucontrol** not purged any more
- Firefox updated

### Version 18.05.2

- Dockerfiles - build arguments and environment variables interaction redesigned
- Default **VNC_RESOLUTION=1024x768** and it can be set also through build arguments

### Version 18.05.1

- Firefox Quantum updated to version **60.0** (64-bit)

### Version 18.05

- This is the first version after splitting from the former common base repository [accetto/ubuntu-vnc-xfce][accetto-github-ubuntu-vnc-xfce]
- Resources for base Ubuntu/VNC images and images with configurable Firefox split into separate GitHub repositories, consequently
  - README, CHANGELOG and Wiki are not common any more
  - Resources for base images moved to repository [accetto/ubuntu-vnc-xfce][accetto-github-ubuntu-vnc-xfce]
  - Resources for configurable Firefox installation moved to repository [accetto/ubuntu-vnc-xfce-firefox-plus][accetto-github-ubuntu-vnc-xfce-firefox-plus]
  - This image contains default Firefox installation without any customization

[this-docker]: https://hub.docker.com/r/accetto/ubuntu-vnc-xfce-firefox-default/
[this-github]: https://github.com/accetto/ubuntu-vnc-xfce-firefox
[this-wiki]: https://github.com/accetto/ubuntu-vnc-xfce-firefox/wiki
[this-base]: https://hub.docker.com/r/accetto/ubuntu-vnc-xfce

[accetto-github-ubuntu-vnc-xfce]: https://github.com/accetto/ubuntu-vnc-xfce
[accetto-github-ubuntu-vnc-xfce-firefox-plus]: https://github.com/accetto/ubuntu-vnc-xfce-firefox-plus
[accetto-docker-xubuntu-vnc]: https://hub.docker.com/r/accetto/xubuntu-vnc
[accetto-docker-xubuntu-vnc-firefox]:https://hub.docker.com/r/accetto/xubuntu-vnc-firefox

[accetto-docker-argbash-docker]: https://hub.docker.com/r/accetto/argbash-docker
[accetto-github-argbash-docker]: https://github.com/accetto/argbash-docker

[mousepad]: https://github.com/codebrainz/mousepad
[novnc]: https://github.com/kanaka/noVNC
[nsswrapper]: https://cwrap.org/nss_wrapper.html
