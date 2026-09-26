# JD Sync — Guia de aplicação do design (temas Campo e Noite)

Este documento é autossuficiente: tem as regras, os tokens, o passo a passo e o CSS completo (no fim). Serve para uma pessoa ou para um assistente de código aplicar o design no repositório do JD Sync.

Prévia visual de referência: `soft-dark/preview.html` (abra no navegador; tem seletor de tema).

---

## 1. Escopo

**Muda:** só a camada visual (cores, tipografia, espaçamento, bordas, sombras, estados).
**Não muda:** estrutura HTML, lógica, dados, textos das funções.

Duas exceções, pequenas e necessárias:
1. Adicionar o atributo `data-sd-theme` no `<html>` (via JS, seção 6).
2. Adicionar um seletor de tema no app (Automático / Campo / Noite), por exemplo no Perfil.

---

## 2. Princípios (o que guia cada decisão)

1. **Campo é o tema de referência.** É claro, feito para uso sob sol, e vale sem nenhum atributo. Noite é o escuro quente para plantão e desarme noturno.
2. **Cor com significado único.** Verde = meta batida. Âmbar = atenção. Coral/terracota = problema. Azul = ação e item ativo. A marca **não** usa verde.
3. **Nada de branco puro no Noite, nada de cinza fraco no Campo.** No Campo todo texto fica ≥ 7:1; no Noite, ≥ 4,5:1.
4. **Toque para luva:** tudo que se toca tem no mínimo 44 px, e o padrão é 48 px.
5. **Todo componente tocável responde:** hover, pressionado, desabilitado, carregando, foco visível.
6. **Títulos em caixa normal.** Remover maiúsculas com letra espaçada ("IMPORTAR ARQUIVOS" → "Importar arquivos").
7. **Simbologia é dado, não tema.** A legenda e a camada do mapa leem os mesmos tokens.
8. **Um único botão primário por tela.** O restante é ghost (contorno).

---

## 3. Tokens

Todos os valores já estão no CSS da seção 10. Esta tabela é a referência humana.

### 3.1 Cores

| Token | Campo (padrão) | Noite | Uso |
|---|---|---|---|
| `--sd-bg` | `#E9E5DD` | `#1A1917` | Fundo da tela |
| `--sd-surface` | `#FDFCFA` | `#2A2825` | Cards, cabeçalho, nav inferior |
| `--sd-surface-2` | `#F2EFE9` | `#33302C` | Campos, busca, hover |
| `--sd-surface-3` | `#E3DED5` | `#3D3A35` | Pressionado, trilho de barra |
| `--sd-text` | `#1A1814` (17:1) | `#E8E3DA` | Texto principal |
| `--sd-text-2` | `#3B3731` (11:1) | `#BDB6AB` | Texto secundário |
| `--sd-text-3` | `#5A544B` (7:1) | `#A39C91` (≥4,5:1) | Legendas, placeholder |
| `--sd-accent` | `#1D559C` | `#8DB1DB` | Texto/ícone de destaque, indicador de aba |
| `--sd-accent-fill` | `#1D559C` | `#3D6496` | Fundo do botão primário |
| `--sd-on-accent` | `#FFFFFF` | `#F4F1EC` | Texto sobre botão primário |
| `--sd-success` | `#125F41` | `#56B28C` | Meta batida |
| `--sd-warning` | `#744B00` | `#D9AB55` | Até 5 pts abaixo da meta |
| `--sd-danger` | `#9A321B` | `#E48369` | Mais de 5 pts abaixo / erro |
| `--sd-sym-green` | `#2E8F66` | `#56B28C` | Símbolo verde no mapa e na legenda |
| `--sd-sym-amber` | `#A8740F` | `#D9AB55` | Símbolo âmbar no mapa e na legenda |
| `--sd-sym-blue` | `#2F6FB8` | `#8DB1DB` | Símbolo azul no mapa e na legenda |

Cada cor de status tem uma versão `-soft` (fundo tingido de pílulas e chips).

Contrastes calculados pela fórmula WCAG sobre `--sd-surface`. **Não foram medidos em tela real.**

### 3.2 Forma, tipografia e toque

| Token | Valor | Uso |
|---|---|---|
| `--sd-r-field` | 6 px | Campos, busca, checkbox |
| `--sd-r-btn` | 10 px | Botões |
| `--sd-r-card` | 14 px | Cards, mapa |
| `--sd-r-pill` | 999 px | Chips e pílulas |
| `--sd-tap` | 48 px | Altura mínima de controle |
| `--sd-fs-xs / sm / md / lg / xl` | 12 / 14 / 16 / 20 / 32 px | Únicos tamanhos de fonte permitidos |
| `--sd-font` | IBM Plex Sans | Interface |
| `--sd-mono` | IBM Plex Mono | Códigos (CDA-01M6) e contagens |

Fonte (Google Fonts):
```html
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=IBM+Plex+Mono:wght@400;500&family=IBM+Plex+Sans:wght@400;500;600;700&display=swap">
```
Se o app precisa funcionar offline, baixe as fontes e sirva localmente (`@font-face`). Senão, em campo sem sinal, cai na fonte do sistema.

