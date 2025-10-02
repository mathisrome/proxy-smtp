#!/bin/bash
set -e

# Amélioration possible, décrouvrir tous dossiers pour rendre automatique le postmap
postmap /etc/postfix-apps/projets/sasl_passwd
chmod 600 /etc/postfix-apps/projets/sasl_passwd*

postmap /etc/postfix-apps/saisie-temps/sasl_passwd
chmod 600 /etc/postfix-apps/saisie-temps/sasl_passwd*

# pour éviter l'érciture à la main du fichier, générer un script permetant d'écrire la configuration
supervisord -c /etc/supervisord.conf