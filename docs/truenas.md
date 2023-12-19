
## TrueNAS Scale

### Disk Burnin

Bevor neue HDD-Festplatten in Betrieb genommen werden, ist es ratsam, diese "einzubrennen".
Die Idee dahinter ist, dass eine eingebrannte, unter Stress getestete HDD höchstwahrscheinlich
langfristig auch ohne Fehler laufen wird. Dieser Prozess dauert sehr lange. Grob kann man mit
einem Tag pro 2 TB Kapazität rechnen.

Zum Klonen des Repositorys:

  1. repo clonen: https://github.com/Spearfoot/disk-burnin-and-testing
  2. im checkout Verzeichnis:
  ```bash
  # am besten nach dem SSH Login tmux bzw. screen starten,
  # damit man die Session ohne SSH Logout wieder deattachen kann
  ./disk-burnin.sh -f sdX # per lsblk die richtigen device mappings zeigen
  ```
  3. täglich einloggen, Session wieder attachen und die Konsolenausgabe nach Fehlern durchsuchen

### Powertop

Mit Powertop unter TrueNAS werden die Stromsparzustände der Festplatten aktiviert.

In TrueNas under "System Settings -> Advanced"
  * add "Init/Shutdown Script" of type "Command"
  * als Command `powertop --auto-tune` eintragen und unter "When" PostInit auswählen

### Let's Encrypt Zertifikat

* Unter "Credentials -> Certificates" neuen "ACME DNS Authenticator" hinzufügen und `cloudflare` konfigurieren
* einen neuen "Certificate Signing Request" erstellen
* einen neuen "ACME Certificate" zu diesem CSR hinzufügen
* self-signed TrueNAS Zertifikat auf das neu erstellte Zertifikat ändern

### Virtual Machines und Apps
* Ubuntu mit Portainer hostet Gitea, in Zukunft vermutlich mehr
* MinIO als True Charts App

### Potenzielle Verbesserungen

- [ ] die TrueNAS Konfiguration auf Terraform migrieren
