#!/bin/bash
SUCCESS=0
ERROR=1
SERVER_CONTAINER="swg_server"
DATABASE_CONTAINER="swg_database"

# Store help output
read -r -d '' HELP << HELP
Usage: run.sh [OPTIONS] COMMAND

  Helper script to handle launching, accessing, and killing docker containers.

Example:
  ./run.sh server

Options:
  -f --force        Relaunches containers

Commands:
    server          Launches containers and shells into server container
    database        Launches containers and shells into database container
    kill            Kills all containers
HELP

function docker_shutdown {
    docker compose down
}

function docker_start {
    # Force recreate
    if [ ${FORCE:-0} -eq 1 ]
    then
        local arg="--force-recreate"
    fi

    docker compose up -d ${arg:+"$arg"}
}

function docker_shell {
    docker exec -it "${1}" /bin/bash
}

POSITIONAL=()
while [[ $# -gt 0 ]]
do
    key="${1}"

    case $key in
        -f|--force)
            FORCE=1
            shift
            ;;
        *)  # Unknown argument
            POSITIONAL+=("${1}")
            shift
            ;;
    esac
done

set -- "${POSITIONAL[@]}"

case "${1}" in
    database)
        echo "Attaching database"
        docker_start
        docker_shell "${DATABASE_CONTAINER}"
        ;;
    server)
        echo "Attaching server"
        docker_start
        docker_shell "${SERVER_CONTAINER}"
        ;;
    kill)
        docker_shutdown
        ;;
    *)
        echo "${HELP}"
        ;;
esac
