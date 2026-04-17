# Segurify - Landing Page Web

Segurify es una Landing Page moderna y responsiva desarrollada en Flutter, destinada a promocionar e impulsar los servicios de un emprendimiento especializado en la instalación de cámaras de seguridad y sistemas de vigilancia.

## 🚀 Tecnologías

- **Flutter Framework** (enfocado exclusivamente en `Web`)
- **Dart**

## 💻 Requisitos Previos

Antes de comenzar, asegúrate de tener instalado en tu entorno de desarrollo local:
- [Flutter SDK](https://docs.flutter.dev/get-started/install) (asegúrate de incluir el soporte para Web)
- Navegador Web moderno (Google Chrome, Edge, etc.)
- Editor de código (VS Code, Android Studio, etc.)

## 🛠️ Configuración y Ejecución del Proyecto Web

Puesto que este proyecto está diseñado exclusivamente como un desarrollo web, sigue estos pasos para configurarlo y ejecutarlo:

1. **Clonar y descargar dependencias:**
   ```bash
   flutter pub get
   ```

2. **Ejecutar en modo de desarrollo:**
   Para lanzar la aplicación localmente en Chrome:
   ```bash
   flutter run -d chrome
   ```
   *Nota: Puedes usar el flag `--web-renderer html` o `--web-renderer canvaskit` (o `skwasm` en versiones recientes de Flutter) si necesitas probar un motor de renderizado específico.*

3. **Compilar para Producción:**
   Para compilar el proyecto y generar los archivos web listos para ser desplegados en tu hosting o servidor web, ejecuta:
   ```bash
   flutter build web --release
   ```
   Este comando generará un directorio en la ruta `/build/web/` con todos los assets, el archivo `index.html` y el código JavaScript compilado de la aplicación.

## 📦 Despliegue

Los archivos generados en `/build/web/` pueden ser subidos directamente a cualquier proveedor de hosting estático, como:
- Firebase Hosting
- GitHub Pages
- Vercel
- Netlify
- AWS S3 / CloudFront
- Cualquier servidor Apache/Nginx web hosting tradicional

## 📂 Organización de Carpetas (Referencia)

Al ser un proyecto exclusivamente Web, los directorios `/android`, `/ios`, `/windows`, `/macos` y `/linux` pueden ser ignorados en el control de versiones y el enfoque de desarrollo debe mantenerse en las carpetas `/lib` y `/web`.
