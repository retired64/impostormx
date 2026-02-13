#  Cómo Compilar ImpostorMX usando GitHub Actions

## ¿Por qué usar GitHub Actions?

**GitHub Actions te permite compilar la aplicación directamente en la nube, sin necesidad de:**
- ❌ Instalar Flutter en tu computadora
- ❌ Configurar Android Studio o Xcode
- ❌ Descargar dependencias manualmente
- ❌ Tener conocimientos técnicos de compilación

**Solo necesitas:**
- ✅ Una cuenta de GitHub (gratis)
- ✅ Un navegador web
- ✅ 2 minutos de tu tiempo

---

## Guía Paso a Paso

### Paso 1: Haz Fork al Repositorio

1. Ve al repositorio oficial: https://github.com/retired64/ImpostorMX
2. Haz clic en el botón **"Fork"** en la esquina superior derecha
3. Confirma la creación del fork en tu cuenta

![Fork Button](https://docs.github.com/assets/cb-40742/mw-1000/images/help/repository/fork-button.webp)

**Importante:** El fork creará una copia completa del proyecto en tu cuenta de GitHub. Esto te permite compilar sin afectar el repositorio original.

---

### Paso 2: Habilita GitHub Actions (si es necesario)

GitHub Actions puede estar deshabilitado en tu fork. Para habilitarlo:

1. Ve a la pestaña **"Actions"** en tu repositorio forkeado
2. Si ves un mensaje diciendo que los workflows están deshabilitados, haz clic en **"I understand my workflows, go ahead and enable them"**

---

### Paso 3: Ejecuta el Workflow de Compilación

#### Para compilar la APK de Android:

1. En tu fork, ve a la pestaña **"Actions"**
2. En el panel izquierdo, selecciona **"Build ImpostorMX Android"**
3. Haz clic en el botón **"Run workflow"** (arriba a la derecha)
4. En el menú desplegable, asegúrate de que esté seleccionada la rama **"main"**
5. Haz clic en el botón verde **"Run workflow"**

```
Actions → Build ImpostorMX Android → Run workflow → main → Run workflow
```

#### Para otras plataformas:

El repositorio también incluye workflows para:
- **Build ImpostorMX iOS** - Compilación para iPhone/iPad (archivo IPA sin firmar)
- **Build ImpostorMX macOS** - Aplicación para Mac
- **Build ImpostorMX Linux** - Aplicación para Linux
- **Build ImpostorMX Windows** - Aplicación para Windows

El proceso es el mismo, solo selecciona el workflow que necesites.

---

### Paso 4: Espera a que Termine la Compilación

1. Una vez iniciado el workflow, verás un proceso en ejecución (círculo amarillo 🟡)
2. La compilación tarda aproximadamente **3-5 minutos**
3. Cuando termine exitosamente, verás una marca verde ✅
4. Si falla, verás una X roja ❌ (esto es raro si no modificaste el código)

---

### Paso 5: Descarga tu APK

1. Haz clic en el workflow completado (con la marca verde ✅)
2. Desplázate hacia abajo hasta la sección **"Artifacts"**
3. Verás dos archivos disponibles para descargar:
   - **impostormx-android-apk** - El archivo APK que puedes instalar en Android
   - **impostormx-android-aab** - El archivo AAB para subir a Google Play Store

4. Haz clic en **"impostormx-android-apk"** para descargar
5. Se descargará un archivo ZIP que contiene tu APK

**Nota:** Los artifacts se conservan por **30 días**. Después de ese tiempo, deberás compilar nuevamente.

---

## Instalación de la APK en Android

1. Descomprime el archivo ZIP descargado
2. Transfiere el archivo `impostormx-v1.0.0.apk` a tu dispositivo Android
3. Abre el archivo APK en tu teléfono
4. Es posible que necesites **habilitar "Instalar aplicaciones desconocidas"** en la configuración de seguridad
5. Sigue las instrucciones en pantalla para instalar

---

## Seguridad y Permisos

### ¿Es seguro instalar esta APK?

**Sí, totalmente seguro.** La aplicación ImpostorMX:

- ✅ **No requiere permisos de internet** - Es completamente offline
- ✅ **No accede a tus archivos** - No lee ni modifica datos personales
- ✅ **No requiere permisos de ubicación** - No rastrea tu posición
- ✅ **Solo usa vibración** - El único permiso es para efectos de vibración del juego
- ✅ **Código abierto** - Puedes revisar todo el código fuente
- ✅ **Compilado por ti** - Tú mismo compilas la APK, no viene de terceros

Puedes verificar los permisos en el AndroidManifest.xml:
https://github.com/retired64/ImpostorMX/blob/main/android/app/src/main/AndroidManifest.xml

### ¿Por qué Google Play Protect o mi antivirus marca advertencia?

- Es normal que apps instaladas fuera de Google Play generen una advertencia genérica
- Esto NO significa que la app sea un virus
- La advertencia aparece porque la app no está firmada por Google Play Store
- **Al compilarla tú mismo, tienes garantía total del origen del código**

---

## ¿Fork y Compilar vs Descargar Release?

### Opción 1: Compilar con GitHub Actions (Fork)
**Ventajas:**
- ✅ Tú compilas tu propia APK desde el código fuente
- ✅ Máxima transparencia y seguridad
- ✅ Puedes modificar el código si quieres personalizarlo
- ✅ Siempre tendrás acceso a compilar nuevas versiones

**Desventajas:**
- ⏱️ Toma 5 minutos compilar
- 📅 Los artifacts duran solo 30 días

### Opción 2: Descargar desde Releases
**Ventajas:**
- ⚡ Descarga inmediata
- 📦 APK lista para instalar

**Desventajas:**
- Depende de que el desarrollador publique releases

**Recomendación:** Si quieres máxima seguridad y transparencia, compila tú mismo. Si solo quieres probar el juego rápido, descarga desde Releases.

---

## Solución de Problemas

### El workflow falla al ejecutarse
- Verifica que no hayas modificado los archivos del proyecto
- Asegúrate de estar ejecutando desde la rama `main`
- Revisa los logs del workflow para ver el error específico

### No veo el botón "Run workflow"
- Asegúrate de haber habilitado GitHub Actions en tu fork
- Verifica que estés en la pestaña "Actions"
- Los workflows de este proyecto usan `workflow_dispatch`, que permite ejecución manual

### El archivo APK no instala en mi teléfono
- Habilita "Fuentes desconocidas" o "Instalar apps desconocidas" en Configuración → Seguridad
- Verifica que tu Android sea versión 5.0 o superior
- Asegúrate de haber descomprimido el archivo ZIP antes de instalar

### Los artifacts desaparecieron
- Los artifacts de GitHub Actions duran 30 días
- Simplemente ejecuta el workflow nuevamente para generar una nueva APK

---

## ❓ Preguntas Frecuentes

### ¿Necesito pagar algo?
No. GitHub Actions es gratis para repositorios públicos, y tienes 2,000 minutos gratis al mes (cada compilación usa ~5 minutos).

### ¿Puedo modificar el código y compilar mi versión?
¡Sí! Ese es el poder del código abierto. Haz los cambios que quieras en tu fork y compila tu versión personalizada.

### ¿Puedo compartir la APK que compilé?
Sí, pero es mejor compartir el enlace al repositorio para que cada persona compile su propia versión.

### ¿La APK se actualizará automáticamente?
No. Esta es una instalación manual. Para obtener actualizaciones, deberás compilar nuevamente desde el código actualizado.

### ¿Por qué no está en Google Play Store?
El desarrollador planea subirla, pero crear una cuenta de desarrollador en Google Play cuesta $25 USD. Si quieres apoyar para que esté en Play Store, considera hacer una contribución o patrocinar el proyecto.

### ¿Qué es el archivo AAB?
El archivo AAB (Android App Bundle) es el formato que requiere Google Play Store. Como usuario regular, solo necesitas el APK.

---

## ¿Qué es ImpostorMX?

ImpostorMX es un juego inspirado en Among Us, desarrollado en Flutter. Es completamente offline, de código abierto, y no requiere permisos invasivos. ¡Perfecto para jugar en cualquier momento sin conexión a internet!

---

## Contribuir

Si encuentras bugs o tienes ideas para mejorar el juego:
1. Abre un Issue en el repositorio
2. O mejor aún, haz un Pull Request con tus mejoras

---

## Soporte

- **Repositorio oficial:** https://github.com/retired64/ImpostorMX
- **Issues/Problemas:** https://github.com/retired64/ImpostorMX/issues

---

## Licencia

Este proyecto es de código abierto. Revisa el archivo LICENSE en el repositorio para más detalles.

---

**¡Disfruta compilando y jugando ImpostorMX!**
