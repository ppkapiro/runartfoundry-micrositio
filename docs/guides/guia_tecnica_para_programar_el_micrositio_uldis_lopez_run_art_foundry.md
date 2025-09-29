# Guía técnica para programar el micrositio

**Proyecto:** Investigación & Propuesta Estratégica — Uldis López · RUN Art Foundry  
**Propósito del documento:** entregar a desarrollo una especificación práctica, completa y verificable para implementar el micrositio final (HTML interactivo, accesible, SEO‑ready, bilingüe), usando los textos definitivos de la guía narrativa.

---

## 1) Objetivos y alcance
- **Objetivo:** micrositio estático/SSR rápido, accesible y fácil de mantener que presente la investigación, la propuesta y el sistema de evidencias.  
- **Público:** cliente (Uldis), aliados, prensa, artistas, instituciones.  
- **Entregable mínimo viable (MVP):** Home + 8 secciones núcleo + navegación, buscador, bilingüe ES/EN, enlaces verificables, desempeño Lighthouse ≥ 95 en Performance/SEO/Best Practices/Accessibility.

---

## 2) Stack recomendado
- **Framework:** Next.js 14+ (App Router) con **Static Site Generation (SSG)** para todo el contenido.  
- **Lenguaje/estilo:** HTML5 semántico, CSS con **TailwindCSS** + PostCSS; sin dependencias pesadas (evitar Bootstrap).  
- **Interactividad:** Islands/React server components + progresivas con **vanilla JS** o pequeñas utilidades (Alpine.js opcional si hace falta).  
- **Build:** Vite/Next build, minificación, tree‑shaking.  
- **Hosting:** Vercel/Netlify (CDN global, HTTP/2 + brotli).  
- **Analítica:** Plausible o Google Analytics 4 (consent mode).  
- **Buscador interno:** Lunr.js/FlexSearch (client‑side) con índice pre‑generado en build.

> Alternativa sin React: Astro + content collections + markdown/MDX. Mantener los mismos criterios de calidad.

---

## 3) Arquitectura de información (IA) y rutas
**Estructura primaria de navegación (nivel 1):**
1. Inicio (`/`)
2. Uldis López (`/uldis`)
3. RUN Art Foundry (`/run`)
4. Cronología (`/timeline`)
5. Evidencias (Prensa & Testimonios) (`/evidence`)
6. Casos (Case Studies) (`/cases`)  
   - Mons. Agustín Román (`/cases/roman`)
   - Ransom Everglades Raider (`/cases/raider`)
7. Blog técnico “RUN Lab” (`/lab`)
8. Contacto (`/contact`)

**Secundarias/Soporte:**
- Políticas (privacidad/cookies), Accesibilidad, Sitemap XML/HTML.
- Página 404/500 personalizadas.

**Breadcrumbs:** en todas las secundarias.  
**Enlaces cruzados:** cada sección enlaza a contenido relacionado (proyectos, posts, evidencias).

---

## 4) Modelo de contenido (headless o ficheros)
- **Fuente única de verdad:** Markdown/MDX por página/sección en `/content/{locale}/...` con _front‑matter_ YAML.  
- **Campos estándar front‑matter:** `title`, `description`, `slug`, `date`, `updated`, `tags`, `canonical`, `cover`, `gallery[]`, `sources[]` (cada `source` con `title`, `publisher`, `url`, `date`, `note`), `testimonials[]` (autor, rol, foto, cita, videoURL).  
- **Colecciones:** `pages`, `cases`, `lab` (posts), `evidence` (prensa), `testimonials`.  
- **Índice buscador:** generar JSON estático `search-index.json` en build con `title`, `excerpt`, `url`, `tags` por documento.

---

