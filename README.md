# Hearable

A Docker container which runs [`audible-cli`][1] and [`AAXtoMP3`][2] tools to fetch your purchased audible books and convert them to other formats for offline or selfhosted listening.

 [1]: https://github.com/mkb79/audible-cli
 [2]: https://github.com/KrumpetPirate/AAXtoMP3

[![Docker Image Version](https://img.shields.io/docker/v/tskulbru/hearable?sort=semver)][hub]
[![Docker Image Size](https://img.shields.io/docker/image-size/tskulbru/hearable)][hub]

 [hub]: https://hub.docker.com/r/tskulbru/hearable/

## Setting up your config
First we need to set up our audible credentials to be reused later on, to do this we need to run the container in interactive mode

```bash
docker run -it \
  -v /path/to/config:/config \
  tskulbru/hearable \
  /bin/bash
```

Once inside the container, run the commands below and follow the steps given.

```bash
audible quickstart
audible activation-bytes

```

## Usage

```bash
docker run -d \
  --name=hearable \
  -e BOOK_TITLES=Mockingjay \
  -v /path/to/config:/config \
  -v /path/to/storage:/storage \
  -v /path/to/backup:/backup \
  tskulbru/hearable
```

### Paremeters

| Parameter | Function |
| :----: | --- |
| `-e BOOK_TITLES=1000` | Optionally you can define specific books for download, uses keywords. If missing it will download all books from library. |
| `-v /config` | Audible configuration location, api keys and authcodes. |
| `-v /storage` | Finished converted media ends up here. |
| `-v /backup` | Optionally you can also save your downloaded AAX files from audible in case you want to convert to different formats later on. |


## Anti-Piracy Notice
Note that this software does not ‘crack’ the DRM or circumvent it in any other way. The application applies account and book specific keys, retrieved directly from the Audible server via the user’s personal account, to decrypt the audiobook in the same manner as the official audiobook playing software does. 
Please only use this application for gaining full access to your own audiobooks for archiving/conversion/convenience. De-DRMed audiobooks must not be uploaded to open servers, torrents, or other methods of mass distribution. No help will be given to people doing such things. Authors, retailers and publishers all need to make a living, so that they can continue to produce audiobooks for us to listen to and enjoy.

(*This blurb is borrowed from https://github.com/KrumpetPirate/AAXtoMP3 and https://apprenticealf.wordpress.com/*). 
