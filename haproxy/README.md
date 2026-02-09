# HAProxy for SpaceDF

## Usage

Clone the repository

```sh
git clone --recurse-submodules git@github.com:Space-DF/spacedf-backend.git
```

Run Docker containers

```sh
cd spacedf-backend
docker-compose up
```

Set up SSL/TSL for EMQX

```sh
sudo apt install certbot -y
## NOTE: Verify there are no applications running on port 80, 443
sudo certbot certonly -d emqx.example.com
sudo cp /etc/letsencrypt/live/emqx.example.com/fullchain.pem ./spacedf-backend/haproxy/certs
sudo cp /etc/letsencrypt/live/emqx.example.com/privkey.pem ./spacedf-backend/haproxy/certs
sudo chown root:root ./spacedf-backend/haproxy/certs/*.pem
sudo chmod 600 ./spacedf-backend/haproxy/certs/privkey.pem
cd spacedf-backend/haproxy/certs && cat fullchain.pem privkey.pem > emqx.pem
```

## License
Licensed under the Apache License, Version 2.0  
See the LICENSE file for details.

[![SpaceDF - A project from Digital Fortress](https://df.technology/images/SpaceDF.png)](https://df.technology/)
