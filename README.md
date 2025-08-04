# NASA Fuel Calculator

A CLI tool for calculating fuel requirements for space missions between planets.

## Prerequisites

- [Install Docker](https://docs.docker.com/engine/install/)

## Docker Commands

### Build
```bash
docker build -t nasa .
```

### Run
```bash
docker run nasa <mass> <action>:<planet> [<action>:<planet>...]
```

The first parameter is the equipment mass. Actions can be `launch` or `land`, and planets can be `earth`, `mars`, or `moon`.

Example:
```bash
docker run nasa 14606 launch:earth land:mars launch:mars land:earth
```

### Test
```bash
docker build -f Dockerfile.test -t nasa-test .
docker run nasa-test
```