### 3.3 Diferenças de comportamento entre temas (também são tokens)

| Token | Campo | Noite | Por quê |
|---|---|---|---|
| `--sd-state-outline` | contorno 1 px na cor do estado | nenhum | No sol o fundo tingido some; o contorno não |
| `--sd-card-border` | borda forte | borda sutil | No sol a sombra não aparece |
| `--sd-indicator` | 3 px | 2 px | Indicador de aba visível sob reflexo |
| `--sd-value-weight` | 700 | 600 | Números grandes legíveis no sol |
| `--sd-tab-active-weight` | 600 | 500 | Aba ativa distinguível sem depender só da cor |

**Regra:** nenhum componente pode ter estilo diferente por tema fora dos tokens. Se precisar, crie um token.

---

## 4. Passo a passo de aplicação

### Passo 1 — Levantar as cores atuais
Rode na raiz do projeto do JD Sync:
```bash
grep -rnoE "#[0-9a-fA-F]{3,8}\b|rgba?\([^)]*\)" --include=*.css --include=*.scss --include=*.html --include=*.js --include=*.jsx --include=*.ts --include=*.tsx . | grep -v node_modules
```
Isso lista todas as cores fixas. Cada uma tem que virar um token.

### Passo 2 — Adicionar o CSS de temas
Copie o CSS da seção 10 para `jd-sync-temas.css` e carregue-o **antes** do CSS do app.

### Passo 3 — Trocar cores fixas por tokens
Use a tabela abaixo. Os valores "atuais" foram estimados a partir de um print da tela; confira no resultado do Passo 1.

| O que existe hoje (aprox.) | Onde | Troca por |
|---|---|---|
| Azul-marinho escuro (~`#0F1A2B`, `#13284A`) | Fundo, cabeçalho | `--sd-bg`, `--sd-surface` |
| Azul-marinho um pouco mais claro | Cards, botões secundários | `--sd-surface` / `--sd-surface-2` |
| Branco puro `#FFF` em texto | Textos | `--sd-text` |
| Cinza-azulado em texto | Rótulos, títulos de seção | `--sd-text-2` / `--sd-text-3` |
| Verde neon (~`#22C55E`) em botão | "Importar KML" | `--sd-accent-fill` (botão primário vira azul) |
| Verde neon no logo e no "SYNC" | Marca | `--sd-text` (marca neutra) |
| Verde neon no "ONLINE" | Status | classe `sd-sync--online` |
| Verde neon no indicador da aba | Abas | `--sd-accent` com `--sd-indicator` |
| Azul vivo (~`#3B82F6`) em texto | "Reconectar…" | `--sd-accent` |
| Vermelho vivo | Alertas | `--sd-danger` |
| Bordas azuis 1–2 px | Cards, botões | `--sd-border` / `--sd-card-border` |

### Passo 4 — Mapear classes
As classes do CSS de referência começam com `sd-`. Há dois caminhos:
- **(Recomendado)** Manter as classes do app e copiar as **declarações** de cada regra `sd-*` para o seletor equivalente do app.
- Adicionar as classes `sd-*` ao HTML existente. Isso é mudança pequena de HTML; só faça se o time aceitar.

| Componente no JD Sync | Classe de referência |
|---|---|
| Container geral do app | `.sd-app` |
| Cabeçalho (logo, código, avatar, status, busca) | `.sd-header`, `.sd-header__row`, `.sd-brand*`, `.sd-chip`, `.sd-chip--code`, `.sd-avatar` |
| Indicador ONLINE | `.sd-chip.sd-sync.sd-sync--online` |
| Campo "Busca" | `.sd-search` |
| Mapa e botões redondos sobre ele | `.sd-map`, `.sd-map__fab`, `.sd-map__attr` |
| Abas Leitura / Edição / Redes / Manobras / Desarmes | `.sd-tabs`, `.sd-tab[aria-selected]` |
| Título de seção ("Importar arquivos", "Simbologia") | `.sd-section__title` |
| "Importar KML / KMZ / GPX" | `.sd-btn.sd-btn--primary` |
| "Importar pasta inteira", "Enquadrar rede", "Reabrir este turno" | `.sd-btn.sd-btn--ghost` |
| "Reconectar para gravar no original" | `.sd-btn.sd-btn--ghost.sd-btn--ghost-accent` |
| Checkbox "Gravar edições…" | `.sd-check` |
| Botões "todos" / olho | `.sd-icon-btn` |
| Lista da Simbologia | `.sd-legend`, `.sd-legend__row`, `.is-active`, `.is-hidden`, `.sd-legend__count`, `.sd-legend__eye` |
| Cards de métrica (EGE, Utilização…) | `.sd-card.sd-metric.sd-metric--ok / --warn / --bad` |
| Pílula de variação (+4 pts) | `.sd-pill.sd-pill--ok / --warn / --bad / --neutral` |
| Navegação inferior | `.sd-bottomnav`, `.sd-bottomnav__item[aria-current="page"]` |

