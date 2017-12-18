#!/bin/sh

# Setup user/group ids
if [ ! -z "${UR_UID}" ]; then
  if [ ! "$(id -u ur)" -eq "${UR_UID}" ]; then
    
    # usermod likes to chown the home directory, so create a new one and use that
    # However, if the new UID is 0, we can't set the home dir back because the
    # UID of 0 is already in use (executing this script).
    if [ ! "${UR_UID}" -eq 0 ]; then
      mkdir /tmp/temphome
      usermod -d /tmp/temphome ur
    fi
    
    # Change the UID
    usermod -o -u "${UR_UID}" ur
    
    # Cleanup the temp home dir
    if [ ! "${UR_UID}" -eq 0 ]; then
      usermod -d /config ur
      rm -Rf /tmp/temphome
    fi
  fi
fi

if [ ! -z "${UR_GID}" ]; then
  if [ ! "$(id -g ur)" -eq "${UR_GID}" ]; then
    groupmod -o -g "${UR_GID}" ur
  fi
fi

# Update ownership of dirs we need to write
#if [ "${CHANGE_CONFIG_DIR_OWNERSHIP,,}" = "true" ]; then
#  chown -R ur:ur /config
#  chown -R ur:ur /remotes
#fi

if [ "${CHANGE_CONFIG_DIR_OWNERSHIP,,}" = "true" ]
then 
	chown -R ur:ur /config
	chown -R ur:ur /remotes
fi
