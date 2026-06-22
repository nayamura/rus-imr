#!/usr/bin/env bash
# ============================================================
#  apply_midnight_skin.sh
#  Aplica el skin "Medianoche" a un clon de RustDesk:
#    - Paleta de colores (light + dark)
#    - Bordes más redondeados
#    - Tipografía Inter (vía google_fonts, ya incluido)
#    - Logo nuevo (assets/icon.svg)
#
#  Uso:
#    git clone https://github.com/rustdesk/rustdesk.git
#    cp assets/icon.svg ./   # (el logo que viene en este paquete)
#    ./apply_midnight_skin.sh /ruta/a/rustdesk
# ============================================================
set -euo pipefail

REPO="${1:-./rustdesk}"
COMMON="$REPO/flutter/lib/common.dart"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

[ -f "$COMMON" ] || { echo "ERROR: no encuentro $COMMON. Pasa la ruta del repo: ./apply_midnight_skin.sh /ruta/rustdesk"; exit 1; }

echo "==> Respaldo de common.dart"
cp "$COMMON" "$COMMON.bak"

# ---------- 1. PALETA MyTheme ----------
echo "==> Aplicando paleta Medianoche"
python3 - "$COMMON" <<'PY'
import re, sys
p = sys.argv[1]
s = open(p, encoding='utf-8').read()

repl = {
    r"static const Color grayBg = Color\(0xFFEFEFF2\);":  "static const Color grayBg = Color(0xFFF4F6FA);",
    r"static const Color accent = Color\(0xFF0071FF\);":   "static const Color accent = Color(0xFF378ADD);",
    r"static const Color accent50 = Color\(0x770071FF\);": "static const Color accent50 = Color(0x77378ADD);",
    r"static const Color accent80 = Color\(0xAA0071FF\);": "static const Color accent80 = Color(0xAA378ADD);",
    r"static const Color canvasColor = Color\(0xFF212121\);": "static const Color canvasColor = Color(0xFF1A1D29);",
    r"static const Color idColor = Color\(0xFF00B6F0\);":  "static const Color idColor = Color(0xFF5DCAA5);",
    r"static const Color cmIdColor = Color\(0xFF21790B\);": "static const Color cmIdColor = Color(0xFF0F6E56);",
    r"static const Color button = Color\(0xFF2C8CFF\);":   "static const Color button = Color(0xFF378ADD);",
    r"static const Color hoverBorder = Color\(0xFF999999\);": "static const Color hoverBorder = Color(0xFF8FA3BF);",
    r"static const Color border = Color\(0xFFCCCCCC\);":   "static const Color border = Color(0xFFD7DCE5);",
}
for pat, new in repl.items():
    s, n = re.subn(pat, new, s)
    if n == 0:
        print(f"   (aviso) no se encontró patrón: {pat}")

# Fondo oscuro Medianoche más profundo
s = s.replace("scaffoldBackgroundColor: Color(0xFF18191E)",
              "scaffoldBackgroundColor: Color(0xFF15171F)")
s = s.replace("dialogBackgroundColor: Color(0xFF18191E)",
              "dialogBackgroundColor: Color(0xFF1A1D29)")

open(p, 'w', encoding='utf-8').write(s)
print("   paleta OK")
PY

# ---------- 2. BORDES más redondeados ----------
echo "==> Redondeando bordes (8 -> 12, 18 -> 20)"
python3 - "$COMMON" <<'PY'
import sys
p = sys.argv[1]
s = open(p, encoding='utf-8').read()
# Botones, inputs y popups: 8 -> 12
s = s.replace("BorderRadius.circular(8.0)", "BorderRadius.circular(12.0)")
s = s.replace("BorderRadius.circular(8)",   "BorderRadius.circular(12)")
s = s.replace("Radius.circular(8.0)",       "Radius.circular(12.0)")
# Diálogos: 18 -> 20
s = s.replace("BorderRadius.circular(18.0)", "BorderRadius.circular(20.0)")
open(p, 'w', encoding='utf-8').write(s)
print("   bordes OK")
PY

# ---------- 3. TIPOGRAFÍA Inter ----------
echo "==> Inyectando fuente Inter (google_fonts)"
python3 - "$COMMON" <<'PY'
import sys, re
p = sys.argv[1]
s = open(p, encoding='utf-8').read()

if "google_fonts/google_fonts.dart" not in s:
    # añadir import tras la primera línea de import de flutter material
    s = s.replace("import 'package:flutter/material.dart';",
                  "import 'package:flutter/material.dart';\nimport 'package:google_fonts/google_fonts.dart';", 1)

# Inyectar fontFamily en ambos ThemeData si aún no está
def inject_font(src, anchor):
    if "fontFamily: GoogleFonts.inter().fontFamily" in src.split(anchor,1)[1][:200]:
        return src
    return src.replace(anchor, anchor + "\n    fontFamily: GoogleFonts.inter().fontFamily,", 1)

s = inject_font(s, "static ThemeData lightTheme = ThemeData(")
s = inject_font(s, "static ThemeData darkTheme = ThemeData(")
open(p, 'w', encoding='utf-8').write(s)
print("   fuente OK")
PY

# ---------- 4. LOGO ----------
echo "==> Reemplazando logo (assets/icon.svg)"
if [ -f "$SCRIPT_DIR/assets/icon.svg" ]; then
    cp "$REPO/flutter/assets/icon.svg" "$REPO/flutter/assets/icon.svg.bak" 2>/dev/null || true
    cp "$SCRIPT_DIR/assets/icon.svg" "$REPO/flutter/assets/icon.svg"
    echo "   logo OK"
else
    echo "   (aviso) no encontré assets/icon.svg junto al script; copia el logo manualmente."
fi

echo ""
echo "============================================================"
echo " Skin Medianoche aplicado."
echo " Reconstruye:  cd $REPO/flutter && flutter pub get && flutter run -d <plataforma>"
echo " Backups: common.dart.bak, icon.svg.bak"
echo "============================================================"
