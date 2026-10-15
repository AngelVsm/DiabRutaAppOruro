# DiabRuta

App de transporte público para Oruro, Bolivia. La desarrolla [Angel Vargas](https://github.com/AngelVsm), estudiante de Ingeniería de Sistemas en la UDABOL, como proyecto de Desarrollo de Aplicaciones Móviles II con el Ing. Kevin Arroyo.

## Descargar

Las versiones están en [Releases](https://github.com/AngelVsm/DiabRutaAppOruro/releases).

- Android: `DiabRuta-android.apk`
- Windows: `DiabRuta-windows.zip`
- Web: `DiabRuta-web.zip`, se abre en el navegador

## Qué hace

- Muestra el mapa de Oruro. Solo se descarga el sector que se está viendo.
- Busca lugares por internet, centrada en Oruro.
- Calcula el viaje en el teléfono, con las líneas guardadas en la app.
- Los comentarios abren WhatsApp con un mensaje listo.
- Las tarifas son las del Decreto Municipal N.° 408, del 26 de diciembre de 2025. Son transitorias, por 6 meses.

## Cómo correrla

```bash
cd apps/example
flutter pub get
flutter run
```

La app está en `apps/example`. En el teléfono se llama DiabRuta. Los idiomas son español e inglés.

## Licencia

DiabRuta — Angel Vargas.

El programa se puede copiar y modificar bajo la [Licencia Pública General de GNU, versión 3](./LICENSE). Se entrega tal cual, sin garantía. El texto legal está en `LICENSE`.