## 5) Componentes UI reutilizables
- **Layout raíz**: header fijo + nav + footer; **skip‑link** accesible; soporte dark/light (prefers‑color‑scheme).  
- **Nav**: menús desktop + offcanvas móvil; foco visible; navegación con teclado.  
- **Card** (casos, posts, evidencias) con variaciones: imagen, texto, meta, CTA.  
- **Tabs** (Uldis/RUN en páginas comparativas).  
- **Accordion** para preguntas frecuentes y bloques extensos.  
- **Timeline**: vertical responsivo con puntos/hitos y anclajes internos.  
- **Testimonial**: bloque con cita, avatar, rol y enlace a video.  
- **MediaLightbox**: galería con zoom/teclas (sin dependencias pesadas).  
- **Callout/Quote**: resaltados para citas clave.  
- **Table** accesibles (roles, `<caption>`).  
- **Breadcrumb**: semántico con datos estructurados.  
- **SearchBox**: autosuggest (client‑side).  
- **LocaleSwitch**: alternador ES/EN con persistencia.

---

## 6) Estilo visual y micro‑interacciones
- **Tipografías:** sistema o Google Fonts livianas (ej. Inter + Spectral); `font-display: swap`.  
- **Paleta:** neutros oscuros + acentos cobre/bronce; alto contraste AA/AAA.  
- **Motion:** transiciones **0.15–0.25s**, animaciones sutiles (hover/focus). Respetar `prefers-reduced-motion`.  
- **Estados:** hover/focus/active/disabled definidos en todos los interactivos.  
- **Ilustraciones/gráficos:** referenciados; placeholders con `aspect-ratio` y `blur-up`.

---

## 7) Accesibilidad (WCAG 2.2 AA)
- Semántica correcta (`<main>`, `<nav>`, `<article>`, `<section>`, `<aside>`, `<footer>`).  
- **Focus visible** siempre; orden de tabulación lógico.  
- **Aria‑labels** solo cuando la semántica no baste.  
- Contraste mínimo 4.5:1 texto normal y 3:1 para grande.  
- **Alt** descriptivo en imágenes; **captions/transcripts** para video.  
- **Skip to content** y **landmarks**.  
- Validar con axe/Lighthouse y tests manuales con teclado/lector NVDA/VoiceOver.

---

## 8) SEO técnico y de contenido
- Títulos únicos (`<title>` ≤ 60 chars) y meta `description` ≤ 155 chars.  
- **Open Graph + Twitter Cards** completas en cada página.  
- **Datos estructurados (schema.org):** `Organization`, `Person` (Uldis), `CreativeWork`/`VisualArtwork` para obras/casos, `BreadcrumbList`, `Article` en blog, `VideoObject` en testimonios.  
- `sitemap.xml`, `robots.txt`, canonicals y alternates (`hreflang` ES/EN).  
- Enlazado interno denso; evitar thin content; headings jerárquicos (H1 único por vista).

---

## 9) Rendimiento y calidad
- **Core Web Vitals:** LCP < 2.0s, CLS < 0.1, INP < 200ms en 3G rápida.  
- **Imágenes responsivas:** `next/image`/`<img srcset>` con AVIF/WEBP + fallback; lazy loading nativo; tamaños correctos.  
- **JS mínimo:** no cargar librerías pesadas; dividir por ruta; desactivar hidración innecesaria.  
- **CSS crítico inline** + resto diferido; purge de Tailwind.  
- **Fuente:** subset + preload WOFF2.  
- **Caché/CDN:** headers `Cache-Control`, etags; prefetch de rutas probables.  
- **Auditoría:** Lighthouse ≥ 95 en las 4 categorías.

---

## 10) Internacionalización (i18n)
- **Locales:** `es` (por defecto) y `en`.  
- **Rutas:** `/` español, `/en/...` inglés.  
- **Hreflang** y `lang` por documento.  
- **Switch persistente** (cookie/localStorage).  
- Contenidos MDX duplicados por locale; no traducir URLs de evidencia externas.

---

