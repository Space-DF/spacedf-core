<p align="center">
  <a href="https://www.digitalfortress.dev/">
    <picture>
      <source media="(prefers-color-scheme: dark)" srcset="https://digitalfortress-s3-bucket-vpcxuhhdwecuj.s3.amazonaws.com/Group+1410083530.svg">
      <img alt="Digital Fortress logo" src="https://digitalfortress-s3-bucket-vpcxuhhdwecuj.s3.amazonaws.com/Group+1410083530.svg">
    </picture>    
  </a>
</p>

---

# Django template

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
docker-compose up
```

### API documentation
http://localhost/docs

### Default Local Database
#### Auth service
- Host: `localhost:5434`
- Username: `postgres`
- Password: `postgres`
- Database: `auth_service`
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

This project is Copyright (c) 2023 and onwards Digital Fortress. It is free software and may be redistributed under the terms specified in the [LICENSE] file.

[LICENSE]: /LICENSE

## About
<a href="https://www.digitalfortress.dev/">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="https://digitalfortress-s3-bucket-vpcxuhhdwecuj.s3.amazonaws.com/Group+1410083530.svg">
    <img alt="Digital Fortress logo" src="https://digitalfortress-s3-bucket-vpcxuhhdwecuj.s3.amazonaws.com/Group+1410083530.svg" width="160">
  </picture>
</a>

This project is made and maintained by Digital Fortress.

We are an experienced team in R&D, software, hardware, cross-platform mobile and DevOps.

See more of [our projects][projects] or do you need to complete one?

-> [Let’s connect with us][website]

[projects]: https://github.com/digitalfortress-dev
[website]: https://www.digitalfortress.dev
