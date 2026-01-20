# SpaceDF Core

## Prerequisites
- [Docker](https://www.docker.com/)
- Docker compose

## Clone source code

```
git clone -b dev --recurse-submodules git@github.com:Space-DF/spacedf-backend.git
```

To update submodules in exist directory

```
git submodule update --init --recursive
```

## Setup

### Setup environment

1. Setup [Docker](https://www.docker.com/)
```commandline
brew install colima
colima start
```
2. Setup docker-compose
```commandline
brew install docker-compose
```

### Launch
```commandline
chmod +x entrypoint.sh
./entrypoint.sh
```

### API documentation
http://localhost/docs

## Services Overview

### Python Django Services
- **Auth Service** - Authentication and OAuth credentials management
- **Bootstrap Service** - Initial setup and configuration service
- **Dashboard Service** - Dashboard and UI backend
- **Device Service** - Device management service
- **Django Common Utils** - Shared utilities library

### Go Services
- **Broker Bridge Service** - Bridge between message brokers
- **MPA Service** - Multi-Protocol Adapter service
- **Telemetry Service** - Telemetry data collection and processing
- **Transformer Service** - Data transformation service

### Infrastructure
- **EMQX** - MQTT message broker
- **HAProxy** - Load balancer and reverse proxy

### Default Local Database Configuration
#### Auth service
- Host: `localhost:5434`
- Username: `postgres`
- Password: `postgres`
- Database: `auth_service`
#### Bootstrap service
- Host: `localhost:5433`
- Username: `postgres`
- Password: `postgres`
- Database: `bootstrap_service`
#### Dashboard service
- Host: `localhost:5435`
- Username: `postgres`
- Password: `postgres`
- Database: `dashboard_service`
#### Device service
- Host: `localhost:5436`
- Username: `postgres`
- Password: `postgres`
- Database: `device_service`
#### Telemetry service
- Host: `localhost:5437`
- Username: `postgres`
- Password: `postgres`
- Database: `spacedf_telemetry`

## License
Licensed under the Apache License, Version 2.0  
See the LICENSE file for details.

[![SpaceDF - A project from Digital Fortress](https://df.technology/images/SpaceDF.png)](https://df.technology/)
