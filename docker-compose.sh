#!/bin/bash
cat <<EOF
version: '2.1'

services:

  ${SERVICE_NAME}:
    image: ${BUILD_IMAGE}
    volumes:
      - .:$PWD
      - $HOME/.cache:/home/$UNAME/.cache
      - $HOME/.ssh:/home/$UNAME/.ssh:ro
      - $HOME/.mix:/home/$UNAME/.mix
    working_dir: $PWD
    command: /sbin/init
    depends_on:
      postgres:
        condition: service_healthy

  postgres:
    image: postgres:10.6
    command: -c fsync=off -c full_page_writes=off
    environment:
      POSTGRES_PASSWORD: postgres
      POSTGRES_DB: nw
    healthcheck:
      test: ["CMD", "pg_isready", "-U", "postgres"]
      interval: 1s
      timeout: 1s
      retries: 60

volumes:
  schemas:
    external: false

EOF
