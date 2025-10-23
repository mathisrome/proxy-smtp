#!/bin/bash

## Symfony CLI
curl -sS https://get.symfony.com/cli/installer | bash
mv /root/.symfony*/bin/symfony /usr/local/bin/symfony
symfony server:ca:install

## Phpcs
curl -OL https://squizlabs.github.io/PHP_CodeSniffer/phpcs.phar
mv phpcs.phar /usr/local/bin/phpcs
chmod +x /usr/local/bin/phpcs

## Phpcbf
curl -OL https://squizlabs.github.io/PHP_CodeSniffer/phpcbf.phar
mv phpcbf.phar /usr/local/bin/phpcbf
chmod +x /usr/local/bin/phpcbf

## Phpstan
curl -OL https://github.com/phpstan/phpstan/releases/download/2.1.27/phpstan.phar
mv phpstan.phar /usr/local/bin/phpstan
chmod +x /usr/local/bin/phpstan

## Grumphp
composer global config --no-plugins allow-plugins.phpro/grumphp true
composer global require phpro/grumphp

if [ "$(uname -m)" == "aarch64" ]
then
    echo "yes"
    curl -OL https://github.com/hadolint/hadolint/releases/latest/download/hadolint-$(uname -s)-arm64
    mv hadolint-$(uname -s)-arm64 /usr/local/bin/hadolint
else
    echo "no"
    curl -OL https://github.com/hadolint/hadolint/releases/latest/download/hadolint-$(uname -s)-$(uname -m)
    mv hadolint-$(uname -s)-$(uname -m) /usr/local/bin/hadolint
fi

chmod +x /usr/local/bin/hadolint