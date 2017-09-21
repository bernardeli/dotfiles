#! /bin/bash

UUID=$1
ruby -rlegacy_uuid -e "puts LegacyUUID.uid_of '$UUID'"
