# Images folder

## Imágenes requeridas para F-Droid

### 1. icon.png (OPCIONAL pero recomendado)
- **Tamaño:** Mínimo 48x48, máximo 512x512 px (recomendado: 512x512)
- **Formato:** PNG con transparencia
- **Uso:** Icono de la app (útil si tu app no tiene icono en el APK)

### 2. featureGraphic.png (FUERTEMENTE RECOMENDADO)
- **Tamaño:** 1024x500 px (o 512x250 px)
- **Formato:** PNG o JPG
- **Orientación:** Horizontal (landscape)
- **Uso:** Banner promocional en la parte superior de la descripción en F-Droid

### 3. phoneScreenshots/ (FUERTEMENTE RECOMENDADO)
Ver carpeta `phoneScreenshots/` para más detalles.

## Imágenes opcionales adicionales:

### promoGraphic.png (opcional)
- **Tamaño:** Similar a featureGraphic pero para pantallas pequeñas
- **Formato:** PNG o JPG

### tvBanner.png (opcional)
- **Tamaño:** 1280x720 px (o 640x360 px)
- **Formato:** PNG o JPG
- **Uso:** Banner para Android TV

## Notas importantes:

1. **Tamaño de archivo:** Mantén los archivos pequeños (piensa en conexiones lentas y planes de datos limitados)
2. **Sin marcos innecesarios:** Evita bordes decorativos excesivos (el espacio en pantalla es limitado)
3. **Dispositivos móviles primero:** Estas imágenes se verán principalmente en teléfonos
4. **Coherencia visual:** Usa el mismo estilo visual en todas las imágenes

## Ubicación en el proyecto:

```
fastlane/metadata/android/
├── en-US/images/
│   ├── icon.png
│   ├── featureGraphic.png
│   └── phoneScreenshots/
│       ├── 1.png
│       ├── 2.png
│       └── ...
└── es-MX/images/
    ├── icon.png
    ├── featureGraphic.png
    └── phoneScreenshots/
        ├── 1.png
        ├── 2.png
        └── ...
```

**Nota:** Puedes usar las mismas imágenes para ambos idiomas (en-US y es-MX) si no tienes versiones localizadas.
