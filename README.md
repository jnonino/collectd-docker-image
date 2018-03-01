# CollectD Docker Image

    docker run --network=host --name=collectd --link influxdb:influxdb jnonino/collectd-docker-image influxdb 25826