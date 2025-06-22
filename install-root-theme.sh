#!/bin/bash

set -e
echo "📦 Instalando tema Root VPS..."

# Se quiser, descomente a linha abaixo se tiver o Pterodactyl instalado no /var/www/pterodactyl
# cd /var/www/pterodactyl

# Criar as pastas necessárias caso não existam
mkdir -p public/images
mkdir -p resources/css

# Baixar imagem de fundo
wget https://wallpapercave.com/wp/wp11054507.jpg -O public/images/bg-gamer.jpg

# Criar CSS personalizado
cat > resources/css/theme.css <<'EOL'
@tailwind base;
@tailwind components;
@tailwind utilities;

body {
    background: #0b0b0b url('/images/bg-gamer.jpg') no-repeat center center fixed;
    background-size: cover;
    font-family: 'Segoe UI', sans-serif;
}

a {
    color: #00ffe1;
}

.navbar {
    background-color: #121212 !important;
    border-bottom: 2px solid #00ffe1;
}

button {
    border-radius: 8px;
    background-color: #00ffe1;
    color: #000;
}

button:hover {
    background-color: #00bfa6;
}

h1, h2, h3, label {
    color: #00ffe1 !important;
}
EOL

# Instalar dependências (só funciona se for dentro do Pterodactyl mesmo)
if [ -f package.json ]; then
    npm install
    npm run build
else
    echo "⚠️ Aviso: Não foi encontrado o package.json (provavelmente você não está dentro da pasta do painel Pterodactyl)."
    echo "⚠️ Pulei a parte de npm install e build."
fi

# Limpar cache (também só se estiver dentro do Pterodactyl com Laravel)
if [ -f artisan ]; then
    php artisan view:clear
    php artisan config:clear
    php artisan cache:clear
else
    echo "⚠️ Aviso: Artisan não encontrado. Pulando limpeza de cache Laravel."
fi

echo "✅ Tema Root VPS aplicado com sucesso!"
