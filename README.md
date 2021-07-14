## Summary

This repo contains an example of spinning up containers (commonly services) from within
a container via `docker-compose`. Compose is a tool for defining and running one or more
docker containers. Compose services are defined in a yaml file named
`docker-compose.yml` which is used by the `docker-compose` command line utility (CLI).
In this example, two containers are used. The first uses the
[`alpine`](https://hub.docker.com/_/alpine) flavor of linux and will be used to spawn
the second container which runs a simple [`nginx`](https://hub.docker.com/_/nginx) server.
A non-default docker [bridge network](https://docs.docker.com/network/bridge/) is also
used to separate the containers from the host network and allow the two services to
communicate.

## Requires

- `docker`
- `docker-compose`

## Usage

1. Clone repository

   ```shell
   git clone https://github.com/aaraney/docker-compose-in-container.git && cd docker-compose-in-container
   ```

2. Build and Run `alpine` container

   ```shell
   docker-compose run docker_composer sh
   ```

   Upon running this, you should be greeted with a shell prompt.

3. Spawn `nginx` container

   For context, the `services` directory in this repository has been mounted to
   `/services` in the `alpine` container. Within the directory resides the
   `docker-compose.yml` file for the `nginx` service. Next, navigate to `/services` and
   spawn the `nginx` container using `docker-compose`.

   ```shell
   cd /services
   docker-compose up --detach
   ```

   Check that the `nginx` container was properly launched by checking the services logs.

   ```shell
   docker-compose logs
   ```

4. Fetch the `nginx` homepage from the `alpine` service using `curl`

   The custom docker network provides domain name service (DNS) resolution, so here we
   specify the `nginx` service by the service name specified in the compose file.

   ```shell
   curl http://nginx

    <!DOCTYPE html>
    <html>
    <head>
    <title>Welcome to nginx!</title>
    <style>
        body {
            width: 35em;
            margin: 0 auto;
            font-family: Tahoma, Verdana, Arial, sans-serif;
        }
    </style>
    </head>
    <body>
    <h1>Welcome to nginx!</h1>
    <p>If you see this page, the nginx web server is successfully installed and
    working. Further configuration is required.</p>

    <p>For online documentation and support please refer to
    <a href="http://nginx.org/">nginx.org</a>.<br/>
    Commercial support is available at
    <a href="http://nginx.com/">nginx.com</a>.</p>

    <p><em>Thank you for using nginx.</em></p>
    </body>
    </html>
   ```
