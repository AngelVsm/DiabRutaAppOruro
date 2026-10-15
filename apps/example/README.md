# DiabRuta

App de rutas para Oruro. Se corre desde esta carpeta.

```bash
flutter pub get
flutter run
```

## Cómo está configurada

Todo está en `lib/main.dart` y `lib/marca.dart`.

| Qué | Valor actual |
| --- | --- |
| Nombre | DiabRuta |
| Ciudad | Oruro, Bolivia (`-17.9604176, -67.1106498`) |
| Idioma | Español e inglés |
| Rutas | `assets/routing/oruro.gtfs.zip`, calculadas en el teléfono |
| Mapa | Estilos claros, estándar, oscuro y colorido de OpenFreeMap |
| Búsqueda de lugares | Por internet, centrada en Oruro |
| Comentarios | WhatsApp |
| Enlace interno | `diabruta://` |

No hay servidor de rutas. El viaje sale del archivo GTFS de Oruro.

Las tarifas salen del Decreto Municipal N.° 408 (26 de diciembre de 2025): minibús, adulto 2,50 Bs y adulto mayor 2 Bs; microbús, adulto 2,20 Bs, adulto mayor y universitario 1,50 Bs, secundaria y escolar 1 Bs. Son transitorias, por 6 meses.
