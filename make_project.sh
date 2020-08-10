#!/bin/bash

set -a
SCRIPTNAME=$(basename -- "$0")
DJANGO_PROJECT_NAME=


print_help () {
    >&2 cat <<EOF
Arguments:
  -n, --name         Django project name

  -h, --help         muestra esta ayuda y finaliza

Example:
  ${SCRIPTNAME} -n my_django_project

EOF
    exit 1
}


make_project () {
    ln -s ./.env_template ./.env
    docker-compose run web django-admin startproject ${DJANGO_PROJECT_NAME} .
    exit 1
}


while [[ ${#} -gt 0 ]]; do
    case "${1}" in
        -n|--name)
            DJANGO_PROJECT_NAME="${2}"
            make_project
            ;;
        -h|--help)
            print_help
            ;;
        *)
            >&2 echo '[ERROR] unknown arg: ${1}'
            exit 1
            ;;
    esac
    shift
done


set +a
echo '[INFO] Done!'
