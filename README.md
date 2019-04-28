# Headless Ubuntu/Xfce container with VNC/noVNC and Firefox

## accetto/ubuntu-vnc-xfce-firefox-default

[Docker Hub][this-docker] - [Git Hub][this-github] - [Changelog][this-changelog] - [Wiki][this-wiki]

**Attention:** Resources for building images with configurable Firefox, previously contained in the common base repository [ubuntu-vnc-xfce][accetto-github-ubuntu-vnc-xfce], have been moved to its own GitHub repository [ubuntu-vnc-xfce-firefox-plus][accetto-github-ubuntu-vnc-xfce-firefox-plus]. Resources for building the base images are in the GitHub repository [accetto/ubuntu-vnc-xfce][accetto-github-ubuntu-vnc-xfce].

**Attention:** The Docker Hub repository is actually named [*ubuntu-vnc-xfce-firefox*-**default**][this-docker] to avoid conflicts with the previous generation image.

***

**This repository** contains resources for building a Docker image based on [Ubuntu][docker-ubuntu] with [Xfce][xfce] desktop environment, **VNC**/[noVNC][novnc] servers for headless use and the current [Firefox][firefox] web browser in its default installation.

The image can be successfully built and used on Linux, Windows, Mac and NAS devices. It has been tested with [Docker Desktop][docker-desktop] on [Ubuntu flavours][ubuntu-flavours], [Windows 10][docker-for-windows] and [Container Station][container-station] from [QNAP][qnap].

Containers created from this image make perfect light-weight web browsers. They can be thrown away easily and replaced quickly, improving browsing privacy. They run under a non-root user by default, improving browsing security.

Running in background is the primary scenario for the containers, but using them interactively in foreground is also possible. For examples see the description below or the [HOWTO][this-wiki-howto] section in [Wiki][this-wiki].

The image is based on the [accetto/ubuntu-vnc-xfce][accetto-docker-ubuntu-vnc-xfce] image, just adding the [Firefox][firefox] browser in its default installation.

The image inherits the following components from its [base image][accetto-docker-ubuntu-vnc-xfce]:

- light-weight [Xfce][xfce] desktop environment
- high-performance VNC server [TigerVNC][tigervnc] (TCP port **5901**)
- [noVNC][novnc] HTML5 clients (full and lite) (TCP port **6901**)
- popular text editor [vim][vim]
- lite but advanced graphical editor [mousepad][mousepad]
- **ping** utility
- container start-up options

The image is regularly maintained and rebuilt. The history of notable changes is documented in [CHANGELOG][this-changelog].

![screenshot-container][screenshot-container]

## Image set