## 11) Navegación y enlaces
- **Menú:** fijo; colapsable en móvil; subrayado animado en active.  
- **Enlaces externos:** `rel="noopener noreferrer"`, icono externo; verificar 200 OK en build (link checker).  
- **Anclas internas** con desplazamiento suave y **offset** para header fijo.

---

## 12) Páginas y requisitos funcionales

### 12.1 Inicio (`/`)
- Hero con claim y CTA hacia Evidencias y Casos.  
- Bloques destacados: Uldis, RUN, Cronología, Últimos posts RUN Lab, Testimonio del mes.  
- KPI snapshot (número de proyectos documentados, apariciones en prensa).  
- Validación: tiempos, contraste, accesibilidad y enlaces funcionan.

### 12.2 Uldis López (`/uldis`)
- Bio narrativa + línea de tiempo personal (hitoss clave).  
- Galería de obras propias (lightbox).  
- Descarga de **press‑kit** (PDF).  
- Datos estructurados `Person`.

### 12.3 RUN Art Foundry (`/run`)
- Servicios (fundición, pátinas, instalación, restauración opcional).  
- Filosofía: transparencia de proceso (video embed).  
- Grid de proyectos con filtros (tags: monumento, edición, pátina, etc.).

### 12.4 Cronología (`/timeline`)
- Timeline 12 meses (Q1..Q4) Uldis/RUN; anclas por trimestre; chips de filtro (Uldis/RUN/Ambos).  
- Botón “Descargar plan” (PDF generado del MDX).

### 12.5 Evidencias (`/evidence`)
- Listado por tipo: Prensa / Testimonios / Métricas.  
- Cards con logo de medio, titular, fecha, `target=_blank`.  
- Filtros por año/medio.

### 12.6 Casos (`/cases` + detalle)
- Index de casos con tarjetas grandes.  
- **Detalle** con: Desafío → Proceso → Resultado → Prensa relacionada → Testimonio.  
- `VisualArtwork`/`CreativeWork` + `BreadcrumbList`.

### 12.7 RUN Lab (`/lab`)
- Blog técnico: listado + etiquetas.  
- Post: TOC flotante, tiempo de lectura, código/figuras con captions.  
- Open Graph por post, `Article` schema.

### 12.8 Contacto (`/contact`)
- Formulario accesible (nombre, email, mensaje, tipo de consulta).  
- **Honeypot + rate limit**; reCAPTCHA v3 opcional; política de privacidad enlazada.  
- Envío vía API serverless (email a inbox RUN) + respuesta automática.

---

## 13) Buscador interno
- Índice generado en build (Lunr/FlexSearch) con título, excerpt, url, tags.  
- UI: input con sugerencias, accesible por teclado, resultados instantáneos (máx. 10).  
- Ponderar coincidencias en título > headings > body > tags.

---

## 14) Analítica y medición
- Integrar **Plausible** o GA4 con consentimiento.  
- Eventos: clics en prensa externa, descargas (press‑kit), reproducción de videos, envío de formularios, cambio de idioma, uso de buscador.  
- UTM en enlaces salientes que controlemos.  
- Panel compartible con el cliente.

---

## 15) Automatización y feeds
- **RSS/Atom** para RUN Lab.  
- **JSON endpoints** estáticos (e.g., `/data/evidence.json`, `/data/testimonials.json`).  
- Webhooks opcionales para regenerar SSG al actualizar contenido en repo.

---

## 16) Seguridad y cumplimiento
- HTTPS forzado; HSTS; CSP estricta (whitelist de dominios de medios).  
- Sanitizar embeds (YouTube nocookie).  
- Política de privacidad y cookies (consent banner ligero).  
- Accesibilidad declarada (página de statement).

---

## 17) Performance budget (por vista)
- HTML inicial < 30 KB; CSS crítico < 10 KB; JS total hidratado < 80 KB.  
- Imágenes hero ≤ 120 KB (AVIF/WEBP).  
- TTFB < 200 ms en CDN; LCP < 2 s móvil.  
- Cualquier librería > 30 KB requiere justificación explícita.

