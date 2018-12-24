#!/bin/bash
#
# Title:      PlexGuide (Reference Title File)
# Author(s):  Admin9705 - Deiteq
# URL:        https://plexguide.com - http://github.plexguide.com
# GNU:        General Public License v3.0
################################################################################

mainstart() {

# wait for place.holder to show up
placeholder=0
while [ "$placeholder" == "0" ]; do
  file="/opt/pgstage/place.holder"
  if [ -e "$file" ]; then
  placeholder="1"; fi
done

latest=$(cat /opt/pgstage/versions.sh | head -n1)

tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📂  PG Update Interface
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

✅  Latest Version: $latest
    Prior Versions? Visit > versions.plexguide.com

💬  Quitting? TYPE > exit
EOF

break=no
read -p '🌍  TYPE a PG Version | PRESS ENTER: ' typed
storage=$(grep $typed /opt/pgstage/versions.sh)

parttwo
}

parttwo() {
if [ "$typed" == "exit" ]; then
  echo ""; touch /var/plexguide/exited.upgrade; exit
fi

if [ "$storage" != "" ]; then
  break=yes
  echo $storage > /var/plexguide/pg.number
  ansible-playbook /opt/plexguide/menu/version/choice.yml

tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✅️  SYSTEM MESSAGE: Installing Verison - $typed - Standby!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
sleep 2
exit
else
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⛔️  SYSTEM MESSAGE: Version $typed does not exist! - Standby!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
  sleep 2
  mainstart
fi
}

mainstart
