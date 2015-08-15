# Zubiaur Laurent
# file: ldap_add_host

LDAP_DIR=/usr/local/bin
RDN=""

if [ $# -ne 2 ]; then
	echo Usage: $0 {hostname basedir}
	exit -1
fi

echo Search for users...
$LDAP_DIR/ldapsearch -x -b ou=People,dc=inpres,dc=be -H ldaps://10.59.4.8:636 \
	-LLL "objectClass=userInpres" dn | grep -v '^$' > .ldap_add_host.tmp

> .ldap_add_host.cache
cat .ldap_add_host.tmp | while read line
do
# retrouve le uid de l'utilisateur
RDN=`echo $line | cut -f1 -d"," | cut -f2 -d"="`
# ajoute la commande LDIF pour modifier l'entree de cet utilisateur
echo "$line
changeType: modify
add: $1
$1: $2/$RDN

" >> .ldap_add_host.cache
done

echo Add attribut $1...
$LDAP_DIR/ldapmodify -c -x -D cn=root,dc=inpres,dc=be -W -H ldaps://10.59.4.8:636 \
	-f ./.ldap_add_host.cache

exit 0

