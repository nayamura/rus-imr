# Skin "Medianoche" + marca IMR para RustDesk

Personalización completa de RustDesk (Flutter): paleta, tipografía, bordes e iconos.
El icono usa las **iniciales IMR de tu logo** (degradado y tipografía originales,
recortadas sin el tagline) sobre fondo blanco.

## Paleta (skin Medianoche)
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
- **Logo app**: `flutter/assets/icon.svg` (iniciales IMR, fondo blanco).
- **Iconos paquete**: `res/32x32.png`, `64x64`, `128x128`, `128x128@2x`,
  `icon.png` (1024), `mac-icon.png` (1024) y `icon.ico` (Windows, 16→256 px).

## Cómo aplicar
```bash
git clone https://github.com/rustdesk/rustdesk.git
# coloca este paquete junto al repo (debe traer assets/ y res/)
./apply_midnight_skin.sh ./rustdesk
cd rustdesk/flutter && flutter pub get && flutter run -d <plataforma>
```
El script crea backups (`*.bak`) y es re-ejecutable.

## Archivos del paquete
- `apply_midnight_skin.sh` — aplica todo automáticamente.
- `assets/icon.svg` — logo de la app (iniciales IMR, fondo blanco).
- `res/*` — set completo de iconos para empaquetado (incluye icon.ico de Windows).
- `logo_horizontal.png` — iniciales IMR con fondo transparente (para web/banner).
- `icon_square_light.png` — vista previa del icono cuadrado.
- `01_mytheme_colors.dart` — bloque de colores de referencia (manual).

## Nota
Se quitó el tagline "Ideas Make Reality" del icono para que las iniciales se lean
nítidas en todos los tamaños (incluido 16 px en la barra de tareas de Windows).
El icono usa fondo blanco porque las letras son oscuras (diseñadas para fondo claro).
El nombre de la app (en `pubspec.yaml` y archivos de `res/`) no se toca.
