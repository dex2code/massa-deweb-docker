# MASSA DEWEB server :: Docker Image

The MASSA DEWEB server ( https://docs.massa.net/docs/deweb/home ) can be launched with a single command using the Docker containerization technology.

**Important!** Before proceeding further, make sure that Docker is installed on your server.
More details here: https://www.docker.com/get-started/

Link to Github repository: https://github.com/dex2code/massa-deweb-docker

Link to Docker repository: https://hub.docker.com/r/dex2build/massa-deweb



# Simple one-line launch:

    docker network create --driver="bridge" --ipv6 "massa-network" && \
    docker container run \
      --detach \
      --hostname="massa-deweb" \
      --name="massa_deweb" \
      --network="massa-network" \
      --publish="8080:8080" \
      --restart="unless-stopped" \
      dex2build/massa-deweb:latest

If the local port `8080/tcp` is already busy by another application you can change the publishing port:

    --publish="18080:8080"

After successfully launching the service, you can check its functionality by going to one of the decentralized sites.
Try to open `http://docs.localhost:8080/` in your browser.



# DEWEB Server configuration:

The docker image contains the default config file with the following settings:

    domain: "localhost"
    network_node_url: "https://mainnet.massa.net/api/v2"
    api_port: 8080

If you need to change these settings, you need to create a new configuration file and then copy it inside the container:

    docker cp /path/to/new/deweb_server_config.yaml massa_deweb:/home/massa/deweb_server_config.yaml

Then restart the container:

    docker restart massa_deweb