### Passo 5 — Tema e seletor (seção 6)
### Passo 6 — Mapa base e simbologia (seção 7)
### Passo 7 — Revisar com o checklist (seção 9)

---

## 5. Regras por componente

**Cabeçalho**
- Fundo `--sd-surface`, borda inferior `--sd-border`. Sem gradiente, sem brilho.
- Logo: ícone em quadrado `--sd-surface-3`, cor `--sd-text`. Nome "JD Sync" em peso 600, sem verde.
- Código da equipe em `--sd-mono`.
- Se não couber numa linha em 360 px: linha 1 = marca + status + avatar; linha 2 = busca + código.

**Busca**
- Altura 48 px, fundo `--sd-surface-2`, raio 6 px. Com foco, a borda vira `--sd-accent`.
- Placeholder específico: "Buscar poste ou trafo" (não "Busca").

**Status de sincronização** — o estado mais importante do app. Cinco variantes:
| Estado | Classe | Cor |
|---|---|---|
| Online | `sd-sync--online` | verde |
| Sincronizando | `sd-sync--syncing` | azul, com spinner |
| N edições pendentes | `sd-sync--pending` | âmbar (mostrar o número) |
| Offline | `sd-sync--offline` | neutro, bolinha vazada |
| Falha ao enviar | `sd-sync--error` | coral |

**Abas**
- Inativa: `--sd-text-3`. Ativa: `--sd-text` e indicador de 2–3 px, arredondado, em `--sd-accent`.
- Proibido: indicador verde grosso, fundo destacado na aba ativa.

**Botões**
- Um primário por tela (`--sd-accent-fill`). O resto é ghost: fundo transparente, borda `--sd-border-strong`; no hover o fundo vira `--sd-surface-2`.
- Pressionado: `transform: scale(.98)`. Desabilitado: borda tracejada, texto `--sd-text-3`. Carregando: spinner no lugar do texto, largura mantida.

**Cards de métrica**
- Fundo `--sd-surface`, borda `--sd-card-border`, raio 14 px, sombra `--sd-shadow-1`.
- Número em 32 px, `tabular-nums`, na cor do nível. Barra de 4 px com marcador da meta.
- Nível de status (lógica visual, não de negócio):
  - `ok` → valor ≥ meta
  - `warn` → abaixo da meta em até 5 pts
  - `bad` → mais de 5 pts abaixo
  - Para métricas em que **menor é melhor**, inverta a comparação.
- Confirme o limite de 5 pts com a operação. É uma sugestão, não uma regra da concessionária.

**Simbologia**
- Linhas com 48 px de altura, separadas por borda fina. Contagem em mono, alinhada à direita.
- Camada oculta: `.is-hidden` (texto `--sd-text-3`, ícone a 35%, olho cortado).

**Navegação inferior**
- Fundo `--sd-surface`, borda superior `--sd-border`. Item ativo: ícone em `--sd-accent` e traço de 24 px no topo.

---

## 6. Troca de tema

Coloque no `<head>`, **antes** do CSS, para não piscar o tema errado ao abrir:
```html
<script>
(function () {
  var mq = window.matchMedia('(prefers-color-scheme: dark)');
  function aplicarTema() {
    var escolha = 'auto';
    try { escolha = localStorage.getItem('jd-tema') || 'auto'; } catch (e) {}
    var tema = escolha === 'auto' ? (mq.matches ? 'noite' : 'campo') : escolha;
    document.documentElement.dataset.sdTheme = tema;
    document.dispatchEvent(new CustomEvent('jd-tema', { detail: tema }));
  }
  window.jdDefinirTema = function (escolha) { // 'auto' | 'campo' | 'noite'
    try { localStorage.setItem('jd-tema', escolha); } catch (e) {}
    aplicarTema();
  };
  mq.addEventListener('change', aplicarTema);
  aplicarTema();
})();
</script>
```
- No seletor do app, chame `jdDefinirTema('auto' | 'campo' | 'noite')`.
- O evento `jd-tema` serve para trocar o mapa base (seção 7).
- Automático segue o sistema. No Android, o modo escuro pode ser agendado para o pôr do sol.

---

## 7. Mapa base e simbologia

Sem trocar o mapa, o tema Noite fica com um bloco branco no meio da tela. Duas opções:

**Opção A — filtro CSS nos tiles (gratuita, sem chave).** Supondo Leaflet; ajuste o seletor se for outra biblioteca:
```css
[data-sd-theme="noite"] .leaflet-tile-pane {
  filter: invert(1) hue-rotate(180deg) brightness(0.85) contrast(0.9) sepia(0.15);
}
```
Afeta só os tiles; marcadores e vetores ficam intactos. O resultado é aceitável, mas os tons não são controlados.

