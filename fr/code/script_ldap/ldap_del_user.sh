# Zubiaur Laurent
# file: ldap_del_user

LDAP_DIR=/usr/local/bin
HOMEDIRMONTAIGNE=/home
HOMEDIRDIDEROT=/usr/test
HOMEDIRSUNRAY=/ldap/user
LOGINSHELL=/bin/sh

if [ $# -ne 1 ]; then
	echo Usage: $0 {username}
	exit -1
fi

$LDAP_DIR/ldapsearch -x -D cn=proxyagent,ou=Profile,dc=inpres,dc=be \
	-w "proxyagent" -H ldaps://10.59.4.8:636 \
	-LLL \
        "uid=$1" homeDirDiderot homeDirSunray1v440 homeDirMontaigne

$LDAP_DIR/ldapdelete -x -D cn=root,dc=inpres,dc=be -W -H ldaps://10.59.4.8:636 \
	"uid=$1, ou=People, dc=inpres,dc=be"	

exit 0

