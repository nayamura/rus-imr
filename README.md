# Skin "Medianoche" + marca IMR para RustDesk

Personalización completa de RustDesk (Flutter): paleta, tipografía, bordes e iconos.
El logo IMR se usa **tal cual lo entregaste**, solo adaptado en tamaño y centrado
sobre fondo blanco (su diseño no se modifica).

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
- **Logo app**: `flutter/assets/icon.svg` (tu logo embebido sobre fondo blanco).
- **Iconos paquete**: `res/32x32.png`, `64x64`, `128x128`, `128x128@2x`,
  `icon.png` (1024), `mac-icon.png` (1024) y `icon.ico` (Windows, multi-tamaño).

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
- `assets/icon.svg` — logo de la app (tu logo intacto, fondo blanco).
- `res/*` — set completo de iconos para empaquetado.
- `logo_horizontal.png` — tu logo recortado, fondo transparente (para web/banner).
- `icon_square_light.png` — vista previa del icono cuadrado.
- `01_mytheme_colors.dart` — bloque de colores de referencia (manual).

## Nota
Tu logo tiene letras oscuras pensadas para fondo claro; por eso el icono usa
fondo blanco (se ve nítido). Para banner/web usa `logo_horizontal.png` directamente.
El nombre de la app (en `pubspec.yaml` y archivos de `res/`) no se toca: dímelo si
quieres cambiarlo también.