**Opção B — trocar a camada (melhor visual).** Por exemplo, CARTO `light_all` no Campo e `dark_all` na Noite:
```js
// Leaflet
var campo = L.tileLayer('https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}.png', { attribution: '© OpenStreetMap © CARTO' });
var noite = L.tileLayer('https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}.png',  { attribution: '© OpenStreetMap © CARTO' });
document.addEventListener('jd-tema', function (e) {
  var nova = e.detail === 'noite' ? noite : campo, velha = e.detail === 'noite' ? campo : noite;
  if (map.hasLayer(velha)) map.removeLayer(velha);
  if (!map.hasLayer(nova)) nova.addTo(map);
});
```
**Atenção:** os basemaps da CARTO exigem chave de API e têm limite de uso gratuito, com plano pago para uso comercial acima do limite. Leia os termos atuais antes: https://carto.com/legal/basemap-terms/ e https://docs.carto.com/faqs/carto-basemaps. Mantenha a atribuição do OSM, da CARTO e do IBGE visível.

**Simbologia:** os símbolos do mapa (triângulos dos transformadores etc.) têm que ler os mesmos tokens da legenda:
```js
function cor(token) { return getComputedStyle(document.documentElement).getPropertyValue(token).trim(); }
// ex.: fillColor: cor('--sd-sym-green')
// Ao receber o evento 'jd-tema', redesenhe/atualize o estilo das camadas.
```
Se o mapa usa ícones SVG, use `fill: var(--sd-sym-green)` diretamente.

---

## 8. O que NÃO fazer

- Não usar verde para marca, botão ou aba. Verde é só meta batida e símbolo de mapa.
- Não usar maiúsculas com espaçamento nos títulos.
- Não colocar cor fixa em componente; sempre token.
- Não deixar dois botões primários na mesma tela.
- Não usar controle menor que 44 px.
- Não diferenciar status só pela cor: o texto (+4 pts, "3 pendentes") tem que dizer o mesmo.
- Não criar tamanho de fonte fora da escala 12/14/16/20/32.
- Não copiar o tema Noite como `:root`. O Campo é o padrão.

---

## 9. Checklist de aceitação

- [ ] `grep` do Passo 1 não retorna cores fixas fora do arquivo de temas (exceto os ícones de terceiros).
- [ ] App abre no Campo com o sistema claro e na Noite com o sistema escuro.
- [ ] Escolha manual no seletor sobrevive a fechar e abrir o app.
- [ ] Sem flash do tema errado ao abrir.
- [ ] Mapa base troca junto com o tema.
- [ ] Legenda e símbolos do mapa têm a mesma cor nos dois temas.
- [ ] Os cinco estados de sincronização aparecem corretamente.
- [ ] Todo controle tem ≥ 44 px (DevTools → inspecionar).
- [ ] Foco por teclado visível em todos os controles.
- [ ] Nada estoura a largura em 360 px.
- [ ] **Teste real:** Campo ao ar livre, ao meio-dia, brilho no máximo. Noite dentro do veículo, à noite. Se algum texto sumir, escureça (Campo) ou clareie (Noite) o token `--sd-text-3` primeiro.

---

## 10. CSS completo

Arquivo `jd-sync-temas.css`. As classes `sd-*` são a referência; mapeie para as do app (Passo 4).

