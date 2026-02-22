Proyecto de Pruebas Automatizadas con Karate

Este proyecto contiene un conjunto de pruebas automatizadas para la API [ServeRest](https://serverest.dev), desarrolladas utilizando el framework Karate. Las pruebas cubren varios endpoints, incluyendo la creación, obtención, actualización y eliminación de usuarios y productos.

Por Luigi Villanueva Perez - Hice una modificación en README

## 1. Prerrequisitos

Antes de ejecutar las pruebas, asegúrate de tener instalado y configurado lo siguiente en tu sistema:

*   **Java 17:** El proyecto está configurado para usar Java 17.
*   **Apache Maven:** Se utiliza para la gestión de dependencias y la ejecución de las pruebas.
*   **Variables de Entorno:**
    *   `JAVA_HOME`: Debe apuntar al directorio de instalación de tu JDK 17.
    *   `M2_HOME`: Debe apuntar al directorio de instalación de Maven.
    *   Asegúrate de que las carpetas `bin` de Java y Maven estén incluidas en la variable `Path` de tu sistema operativo.

## 2. Ejecución de las Pruebas

Todas las pruebas se ejecutan desde la línea de comandos, ubicándote en la raíz del proyecto.

### Ejecutar todos los casos de prueba (Regresión)

Para ejecutar el conjunto completo de pruebas de regresión, utiliza el siguiente comando. Este comando apunta al runner `ServerRestRunner` y ejecuta todos los escenarios etiquetados con `@regresion` en el entorno de certificación (`cert`).

```bash
mvn clean test -Dtest=UsersRunner -Dkarate.options="--tags @regresion" -Dkarate.env=dev