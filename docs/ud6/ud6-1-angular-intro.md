# UD6 - 1. Introducción a Angular

## Introducción

Angular es un **framework para el desarrollo de aplicaciones web** en el lado del cliente (_frontend_). Es decir, es un conjunto de herramientas que nos facilitan el desarrollo de aplicaciones web, y que se ejecutan en el navegador del cliente.

Está **desarrollado en _TypeScript_**. Este lenguaje es básicamente _JavaScript_ con características adicionales, las más destacables son el **tipado** de variables y funciones. Esto **mejora la depuración** de aplicaciones en tiempo de desarrollo, el **autocompletado** por parte del editor (_intellisense_), etc. Al pasar por un proceso de transpilado a _JavaScript_, el resultado será **código compatible** con todos los navegadores actuales.

Algunas de las **principales características** de _Angular_ son:

- Introduce **expresividad en el código HTML** a través de la interpolación de variables, _data-binding_, directivas, etc.
- Tiene un **diseño modular**. Sólo se importan las características que necesitamos en la aplicación (mejora de tamaño y rendimiento). Además permite separar nuestra aplicación en módulos de forma que el navegador vaya cargando en cada momento lo que necesita (lazy loading) → Mejora de tiempos de carga.
- Es fácil crear **componentes reutilizables** para la aplicación actual u otras.
- La **integración con un servidor** de _backend_ basado en servicios web es muy sencilla.
- Permite ejecutar **_Angular_ en el lado del servidor** para generar contenido estático que puedan indexar los motores de búsqueda (incapaces de ejecutar ellos _Angular_ en el cliente). Esta característica se llama _Angular Universal_ o **_Server Side Rendering_**.
- Potentes **herramientas de desarrollo y depuración**: _TypeScript_, _Angular DevTools_ (plugin de Chrome), frameworks de pruebas como _Karma_ o _Jasmine_, etc.
- **Integración con frameworks de diseño** como _Bootstrap_, _Angular Material_, _Ionic_, etc.
- Crea **aplicaciones de una página** (**SPA** - _Single Page Applications_), donde la página principal se carga entera sólo una vez → Mejor rendimiento.
- Debido a su naturaleza de **framework completo y modular**, es la solución más efectiva para desarrollar **grandes aplicaciones**.

En resumen, vamos a aprender un framework completo y muy popular, desarrollado y usado por _Google_, y con herramientas orientadas a facilitar el desarrollo de grandes aplicaciones.

## Preparar el entorno de desarrollo

Para desarrollar aplicaciones con _Angular_ necesitaremos instalar:

