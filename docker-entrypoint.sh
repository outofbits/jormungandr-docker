#!/bin/sh
set -e

if [ ! -z "$GENESIS_BLOCK_HASH" ]; then
	if [ ! -z "$NODE_CONFIG_PATH" ]; then
		if [ ! -z "$NODE_SECRET_PATH" -a -f "$NODE_SECRET_PATH" ]; then
			if [ ! -z "$GUARDED" ]; then
				echo "INFO: started the guardian."
				/opt/jormungandr/bin/guardian $NODE_CONFIG_PATH &
			fi
			exec /opt/jormungandr/bin/jormungandr --genesis-block-hash $GENESIS_BLOCK_HASH --config $NODE_CONFIG_PATH --secret $NODE_SECRET_PATH "$@"
		else
			echo "WARN: started as a passive node!"
			exec /opt/jormungandr/bin/jormungandr --genesis-block-hash $GENESIS_BLOCK_HASH --config $NODE_CONFIG_PATH "$@"
		fi
	else
		echo "node configuration path must be specified and configuration file must exist!"
		exit 1
	fi
else
	echo "genesis block hash is required!"
	exit 1
fi