```css
/* ==========================================================================
   JD Sync — temas "Campo" (padrão, claro) e "Noite" (escuro)
   Camada visual apenas. Os seletores de componente usam as classes da prévia
   (soft-dark/preview.html); para aplicar no app real, mapeie-os para as
   classes existentes ou troque apenas os tokens.

   Campo é o tema de referência: é o que vale sem nenhum atributo.
   Noite liga com data-sd-theme="noite" no <html> (ou em .sd-app).

   Modo automático recomendado — segue o sistema, que no Android pode
   escurecer no pôr do sol. A escolha manual do usuário tem prioridade:
     const mq = matchMedia('(prefers-color-scheme: dark)');
     function aplicarTema() {
       const escolha = localStorage.getItem('jd-tema') || 'auto'; // 'auto' | 'campo' | 'noite'
       const tema = escolha === 'auto' ? (mq.matches ? 'noite' : 'campo') : escolha;
       document.documentElement.dataset.sdTheme = tema;
     }
     mq.addEventListener('change', aplicarTema); aplicarTema();
   ========================================================================== */

/* ==========================================================================
   Campo — claro, para uso sob sol
   Sob luz direta o reflexo apaga sombras, tons sutis e cinzas médios.
   Então: texto ≥ 7:1, bordas visíveis no lugar de sombra, estados com
   contorno além da cor de fundo e indicadores mais grossos.
   ========================================================================== */
:root,
[data-sd-theme="campo"] {
  color-scheme: light;

  /* Superfícies */
  --sd-bg:          #e9e5dd;
  --sd-surface:     #fdfcfa;
  --sd-surface-2:   #f2efe9;
  --sd-surface-3:   #e3ded5;
  --sd-border:        rgba(45, 35, 20, 0.16);
  --sd-border-strong: rgba(45, 35, 20, 0.30);
  --sd-card-border:   var(--sd-border-strong);

  /* Texto */
  --sd-text:   #1a1814;  /* 17:1 no card */
  --sd-text-2: #3b3731;  /* 11:1 */
  --sd-text-3: #5a544b;  /* 7:1 */

  /* Destaque */
  --sd-accent:            #1d559c;
  --sd-accent-fill:       #1d559c;
  --sd-accent-fill-hover: #184a88;
  --sd-accent-soft:       rgba(29, 85, 156, 0.12);
  --sd-on-accent:         #ffffff;

  /* Status em três níveis — nenhum deles é a cor da marca */
  --sd-success:      #125f41;  /* meta batida */
  --sd-success-soft: rgba(18, 95, 65, 0.12);
  --sd-warning:      #744b00;  /* até 5 pts abaixo da meta */
  --sd-warning-soft: rgba(168, 116, 15, 0.16);
  --sd-danger:       #9a321b;  /* mais de 5 pts abaixo */
  --sd-danger-soft:  rgba(154, 50, 27, 0.12);
  --sd-state-outline: inset 0 0 0 1px currentColor;

  /* Camadas sobre o mapa */
  --sd-overlay:   rgba(253, 252, 250, 0.96);
  --sd-overlay-2: rgba(253, 252, 250, 0.9);

  /* Simbologia do mapa — é dado, não tema: a camada do mapa tem que ler
     estes mesmos tokens. Ajustados por tema só para manter 3:1 sobre a base. */
  --sd-sym-green: #2e8f66;
  --sd-sym-amber: #a8740f;
  --sd-sym-blue:  #2f6fb8;

  /* Espessuras */
  --sd-indicator: 3px;
  --sd-value-weight: 700;
  --sd-tab-active-weight: 600;

  /* Profundidade */
  --sd-shadow-1: 0 1px 2px rgba(45, 35, 20, 0.10);
  --sd-shadow-2: 0 1px 3px rgba(45, 35, 20, 0.14), 0 6px 16px rgba(45, 35, 20, 0.10);
  --sd-inner-hl: inset 0 0 0 0 transparent;

  /* Comuns aos dois temas */
  --sd-r-field: 6px;
  --sd-r-btn:   10px;
  --sd-r-card:  14px;
  --sd-r-pill:  999px;
  --sd-tap: 48px;           /* uso com luva ou em movimento */
  --sd-fs-xs: 12px;
  --sd-fs-sm: 14px;
  --sd-fs-md: 16px;
  --sd-fs-lg: 20px;
  --sd-fs-xl: 32px;
  --sd-ease: cubic-bezier(0.2, 0.7, 0.2, 1);
  --sd-font: "IBM Plex Sans", system-ui, -apple-system, "Segoe UI", Roboto, sans-serif;
  --sd-mono: "IBM Plex Mono", ui-monospace, "SFMono-Regular", Menlo, monospace;
}

/* ==========================================================================
   Noite — escuro quente, para plantão e atendimento noturno
   Brilho baixo para não ofuscar dentro da cabine. Profundidade vem da
   superfície clarear a cada nível; a sombra é só apoio.
   ========================================================================== */
[data-sd-theme="noite"] {
  color-scheme: dark;

  --sd-bg:          #1a1917;
  --sd-surface:     #2a2825;
  --sd-surface-2:   #33302c;
  --sd-surface-3:   #3d3a35;
  --sd-border:        rgba(255, 244, 228, 0.08);
  --sd-border-strong: rgba(255, 244, 228, 0.14);
  --sd-card-border:   var(--sd-border);

  --sd-text:   #e8e3da;
  --sd-text-2: #bdb6ab;
  --sd-text-3: #a39c91;  /* ≥ 4.5:1 até --sd-surface-2 */

  --sd-accent:            #8db1db;
  --sd-accent-fill:       #3d6496;
  --sd-accent-fill-hover: #46709f;
  --sd-accent-soft:       rgba(141, 177, 219, 0.14);
  --sd-on-accent:         #f4f1ec;

  --sd-success:      #56b28c;
  --sd-success-soft: rgba(86, 178, 140, 0.15);
  --sd-warning:      #d9ab55;
  --sd-warning-soft: rgba(217, 171, 85, 0.15);
  --sd-danger:       #e48369;
  --sd-danger-soft:  rgba(228, 131, 105, 0.15);
  --sd-state-outline: none;

  --sd-overlay:   rgba(42, 40, 37, 0.9);
  --sd-overlay-2: rgba(26, 25, 23, 0.78);

  --sd-sym-green: #56b28c;
  --sd-sym-amber: #d9ab55;
  --sd-sym-blue:  #8db1db;

  --sd-indicator: 2px;
  --sd-value-weight: 600;
  --sd-tab-active-weight: 500;

  --sd-shadow-1: 0 1px 2px rgba(0, 0, 0, 0.30);
  --sd-shadow-2: 0 2px 6px rgba(0, 0, 0, 0.28), 0 12px 28px rgba(0, 0, 0, 0.30);
  --sd-inner-hl: inset 0 1px 0 rgba(255, 244, 228, 0.05);
}

/* ---------- Base ---------- */
.sd-app {
  background: var(--sd-bg);
  color: var(--sd-text);
  font-family: var(--sd-font);
  font-size: var(--sd-fs-md);
  line-height: 1.45;
  -webkit-font-smoothing: antialiased;
  -webkit-tap-highlight-color: transparent;
}
.sd-app :focus-visible {
  outline: 2px solid var(--sd-accent);
  outline-offset: 2px;
}

/* ---------- Cabeçalho ---------- */
.sd-header {
  background: var(--sd-surface);
  border-bottom: 1px solid var(--sd-border);
  padding: 12px 16px;
  display: grid;
  gap: 12px;
}
.sd-header__row { display: flex; align-items: center; gap: 8px; }
.sd-brand { display: flex; align-items: center; gap: 10px; min-width: 0; }
.sd-brand__mark {
  width: 36px; height: 36px; border-radius: var(--sd-r-btn);
  display: grid; place-items: center;
  background: var(--sd-surface-3);
  color: var(--sd-text);
  box-shadow: var(--sd-inner-hl);
}
.sd-brand__name { font-weight: 600; font-size: var(--sd-fs-md); letter-spacing: -0.01em; }
.sd-brand > div { min-width: 0; }
.sd-brand__name, .sd-brand__by { white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
.sd-brand__by { font-size: var(--sd-fs-xs); color: var(--sd-text-3); }

.sd-chip {
  flex: none;
  display: inline-flex; align-items: center; gap: 6px;
  height: 32px; padding: 0 12px;
  border-radius: var(--sd-r-pill);
  background: var(--sd-surface-2);
  border: 1px solid var(--sd-border);
  color: var(--sd-text-2);
  font-size: var(--sd-fs-xs); font-weight: 500;
  white-space: nowrap;
}
.sd-chip--code { font-family: var(--sd-mono); color: var(--sd-text); }
.sd-avatar {
  flex: none;
  width: 32px; height: 32px; border-radius: 50%;
  display: grid; place-items: center;
  background: var(--sd-surface-3); color: var(--sd-text);
  font-size: var(--sd-fs-xs); font-weight: 600;
}

/* ---------- Estado de sincronização ---------- */
.sd-sync { border-color: transparent; box-shadow: var(--sd-state-outline); }
.sd-sync::before {
  content: ""; width: 7px; height: 7px; border-radius: 50%;
  background: currentColor; flex: none;
}
.sd-sync--online  { color: var(--sd-success); background: var(--sd-success-soft); }
.sd-sync--pending { color: var(--sd-warning); background: var(--sd-warning-soft); }
.sd-sync--offline { color: var(--sd-text-2);  background: var(--sd-surface-3); }
.sd-sync--offline::before { background: none; box-shadow: inset 0 0 0 1.5px currentColor; }
.sd-sync--syncing { color: var(--sd-accent);  background: var(--sd-accent-soft); }
.sd-sync--syncing::before {
  width: 10px; height: 10px; background: none;
  border: 2px solid currentColor; border-right-color: transparent;
  animation: sd-spin 0.9s linear infinite;
}
.sd-sync--error   { color: var(--sd-danger);  background: var(--sd-danger-soft); }

/* ---------- Busca ---------- */
.sd-search {
  display: flex; align-items: center; gap: 10px; min-width: 0;
  height: var(--sd-tap); padding: 0 14px;
  background: var(--sd-surface-2);
  border: 1px solid var(--sd-border);
  border-radius: var(--sd-r-field);
  box-shadow: var(--sd-inner-hl);
  color: var(--sd-text-3);
  transition: border-color .2s var(--sd-ease), background .2s var(--sd-ease);
}
.sd-search:focus-within { border-color: var(--sd-accent); }
.sd-search input {
  flex: 1; min-width: 0; border: 0; outline: 0; background: none;
  color: var(--sd-text); font: inherit; font-size: var(--sd-fs-md);
}
.sd-search input::placeholder { color: var(--sd-text-3); }

/* ---------- Mapa ---------- */
.sd-map {
  position: relative;
  border-radius: var(--sd-r-card);
  overflow: hidden;
  box-shadow: var(--sd-shadow-2);
  border: 1px solid var(--sd-card-border);
}
.sd-map__fab {
  position: absolute; right: 8px;
  width: 44px; height: 44px; border-radius: 50%;
  display: grid; place-items: center;
  background: var(--sd-overlay);
  backdrop-filter: blur(6px);
  border: 1px solid var(--sd-border-strong);
  color: var(--sd-text);
  box-shadow: var(--sd-shadow-1);
  cursor: pointer;
  transition: transform .12s var(--sd-ease), background .12s var(--sd-ease);
}
.sd-map__fab:active { transform: scale(.94); background: var(--sd-surface-3); }
.sd-map__attr {
  position: absolute; left: 8px; bottom: 8px; right: 60px;
  font-size: 10px; color: var(--sd-text-3);
  background: var(--sd-overlay-2);
  padding: 3px 8px; border-radius: var(--sd-r-field);
}

/* ---------- Abas ---------- */
.sd-tabs {
  display: flex; gap: 2px;
  overflow-x: auto; scrollbar-width: none;
  background: var(--sd-bg);
  border-bottom: 1px solid var(--sd-border);
  padding: 0 8px;
}
.sd-tab {
  position: relative; flex: none;
  display: inline-flex; align-items: center; gap: 6px;
  height: var(--sd-tap); padding: 0 12px;
  border: 0; background: none;
  color: var(--sd-text-3); font: inherit; font-size: var(--sd-fs-sm); font-weight: 500;
  cursor: pointer;
  transition: color .2s var(--sd-ease);
}
.sd-tab:hover { color: var(--sd-text-2); }
.sd-tab[aria-selected="true"] { color: var(--sd-text); font-weight: var(--sd-tab-active-weight); }
.sd-tab[aria-selected="true"]::after {
  content: ""; position: absolute; left: 12px; right: 12px; bottom: -1px;
  height: var(--sd-indicator); border-radius: 2px;
  background: var(--sd-accent);
}

/* ---------- Seções e cards ---------- */
.sd-section { display: grid; gap: 8px; }
.sd-section__title {
  font-size: var(--sd-fs-sm); font-weight: 600; color: var(--sd-text-2);
  margin: 0;
}
.sd-card {
  background: var(--sd-surface);
  border: 1px solid var(--sd-card-border);
  border-radius: var(--sd-r-card);
  box-shadow: var(--sd-shadow-1), var(--sd-inner-hl);
  padding: 16px;
}

/* ---------- Botões ---------- */
.sd-btn {
  position: relative;
  display: inline-flex; align-items: center; justify-content: center; gap: 8px;
  width: 100%; min-height: var(--sd-tap); padding: 0 16px;
  border-radius: var(--sd-r-btn);
  font: inherit; font-size: var(--sd-fs-sm); font-weight: 500;
  cursor: pointer;
  transition: background .18s var(--sd-ease), border-color .18s var(--sd-ease),
              color .18s var(--sd-ease), transform .12s var(--sd-ease);
}
.sd-btn:active:not([disabled]) { transform: scale(.98); }
.sd-btn--primary {
  background: var(--sd-accent-fill); color: var(--sd-on-accent);
  border: 1px solid transparent;
  box-shadow: var(--sd-shadow-1), inset 0 1px 0 rgba(255, 255, 255, 0.08);
}
.sd-btn--primary:hover { background: var(--sd-accent-fill-hover); }
.sd-btn--ghost {
  background: transparent; color: var(--sd-text);
  border: 1px solid var(--sd-border-strong);
}
.sd-btn--ghost:hover { background: var(--sd-surface-2); }
.sd-btn--ghost:active:not([disabled]) { background: var(--sd-surface-3); }
.sd-btn--ghost-accent { color: var(--sd-accent); }
.sd-btn[disabled] {
  cursor: not-allowed;
  background: transparent; color: var(--sd-text-3);
  border: 1px dashed var(--sd-border-strong); box-shadow: none;
}
.sd-btn.is-loading { color: transparent; pointer-events: none; }
.sd-btn.is-loading::after {
  content: ""; position: absolute; width: 18px; height: 18px; border-radius: 50%;
  border: 2px solid var(--sd-on-accent); border-right-color: transparent;
  animation: sd-spin 0.9s linear infinite;
}
.sd-btn.is-loading > * { visibility: hidden; }

.sd-check {
  display: flex; align-items: center; gap: 12px;
  min-height: var(--sd-tap);
  color: var(--sd-text-2); font-size: var(--sd-fs-sm);
  cursor: pointer;
}
.sd-check input {
  appearance: none; flex: none; margin: 0;
  width: 22px; height: 22px; border-radius: var(--sd-r-field);
  border: 1.5px solid var(--sd-text-3); background: var(--sd-surface-2);
  display: grid; place-items: center;
  transition: background .15s var(--sd-ease), border-color .15s var(--sd-ease);
}
.sd-check input::after {
  content: ""; width: 10px; height: 6px; margin-top: -2px;
  border: solid var(--sd-on-accent); border-width: 0 0 2px 2px;
  transform: rotate(-45deg) scale(0); transition: transform .15s var(--sd-ease);
}
.sd-check input:checked { background: var(--sd-accent-fill); border-color: var(--sd-accent-fill); }
.sd-check input:checked::after { transform: rotate(-45deg) scale(1); }

/* ---------- Botão compacto (ícone + rótulo) ---------- */
.sd-icon-btn {
  min-width: 44px; height: 44px; padding: 0 12px;
  display: inline-flex; align-items: center; justify-content: center; gap: 6px;
  border-radius: var(--sd-r-btn);
  border: 1px solid var(--sd-border-strong); background: none;
  color: var(--sd-text-2); font: inherit; font-size: var(--sd-fs-xs);
  cursor: pointer;
  transition: background .15s var(--sd-ease), transform .12s var(--sd-ease);
}
.sd-icon-btn:hover { background: var(--sd-surface-2); }
.sd-icon-btn:active { transform: scale(.96); background: var(--sd-surface-3); }

/* ---------- Simbologia ---------- */
.sd-legend { display: grid; }
.sd-legend__row {
  display: grid; grid-template-columns: 22px 1fr auto 44px; align-items: center; gap: 10px;
  min-height: var(--sd-tap); padding: 0 0 0 10px; border-radius: var(--sd-r-btn);
  font-size: var(--sd-fs-sm); color: var(--sd-text);
  cursor: pointer;
}
.sd-legend__row + .sd-legend__row { border-top: 1px solid var(--sd-border); }
.sd-legend__row:hover { background: var(--sd-surface-2); }
.sd-legend__row.is-active { background: var(--sd-accent-soft); border-color: transparent; }
.sd-legend__row.is-active + .sd-legend__row { border-color: transparent; }
.sd-legend__row.is-hidden { color: var(--sd-text-3); }
.sd-legend__row.is-hidden svg:first-child { opacity: .35; }
.sd-legend__count {
  font-family: var(--sd-mono); font-size: var(--sd-fs-xs); color: var(--sd-text-3);
  font-variant-numeric: tabular-nums; text-align: right;
}
.sd-legend__eye { color: var(--sd-text-3); display: grid; place-items: center; height: var(--sd-tap); }

/* ---------- Métricas ---------- */
.sd-metrics { display: grid; grid-template-columns: 1fr 1fr; gap: 10px; }
.sd-metric { display: grid; gap: 8px; padding: 14px; }
.sd-metric__label { font-size: var(--sd-fs-xs); font-weight: 500; color: var(--sd-text-2); }
.sd-metric__value {
  font-size: var(--sd-fs-xl); font-weight: var(--sd-value-weight); line-height: 1; letter-spacing: -0.02em;
  font-variant-numeric: tabular-nums;
}
.sd-metric__value small { font-size: var(--sd-fs-md); font-weight: 500; margin-left: 1px; }
.sd-metric__meta { display: flex; align-items: center; gap: 6px; flex-wrap: wrap; font-size: var(--sd-fs-xs); color: var(--sd-text-3); }
.sd-bar { position: relative; height: 4px; border-radius: 4px; background: var(--sd-surface-3); }
.sd-bar > i { position: absolute; inset: 0 auto 0 0; border-radius: inherit; }
.sd-bar > b { position: absolute; top: -3px; width: 2px; height: 10px; border-radius: 1px; background: var(--sd-text-2); }
.sd-metric--ok   .sd-metric__value { color: var(--sd-success); }
.sd-metric--warn .sd-metric__value { color: var(--sd-warning); }
.sd-metric--bad  .sd-metric__value { color: var(--sd-danger); }
.sd-metric--ok   .sd-bar > i { background: var(--sd-success); }
.sd-metric--warn .sd-bar > i { background: var(--sd-warning); }
.sd-metric--bad  .sd-bar > i { background: var(--sd-danger); }

.sd-pill {
  display: inline-flex; align-items: center; gap: 5px;
  padding: 2px 8px; border-radius: var(--sd-r-pill);
  font-size: var(--sd-fs-xs); font-weight: 500;
  font-variant-numeric: tabular-nums;
  box-shadow: var(--sd-state-outline);
}
.sd-pill--ok      { color: var(--sd-success); background: var(--sd-success-soft); }
.sd-pill--warn    { color: var(--sd-warning); background: var(--sd-warning-soft); }
.sd-pill--bad     { color: var(--sd-danger);  background: var(--sd-danger-soft); }
.sd-pill--neutral { color: var(--sd-text-2);  background: var(--sd-surface-3); }

/* ---------- Navegação inferior ---------- */
.sd-bottomnav {
  display: grid; grid-template-columns: repeat(4, 1fr);
  background: var(--sd-surface);
  border-top: 1px solid var(--sd-border);
  padding: 4px 6px calc(4px + env(safe-area-inset-bottom, 0px));
}
.sd-bottomnav__item {
  display: grid; justify-items: center; align-content: center; gap: 3px;
  min-height: 56px; border: 0; background: none; border-radius: var(--sd-r-btn);
  color: var(--sd-text-3); font: inherit; font-size: var(--sd-fs-xs); font-weight: 500;
  cursor: pointer; position: relative;
  transition: color .15s var(--sd-ease), background .15s var(--sd-ease);
}
.sd-bottomnav__item:active { background: var(--sd-surface-2); }
.sd-bottomnav__item[aria-current="page"] { color: var(--sd-text); }
.sd-bottomnav__item[aria-current="page"]::before {
  content: ""; position: absolute; top: -4px; width: 24px; height: var(--sd-indicator);
  border-radius: 2px; background: var(--sd-accent);
}
.sd-bottomnav__item[aria-current="page"] svg { color: var(--sd-accent); }

@keyframes sd-spin { to { transform: rotate(360deg); } }

@media (prefers-reduced-motion: reduce) {
  .sd-app *, .sd-app *::before, .sd-app *::after { transition: none !important; animation: none !important; }
}
```