---

## 18) Pruebas y QA
- **Unitarias** (utilidades) y **E2E** (Playwright) para rutas críticas.  
- **Visual regression** (Chromatic/Playwright screenshots).  
- Matriz de dispositivos: iPhone SE/14, Pixel 5/8, iPad, desktop 1280/1440/1920.  
- Validar enlaces (externos 200 OK), i18n (hreflang), sitemap, meta OG.  
- Auditoría final Lighthouse móvil y desktop.

---

## 19) Deploy y CI/CD
- CI con GitHub Actions: lint (ESLint), type‑check (TS opcional), build, tests, Lighthouse CI.  
- Branching: `main` (producción), `dev` (staging).  
- Previews por PR (Vercel/Netlify).  
- Monitoreo uptime (StatusCake/UptimeRobot) + alertas.

---

## 20) Entregables finales
1. Código en repo con README de instalación/edición de contenidos.  
2. Guía de autores (cómo añadir una evidencia, un caso, un post).  
3. Assets optimizados (logos, favicons, manifiesto PWA opcional).  
4. Reporte de QA (resultados de tests, puntajes Lighthouse).  
5. Backups de contenido `/content` y `/public/media`.

---

## 21) Criterios de aceptación (checklist)
- [ ] Navegación clara y estable (sin saltos de layout; CLS < 0.1).  
- [ ] Todos los enlaces externos funcionan y abren en pestaña nueva con indicador.  
- [ ] Bilingüe completo, con `hreflang` y alternador funcional.  
- [ ] Accesibilidad: navegación por teclado en toda la UI; foco visible; contraste AA.  
- [ ] SEO: metadatos, OG/Twitter, schema por tipo de página, sitemap/robots.  
- [ ] Rendimiento: Lighthouse ≥ 95 (móvil/desktop); imágenes con `srcset` y lazy.  
- [ ] Buscador: resultados relevantes en < 100 ms tras teclear.  
- [ ] Evidencias y casos con datos completos (fuentes, fechas, prensa, testimonios).  
- [ ] Formulario de contacto protegido (honeypot/rate‑limit) y entrega confirmada.  
- [ ] Deploy productivo en CDN con dominio y SSL activos.

---

## 22) Notas de implementación
- Mantener **semántica** y evitar `divitis`.  
- Reducir hidración: componentes estáticos por defecto; hidratar solo lo interactivo.  
- Evitar librerías de UI pesadas; priorizar Tailwind + componentes propios.  
- Preparar **tokens de diseño** (espaciados, tipografías, colores) en Tailwind config.  
- Documentar decisiones (ADR) para cambios estructurales.

---

### Apéndice A — Mapeo rápido de contenidos a páginas
- Textos de **Perfil de Uldis** → `/uldis` + highlights en Home.  
- **Diagnóstico RUN** y servicios → `/run`.  
- **Cronología integrada** → `/timeline`.  
- **Sistema de evidencias** → `/evidence` + badges en Home.  
- **Casos** (Mons. Román, Raider) → `/cases/*` con estructura Desafío/Proceso/Resultado/Prensa/Testimonio.  
- **Blog técnico RUN Lab** → `/lab`.

### Apéndice B — Especificación de datos estructurados mínimos
- `Organization` (RUN): nombre, logo, sameAs (IG, FB, YT, Yelp), address, geo.  
- `Person` (Uldis): name, image, jobTitle (Sculptor, Founder), sameAs.  
- `BreadcrumbList` en todas las secundarias.  
- `Article` en posts; `VisualArtwork`/`CreativeWork` en casos; `VideoObject` en testimonios.

---

**Fin de documento** — Cualquier duda de desarrollo, consultar a coordinación para ejemplos de contenido MDX y assets de referencia.