- [accetto/ubuntu-vnc-xfce-firefox-default][this-docker]

  - `latest` based on `accetto/ubuntu-vnc-xfce:latest`

    [![version badge](https://images.microbadger.com/badges/version/accetto/ubuntu-vnc-xfce-firefox-default.svg)](https://microbadger.com/images/accetto/ubuntu-vnc-xfce-firefox-default "Get your own version badge on microbadger.com") [![size badge](https://images.microbadger.com/badges/image/accetto/ubuntu-vnc-xfce-firefox-default.svg)](https://microbadger.com/images/accetto/ubuntu-vnc-xfce-firefox-default "Get your own image badge on microbadger.com")

### Ports

Following **TCP** ports are exposed:

- **5901** used for access over **VNC**
- **6901** used for access over [noVNC][novnc]

The default **VNC user** password is **headless**.

### Volumes

The containers do not create or use any external volumes by default. However, the following folders make good mounting points:

- /home/headless/Documents/
- /home/headless/Downloads/
- /home/headless/Music/
- /home/headless/Pictures/
- /home/headless/Public/
- /home/headless/Templates/
- /home/headless/Videos/

The following mounting point is specific to Firefox:

- /home/headless/.mozilla

Both *named volumes* and *bind mounts* can be used. More about volumes can be found in [Docker documentation][docker-doc] (e.g. [Manage data in Docker][docker-doc-managing-data]).

## Running containers in background (detached)

Created containers will run under the non-root user **headless:headless** by default.

The following container will listen on automatically selected **TCP** ports of the host computer:

```docker
docker run -d -P accetto/ubuntu-vnc-xfce-firefox-default
```

The following container will listen on the host's explicit **TCP** ports **25901** (VNC) and **26901** (noVNC):

```docker
docker run -d -p 25901:5901 -p 26901:6901 accetto/ubuntu-vnc-xfce-firefox-default
```

The following container wil create or re-use the local named volume **my\_Downloads** mounted as `/home/headless/Downloads`. The container will be accessible through the same **TCP** ports as the one above:

```docker
docker run -d -P -v my_Downloads:/home/headless/Downloads accetto/ubuntu-vnc-xfce-firefox-default
```

or using the newer syntax with **--mount** flag:

```docker
docker run -d -P --mount source=my_Downloads,target=/home/headless/Downloads accetto/ubuntu-vnc-xfce-firefox-default
```

More usage examples can be found in [Wiki][this-wiki] (section [HOWTO][this-wiki-howto]).

## Running containers in foreground (interactively)

The image supports the following container start-up options: `--wait` (default), `--skip`, `--debug` (also `--tail-log`) and `--help`. This functionality is inherited from the [base image][accetto-docker-ubuntu-vnc-xfce].

The following container will print out the help and then it'll remove itself:

```docker
docker run --rm accetto/ubuntu-vnc-xfce-firefox-default --help
```

Excerpt from the output, which describes the other options:

```docker
OPTIONS:
-w, --wait      (default) Keeps the UI and the vnc server up until SIGINT or SIGTERM are received.
                An optional command can be executed after the vnc starts up.
                example: docker run -d -P accetto/ubuntu-vnc-xfce
                example: docker run -it -P accetto/ubuntu-vnc-xfce /bin/bash

-s, --skip      Skips the vnc startup and just executes the provided command.
                example: docker run -it -P accetto/ubuntu-vnc-xfce --skip /bin/bash

-d, --debug     Executes the vnc startup and tails the vnc/noVNC logs.
                Any parameters after '--debug' are ignored. CTRL-C stops the container.
                example: docker run -it -P accetto/ubuntu-vnc-xfce --debug

-t, --tail-log  same as '--debug'

-h, --help      Prints out this help.
                example: docker run --rm accetto/ubuntu-vnc-xfce
```

It should be noticed, that the `--debug` start-up option does not show the command prompt even if the `-it` run arguments are provided. This is because the container is watching the incoming vnc/noVNC connections and prints out their logs in real time. However, it is easy to attach to the running container like in the following example.

In the first terminal window on the host computer, create a new container named **foo**:

```docker
docker run --name foo accetto/ubuntu-vnc-xfce-firefox-default --debug
```

In the second terminal window on the host computer, execute the shell inside the **foo** container:

```docker
docker exec -it foo /bin/bash
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

If you have found a problem or you just have a question, please check the [Issues][this-issues] and the [Troubleshooting][this-wiki-troubleshooting], [FAQ][this-wiki-faq] and [HOWTO][this-wiki-howto] sections in [Wiki][this-wiki] first. Please do not overlook the closed issues.

If you do not find a solution, you can file a new issue. The better you describe the problem, the bigger the chance it'll be solved soon.

## Credits

Credit goes to all the countless people and companies who contribute to open source community and make so many dreamy things real.

[this-docker]: https://hub.docker.com/r/accetto/ubuntu-vnc-xfce-firefox-default/
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
[docker-doc]: https://docs.docker.com/
[docker-doc-managing-data]: https://docs.docker.com/storage/
[docker-for-windows]: https://hub.docker.com/editions/community/docker-ce-desktop-windows
[docker-desktop]: https://www.docker.com/products/docker-desktop

[qnap]: https://www.qnap.com/en/
[container-station]: https://www.qnap.com/solution/container_station/en/

[ubuntu-flavours]: https://www.ubuntu.com/download/flavours

[firefox]: https://www.mozilla.org
[mousepad]: https://github.com/codebrainz/mousepad
[novnc]: https://github.com/kanaka/noVNC
[tigervnc]: http://tigervnc.org
[tightvnc]: http://www.tightvnc.com
[vim]: https://www.vim.org/
[xfce]: http://www.xfce.org

[screenshot-container]: https://raw.githubusercontent.com/accetto/ubuntu-vnc-xfce-firefox/master/ubuntu-vnc-xfce-firefox.jpg
