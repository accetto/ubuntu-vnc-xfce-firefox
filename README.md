# Headless Ubuntu/Xfce containers with VNC/noVNC and Firefox

## accetto/ubuntu-vnc-xfce-firefox

[Docker Hub][this-docker] - [Git Hub][this-github]

This repository contains resources for building Docker images based on [Ubuntu][docker-ubuntu], with [Xfce][xfce] desktops, headless **VNC**/[noVNC][novnc] environments and default installation of the current [Firefox][firefox] browser.

These images can be also successfully built and used on NAS devices. They
have been tested with [Container Station][container-station] from [QNAP][qnap].

The images are perfect for fast creation of light-weight web browser containers. They can be thrown away easily and replaced quickly, improving browsing privacy. They run under a non-root user by default, improving browsing security.

The images are based on the [accetto/ubuntu-vnc-xfce][accetto-docker-ubuntu-vnc-xfce] images, just adding the [Firefox][firefox] browser.

The images inherit the following components from the base images

- light-weight [Xfce][xfce] desktop environment
- high-performance VNC server [TigerVNC][tigervnc] (TCP port **5901**)
- [noVNC][novnc] HTML5 clients (full and lite) (TCP port **6901**)
- light-weight graphical editor [leafpad][leafpad]
- popular text editor [vim][vim]

The images are regularly maintained and rebuilt. The history of notable changes is documented in [CHANGELOG][this-changelog].

*Remark:* Resources for building images with configurable Firefox, previously contained in the common base repository [ubuntu-vnc-xfce][accetto-github-ubuntu-vnc-xfce], have been moved to the separate repository [ubuntu-vnc-xfce-firefox-plus][accetto-github-ubuntu-vnc-xfce-firefox-plus]. Resources for building base images are in the repository [accetto/ubuntu-vnc-xfce][accetto-github-ubuntu-vnc-xfce].

## Image set

