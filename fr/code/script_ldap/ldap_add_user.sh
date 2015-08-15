# Zubiaur Laurent
# file: ldap_add_user

LDAP_DIR=/usr/local/bin
HOMEDIRMONTAIGNE=/home
HOMEDIRDIDEROT=/usr/test
HOMEDIRSUNRAY=/ldap/user
LOGINSHELL=/bin/sh

if [ $# -ne 4 ]; then
	echo Usage: $0 {username userpassword gid uid}
	exit -1
fi

echo "dn: uid=$1, ou=People, dc=inpres,dc=be
userPassword: $2
loginShell: /bin/sh
gidNumber: $3
uidNumber: $4
shadowFlag: 0
objectClass: posixAccount
objectClass: shadowAccount
objectClass: account
objectClass: top
objectClass: userInpres
uid: $1
shadowLastChange: 12842
cn: $1
homeDirectory: /
homeDirDiderot: $HOMEDIRDIDEROT/$1
homeDirSunray1v440: $HOMEDIRSUNRAY/$1
homeDirMontaigne: $HOMEDIRMONTAIGNE/$1" > .ldap_add_user.cache
echo Add user $1...
$LDAP_DIR/ldapadd -x -D cn=root,dc=inpres,dc=be -W -H ldaps://10.59.4.8:636 \
	-f ./.ldap_add_user.cache

echo Change password for user $1...
$LDAP_DIR/ldappasswd -x -D cn=root,dc=inpres,dc=be -W -H ldaps://10.59.4.8:636 \
	-a $2 -s $2 "uid=$1, ou=People, dc=inpres,dc=be"
exit 0