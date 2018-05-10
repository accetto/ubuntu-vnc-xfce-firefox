# CHANGELOG

## accetto/ubuntu-vnc-xfce-firefox

[Docker Hub][this-docker] - [Git Hub][this-github]

**Attention:** The Docker Hub repository is actually named *ubuntu-vnc-xfce-firefox*-**default** to avoid conflicts with the previous generation.

### Version 18.05

- This is the first version after splitting from the former common base repository [accetto/ubuntu-vnc-xfce][accetto-github-ubuntu-vnc-xfce]
- Resources for base Ubuntu/VNC images and images with configurable Firefox split into separate GitHub repositories, consequently
  - README, CHANGELOG and Wiki are not common any more
  - Resources for base images moved to repository [accetto/ubuntu-vnc-xfce][accetto-github-ubuntu-vnc-xfce]
  - Resources for configurable Firefox installation moved to repository [accetto/ubuntu-vnc-xfce-firefox-plus][accetto-github-ubuntu-vnc-xfce-firefox-plus]
  - This image contains default Firefox installation without any customization

[this-docker]: https://hub.docker.com/r/accetto/ubuntu-vnc-xfce-firefox-default/
[this-github]: https://github.com/accetto/ubuntu-vnc-xfce-firefox

[accetto-github-ubuntu-vnc-xfce]: https://github.com/accetto/ubuntu-vnc-xfce
[accetto-github-ubuntu-vnc-xfce-firefox-plus]: https://github.com/accetto/ubuntu-vnc-xfce-firefox-plus
