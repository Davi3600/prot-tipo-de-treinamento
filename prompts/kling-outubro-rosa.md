# Prompt Kling.ai — Outubro Rosa (telas e TVs da cidade)

Formato sugerido: **16:9**, 10 s, modo Professional/High Quality.
Não peça texto nem logo ao Kling: ele deforma letras. Coloque "Outubro Rosa", a mensagem e a assinatura na edição.

---

## Opção A — prompt único (um clipe de 10 s)

**Prompt (em inglês, porque o Kling segue melhor):**

```
Cinematic close-up of a woman's hand gently reaching toward a pink satin awareness ribbon pinned on a white blouse, fingertips softly touching the ribbon, slow and delicate movement. The camera slowly pulls back and transitions to a warm, bright scene of diverse Brazilian women of different ages and skin tones standing together outdoors in a sunny city park, smiling with confidence and solidarity. One woman wears a pink headscarf, another holds a pink ribbon close to her chest, another wears a soft pink scarf, an older woman and a young woman embrace. Soft golden-hour sunlight, pink and white color palette, shallow depth of field, gentle bokeh, hopeful and empowering mood, clean composition, photorealistic, high detail, smooth slow camera movement, 4K commercial look.
```

**Negative prompt:**

```
text, letters, words, logo, watermark, subtitles, distorted hands, extra fingers, deformed fingers, blurry faces, deformed faces, sad, crying, hospital, medical equipment, nudity, exposed breasts, dark lighting, low quality, cartoon, flickering
```

---

## Opção B — 3 clipes separados (recomendado, editar depois)

Gerar cenas separadas e juntar na edição dá muito mais controle. Um clipe só com mão + várias mulheres costuma sair com mãos e rostos deformados.

**Cena 1 — a mão no laço (5 s)**

```
Extreme close-up of a woman's hand slowly reaching and gently touching a pink satin awareness ribbon pinned on a white blouse, fingertips resting softly on the ribbon. Soft natural window light, pink and white palette, shallow depth of field, creamy bokeh, slow subtle camera push-in, photorealistic, elegant, emotional, commercial quality.
```

**Cena 2 — as mulheres (5 s)**

```
Group of diverse Brazilian women of different ages, body types and skin tones standing together outdoors in a bright city park, smiling confidently at the camera. Each woman has a touch of pink: one wears a pink headscarf, one a pink ribbon on her chest, one a soft pink scarf, one a pink blouse. Warm golden-hour sunlight, gentle breeze, slow lateral camera movement, hopeful, empowering, solidarity, photorealistic, cinematic commercial look.
```

**Cena 3 — fecho/abraço (5 s)**

```
Medium shot of a mature woman and a young woman embracing warmly and smiling, both wearing pink awareness ribbons on their clothes, soft pink and white background with gentle bokeh lights, warm soft lighting, slow camera pull-back leaving empty space on the right side of the frame, photorealistic, hopeful and tender mood.
```

O espaço vazio na Cena 3 é proposital: serve para a mensagem final e a assinatura entrarem na edição.

Use o mesmo **negative prompt** da Opção A em todas as cenas.

---

## Opção C — prompt único multi-shot (Kling 3.0, 15 s)

O Kling 3.0 gera até 15 s com vários planos numa única geração. Use 16:9, 15 s.

```
A 15-second cinematic awareness film for Breast Cancer Awareness Month, three shots, photorealistic, consistent pink and white color palette, soft warm lighting, hopeful and empowering mood, commercial quality.

Shot 1 (0-5s): Extreme close-up of a woman's hand slowly reaching and gently touching a pink satin awareness ribbon pinned on a white blouse, fingertips resting softly on the ribbon. Soft natural window light, shallow depth of field, creamy bokeh, slow subtle camera push-in.

Shot 2 (5-10s): Cut to a group of diverse Brazilian women of different ages, body types and skin tones standing together outdoors in a bright city park, smiling confidently at the camera. Each woman has a touch of pink: one wears a pink headscarf, one a pink ribbon on her chest, one a soft pink scarf, one a pink blouse. Warm golden-hour sunlight, gentle breeze, slow lateral camera movement.

Shot 3 (10-15s): Cut to a medium shot of a mature woman and a young woman from the group embracing warmly and smiling, both wearing pink ribbons, soft pink bokeh background, slow camera pull-back leaving empty space on the right side of the frame.
```

## Opção D — 8 s, plano gratuito (um plano contínuo, sem cortes)

Funciona em qualquer modelo, inclusive nos que não têm multi-shot. Se a duração de 8 s não estiver disponível, gere 10 s e corte na edição.

```
One continuous 8-second shot, no cuts. Starts with an extreme close-up of a woman's hand gently touching a pink satin awareness ribbon pinned on her white blouse. The camera smoothly and slowly pulls back and rises, revealing her smiling, standing outdoors in a sunny city park beside a diverse group of Brazilian women of different ages and skin tones, each wearing something pink: a pink headscarf, a pink scarf, a pink blouse, pink ribbons. They smile warmly and put their arms around each other. Golden-hour light, pink and white palette, shallow depth of field, hopeful and empowering mood, photorealistic, cinematic commercial look, empty space on the right side of the frame at the end.
```

## Opção D2 — 8 s, laço sem letras (correção)

O termo "awareness ribbon" puxa laços de campanha com texto impresso. Aqui o laço é descrito como objeto liso e sem estampa.

```
One continuous 8-second shot, no cuts. Starts with an extreme close-up of a woman's hand gently touching a small plain pink satin ribbon loop pinned on her white blouse; the ribbon is solid pink, smooth and completely blank, with no print, no pattern and no writing. The camera smoothly and slowly pulls back and rises, revealing her smiling, standing outdoors in a sunny city park beside a diverse group of Brazilian women of different ages and skin tones, each wearing something pink: a pink headscarf, a pink scarf, a pink blouse. They smile warmly and put their arms around each other. Golden-hour light, pink and white palette, shallow depth of field, hopeful mood, photorealistic, cinematic commercial look, empty space on the right side of the frame at the end.
```

Negative prompt:

```
text, letters, words, writing, typography, printed text on ribbon, embroidered letters, pattern on ribbon, logo, badge, label, watermark, subtitles, distorted hands, extra fingers, deformed fingers, deformed faces, sad, crying, hospital, nudity, dark lighting, low quality, cartoon, flickering
```

---

## Checklist antes de publicar

- [ ] Confirmar com quem opera as telas: resolução, proporção (16:9, vertical ou formato de painel LED), duração e se tem áudio (em rua normalmente não tem).
- [ ] Mensagem e chamada para ação na edição (ex.: "Outubro Rosa — cuide-se. Procure a unidade de saúde mais próxima."). Conferir a recomendação atual do Ministério da Saúde sobre mamografia antes de citar faixa etária.
- [ ] Texto grande e com contraste alto: quem vê a tela passa em poucos segundos e de longe.
- [ ] Revisar quadro a quadro: mãos, dedos e rostos.
