# DiabRuta

App de transporte público para Oruro, Bolivia. La desarrolla [Angel Vargas](https://github.com/AngelVsm), estudiante de Ingeniería de Sistemas en la UDABOL, como proyecto de Desarrollo de Aplicaciones Móviles II con el Ing. Kevin Arroyo. Es código abierto: [AngelVsm/DiabRutaAppOruro](https://github.com/AngelVsm/DiabRutaAppOruro).

[![GPLv3 License](https://img.shields.io/badge/License-GPL%20v3-yellow.svg)](https://opensource.org/licenses/)

## Qué hace esta app

- Muestra el mapa de Oruro. Las teselas llegan por internet y solo se descargan del sector que se está viendo.
- Busca lugares con Photon, también por internet, centrada en Oruro.
- Calcula el viaje **en el teléfono**, con las líneas guardadas en `apps/example/assets/routing/oruro.gtfs.zip`. No consulta un servidor de rutas.
- Los comentarios abren WhatsApp con un mensaje listo.
- Las tarifas son las del Decreto Municipal N.° 408, publicadas el 26 de diciembre de 2025: transitorias, por 6 meses.

DiabRuta no consulta un servidor de rutas. El viaje sale del archivo que va dentro de la app.

## Cómo correrla

```bash
cd apps/example
flutter pub get
flutter run
```

La app que se instala está en `apps/example`. El nombre en el teléfono es DiabRuta. Los idiomas de la interfaz son español e inglés.

## De dónde sale el código

El mapa, la búsqueda y el cálculo de rutas usan librerías libres de [Trufi Core](https://github.com/trufi-association/trufi-core) (GPL-3.0). Esas librerías conservan su licencia y su autoría. Por eso varias carpetas se llaman `trufi_core_*` y parte de su documentación interna sigue en inglés: es el código original, no otra app escondida.

La app, las rutas de Oruro, el nombre, los colores y los textos de presentación son de Angel Vargas.

| Carpeta | Para qué está |
| --- | --- |
| `apps/example` | DiabRuta, la app que se corre |
| `packages/trufi_core_maps` | Mapa |
| `packages/trufi_core_planner` | Lectura del GTFS y cálculo en el teléfono |
| `packages/trufi_core_routing` | Conexión de ese cálculo con la pantalla |
| `packages/screens` | Pantallas: inicio, rutas, tarifas, comentarios, ajustes y sobre nosotros |

## Licencia

DiabRuta, adaptación para Oruro — Angel Vargas.

El código base es Trufi Core. Copyright 2020-present — [Trufi Association](https://www.trufi-association.org/).

El programa se puede copiar y modificar bajo la [Licencia Pública General de GNU, versión 3](./LICENSE). Se entrega tal cual, sin garantía. El texto legal completo está en `LICENSE`.

