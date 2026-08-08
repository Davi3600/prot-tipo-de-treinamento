#!/usr/bin/env bash
# Gera _build/artifact.html — a versão autocontida da landing page para
# publicar como Artifact (claude.ai) ou em qualquer host que bloqueie
# requisições externas.
#
# O que o script faz com site/index.html:
#   1. descarta o wrapper de documento (doctype/head/body) — o Artifact
#      recebe só o conteúdo;
#   2. troca o <link> do Google Fonts por @font-face com woff2 em base64
#      (a CSP do Artifact bloqueia CDNs);
#   3. embute as imagens de assets/ como data: URIs.
#
# site/index.html continua sendo a fonte da verdade. Não edite
# _build/artifact.html à mão.
set -euo pipefail
cd "$(dirname "$0")/.."

python3 - <<'PY'
import base64, re

def b64(caminho):
    return base64.b64encode(open(caminho, 'rb').read()).decode()

doc = open('site/index.html', encoding='utf-8').read()

titulo = re.search(r'<title>(.*?)</title>', doc, re.S).group(1)
css    = re.search(r'<style>\n(.*?)</style>', doc, re.S).group(1)
corpo  = re.search(r'<body>\n(.*?)\n</body>', doc, re.S).group(1)

fontfaces = (
    '@font-face{font-family:"DM Sans";font-style:normal;font-weight:100 1000;'
    'font-display:swap;src:url(data:font/woff2;base64,%s) format("woff2");}\n'
    '@font-face{font-family:"Space Grotesk";font-style:normal;font-weight:300 700;'
    'font-display:swap;src:url(data:font/woff2;base64,%s) format("woff2");}\n'
) % (b64('_build/fonts/dm-sans.woff2'), b64('_build/fonts/space-grotesk.woff2'))

imagens = {
    'assets/logo-simbolo.jpg': 'data:image/jpeg;base64,' + b64('site/assets/logo-simbolo.jpg'),
    'assets/logo-nome.jpg':    'data:image/jpeg;base64,' + b64('site/assets/logo-nome.jpg'),
    'assets/equipe-1.jpg':     'data:image/jpeg;base64,' + b64('site/assets/equipe-1.jpg'),
    'assets/equipe-2.jpg':     'data:image/jpeg;base64,' + b64('site/assets/equipe-2.jpg'),
}
for caminho, uri in imagens.items():
    css = css.replace(caminho, uri)
    corpo = corpo.replace(caminho, uri)

saida = f'<title>{titulo}</title>\n\n\n\n<style>\n{fontfaces}{css}</style>\n\n{corpo}\n'
open('_build/artifact.html', 'w', encoding='utf-8').write(saida)
print(f'_build/artifact.html gerado ({len(saida)} chars)')
PY
