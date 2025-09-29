# Instrucciones de integración para programador — Micrositio RUN

**Objetivo:** Explicar cómo el programador debe integrar en el micrositio los documentos estratégicos ya preparados (guía narrativa, guía técnica de programación, guía didáctica SEO/competencia y guía práctica de acciones), de modo que el sitio quede navegable, coherente y listo para presentar al cliente.

---

## 1. Documentos base
1. **Guía narrativa estratégica** (contenido principal para micrositio).  
2. **Guía técnica de programación** (estructura, componentes, requisitos de accesibilidad/SEO).  
3. **Guía didáctica SEO & Competencia** (explicación técnica para sección educativa o blog).  
4. **Guía práctica de acciones** (lista de tareas concretas para RUN y Uldis).

El programador debe tomar estos textos como **contenido definitivo** y transformarlos en páginas HTML interactivas, respetando la estructura de navegación propuesta.

---

## 2. Integración en el micrositio
- **Estructura principal de navegación:**
  - Inicio
  - Uldis López (marca personal)
  - RUN Art Foundry (marca corporativa)
  - Cronología
  - Evidencias (prensa y testimonios)
  - Casos (ej. Agustín Román, Raider)
  - Blog / RUN Lab
  - Competencia & SEO (explicaciones didácticas)
  - Acciones prácticas (roadmap operativo)
  - Contacto

- **Formato de integración:**
  - Cada documento se convierte en sección/página independiente.
  - Los títulos y subtítulos de los documentos se mapearán como `<h1>`, `<h2>`, `<h3>` dentro de cada página.
  - Las listas de acciones y ejemplos se presentan con listas ordenadas (`<ol>`) y no ordenadas (`<ul>`).

---

## 3. Diseño y usabilidad
- Aplicar las pautas de la guía técnica: diseño claro, accesible, con modo oscuro/claro, navegación fluida y enlaces externos con `target=_blank`.
- Incluir buscador interno que indexe títulos y subtítulos de estos documentos.
- Asegurar que las secciones didácticas (SEO & Competencia) tengan resaltados visuales (ej. cajas de nota o callouts) para separar teoría de ejemplos.

---

## 4. Integración de evidencias y ejemplos
- Los ejemplos prácticos de las guías deben mostrarse en **cards o bloques destacados** con icono o color diferenciado.
- Cuando un ejemplo cite una fuente externa (ej. prensa, YouTube, Instagram), debe insertarse como **enlace clicable** o embed (si aplica).
- Para las guías de acciones, usar **checklists interactivos** (opcional) donde el usuario pueda marcar completado.

---

## 5. Localización y bilingüe
- Todo el contenido debe estar disponible en **ES y EN**.  
- El programador debe preparar el sistema de i18n (internacionalización) para que los documentos puedan duplicarse y traducirse fácilmente.

---

## 6. Mantenimiento futuro
- El programador debe documentar en README:
  - Cómo añadir o editar nuevas páginas de contenido.
  - Cómo actualizar los documentos cuando se revisen.
  - Cómo regenerar el índice de búsqueda.

---

## 7. Entregables esperados
1. Micrositio navegable con todas las secciones integradas.  
2. Menú lateral o superior con acceso a cada documento/guía.  
3. Bilingüe funcional.  
4. Checklist de QA con accesibilidad, SEO y usabilidad cumplidos.  
5. Documentación técnica para el cliente sobre mantenimiento.

---

**Nota:** Estas instrucciones no son de diseño visual sino de **integración técnica de contenidos**. El programador debe respetar la narrativa y el estilo definido en los documentos, garantizando que sean fáciles de leer, navegar y compartir.

