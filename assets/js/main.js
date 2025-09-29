/*
 * RUN Art Foundry - JavaScript Principal
 * Funcionalidades: navegación, búsqueda, i18n, accesibilidad, interacciones
 */

// === CONFIGURACIÓN GLOBAL ===
const CONFIG = {
  defaultLocale: 'es',
  supportedLocales: ['es', 'en'],
  searchIndex: null,
  searchData: [],
  currentLocale: 'es',
  translations: {}
};

// === UTILIDADES ===
const Utils = {
  // Debounce para optimizar búsquedas
  debounce(func, wait) {
    let timeout;
    return function executedFunction(...args) {
      const later = () => {
        clearTimeout(timeout);
        func(...args);
      };
      clearTimeout(timeout);
      timeout = setTimeout(later, wait);
    };
  },

  // Escape HTML para prevenir XSS
  escapeHtml(text) {
    const map = {
      '&': '&amp;',
      '<': '&lt;',
      '>': '&gt;',
      '"': '&quot;',
      "'": '&#039;'
    };
    return text.replace(/[&<>"']/g, m => map[m]);
  },

  // Smooth scroll con offset para header fijo
  scrollToElement(element, offset = 80) {
    const elementPosition = element.getBoundingClientRect().top;
    const offsetPosition = elementPosition + window.pageYOffset - offset;

    window.scrollTo({
      top: offsetPosition,
      behavior: 'smooth'
    });
  },

  // Detectar si reduce motion está activo
  prefersReducedMotion() {
    return window.matchMedia('(prefers-reduced-motion: reduce)').matches;
  },

  // Generar ID único
  generateId() {
    return Math.random().toString(36).substr(2, 9);
  }
};

// === GESTIÓN DE IDIOMAS ===
const I18n = {
  // Inicializar sistema de internacionalización
  init() {
    this.loadSavedLocale();
    this.bindLocaleSwitch();
    this.updatePageContent();
  },

  // Cargar idioma guardado del localStorage
  loadSavedLocale() {
    const saved = localStorage.getItem('run-locale');
    if (saved && CONFIG.supportedLocales.includes(saved)) {
      CONFIG.currentLocale = saved;
    } else {
      // Detectar idioma del navegador
      const browserLang = navigator.language.split('-')[0];
      CONFIG.currentLocale = CONFIG.supportedLocales.includes(browserLang) 
        ? browserLang 
        : CONFIG.defaultLocale;
    }
  },

  // Cambiar idioma
  switchLocale(locale) {
    if (!CONFIG.supportedLocales.includes(locale)) return;
    
    CONFIG.currentLocale = locale;
    localStorage.setItem('run-locale', locale);
    
    // Actualizar URL si necesario
    if (locale === 'en') {
      if (!window.location.pathname.startsWith('/en/')) {
        const newPath = '/en' + window.location.pathname;
        window.history.pushState({}, '', newPath);
      }
    } else {
      if (window.location.pathname.startsWith('/en/')) {
        const newPath = window.location.pathname.replace('/en', '');
        window.history.pushState({}, '', newPath || '/');
      }
    }

    this.updatePageContent();
    this.updateLocaleButtons();
  },

  // Vincular botones de idioma
  bindLocaleSwitch() {
    const buttons = document.querySelectorAll('.locale-btn');
    buttons.forEach(btn => {
      btn.addEventListener('click', (e) => {
        e.preventDefault();
        const locale = btn.dataset.locale;
        this.switchLocale(locale);
      });
    });
  },

  // Actualizar contenido de la página
  updatePageContent() {
    document.documentElement.lang = CONFIG.currentLocale;
    
    // Actualizar textos traducibles
    const elements = document.querySelectorAll('[data-i18n]');
    elements.forEach(el => {
      const key = el.dataset.i18n;
      const text = this.getText(key);
      if (text) {
        if (el.tagName === 'INPUT' && el.type === 'text') {
          el.placeholder = text;
        } else {
          el.textContent = text;
        }
      }
    });
  },

  // Actualizar botones de idioma
  updateLocaleButtons() {
    const buttons = document.querySelectorAll('.locale-btn');
    buttons.forEach(btn => {
      btn.classList.toggle('active', btn.dataset.locale === CONFIG.currentLocale);
    });
  },

  // Obtener texto traducido
  getText(key) {
    return CONFIG.translations[CONFIG.currentLocale]?.[key] || key;
  }
};

// === NAVEGACIÓN ===
const Navigation = {
  init() {
    this.bindToggle();
    this.bindLinks();
    this.highlightCurrentPage();
    this.handleScroll();
  },

  // Toggle de navegación móvil
  bindToggle() {
    const toggle = document.querySelector('.nav-toggle');
    const nav = document.querySelector('.nav-main');
    
    if (toggle && nav) {
      toggle.addEventListener('click', () => {
        const isOpen = nav.classList.contains('active');
        
        nav.classList.toggle('active');
        toggle.setAttribute('aria-expanded', !isOpen);
        
        // Actualizar ícono
        toggle.innerHTML = isOpen ? '☰' : '✕';
        
        // Trap focus en navegación móvil
        if (!isOpen) {
          this.trapFocus(nav);
        }
      });

      // Cerrar con Escape
      document.addEventListener('keydown', (e) => {
        if (e.key === 'Escape' && nav.classList.contains('active')) {
          nav.classList.remove('active');
          toggle.setAttribute('aria-expanded', 'false');
          toggle.innerHTML = '☰';
          toggle.focus();
        }
      });

      // Cerrar al hacer clic fuera
      document.addEventListener('click', (e) => {
        if (!nav.contains(e.target) && !toggle.contains(e.target)) {
          nav.classList.remove('active');
          toggle.setAttribute('aria-expanded', 'false');
          toggle.innerHTML = '☰';
        }
      });
    }
  },

  // Vincular enlaces de navegación
  bindLinks() {
    const links = document.querySelectorAll('.nav-link[href^="#"]');
    links.forEach(link => {
      link.addEventListener('click', (e) => {
        e.preventDefault();
        const targetId = link.getAttribute('href').substring(1);
        const target = document.getElementById(targetId);
        
        if (target) {
          Utils.scrollToElement(target);
          
          // Cerrar navegación móvil si está abierta
          const nav = document.querySelector('.nav-main');
          const toggle = document.querySelector('.nav-toggle');
          if (nav && nav.classList.contains('active')) {
            nav.classList.remove('active');
            toggle.setAttribute('aria-expanded', 'false');
            toggle.innerHTML = '☰';
          }
        }
      });
    });
  },

  // Resaltar página actual
  highlightCurrentPage() {
    const currentPath = window.location.pathname;
    const links = document.querySelectorAll('.nav-link');
    
    links.forEach(link => {
      const href = link.getAttribute('href');
      if (href === currentPath || (href === '/' && currentPath === '/')) {
        link.classList.add('active');
        link.setAttribute('aria-current', 'page');
      }
    });
  },

  // Manejo del scroll para header
  handleScroll() {
    const header = document.querySelector('.header');
    if (!header) return;

    let lastScrollY = window.scrollY;
    let ticking = false;

    const updateHeader = () => {
      const scrollY = window.scrollY;
      
      if (scrollY > 100) {
        header.style.background = 'rgba(255, 255, 255, 0.98)';
        header.style.boxShadow = '0 2px 10px rgba(0, 0, 0, 0.1)';
      } else {
        header.style.background = 'rgba(255, 255, 255, 0.95)';
        header.style.boxShadow = 'none';
      }

      lastScrollY = scrollY;
      ticking = false;
    };

    window.addEventListener('scroll', () => {
      if (!ticking) {
        requestAnimationFrame(updateHeader);
        ticking = true;
      }
    });
  },

  // Trap focus para accesibilidad
  trapFocus(element) {
    const focusableElements = element.querySelectorAll(
      'a[href], button, textarea, input[type="text"], input[type="radio"], input[type="checkbox"], select'
    );
    const firstElement = focusableElements[0];
    const lastElement = focusableElements[focusableElements.length - 1];

    element.addEventListener('keydown', (e) => {
      if (e.key === 'Tab') {
        if (e.shiftKey) {
          if (document.activeElement === firstElement) {
            lastElement.focus();
            e.preventDefault();
          }
        } else {
          if (document.activeElement === lastElement) {
            firstElement.focus();
            e.preventDefault();
          }
        }
      }
    });

    firstElement?.focus();
  }
};

// === BÚSQUEDA ===
const Search = {
  init() {
    this.loadSearchIndex();
    this.bindSearchInput();
  },

  // Cargar índice de búsqueda
  async loadSearchIndex() {
    try {
      const response = await fetch('./assets/data/search-index.json');
      CONFIG.searchData = await response.json();
      console.log('Índice de búsqueda cargado:', CONFIG.searchData.length, 'elementos');
    } catch (error) {
      console.warn('No se pudo cargar el índice de búsqueda:', error);
      CONFIG.searchData = [];
    }
  },

  // Vincular input de búsqueda
  bindSearchInput() {
    const input = document.querySelector('.search-input');
    const results = document.querySelector('.search-results');

    if (!input || !results) return;

    const debouncedSearch = Utils.debounce((query) => {
      this.performSearch(query, results);
    }, 300);

    input.addEventListener('input', (e) => {
      const query = e.target.value.trim();
      if (query.length >= 2) {
        debouncedSearch(query);
      } else {
        results.classList.remove('show');
      }
    });

    // Navegación con teclado
    input.addEventListener('keydown', (e) => {
      if (e.key === 'ArrowDown') {
        e.preventDefault();
        const firstResult = results.querySelector('.search-result');
        firstResult?.focus();
      } else if (e.key === 'Escape') {
        results.classList.remove('show');
        input.blur();
      }
    });

    // Cerrar resultados al hacer clic fuera
    document.addEventListener('click', (e) => {
      if (!input.contains(e.target) && !results.contains(e.target)) {
        results.classList.remove('show');
      }
    });
  },

  // Realizar búsqueda
  performSearch(query, resultsContainer) {
    if (!CONFIG.searchData.length) {
      resultsContainer.innerHTML = '<div class="search-result">Índice de búsqueda no disponible</div>';
      resultsContainer.classList.add('show');
      return;
    }

    const results = this.searchContent(query);
    this.displayResults(results, resultsContainer, query);
  },

  // Buscar en contenido
  searchContent(query) {
    const searchTerms = query.toLowerCase().split(' ').filter(term => term.length > 1);
    
    return CONFIG.searchData
      .map(item => {
        let score = 0;
        const content = (item.title + ' ' + item.excerpt + ' ' + item.tags.join(' ')).toLowerCase();
        
        searchTerms.forEach(term => {
          // Puntuación por coincidencias en título (mayor peso)
          if (item.title.toLowerCase().includes(term)) {
            score += 10;
          }
          
          // Puntuación por coincidencias en contenido
          const matches = (content.match(new RegExp(term, 'g')) || []).length;
          score += matches * 2;
          
          // Puntuación por coincidencias exactas
          if (content.includes(query.toLowerCase())) {
            score += 5;
          }
        });
        
        return { ...item, score };
      })
      .filter(item => item.score > 0)
      .sort((a, b) => b.score - a.score)
      .slice(0, 8); // Máximo 8 resultados
  },

  // Mostrar resultados
  displayResults(results, container, query) {
    if (results.length === 0) {
      container.innerHTML = `<div class="search-result">No se encontraron resultados para "${Utils.escapeHtml(query)}"</div>`;
    } else {
      container.innerHTML = results.map((result, index) => `
        <a href="${result.url}" class="search-result" tabindex="0">
          <div class="search-result-title">${this.highlightTerms(result.title, query)}</div>
          <div class="search-result-excerpt">${this.highlightTerms(result.excerpt, query)}</div>
          ${result.tags.length > 0 ? `<div class="search-result-tags">${result.tags.join(', ')}</div>` : ''}
        </a>
      `).join('');

      // Agregar navegación con teclado
      this.bindResultsNavigation(container);
    }
    
    container.classList.add('show');
  },

  // Resaltar términos de búsqueda
  highlightTerms(text, query) {
    const terms = query.split(' ').filter(term => term.length > 1);
    let highlighted = Utils.escapeHtml(text);
    
    terms.forEach(term => {
      const regex = new RegExp(`(${term})`, 'gi');
      highlighted = highlighted.replace(regex, '<mark>$1</mark>');
    });
    
    return highlighted;
  },

  // Navegación con teclado en resultados
  bindResultsNavigation(container) {
    const results = container.querySelectorAll('.search-result');
    
    results.forEach((result, index) => {
      result.addEventListener('keydown', (e) => {
        switch (e.key) {
          case 'ArrowDown':
            e.preventDefault();
            const next = results[index + 1] || results[0];
            next.focus();
            break;
          case 'ArrowUp':
            e.preventDefault();
            const prev = results[index - 1] || results[results.length - 1];
            prev.focus();
            break;
          case 'Escape':
            e.preventDefault();
            container.classList.remove('show');
            document.querySelector('.search-input').focus();
            break;
        }
      });
    });
  }
};

// === COMPONENTES INTERACTIVOS ===
const Components = {
  init() {
    this.initTabs();
    this.initAccordions();
    this.initLightbox();
    this.initLazyLoading();
  },

  // Inicializar tabs
  initTabs() {
    const tabContainers = document.querySelectorAll('.tabs');
    
    tabContainers.forEach(container => {
      const buttons = container.querySelectorAll('.tab-button');
      const contents = container.parentElement.querySelectorAll('.tab-content');
      
      buttons.forEach((button, index) => {
        button.addEventListener('click', () => {
          // Desactivar todos
          buttons.forEach(btn => {
            btn.classList.remove('active');
            btn.setAttribute('aria-selected', 'false');
          });
          contents.forEach(content => {
            content.classList.remove('active');
            content.setAttribute('aria-hidden', 'true');
          });
          
          // Activar seleccionado
          button.classList.add('active');
          button.setAttribute('aria-selected', 'true');
          if (contents[index]) {
            contents[index].classList.add('active');
            contents[index].setAttribute('aria-hidden', 'false');
          }
        });

        // Navegación con teclado
        button.addEventListener('keydown', (e) => {
          let newIndex = -1;
          
          switch (e.key) {
            case 'ArrowLeft':
              e.preventDefault();
              newIndex = index > 0 ? index - 1 : buttons.length - 1;
              break;
            case 'ArrowRight':
              e.preventDefault();
              newIndex = index < buttons.length - 1 ? index + 1 : 0;
              break;
            case 'Home':
              e.preventDefault();
              newIndex = 0;
              break;
            case 'End':
              e.preventDefault();
              newIndex = buttons.length - 1;
              break;
          }
          
          if (newIndex >= 0) {
            buttons[newIndex].focus();
            buttons[newIndex].click();
          }
        });
      });
    });
  },

  // Inicializar acordeones
  initAccordions() {
    const accordions = document.querySelectorAll('.accordion-item');
    
    accordions.forEach(item => {
      const header = item.querySelector('.accordion-header');
      const content = item.querySelector('.accordion-content');
      const icon = item.querySelector('.accordion-icon');
      
      if (header && content) {
        const id = Utils.generateId();
        header.setAttribute('aria-controls', id);
        content.setAttribute('id', id);
        
        header.addEventListener('click', () => {
          const isOpen = item.classList.contains('active');
          
          // Cerrar otros acordeones si es necesario (opcional)
          // accordions.forEach(otherItem => {
          //   if (otherItem !== item) {
          //     otherItem.classList.remove('active');
          //   }
          // });
          
          item.classList.toggle('active');
          header.setAttribute('aria-expanded', !isOpen);
          
          if (icon) {
            icon.style.transform = isOpen ? 'rotate(0deg)' : 'rotate(180deg)';
          }
        });
      }
    });
  },

  // Inicializar lightbox para imágenes
  initLightbox() {
    const images = document.querySelectorAll('img[data-lightbox]');
    
    images.forEach(img => {
      img.addEventListener('click', () => {
        this.openLightbox(img.src, img.alt);
      });
      
      // Hacer clickeables con teclado
      img.setAttribute('tabindex', '0');
      img.addEventListener('keydown', (e) => {
        if (e.key === 'Enter' || e.key === ' ') {
          e.preventDefault();
          this.openLightbox(img.src, img.alt);
        }
      });
    });
  },

  // Abrir lightbox
  openLightbox(src, alt) {
    const lightbox = document.createElement('div');
    lightbox.className = 'lightbox';
    lightbox.innerHTML = `
      <div class="lightbox-backdrop">
        <div class="lightbox-container">
          <button class="lightbox-close" aria-label="Cerrar">&times;</button>
          <img src="${src}" alt="${alt}" class="lightbox-image">
          <div class="lightbox-caption">${alt}</div>
        </div>
      </div>
    `;
    
    document.body.appendChild(lightbox);
    document.body.style.overflow = 'hidden';
    
    // Event listeners
    const close = () => {
      document.body.removeChild(lightbox);
      document.body.style.overflow = '';
    };
    
    lightbox.querySelector('.lightbox-close').addEventListener('click', close);
    lightbox.querySelector('.lightbox-backdrop').addEventListener('click', (e) => {
      if (e.target === e.currentTarget) close();
    });
    
    document.addEventListener('keydown', function escapeHandler(e) {
      if (e.key === 'Escape') {
        close();
        document.removeEventListener('keydown', escapeHandler);
      }
    });
    
    // Focus en el botón de cerrar
    setTimeout(() => {
      lightbox.querySelector('.lightbox-close').focus();
    }, 100);
  },

  // Lazy loading para imágenes
  initLazyLoading() {
    if ('IntersectionObserver' in window) {
      const imageObserver = new IntersectionObserver((entries, observer) => {
        entries.forEach(entry => {
          if (entry.isIntersecting) {
            const img = entry.target;
            img.src = img.dataset.src;
            img.classList.remove('lazy');
            imageObserver.unobserve(img);
          }
        });
      });

      document.querySelectorAll('img[data-src]').forEach(img => {
        imageObserver.observe(img);
      });
    }
  }
};

// === FORMULARIOS ===
const Forms = {
  init() {
    this.bindContactForm();
    this.enhanceAccessibility();
  },

  // Formulario de contacto
  bindContactForm() {
    const form = document.querySelector('#contact-form');
    if (!form) return;

    form.addEventListener('submit', async (e) => {
      e.preventDefault();
      
      const submitBtn = form.querySelector('button[type="submit"]');
      const originalText = submitBtn.textContent;
      
      // Estado de carga
      submitBtn.disabled = true;
      submitBtn.textContent = CONFIG.currentLocale === 'es' ? 'Enviando...' : 'Sending...';
      
      try {
        const formData = new FormData(form);
        const data = Object.fromEntries(formData);
        
        // Aquí iría la lógica de envío real
        // Por ahora simulamos un envío exitoso
        await new Promise(resolve => setTimeout(resolve, 2000));
        
        this.showMessage('success', 
          CONFIG.currentLocale === 'es' 
            ? 'Mensaje enviado correctamente. Te contactaremos pronto.' 
            : 'Message sent successfully. We will contact you soon.'
        );
        
        form.reset();
        
      } catch (error) {
        this.showMessage('error', 
          CONFIG.currentLocale === 'es' 
            ? 'Error al enviar el mensaje. Intenta nuevamente.' 
            : 'Error sending message. Please try again.'
        );
      } finally {
        submitBtn.disabled = false;
        submitBtn.textContent = originalText;
      }
    });
  },

  // Mejorar accesibilidad de formularios
  enhanceAccessibility() {
    const inputs = document.querySelectorAll('input, textarea, select');
    
    inputs.forEach(input => {
      // Agregar aria-describedby para mensajes de error
      const errorId = input.id + '-error';
      input.setAttribute('aria-describedby', errorId);
      
      // Validación en tiempo real
      input.addEventListener('blur', () => {
        this.validateField(input);
      });
    });
  },

  // Validar campo individual
  validateField(field) {
    const value = field.value.trim();
    let isValid = true;
    let message = '';

    // Validaciones básicas
    if (field.hasAttribute('required') && !value) {
      isValid = false;
      message = 'Este campo es obligatorio';
    } else if (field.type === 'email' && value && !this.isValidEmail(value)) {
      isValid = false;
      message = 'Ingresa un email válido';
    }

    this.showFieldError(field, isValid ? null : message);
    return isValid;
  },

  // Validar email
  isValidEmail(email) {
    return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email);
  },

  // Mostrar error en campo
  showFieldError(field, message) {
    const errorId = field.id + '-error';
    let errorElement = document.getElementById(errorId);
    
    if (!errorElement) {
      errorElement = document.createElement('div');
      errorElement.id = errorId;
      errorElement.className = 'field-error';
      field.parentNode.appendChild(errorElement);
    }
    
    if (message) {
      errorElement.textContent = message;
      errorElement.style.display = 'block';
      field.classList.add('error');
      field.setAttribute('aria-invalid', 'true');
    } else {
      errorElement.style.display = 'none';
      field.classList.remove('error');
      field.setAttribute('aria-invalid', 'false');
    }
  },

  // Mostrar mensaje de estado
  showMessage(type, text) {
    const existing = document.querySelector('.form-message');
    if (existing) existing.remove();

    const message = document.createElement('div');
    message.className = `form-message callout callout-${type}`;
    message.textContent = text;
    message.setAttribute('role', type === 'error' ? 'alert' : 'status');
    
    const form = document.querySelector('#contact-form');
    form.parentNode.insertBefore(message, form);
    
    // Auto-ocultar después de 5 segundos
    setTimeout(() => {
      if (message.parentNode) {
        message.parentNode.removeChild(message);
      }
    }, 5000);
  }
};

// === ANALYTICS ===
const Analytics = {
  init() {
    this.trackEvents();
    this.trackPerformance();
  },

  // Tracking de eventos
  trackEvents() {
    // Click en enlaces externos
    document.addEventListener('click', (e) => {
      const link = e.target.closest('a[target="_blank"]');
      if (link) {
        this.track('external_link_click', {
          url: link.href,
          text: link.textContent.trim()
        });
      }
    });

    // Uso del buscador
    const searchInput = document.querySelector('.search-input');
    if (searchInput) {
      let searchTimeout;
      searchInput.addEventListener('input', (e) => {
        clearTimeout(searchTimeout);
        searchTimeout = setTimeout(() => {
          if (e.target.value.length >= 3) {
            this.track('search', { query: e.target.value });
          }
        }, 1000);
      });
    }

    // Cambio de idioma
    document.addEventListener('click', (e) => {
      if (e.target.matches('.locale-btn')) {
        this.track('language_change', { 
          from: CONFIG.currentLocale, 
          to: e.target.dataset.locale 
        });
      }
    });
  },

  // Tracking de performance
  trackPerformance() {
    // Core Web Vitals
    if ('web-vital' in window) {
      // Implementar cuando se agregue la librería web-vitals
    }

    // Tiempo de carga
    window.addEventListener('load', () => {
      const loadTime = performance.timing.loadEventEnd - performance.timing.navigationStart;
      this.track('page_load_time', { duration: loadTime });
    });
  },

  // Enviar evento de tracking
  track(event, data = {}) {
    // Implementar según el proveedor de analytics (Plausible, GA4, etc.)
    console.log('Analytics:', event, data);
    
    // Ejemplo para Plausible
    if (window.plausible) {
      window.plausible(event, { props: data });
    }
    
    // Ejemplo para GA4
    if (window.gtag) {
      window.gtag('event', event, data);
    }
  }
};

// === INICIALIZACIÓN ===
document.addEventListener('DOMContentLoaded', () => {
  console.log('🎨 RUN Art Foundry - Micrositio inicializado');
  
  // Inicializar módulos
  I18n.init();
  Navigation.init();
  Search.init();
  Components.init();
  Forms.init();
  Analytics.init();
  
  // Configurar service worker si está disponible
  if ('serviceWorker' in navigator) {
    navigator.serviceWorker.register('./sw.js')
      .then(() => console.log('Service Worker registrado'))
      .catch(err => console.log('Error en Service Worker:', err));
  }
  
  // Anunciar carga completa para lectores de pantalla
  const announcement = document.createElement('div');
  announcement.textContent = CONFIG.currentLocale === 'es' 
    ? 'Página cargada completamente' 
    : 'Page loaded completely';
  announcement.className = 'sr-only';
  announcement.setAttribute('aria-live', 'polite');
  document.body.appendChild(announcement);
  
  setTimeout(() => {
    document.body.removeChild(announcement);
  }, 1000);
});

// === EXPORTAR PARA USO GLOBAL ===
window.RunArtFoundry = {
  CONFIG,
  Utils,
  I18n,
  Navigation,
  Search,
  Components,
  Forms,
  Analytics
};
/* ============================================== */
/* MENÚ RESPONSIVE - AGREGADO Mon Sep 29 16:34:50 EDT 2025 */
/* ============================================== */

/* ==============================================
   MENÚ RESPONSIVE - JavaScript
   ============================================== */

// Toggle del menú móvil
function toggleMenu() {
    const navList = document.getElementById("nav-list");
    const navToggle = document.querySelector(".nav-toggle");
    
    if (navList && navToggle) {
        navList.classList.toggle("active");
        
        // Cambiar icono del botón
        const icon = navToggle.querySelector("span");
        if (icon) {
            icon.textContent = navList.classList.contains("active") ? "✕" : "☰";
        }
        
        // Actualizar aria-label
        navToggle.setAttribute("aria-label", 
            navList.classList.contains("active") ? "Cerrar menú" : "Abrir menú"
        );
    }
}

// Cerrar menú al hacer clic en un enlace (móvil)
document.addEventListener("DOMContentLoaded", function() {
    const navLinks = document.querySelectorAll(".nav-link");
    const navList = document.getElementById("nav-list");
    
    navLinks.forEach(link => {
        link.addEventListener("click", function() {
            if (window.innerWidth <= 767) {
                navList.classList.remove("active");
                const navToggle = document.querySelector(".nav-toggle span");
                if (navToggle) {
                    navToggle.textContent = "☰";
                }
            }
        });
    });
    
    // Cerrar menú al redimensionar ventana
    window.addEventListener("resize", function() {
        if (window.innerWidth > 767) {
            navList.classList.remove("active");
            const navToggle = document.querySelector(".nav-toggle span");
            if (navToggle) {
                navToggle.textContent = "☰";
            }
        }
    });
});

// Navegación con teclado
document.addEventListener("keydown", function(e) {
    if (e.key === "Escape") {
        const navList = document.getElementById("nav-list");
        if (navList && navList.classList.contains("active")) {
            toggleMenu();
        }
    }
});
