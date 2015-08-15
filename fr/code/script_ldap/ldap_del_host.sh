# Zubiaur Laurent
# file: ldap_del_host

LDAP_DIR=/usr/local/bin

if [ $# -ne 1 ]; then
	echo Usage: $0 {hostname}
	exit -1
fi

echo Search for users...
$LDAP_DIR/ldapsearch -x -b ou=People,dc=inpres,dc=be -H ldaps://10.59.4.8:636 \
	-LLL "objectClass=userInpres" dn | grep -v '^$' > .ldap_del_host.tmp

> .ldap_del_host.cache 
cat .ldap_del_host.tmp | while read line
do
echo "$line
changeType: modify
delete: $1

" >> .ldap_del_host.cache
done

echo Delete attribut $1...
$LDAP_DIR/ldapmodify -c -x -D cn=root,dc=inpres,dc=be -W -H ldaps://10.59.4.8:636 \
	-f ./.ldap_del_host.cache

exit 0