- [**_Node.js (lts)_**](#instalar-nodejs-lts): Es un entorno de ejecución de _JavaScript_ en el lado del servidor. Nos permite ejecutar _JavaScript_ fuera del navegador, y nos proporciona un gestor de paquetes (_npm_) para instalar librerías de terceros.
- [**_Angular CLI_**](#instalar-angular-cli): Es una herramienta de línea de comandos que nos permite crear y gestionar proyectos de _Angular_. Se instala a través de _npm_.
- [**_Visual Studio Code_**](https://code.visualstudio.com/): Es un editor de código gratuito y multiplataforma, desarrollado por _Microsoft_. Es uno de los editores más populares para desarrollar aplicaciones con _Angular_.
- [**_Git_**](https://git-scm.com/downloads): Es un sistema de control de versiones distribuido, que nos permite trabajar en equipo de forma eficiente.
- [**_Angular DevTools_**](#instalar-angular-devtools): Es un plugin para el navegador _Chrome_ que nos permite depurar aplicaciones _Angular_.
- Extensión **[_Angular Essentials (Version 16)_](#instalar-angular-essentials-para-visual-studio-code)** para **_Visual Studio Code_**: Es una extensión para _Visual Studio Code_ que nos proporciona herramientas para desarrollar aplicaciones _Angular_.


### Instalar _Node.js (lts)_

!!! note "Instalación de _Node.js_ con permisos de administrador"
    Para instalar _Node.js_, en _Windows_ podemos descargar el instalador desde la [página oficial](https://nodejs.org/en). En _Linux_ podemos instalarlo a través del gestor de paquetes de la distribución.

**En los ordenadores del aula** tendremos que instalar _Node.js_ en nuestro perfil de usuario, ya que no tenemos permisos de administrador. Para ello, utilizaremos la herramienta [**_nvm_** (_Node Version Manager_)](https://github.com/nvm-sh/nvm#installing-and-updating) que nos permite instalar y gestionar varias versiones de _Node.js_ en nuestro perfil de usuario:

- Abrimos una terminal.
- Ejecutamos el siguiente comando para instalar _`nvm`_:

    ```bash
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash
    ```

- Cerramos la terminal y la volvemos a abrir. Esto permite que recargue las variables de entorno y reconozca el comando _`nvm`_.
- Ejecutamos el siguiente comando para instalar la versión _lts_ de _Node.js_:

    ```bash title="Comando:"
    nvm install --lts
    ```

    ```bash title="Salida:"
    Downloading and installing node v20.9.0...
    Local cache found: ${NVM_DIR}/.cache/bin/node-v20.9.0-linux-x64/node-v20.9.0-linux-x64.tar.xz
    Checksums match! Using existing downloaded archive ${NVM_DIR}/.cache/bin/node-v20.9.0-linux-x64/node-v20.9.0-linux-x64.tar.xz
    Now using node v20.9.0 (npm v10.1.0)
    ```

- Ejecutamos el siguiente comando para comprobar que se ha instalado correctamente:

    ```bash title="Comando:"
    node -v; npm -v
    ```

    ```text title="Salida:"
    v20.9.0
    10.1.0
    ```

### Instalar _Angular CLI_

_Angular CLI_ es una herramienta de línea de comandos que nos permite crear y gestionar proyectos _Angular_. Para instalarla, ejecutamos el siguiente comando:

```bash
npm install -g @angular/cli
```

Para comprobar que se ha instalado correctamente, ejecutamos el siguiente comando:

```bash title="Comando:"
ng version
```

```text title="Salida:"

     _                      _                 ____ _     ___
    / \   _ __   __ _ _   _| | __ _ _ __     / ___| |   |_ _|
   / . \ | '_ \ / _` | | | | |/ _` | '__|   | |   | |    | |
  / ___ \| | | | (_| | |_| | | (_| | |      | |___| |___ | |
 /_/   \_\_| |_|\__, |\__,_|_|\__,_|_|       \____|_____|___|
                |___/
    

Angular CLI: 17.0.1
Node: 20.9.0
Package Manager: npm 10.1.0
OS: linux x64

Angular: 
... 

Package                      Version
------------------------------------------------------
@angular-devkit/architect    0.1700.1 (cli-only)
@angular-devkit/core         17.0.1 (cli-only)
@angular-devkit/schematics   17.0.1 (cli-only)
@schematics/angular          17.0.1 (cli-only)
```

### Instalar _Angular DevTools_

_Angular DevTools_ es un plugin para el navegador _Chrome_ que nos permite depurar aplicaciones _Angular_. Para instalarlo, abrimos _Chrome_ y accedemos a la [página de la extensión](https://chromewebstore.google.com/detail/angular-devtools/ienfalfjdbdpebioblfackkekamfmbnh). Pulsamos el botón **Añadir a Chrome** y confirmamos la instalación.

### Instalar _Angular Essentials_ para _Visual Studio Code_

Para instalar la extensión _Angular Essentials (Version 16)_ para _Visual Studio Code_, abrimos _Visual Studio Code_ y pulsamos el botón **Extensiones** en la barra lateral izquierda. En el cuadro de búsqueda escribimos el nombre de la extensión (_"Angular Essentials"_) y pulsamos el botón **Instalar**.

![Instalar extensión Angular Essentials](./img/angular_essentials.png)

## Creando un nuevo proyecto

_Angular CLI_ es una herramienta de línea de comandos que nos permite crear y gestionar proyectos _Angular_. Para crear un proyecto, ejecutamos el siguiente comando:

```bash
ng new angular-products
```

Mostrará un asistente para configurar el proyecto:

```text
? Which stylesheet format would you like to use? (Use arrow keys)
❯ CSS 
  SCSS   [ https://sass-lang.com/documentation/syntax#scss                ] 
  Sass   [ https://sass-lang.com/documentation/syntax#the-indented-syntax ] 
  Less   [ http://lesscss.org                                             ] 

? Do you want to enable Server-Side Rendering (SSR) and Static Site Generation (SSG/Prerendering)? (y/N) 
```

Una vez creado, debemos acceder a la carpeta del proyecto:

```bash
cd angular-products
```

Una vez creado el proyecto, podemos ejecutarlo con el siguiente comando:

```bash
ng serve
```

```text
Initial Chunk Files | Names         |  Raw Size
polyfills.js        | polyfills     |  82.71 kB | 
main.js             | main          |  23.23 kB | 
styles.css          | styles        |  95 bytes | 

                    | Initial Total | 106.04 kB

Application bundle generation complete. [1.404 seconds]
Watch mode enabled. Watching for file changes...
  ➜  Local:   http://localhost:4200/
```

Se pueden instalar librerías con el siguiente comando:

```bash
ng add @angular/material
npm i bootstrap bootstrap-icons
```

En este caso estamos instalando la librería _Angular Material_ y _Bootstrap_.

## Estructura de un proyecto _Angular_

Un proyecto _Angular_ tiene una estructura similar a la siguiente:

```text
angular-products
├── node_modules
├── src
│   ├── app
│   │   ├── app.component.css
│   │   ├── app.component.html
│   │   ├── app.component.spec.ts
│   │   ├── app.component.ts
│   │   ├── app.module.ts
│   │   └── app.routers.ts
│   ├── assets
│   │   └── ...
│   ├── favicon.ico
│   ├── index.html
│   ├── main.ts
│   └── styles.css
├── .editorconfig
├── .gitignore
├── angular.json
├── package.json
├── README.md
├── tsconfig.app.json
├── tsconfig.json
├── tsconfig.spec.json
└── tslint.json
```

- **`node_modules`**: Carpeta donde se instalan las librerías de terceros.
- **`src`**: Carpeta que contiene la aplicación
- **`src/app`**: Carpeta que contiene los componentes, servicios, etc. de la aplicación.
- **`src/assets`**: Carpeta que contiene los recursos estáticos de la aplicación (imágenes, etc.).
- **`src/index.html`**: Página HTML principal de la aplicación.
- **`src/main.ts`**: Punto de entrada de la aplicación.
- **`src/styles.css`**: Hoja de estilos global de la aplicación.
- **`angular.json`**: Archivo de configuración de _Angular_.
- **`package.json`**: Archivo de configuración de _npm_.
- **`tsconfig.json`**: Archivo de configuración de _TypeScript_.
- **`tslint.json`**: Archivo de configuración de _TSLint_.

## Componentes

Un componente es una pieza de código que encapsula la lógica y la vista de una parte de la aplicación. Un componente puede contener otros componentes, formando una estructura de árbol.

Un componente tiene una **plantilla HTML** que define la vista del componente. Esta plantilla puede contener código HTML, directivas, interpolación de variables, etc.

Un componente tiene una **clase _TypeScript_** que define la lógica del componente. Esta clase puede contener propiedades, métodos, etc.

Un componente tiene un **estilo CSS** que define el aspecto del componente. Este estilo puede ser global para toda la aplicación, o local para el componente.

### Modificar el componente principal

El componente principal de la aplicación es el componente `AppComponent`. Este componente se crea automáticamente al crear el proyecto. Podemos modificar su plantilla HTML para que muestre un mensaje de bienvenida:

```html title="src/app/app.component.html"
<h1>Hola desde {{title}}!</h1>
```

Se utiliza la interpolación de variables para mostrar el valor de la propiedad `title` de la clase `AppComponent`. Esta propiedad se inicializa en el constructor de la clase:

```typescript title="src/app/app.component.ts" linenums="1" hl_lines="13"
import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterOutlet } from '@angular/router';

@Component({
  selector: 'app-root',
  standalone: true,
  imports: [CommonModule, RouterOutlet],
  templateUrl: './app.component.html',
  styleUrl: './app.component.css'
})
export class AppComponent {
  title = 'Mi primera aplicación en Angular';
}
```

Una alternativa al uso de plantillas es el uso de _**template strings**_, por ejemplo:

```typescript title="src/app/app.component.ts" linenums="1" hl_lines="9-13"
import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterOutlet } from '@angular/router';

@Component({
  selector: 'app-root',
  standalone: true,
  imports: [CommonModule, RouterOutlet],
  template: `
    <h1>
      {{title}}
    </h1>
  `,
  styleUrl: './app.component.css'
})
export class AppComponent {
  title = 'Mi primera aplicación en Angular';
}
```

Aunque durante el curso utilizaremos plantillas HTML, es importante conocer esta alternativa.

### Bootstrap

Vamos a utilizar el framework _Bootstrap_ para maquetar la aplicación. Para ello, debemos instalarlo con _npm_:

```bash
npm install bootstrap
```

Ahora, en el archivo `src/styles.css` importamos el archivo CSS de _Bootstrap_:

```css title="src/styles.css" hl_lines="3"
/* You can add global styles to this file, and also import other style files */

@import "../node_modules/bootstrap/dist/css/bootstrap.css";

html, body { height: 100%; }
body { margin: 0; font-family: Roboto, "Helvetica Neue", sans-serif; }
```

## Crear un nuevo componente

Vamos a crear un nuevo componente llamado `products-list`. Para ello, ejecutamos el siguiente comando:

```bash
ng generate component products-list
```

Creará una carpeta con el nombre del componente `src/app/products-list`. Esta carpeta contendrá los archivos del componente.

### Modificar el componente

El componente `ProductsListComponent` se crea automáticamente al crear el componente. Podemos modificar su plantilla HTML para que muestre una lista de productos:

```html title="src/app/products-list/products-list.component.html" linenums="1"
<div class="card">
  <div class="card-header bg-primary text-white">
    {{title}}
  </div>
  <div class="card-block">
    <div class="table-responsive">
      <table class="table table-striped">
        <thead>
          <tr>
            <th>{{headers.description}}</th>
            <th>{{headers.price}}</th>
            <th>{{headers.available}}</th>
          </tr>
        </thead>
        <tbody>
          <!-- Aquí van los productos. Por ahora se queda vacío -->
        </tbody>
      </table>
    </div>
  </div>
</div>
```

Ahora, en la clase `ProductsListComponent` inicializamos las propiedades `title` y `headers`:

```typescript title="src/app/products-list/products-list.component.ts" linenums="1" hl_lines="4 11-13"
import { Component } from '@angular/core';

@Component({
  selector: 'app-products-list',
  standalone: true,
  imports: [],
  templateUrl: './products-list.component.html',
  styleUrl: './products-list.component.css'
})
export class ProductsListComponent {
  title = 'Mi lista de productos';
  headers = { description: 'Producto', price: 'Precio', available: 'Disponible' };
  constructor() { }
}
```

!!!note "prefijos de componentes"
    Debemos fijarnos en el nombre que se le ha dado al selector del componente (`app-products-list`). Este nombre lo utilizaremos para insertar el componente en la plantilla del componente principal. Le ha añadido el prefijo `app-`, esto se puede modificar en el archivo `angular.json`:

    ```json title="angular.json" linenums="1" hl_lines="11"
    {
    "$schema": "./node_modules/@angular/cli/lib/config/schema.json",
    "version": 1,
    "newProjectRoot": "projects",
    "projects": {
        "angular-products": {
        "projectType": "application",
        "schematics": {},
        "root": "",
        "sourceRoot": "src",
        "prefix": "app",
        "architect": {
            "build": {
            "builder": "@angular-devkit/build-angular:application",
            ...
    ```

### Insertar el componente en la plantilla del componente principal

Para insertar el componente `ProductsListComponent` en la plantilla del componente principal, debemos importar el componente en el archivo `src/app/app.component.ts`:

```typescript title="src/app/app.component.ts" linenums="1" hl_lines="4 9"
import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterOutlet } from '@angular/router';
import { ProductsListComponent } from './products-list/products-list.component';

@Component({
  selector: 'app-root',
  standalone: true,
  imports: [CommonModule, RouterOutlet, ProductsListComponent],
  templateUrl: './app.component.html',
  styleUrl: './app.component.css'
})
export class AppComponent {
  title = 'Angular Products';
}
```

Ahora, en la plantilla del componente principal `src/app/app.component.html` insertamos el componente `ProductsListComponent`:

```html title="src/app/app.component.html" linenums="1" hl_lines="5"
<div class="container">
  <h1>
    {{title}}
  </h1>
  <app-products-list></app-products-list>
</div>
```

## Directivas `@for` y `@if`

Vamos a añadir algunos productos, para ello, antes debemos especificar la estructura que tendrán los datos mediante una interfaz `Product`. Para crearla, ejecutamos el siguiente comando:

```bash
ng generate interface interfaces/product
```

Esto creará un archivo `src/app/interfaces/product.ts`, agregamos la siguiente interfaz:

```typescript title="src/app/interfaces/product.ts"
export interface Product {
  id: number;
  description: string;
  price: number;
  available: string;
  imageUrl: string;
  rating: number;
}
```

Ahora, si la tabla no contiene productos, directamente, no se mostrará, esto lo controlamos con la directiva `@if`:

```html title="src/app/products-list/products-list.component.html" linenums="1" hl_lines="6 21"
<div class="card">
  <div class="card-header bg-primary text-white">
    {{title}}
  </div>
  <div class="card-block">
    @if(products && products.length) {
    <div class="table-responsive">
      <table class="table table-striped">
        <thead>
          <tr>
            <th>{{headers.description}}</th>
            <th>{{headers.price}}</th>
            <th>{{headers.available}}</th>
          </tr>
        </thead>
        <tbody>
          <!-- Aquí van los productos. Por ahora se queda vacío -->
        </tbody>
      </table>
    </div>
    }
    @else {
    <div class="alert alert-info">
      No hay productos
    </div>
    }
  </div>
</div>
```

Se agrega la directiva `@else`, opcional, para mostrar un mensaje cuando no hay productos.

Ahora, en la clase `ProductsListComponent` inicializamos la propiedad `products`, que es un array de objetos `Product`, que, de momento, lo inicializamos desde código:

```typescript title="src/app/products-list/products-list.component.ts" linenums="1" hl_lines="2 15-31"
import { Component } from '@angular/core';
import { Product } from '../interfaces/product';

@Component({
  selector: 'app-products-list',
  standalone: true,
  imports: [],
  templateUrl: './products-list.component.html',
  styleUrl: './products-list.component.css'
})
export class ProductsListComponent {
  title = 'Mi lista de productos';
  headers = { description: 'Producto', price: 'Precio', available: 'Disponible' };

  products: Product[] = [
    {
      id: 1,
      description: 'SSD hard drive',
      available: '2016-10-03',
      price: 75,
      imageUrl: 'assets/ssd.jpg',
      rating: 5
    }, {
      id: 2,
      description: 'LGA1151 Motherboard',
      available: '2016-09-15',
      price: 96.95,
      imageUrl: 'assets/motherboard.jpg',
      rating: 4
    }
  ];

  constructor() { }
}
```

Por último, debemos mostrar los productos en la tabla, para ello, utilizamos la directiva `@for`:

```html title="src/app/products-list/products-list.component.html" linenums="1" hl_lines="17-23"
<div class="card">
  <div class="card-header bg-primary text-white">
    {{title}}
  </div>
  <div class="card-block">
    @if(products && products.length) {
    <div class="table-responsive">
      <table class="table table-striped">
        <thead>
          <tr>
            <th>{{headers.description}}</th>
            <th>{{headers.price}}</th>
            <th>{{headers.available}}</th>
          </tr>
        </thead>
        <tbody>
          @for(product of products; track product.id) {
          <tr>
            <td>{{product.description}}</td>
            <td>{{product.price}}</td>
            <td>{{product.available}}</td>
          </tr>
          }
        </tbody>
      </table>
    </div>
    }
    @else {
    <div class="alert alert-info">
      No hay productos
    </div>
    }
  </div>
</div>
```

La directiva `@for` tiene una propiedad `track` obligatoria, que permite especificar una propiedad del objeto que se utiliza para identificar cada elemento de la lista. Esto permite que _Angular_ pueda identificar los elementos de la lista y actualizarlos de forma eficiente.

!!!note
    La directiva `@for` es equivalente a la directiva `*ngFor`, y la directiva `@if` es equivalente a la directiva `*ngIf`. Las nuevas directivas son más expresivas y fáciles de leer, además incluyen mejoras de rendimiento.

## Actividad 1

Vamos a ir implementando poco a poco un proyecto de gestión de eventos (deportivos, conciertos, etc.).

[Actividad 1](actividades/ud6-act1.md)
