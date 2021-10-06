#!/bin/sh

# Para o deploy se algum comando falhar
set -e

printf "\033[0;32mGerando site...\033[0m\n"

# Construindo o site
hugo -t "m10c"

printf "\033[0;32mEnviando atualizações ao GitHub...\033[0m\n"
# Adicionando as atualizações ao repositório principal
git add .

msg="reconstruindo site $(date)"
if [ -n "$*" ]; then
	msg="$*"
fi

git commit -m "$msg" 
git push origin master

# Tornando as atualizações públicas no blog
cd public/
git add .
git commit -m "$msg"
git push origin main
