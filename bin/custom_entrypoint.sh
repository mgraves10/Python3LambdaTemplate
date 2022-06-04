#!/bin/sh
H="$(eval echo $1)"
export _HANDLER=$H
exec /lambda-entrypoint.sh "${H}"