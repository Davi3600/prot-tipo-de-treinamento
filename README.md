# Landing page NEXFC

Landing page de conversão da NEXFC — sites de alta conversão e automação de
vendas. HTML/CSS/JS puro, sem framework, com a identidade visual oficial
(navy `#041435` amostrado da logo, tipografia DM Sans + Space Grotesk).

**Artifact publicado:** https://claude.ai/code/artifact/4779fbcb-9d26-4943-82a4-a47482c10e1f

## Estrutura

| Caminho | O que é |
|---|---|
| `site/index.html` | A landing page. **Fonte da verdade.** |
| `site/assets/*.jpg` | Imagens originais enviadas pelo cliente, sem edição. |
| `_build/build-artifact.sh` | Gera a versão autocontida (fontes e imagens em base64). |
| `_build/fonts/*.woff2` | Fontes usadas pelo build do artifact. |
| `_build/artifact.html` | Saída do script. Não editar à mão. |

`site/` é exatamente o que vai para o deploy (ex.: arrastar a pasta em
app.netlify.com/drop) — nada além disso.

## Build do artifact

```bash
bash _build/build-artifact.sh
```

Gera `_build/artifact.html` embutindo fontes e imagens como `data:` URIs
(a CSP do Artifact bloqueia CDNs e requisições externas).

## Responsividade

A página é mobile-first no comportamento: testada sem overflow horizontal em
320, 360, 390, 768 e 1440 px. Pontos de atenção ao editar:

- Grids de duas colunas usam `minmax(0, …)` — nunca `1fr` puro — para que
  conteúdo interno (ex.: texto com `white-space:nowrap`) não empurre a
  página além do viewport.
- Botões quebram linha no celular (`.btn { white-space:normal }` ≤640px);
  não recoloque `nowrap` em rótulos longos.
- Os `<br>` dos títulos são ritmo de desktop e somem ≤640px — por isso todo
  `<br>` de título tem um espaço antes (`… <br>`). Mantenha o espaço.
- Logo: os arquivos da marca são os JPEGs originais recortados por CSS com
  `mix-blend-mode:lighten`. Nenhuma seção pode ter fundo mais escuro que
  `#041435`, e o nav ganha fundo sólido quando o menu mobile abre
  (`.nav.menu-open`) para o recorte continuar invisível.

## Pendências antes de mostrar a cliente

1. **Trocar o conteúdo fictício** — cases, depoimentos, números do hero,
   nomes do marquee e a "garantia de entrega" são espaço reservado, não
   dados reais. Publicar isso como verdadeiro é problema sério (CDC/Conar).
2. **Número de WhatsApp** — `5511900000000` na constante `WHATSAPP_NUMERO`
   do script e nos links `wa.me` (rodapé e botão flutuante).
3. **E-mail e CNPJ** — `contato@nexfc.com.br` e `00.000.000/0001-00` no rodapé.
4. **Links de LinkedIn e YouTube** estão em `#`.
5. O multiplicador 3,4x da calculadora de ROI vem de estatística fictícia —
   precisa virar um número defensável.

As duas fotos da equipe são reais, enviadas pelo cliente — podem ficar.
