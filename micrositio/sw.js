// Service Worker para RUN Art Foundry Micrositio
// Versión básica para cache de recursos estáticos

const CACHE_NAME = 'runartfoundry-v1';
const urlsToCache = [
  './',
  './assets/css/main.css',
  './assets/js/main.js',
  './assets/data/search-index.json'
];

// Instalación
self.addEventListener('install', (event) => {
  event.waitUntil(
    caches.open(CACHE_NAME)
      .then((cache) => {
        return cache.addAll(urlsToCache);
      })
      .catch((error) => {
        console.log('Error al cachear recursos:', error);
      })
  );
});

// Activación
self.addEventListener('activate', (event) => {
  event.waitUntil(
    caches.keys().then((cacheNames) => {
      return Promise.all(
        cacheNames.map((cacheName) => {
          if (cacheName !== CACHE_NAME) {
            return caches.delete(cacheName);
          }
        })
      );
    })
  );
});

// Interceptar requests
self.addEventListener('fetch', (event) => {
  event.respondWith(
    caches.match(event.request)
      .then((response) => {
        // Devolver del cache si existe, sino fetch de la red
        return response || fetch(event.request);
      })
      .catch(() => {
        // En caso de error de red, devolver página offline básica
        if (event.request.destination === 'document') {
          return caches.match('./');
        }
      })
  );
});