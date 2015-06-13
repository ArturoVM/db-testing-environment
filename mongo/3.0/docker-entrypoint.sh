#!/bin/bash
set -e

if [ "${1:0:1}" = '-' ]; then
	set -- mongod "$@"
fi

if [ "$1" = 'mongod' ]; then
	chown -R mongodb /data/db

	numa='numactl --interleave=all'
	if $numa true &> /dev/null; then
		set -- $numa "$@"
	fi

	if [ ! -d "$DATADIR/journal" ]; then
	(
		sleep 5;
		mongo "$MONGO_DATABASE" --eval "db.createUser({\"user\": \"$MONGO_USER\", \"pwd\": \"$MONGO_PASSWORD\", \"roles\": [{role: \"readWrite\", db:\"$MONGO_DATABASE\"}]}, {w: 1})";
	) &
  fi

	exec gosu mongodb "$@"
fi

exec "$@"
