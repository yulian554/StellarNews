# StellarNews - Aplicación iOS

Stellar News es una aplicación iOS moderna que proporciona las últimas noticias y actualizaciones sobre exploración espacial, utilizando la [API de Spaceflight News](https://spaceflightnewsapi.net/). La aplicación presenta una interfaz limpia con componentes de UIKit y SwiftUI trabajando juntos.

### Características

* **Pantalla de Inicio:** Muestra los últimos 10 artículos relacionados con el espacio
* **Funcionalidad de Búsqueda:** Busca artículos específicos basados en palabras clave
* **Detalles de Artículos:** Visualiza información detallada sobre cada artículo
* **Perfil de Usuario:** Experiencia de usuario personalizada con configuración de perfil

### Capturas de Pantalla

### Arquitectura
La aplicación está construida usando:

* **Arquitectura Limpia:** Con capas separadas de presentación, dominio y datos
* **Patrón MVVM:** Para mejor separación de responsabilidades y facilidad de pruebas
* **UIKit y SwiftUI:** Enfoque híbrido con frameworks de UI heredados y modernos
* **Swift Package Manager:** Para gestionar dependencias

### Requisitos

* iOS 17.0+
* Xcode 16.2
* Swift 6

### Instalación

Clona el repositorio: git clone https://github.com/yulian554/StellarNews.git

### Dependencias

* **SDWebImage POD:** Para carga y almacenamiento eficiente de imágenes
* **SkeletonView POD:** Para animaciones de carga
* **Alamofire SPM:** Para peticiones de red

### API
Este proyecto utiliza la [API de Spaceflight News](https://spaceflightnewsapi.net/), que proporciona información sobre noticias relacionadas con el espacio de diversas fuentes.

### Configuración del Entorno de Desarrollo
El proyecto incluye dos esquemas:

* **StellarNews:** Versión de producción
* **StellarNewsDev:** Versión de desarrollo con funciones de depuración adicionales

Selecciona el esquema apropiado según tus necesidades de desarrollo.

### Pruebas
El proyecto incluye pruebas unitarias para todas las capas de la aplicación. Para ejecutar las pruebas:

* Selecciona el esquema StellarNews
* Presiona ⌘+U

Agradecimientos

* [API de Spaceflight News](https://spaceflightnewsapi.net/) por proporcionar los datos
* La comunidad de código abierto por las increíbles herramientas y bibliotecas