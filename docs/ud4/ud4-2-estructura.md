# UD4 - 2. Estructuración de proyectos

- [Introducción](#introducción)
- [Crear un nuevo proyecto](#crear-un-nuevo-proyecto)
    - [Desarrollar nuestro proyecto](#desarrollar-nuestro-proyecto)
    - [Paso a producción](#paso-a-producción)
- [Trabajar con distintos ficheros de código](#trabajar-con-distintos-ficheros-de-código)
    - [export](#export)
    - [import](#import)

## Introducción

Cuando trabajamos con clases la mejor forma de organizar el código es poniendo cada clase un su propio fichero javascript. Esto reduce el acoplamiento de nuestro código y nos permite reutilizar una clase en cualquier proyecto en que la necesitemos.

Sin embargo tener muchos ficheros hace que tengamos que importarlos todos, y en el orden adecuado, en nuestro _index.html_ (mediante etiquetas `<script src="...">`) lo que empieza a ser engorroso.

Para evitar este problema se utilizan las herramientas de construcción de proyectos o _module bundlers_ que unen todo el código de los distintos ficheros javascript en un único fichero que es el que se importa en el _index.html_ y hacen los mismo con los ficheros CSS.

Además proporcionan otras ventajas:

- **transpilan** el código, de forma que podemos usar sentencias javascript que aún no soportan muchos navegadores ya que se convertirán a sentencias que hacen lo mismo pero con código _legacy_
- **minimizan** y **optimizan** el código para que ocupe menos y su carga sea más rápida
- **ofuscan** el código al minimizarlo lo que dificulta que el usuario pueda ver en la consola lo que hace el programa y manipularlo

Veremos el _bundler_ **Vite** que, junto con **webpack**, son los más usados en entorno _frontend_. Junto a _npm_ tendremos una forma fácil y práctica de empaquetar el código.

Además _Vite_ incorpora un servidor de desarrollo para hacer más cómoda la creación y prueba de nuestros proyectos.

## Crear un nuevo proyecto

_Vite_ necesita _Node.js_ versión 16 o superior aunque lo mejor es tenerlo actualizado para poder utilitzar todas sus plantillas. Para crear un nuevo proyecto haremos:

```bash
npm create vite@latest
```

Al crear el proyecto nos pregunta qué framework vamos a utilizar (le diremos que _Vanilla_, es decir, _Javascript_ sin framework) y qué lenguaje usaremos _Javascript_ o Typescript.

Esto crea la estructura (_scaffolding_) de nuestro proyecto que consiste en una carpeta con el mismo nombre que el proyecto y una serie de ficheros en su interior:

Nos preguntará el nombre del proyecto, la plantilla (_Vanilla_ para Javascript sin framework) y el lenguaje que queremos usar (_Javascript/Typescript_) y se crea una carpeta con el nombre de nuestro proyecto que contiene:

- `index.html`: html con un div con _id_ **app** que es donde se cargará la app y una etiqueta **script** que carga un módulo llamado `main.js`
- `main.js`: es el punto de entrada a la aplicación .Importa los ficheros CSS, imágenes y ficheros JS con funciones o clases y establece el contenido de la página principal.
- `counter.js`: módulo JS que exporta una función como ejemplo que es usada en el _main.js_. Es un contador de ejemplo que se incrementa cada vez que se pulsa un botón, puede borrarse.
- `style.css`: fichero donde poner nuestros estilos, con CSS de ejemplo.
- `public/`: carpeta donde dejar elementos estáticos que no pasarán por _vite_ (como imágenes, ficheros CSS, ...)
- `node_modules`: librerías de las dependencias. **No debe subirse al repositorio**.
- `package.json`: fichero de configuración del proyecto. Además del nombre y la versión incluye apartados importantes:
  - `devDependences`: dependencias que se usan en desarrollo pero que no se incorporarán al código final
  - `dependences`: dependencias que sí se incluirán en el código final (librerías que estemos usando)
  - `scripts`: para ejecutar el servidor de desarrollo (`npm run dev`), generar el código final (`npm run build`), etc.

### Desarrollar nuestro proyecto

Tanto si acabamos de crear el proyecto como si lo hemos bajado de un repositorio por primera vez, deberemos instalar las dependencias que se indican en el `package.json` ejecutando:

```bash
npm install
```

Una vez instaladas las dependencias, no hace falta volver a hacerlo a no ser que se vuelva a generar, descargar el proyecto o hayamos modificado el `package.json` manualmente.

Para lanzar el servidor de desarrollo ejecutaremos:

```bash
npm run dev
```

Esto hace que _Vite_ lance un servidor web en el puerto 5173 donde podemos ver la ejecución de nuestro proyecto.

### Paso a producción

Cuando lo hayamos acabado y queramos subirlo a producción ejecutaremos

```bash
npm run build
```

que crea la carpeta `/dist` con los ficheros que debemos subir al servidor web de producción:

- `index.html`
- cualquier fichero que tengamos en _/public_
- carpeta `assets` con
  - fichero JS con todo el código que necesita el proyecto
  - fichero CSS con todos los estilos del proyecto
  - otros ficheros importados en el JS como imágenes, ...

## Trabajar con distintos ficheros de código

Para que un fichero pueda tener acceso a código de otro fichero hay que hacer 2 cosas:

1. El fichero al que queremos acceder debe **exportar** el código que desea que sea accesible desde otros ficheros. Se hace con la sentencia `export`
2. El fichero que quiere acceder a ese código debe **importarlo** a una variable. Lo haremos con `import`

### export

En el caso de un fichero con una única función a exportar la exportamos directamente, por ejemplo:

```js title="cuadrado.js"
export default const cuadrado = (value) => value * value
```

En el caso de querer exportar muchas funciones lo más sencillo es exportarlas juntas en un objeto como en el fichero _functions.js_:

```javascript title="functions.js"
function letras () {
  ...
}
function palabras () {
  ...
}
...
export default {
	letras,
	palabras,
	maysc,
	titulo,
	letrasReves,
	palabrasReves,
	palindromo
}
```

Si es un fichero que define una clase la exportamos tal cual:

```javascript title="product.class.js"
export class Product {
    constructor() {

    }
    ...
}
```

### import

En el fichero donde vayamos a usar dicho código lo importamos. Si se trata de una única función:

```javascript title="main.js"
import cuadrado from './cuadrado.js'
console.log('El cuadrado de 2 es ' + cuadrado(2))
```

Si es un fichero con muchas funciones exportadas a un objeto podemos importar todas o seleccionar las que queramos:

```javascript title="main.js"
import functions from './functions.js'
console.log('Las letras de "Hola" son ' + functions.letras("Hola") + ' y al revés es ' + functions.letrasReves('Hola'))
```

o bien:

```javascript title="main.js"
import { letras, letrasReves } from './functions.js'
console.log('Las letras de "Hola" son ' + letras("Hola") + ' y al revés es ' + letrasReves('Hola'))
```

Para usar una clase la importamos:

```javascript title="main.js"
import Product from './product.class'
const myProd = new Product()
```
