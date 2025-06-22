#!/bin/bash

set -e
echo "📦 Instalando tema Root VPS..."

cd /var/www/pterodactyl

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

# Instalar dependências
npm install
npm run build

# Limpar cache
php artisan view:clear
php artisan config:clear
php artisan cache:clear

echo "✅ Tema Root VPS aplicado com sucesso!"
