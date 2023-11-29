# UD5 - 2. Componentes

## Introducción

Los componentes se pueden usar y replicar en cualquier parte de la aplicación. Si creamos nuestra propia librería de componentes, podemos reutilizarlos en cualquier proyecto.

Incorporan **lógica** (`js`), **estructura** (`html`) y **estilos** (`css`) en un único paquete.

Los componentes se representan en HTML con **etiquetas personalizadas**, que se pueden usar en cualquier parte de la aplicación.

```html hl_lines="3"
<body>

    <mi-componente></mi-componente>

</body>
```

El nombre de los componentes debe ser único, para evitar conflictos y deben contener al menos un guión (`-`).

Principales **ventajas**:

- Reutilización de código.
- Facilita el mantenimiento.
- Facilita la colaboración entre desarrolladores.
- Diseño consistente.

Veremos cómo usar componentes de terceros y cómo crear nuestros propios componentes.

## Uso de librerías de componentes

Vamos a ver cómo usar componentes de terceros en nuestra aplicación. En este caso, vamos a usar la librería [material-web](https://m3.material.io/develop/web)

### Instalación

!!! note "Preparación del entorno"
    Usaremos `npm create vite@latest` para crear la estructura del proyecto base.

Para instalar la librería, ejecutamos el siguiente comando:

```bash
npm install @material/web
```

Es necesario consultar la documentación oficial, disponible en [https://material-web.dev/about/intro/](https://material-web.dev/about/intro/), para ver cómo se usan los componentes.

### Ejemplo de uso

Siguiendo los ejemplos de la documentación, podemos crear un componente de prueba:

```html title="index.html" hl_lines="9 16-20 25 28-39" linenums="1"
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Document</title>
  <link rel="stylesheet" href="style.css">
  <script type="module" src="src/main.js"></script>

</head>

<body>
    <h2>Botones</h2>
    <div>
        <md-elevated-button>md-elevated-button</md-elevated-button>
        <md-filled-button>md-filled-button</md-filled-button>
        <md-filled-tonal-button>md-filled-tonal-button</md-filled-tonal-button>
        <md-outlined-button>md-outlined-button</md-outlined-button>
        <md-text-button>md-text-button</md-text-button>
    </div>

    <h2>Diálogo</h2>
    <div>
        <md-elevated-button id="open-dialog">Mostrar diálogo</md-elevated-button>
    </div>

    <md-dialog id="dialog">
        <div slot="headline">
            Mi primer md-dialog
            <md-circular-progress indeterminate></md-circular-progress>
        </div>
        <form slot="content" id="form-id" method="dialog">
            Lorem ipsum dolor sit amet consectetur adipisicing elit. Quisquam, voluptatum. Quisquam, voluptatum. Quisquam,
        </form>
        <div slot="actions">
            <md-text-button form="form-id">Cerrar</md-text-button>
        </div>
    </md-dialog>

</body>

</html>
```

Se definen las etiquetas `<md->` que se pueden usar en cualquier parte de la aplicación.

Pero es importante que se carguen los ficheros `js` de la librería, para que se puedan interpretar las etiquetas personalizadas. Para ello, añadiremos el siguiente código a `src/main.js`:

```js title="src/main.js" linenums="1"
import '@material/web/dialog/dialog.js';
import '@material/web/button/text-button.js';
import '@material/web/button/elevated-button.js';
import '@material/web/button/filled-button.js';
import '@material/web/button/filled-tonal-button.js';
import '@material/web/button/outlined-button.js';
import '@material/web/button/text-button.js';
import '@material/web/progress/circular-progress.js';

const dialog = document.getElementById('dialog');
const btnOpenDialog = document.getElementById('open-dialog');

btnOpenDialog.addEventListener('click', showDialog);

function showDialog() {
    dialog.show();
}
```

Si hacemos un uso intensivo de la librería podemos importar directamente todos los componentes:

```js title="src/main.js"
import '@material/web/all.js';
```

Cómo habitualmente el comportamiento de los diálogos es que se muestren bajo demanda, por ejemplo, cuando ocurre un evento, se añade un evento `click` al botón, que llama al método `show()` del diálogo.

!!! question "ACTIVIDAD 1: `📂 UD5/act01/`"
    Sigue la documentación de _material-web_ y construye una pequeña aplicación que dado un _input_ de tipo texto y un botón, al pulsar el botón mostrará un diálogo con el texto escrito en el input.

    Por ejemplo, puedes usar los siguiente componentes:
    
    - `md-filled-text-field` para el input.
    - `elevated-button` para el botón.
    - `md-dialog` para el diálogo.

    Haz que el diálogo se cierre a los 3 segundos de mostrarse.

    Recordatorio de cómo se define un _timeout_:

    ```js title="src/main.js"
      setTimeout(() => {
        // código a ejecutar al terminar el timeout
      }, milisegundos);
    ```
    
## Crear componentes personalizados

Por otra parte, también podemos crear nuestros propios componentes con el aspecto y comportamiento que necesitemos.

Vamos a ver un ejemplo de creación de un componente simple mediante _javascript_

```js title="src/HelloWorld.js" linenums="1" hl_lines="1 3 10"
class HelloWorld extends HTMLElement {

    connectedCallback() {
        this.innerHTML = /*html*/`
            <h1>Hola Mundo</h1>
        `;
    }
}

customElements.define('hello-world', HelloWorld);
```

- En la primera línea, se define una clase que hereda de `HTMLElement`, que es la clase base de todos los elementos HTML.
- En la función `connectedCallback` se define el contenido del componente. Esta función se ejecuta cuando el componente se añade al DOM.
- Se recomienda el uso de _template literals_ para definir el contenido, dado que no suele ser estático, pueden utilizar variables, eventos, comportamiento, estilos, etc.
- En la última línea, se registra el componente con el nombre `<hello-world>` y se asocia con la clase `HelloWorld` para que el navegador sepa interpretarlo.

Para poder usarlo en nuestra aplicación, debemos importarlo en el fichero `index.html` y luego escribir la etiqueta:

```html title="index.html" hl_lines="9 14-16" linenums="1"
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Document</title>
  <link rel="stylesheet" href="style.css">
  <script type="module" src="src/HelloWorld.js"></script>
</head>

<body>

  <hello-world></hello-world>
  <hello-world></hello-world>
  <hello-world></hello-world>

</body>

</html>
```

De esta forma podemos llamar a esta pieza de código en cualquier parte de nuestra aplicación y tantas veces como haga falta.

Pero por lo general, los componentes suelen tener un comportamiento algo más complejo. Vamos a pasarle un atributo al componente para que se muestre un saludo personalizado:

```js title="src/HelloWorld.js" linenums="1" hl_lines="1 3 10"
class HelloWorld extends HTMLElement {

    constructor() {
        super();
        this.name = this.getAttribute('name');
    }

    connectedCallback() {
        this.innerHTML = /*html*/`
            <h1>Hello ${name}</h1>
        `;
    }
}

customElements.define('hello-world', HelloWorld);
```

- En el constructor, se obtiene el valor del atributo `name` y se guarda en una propiedad del componente.
- En la función `connectedCallback` se usa la propiedad `name` para mostrar el saludo.

Ahora en nuestro html podemos usar el componente de la siguiente forma:

```html title="index.html" linenums="1"
<body>

  <hello-world name="Ana"></hello-world>
  <hello-world name="Pepe"></hello-world>
  <hello-world name="Rosa"></hello-world>

</body>
```

Puede que hayas notado que el componente define una etiqueta de apertura y otra de cierre, pero no hay contenido entre ellas, de hecho, si añadimos contenido, no se mostrará. Esto es porque el contenido que se añade en el html se sustituye por el contenido que se define en la función `connectedCallback`.

Para poder añadir contenido al componente, debemos usar la etiqueta `<slot>`:

```js title="src/HelloWorld.js" linenums="1" hl_lines="1 3 10"
class HelloWorld extends HTMLElement {

    constructor() {
        super();
        this.name = this.getAttribute('name');
    }

    connectedCallback() {
        this.innerHTML = /*html*/`
            <h1>Hello ${name}</h1>
            <slot></slot>
        `;
    }
}

customElements.define('hello-world', HelloWorld);
```

Ahora, si añadimos contenido entre las etiquetas `<hello-world>` y `</hello-world>` se mostrará en el componente:

```html title="index.html" linenums="1"
<body>

  <hello-world name="Ana">
    <p>Buenos días</p>
    <div>
        <p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Quisquam, voluptatum. Quisquam, voluptatum. Quisquam,</p>
    </div>
  </hello-world>
  <hello-world name="Pepe">
    <p>Esto es otro párrafo</p>
  </hello-world>
  <hello-world name="Rosa">
    <id-card>Esto podría ser otro componente</id-card>
  </hello-world>

</body>
```

Si para crear componentes más complejos, podemos usar slots con nombre:

```js title="src/HelloWorld.js" linenums="1" hl_lines="1 3 10"
class HelloWorld extends HTMLElement {

    constructor() {
        super();
        this.name = this.getAttribute('name');
    }

    connectedCallback() {
        this.innerHTML = /*html*/`
            <slot name="title"></slot>
            <h1>Hello ${name}</h1>
            <slot name="content"></slot>
        `;
    }
}

customElements.define('hello-world', HelloWorld);
```

Y en el html:

```html title="index.html" linenums="1"
<body>

  <hello-world name="Ana">
    <h3 slot="title">Buenos días</h3>
    <div slot="content">
        <p>
            Lorem ipsum dolor sit amet consectetur adipisicing elit. Quisquam, voluptatum. Quisquam, voluptatum. Quisquam,
        </p>
    </div>
  </hello-world>

</body>
```

Podemos darnos cuenta que el orden de los `<slot>` se define en el componente, y es independiente del orden en el que se escriban en el html.

!!! question "ACTIVIDAD 2: `📂 UD5/act02/`"
    Crea los siguientes componentes personalizados:

    - `mi-card`: que muestre un título, un contenido y un pie.
        - Se le pasará el atributo `title` para el título.
        - Tendrá dos _slots_: `content` y `footer`.

        Ejemplo:
        ```html
        <mi-card title="Título">
            <div slot="content">
                <p>Contenido</p>
            </div>
            <div slot="footer">
                <p>Pie</p>
            </div>
        </mi-card>
        ```

    - `mi-counter`: que muestre que muestre un número y dos botones para incrementar y decrementar el número, tendrá los siguientes atributos:
        - `init` que indicará el valor inicial del contador. Por defecto será 0.
        - `min` que indicará el valor mínimo del contador. Por defecto será 0.
        - `max` que indicará el valor máximo del contador. Por defecto será 10.
        - `step` que indicará el incremento/decremento del contador. Por defecto será 1.
        - Los atributos pueden omitirse, y en ese caso se usarán los valores por defecto.

        Ejemplo:
        ```html
        <mi-counter></mi-counter>
        <mi-counter init="-1" min="-10"></mi-counter>
        <mi-counter init="50" min="0" max="100" step="2"></mi-counter>
        ```

    Presenta los componentes en una página _html_ y añade tres componentes con diferente configuración uno de ellos debe incluir `<mi-counter>` dentro de `<mi-card>`.
