# Einmalige Initialisierung: auth/-Verzeichnis anlegen und ersten Benutzer erstellen.
# Muss vor dem ersten "docker compose up" ausgeführt werden.
#
# htpasswd-Flags:
#   -B  bcrypt-Hashing verwenden (sicher, von der Registry empfohlen)
#   -c  Passwort-Datei neu anlegen (überschreibt eine vorhandene Datei!)
#
# Weitere Benutzer ohne -c hinzufügen, damit die Datei nicht überschrieben wird:
#   htpasswd -B ./auth/registry.password weiterer-user
mkdir auth && htpasswd -Bc ./auth/registry.password docker
