# Cambios

## v1.0.3

### Nuevo
- Compilación para iOS sin firmar (`DiabRuta-ios-unsigned.ipa`) para pruebas con Sideloadly / AltStore / SideStore.
- Lanzador `abrir_web.bat` para abrir DiabRuta Web en Windows con servidor HTTP local automático.

### Corregido
- Windows: soporte completo de mapa en escritorio (`flutter_map`) y protección de sensores en equipos sin brújula.
- Web: rutas con `#/`, manejo de `/index.html`, `<base href="./">` y servidor local corregido en `abrir_web.bat`.
- iOS: calibración de la brújula/giroscopio mediante rumbo calibrado nativo de CoreLocation (`CLHeading`).
- Íconos oficiales de DiabRuta actualizados en Web, Windows (`.exe`) e iOS.

### Mejorado
- Inicio limpio al cerrar y volver a abrir la app sin ruta activa (en segundo plano mantiene la ruta en curso).
- Enlaces de redes sociales actualizados (Instagram/TikTok: `annhhelz`, Facebook: `annhhelzz`).

## 2026-10-15

DiabRuta para Oruro. Rutas locales, español e inglés, y las tarifas transitorias del Decreto Municipal N.° 408.


