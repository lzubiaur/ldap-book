# Zubiaur Laurent
# file: ldap_chg_passwd

LDAP_DIR=/usr/local/bin

if [ $# -ne 2 ]; then
	echo Usage: $0 {username password}
	exit -1
fi

echo Change password for $1...
echo "dn: uid=$1,ou=People,dc=inpres,dc=be
changeType: modify
replace: userPassword
userPassword: $2" | 
$LDAP_DIR/ldapmodify -x -D cn=root,dc=inpres,dc=be -W -H ldaps://10.59.4.8:636

exit 0

