# README

## Description
Code for **Everyday Rails Testing with RSpec** using [Dip.yml](https://github.com/bibendi/dip) and the code in [Evil Martians - Ruby on Whales: Dockerizing Ruby and Rails development](https://evilmartians.com/chronicles/ruby-on-whales-docker-for-ruby-rails-development#introducing-dip) using Rails and SQLite3.

## Requirements
[Docker 27.3.2](https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository), docker-desktop is not mandatory

## Running
```console
dip provision
dip rails s
```
use VS Code for code edition and connecting to the container's shell.

## Notification
This is code in review, the *dip.yml*, *compose.yml* codes are quite convoluted. As I made some heavy changes leaving out Postgres, Sidekiq, Redis, Webpak.
Also, though it is common to run an image to install and create a *rails* project, but that is not mentioned.

```
docker run -i -t --rm -v ${PWD}:/app ruby 3.2.2 bash
```
