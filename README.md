# Skin "Medianoche" para RustDesk

Personalización completa del skin de RustDesk (Flutter): paleta de colores,
tipografía, bordes y logo.

## Paleta
| Uso              | Color      |
|------------------|------------|
| Acento principal | `#378ADD`  |
| Acento secundario| `#5DCAA5`  |
| Lienzo oscuro    | `#1A1D29`  |
| Fondo oscuro app | `#15171F`  |
| Fondo claro      | `#F4F6FA`  |

## Qué cambia
- **Colores**: clase `MyTheme` en `flutter/lib/common.dart` (light + dark).
- **Fuente**: inyecta `Inter` vía `google_fonts` (ya está en pubspec.yaml).
- **Bordes**: botones/inputs 8→12 px, diálogos 18→20 px.
- **Logo**: reemplaza `flutter/assets/icon.svg`.

## Cómo aplicar
```bash
git clone https://github.com/rustdesk/rustdesk.git
# coloca este paquete junto al repo
./apply_midnight_skin.sh ./rustdesk
cd rustdesk/flutter && flutter pub get && flutter run -d <plataforma>
```
El script crea backups (`*.bak`) y es re-ejecutable.

## Archivos
- `apply_midnight_skin.sh` — aplica todo automáticamente.
- `assets/icon.svg` — logo nuevo.
- `01_mytheme_colors.dart` — bloque de colores de referencia (manual).
- `logo_preview.png` — vista previa del logo.

## Notas para ir más allá
- Iconos de bandeja del sistema: `res/mac-tray-*.png`, `res/*.png`, `res/icon.ico`.
- Banner / logos web: `res/logo.svg`, `res/logo-header.svg`, `res/rustdesk-banner.svg`.
- Nombre de la app: `flutter/pubspec.yaml`, archivos de empaquetado en `res/`.
