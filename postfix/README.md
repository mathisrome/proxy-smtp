# 📬 Benchmark Postfix – Multi-Environnement SMTP Relay

Ce benchmark a pour objectif d’évaluer la faisabilité, la complexité et les implications techniques de la mise en place de plusieurs instances Postfix sur une même machine ou dans un même conteneur, dans le cadre de relais SMTP multi-environnement.

## 🧭 Objectif

Mettre en place **un ou plusieurs environnements SMTP isolés** sur une même machine.

Dans notre exemple nous aurons 2 environnements :

- Un pour le projet `projets`
- Un autre pour le projet `saisie-temps`

Chaque environnement doit :

- Utiliser sa propre configuration Postfix (`main.cf`, `master.cf`)
- Relayer les emails via un SMTP distant spécifique (ex: Mailpit ou Mailcatcher)
- Être authentifié de manière indépendante

---

## ⚙️ Structure mise en place

- 📁 `/etc/postfix-apps/projets` : Configuration Postfix pour `projets`
- 📁 `/etc/postfix-apps/saisie-temps` : Configuration Postfix pour `saisie-temps`
- 📁 `~/.msmtprc` : Fichier de configuration SMTP client pour les tests
- 🐳 Docker / Supervisor : gestion multi-processus dans un conteneur

---

## ⚠️ Complexité de la configuration multi-environnement

Mettre en place **plusieurs instances de Postfix en parallèle** n’est **pas officiellement supporté de manière native** sans une configuration avancée. Cela implique :

- L’isolation complète de chaque instance :
    - `queue_directory`
    - `data_directory`
    - `pid_file`
    - `config_directory`
- La duplication de fichiers de configuration (`main.cf`, `master.cf`)
- La gestion des permissions et des sockets UNIX
- Le lancement via un gestionnaire multi-processus (`supervisord`, `s6`, etc.)

Il est **impossible de faire tourner plusieurs instances foreground (`start-fg`)** de Postfix simultanément, car une seule instance peut contrôler le système de messagerie local à la fois.

---

## 🔓 Nécessité d’ouvrir plusieurs ports

Chaque instance Postfix doit être accessible via un port distinct, faute de quoi il est impossible de les exposer séparément.

Exemple :

- `projets` : écoute sur `localhost:2525`
- `saisie-temps` : écoute sur `localhost:2626`

👉 **Il n’est pas possible de mutualiser un seul port (ex: 25)** pour plusieurs instances Postfix.

Cela implique que la machine hôte ou le conteneur :

- Doit avoir autant de ports disponibles que d’environnements
- Doit router le trafic SMTP entrant vers le bon port selon l’application source

---

## 🧪 Envoi de mails

L’envoi de mails peut être testé via `msmtp` ou un wrapper `sendmail`, par exemple :

```bash
echo "Test message" | msmtp -C .msmtp -a projets destination@example.com
echo "Test message" | msmtp -C .msmtp -a saisie-temps destination@example.com
```

🔚 Conclusion

La mise en place d’une architecture SMTP multi-environnement avec Postfix est :

Techniquement faisable, à condition de respecter un certain nombre de règles strictes d’isolation

Complexe à maintenir, surtout à grande échelle ou en environnement dynamique

Non conçue par défaut dans Postfix, qui s’attend à être le seul MTA actif sur la machine

Dépendante de l’ouverture de ports distincts : chaque environnement doit avoir un port dédié