- [accetto/ubuntu-vnc-xfce-firefox][this-docker]

  - `latest` based on `accetto/ubuntu-vnc-xfce:latest`
  - `rolling` based on `accetto/ubuntu-vnc-xfce:rolling`

    [![version badge](https://images.microbadger.com/badges/version/accetto/ubuntu-vnc-xfce-firefox.svg)](https://microbadger.com/images/accetto/ubuntu-vnc-xfce-firefox "Get your own version badge on microbadger.com") [![size badge](https://images.microbadger.com/badges/image/accetto/ubuntu-vnc-xfce-firefox.svg)](https://microbadger.com/images/accetto/ubuntu-vnc-xfce-firefox "Get your own image badge on microbadger.com") [![version badge](https://images.microbadger.com/badges/version/accetto/ubuntu-vnc-xfce-firefox:rolling.svg)](https://microbadger.com/images/accetto/ubuntu-vnc-xfce-firefox:rolling "Get your own version badge on microbadger.com") [![size badge](https://images.microbadger.com/badges/image/accetto/ubuntu-vnc-xfce-firefox:rolling.svg)](https://microbadger.com/images/accetto/ubuntu-vnc-xfce-firefox:rolling "Get your own image badge on microbadger.com")

### Ports

The images expose the following **TCP** ports:

- **5901** used for access over **VNC**
- **6901** used for access over [noVNC][novnc]

The default **VNC user** password is **headless**.

### Volumes

The images do not create or use any external volumes by default. However, the following folders make good mounting points:

- /headless/Documents/
- /headless/Downloads/
- /headless/Music/
- /headless/Pictures/
- /headless/Public/
- /headless/Templates/
- /headless/Videos/

The following mounting point is specific to Firefox:

- /headless/.mozilla

Both *named volumes* and *bind mounts* can be used. More about volumes can be found in [Docker documentation][docker-doc-managing-data].

## Creating containers

Created containers will run under the non-root user **headless:headless** by default.

The following container will listen on the host's **TCP** ports **25901** (VNC) and **26901** (noVNC):

```docker
docker run -d -p 25901:5901 -p 26901:6901 accetto/ubuntu-vnc-xfce-firefox
```

The following container wil create or re-use the local named volume **my\_Downloads** mounted as `/headless/Downloads`. The container will be accessible through the same **TCP** ports as the one above:

```docker
docker run -d -p 25901:5901 -p 26901:6901 -v my_Downloads:/headless/Downloads accetto/ubuntu-vnc-xfce-firefox
```

or using the newer syntax with **--mount** flag:

```docker
docker run -d -p 25901:5901 -p 26901:6901 --mount source=my_Downloads,target=/headless/Downloads accetto/ubuntu-vnc-xfce-firefox
```

## Using headless containers

There are two ways, how to use the created headless containers. Note that the default **VNC user** password is **headless**.

### Over VNC

To be able to use the containers over **VNC**, a **VNC Viewer** is needed (e.g. [TigerVNC][tigervnc] or [TightVNC][tightvnc]).

The VNC Viewer should connect to the host running the container, pointing to the host's TCP port mapped to the container's TCP port **5901**.

For example, if the container has been created on the host called `mynas` using the parameters described above, the VNC Viewer should connect to `mynas:25901`.

### Over noVNC

To be able to use the containers over [noVNC][novnc], an HTML5 capable web browser is needed. It actually means, that any current web browser can be used.

The browser should navigate to the host running the container, pointing to the host's TCP port mapped to the container's TCP port **6901**.

However, the containers offer two [noVNC][novnc] clients - **lite** and **full**. The connection URL differs slightly in both cases. To make it easier, a simple startup page is implemented.

If the container have been created on the host called `mynas` using the parameters described above, then the web browser should navigate to `http://mynas:26901`.

The startup page will show two hyperlinks pointing to the both noVNC clients:

- `http://mynas:26901/vnc_lite.html`
- `http://mynas:26901/vnc.html`

It's also possible to provide the password through the links:

- `http://mynas:26901/vnc_lite.html?password=headless`
- `http://mynas:26901/vnc.html?password=headless`

## Issues

If you have found a problem or just have a question, please check the [Issues][this-issues] and the [Troubleshooting][this-wiki-troubleshooting], [FAQ][this-wiki-faq] and [HOWTO][this-wiki-howto] pages in [Wiki][this-wiki] first. Please do not overlook also the closed issues.

If you do not find a solution, you can file a new issue. The better you describe the problem, the bigger the chance it'll be solved soon.

[this-docker]: https://hub.docker.com/r/accetto/ubuntu-vnc-xfce-firefox/
[this-github]: https://github.com/accetto/ubuntu-vnc-xfce-firefox

[this-changelog]: https://github.com/accetto/ubuntu-vnc-xfce-firefox/blob/master/CHANGELOG.md
[this-issues]: https://github.com/accetto/ubuntu-vnc-xfce-firefox/issues

[this-wiki]: https://github.com/accetto/ubuntu-vnc-xfce-firefox/wiki
[this-wiki-howto]: https://github.com/accetto/ubuntu-vnc-xfce-firefox/wiki/How-to
[this-wiki-troubleshooting]: https://github.com/accetto/ubuntu-vnc-xfce-firefox/wiki/Troubleshooting
[this-wiki-faq]: https://github.com/accetto/ubuntu-vnc-xfce-firefox/wiki/Frequently-asked-questions

[accetto-github]: https://github.com/accetto/
[accetto-docker]: https://hub.docker.com/u/accetto/

[accetto-github-ubuntu-vnc-xfce]: https://github.com/accetto/ubuntu-vnc-xfce
[accetto-docker-ubuntu-vnc-xfce]: https://hub.docker.com/r/accetto/ubuntu-vnc-xfce/

[accetto-github-ubuntu-vnc-xfce-firefox-plus]: https://github.com/accetto/ubuntu-vnc-xfce-firefox-plus/
[accetto-docker-ubuntu-vnc-xfce-firefox-plus]: https://hub.docker.com/r/accetto/ubuntu-vnc-xfce-firefox-plus/

[docker-ubuntu]: https://hub.docker.com/_/ubuntu/
[docker-doc-managing-data]: https://docs.docker.com/storage/

[xfce]: http://www.xfce.org
[tigervnc]: http://tigervnc.org
[novnc]: https://github.com/kanaka/noVNC
[leafpad]: https://en.wikipedia.org/wiki/Leafpad
[tightvnc]: http://www.tightvnc.com
[firefox]: https://www.mozilla.org
[vim]: https://www.vim.org/

[qnap]: https://www.qnap.com/en/
[container-station]: https://www.qnap.com/solution/container_station/en/
