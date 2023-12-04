# UD5 - 2. Componentes

## Introducción

Los componentes web (_WebComponents_) se pueden usar y replicar en cualquier parte de la aplicación. Si creamos nuestra propia librería de componentes, podemos reutilizarlos en cualquier proyecto.

Incorporan **lógica** (`js`), **estructura** (`html`) y **estilos** (`css`) en un único paquete.

Los componentes se representan en HTML con **etiquetas personalizadas**, que se pueden usar en cualquier parte de la aplicación.

> Referencia MDN: [Web Components](https://developer.mozilla.org/es/docs/Web/API/Web_components)

```html hl_lines="3"
<body>

    <mi-componente></mi-componente>

</body>
```

El nombre de los componentes debe ser único, para evitar conflictos y deben contener al menos un guion (**`-`**).

Principales **ventajas**:

- Reutilización de código.
- Facilita el mantenimiento.
- Facilita la colaboración entre desarrolladores.
- Diseño consistente.

Veremos cómo **usar** componentes de terceros y cómo **crear** nuestros propios componentes.

## Uso de librerías de componentes

Vamos a ver cómo usar componentes de terceros en nuestra aplicación. En este caso, vamos a usar la librería [material-web](https://m3.material.io/develop/web) que implementa _WebComponents_  basados en [Material Design](https://m3.material.io/). _Material Design_ es un sistema de diseño creado por _Google_ ampliamente utilizado en todo tipo de aplicaciones.

Este apartado servirá como introducción y profundizaremos en detalle cuando veamos [_Angular Material_](https://material.angular.io/) en la siguiente unidad.

### Instalación

Para utilizar la librería necesitaremos es muy recomendable el uso de un _bundler_, como _webpack_ o _vite_, que facilitará la importación y uso de los módulos de la librería.

!!! note "Recuerda"
    Para crear una estructura base para un proyecto con _vite_ utilizamos:
    
    ```
    npm create vite@latest
    ```
    
    Crea un directorio con el nombre del proyecto, por lo que si quieres que se cree en el directorio actual, debes ejecutar el comando desde el directorio padre.

    Una vez creado el proyecto, debemos instalar las dependencias con `npm install` (o `npm i`).

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

```js title="src/main.js" linenums="1" hl_lines="10-14"
import '@material/web/dialog/dialog.js';
import '@material/web/button/text-button.js';
import '@material/web/button/elevated-button.js';
import '@material/web/button/filled-button.js';
import '@material/web/button/filled-tonal-button.js';
import '@material/web/button/outlined-button.js';
import '@material/web/button/text-button.js';
import '@material/web/progress/circular-progress.js';

// NOTA:
//   Si no queremos importar cada componente por separado,
//   podemos importarlos todos con:
//
// import '@material/web/all.js';

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

Cómo habitualmente el comportamiento de los diálogos es que se muestren bajo demanda, por ejemplo, cuando ocurre un evento, se añade un evento `click` al botón, que llama al método `show()` del diálogo. También existe el método `close()` si necesitamos cerrarlo desde el código.

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

Con esto hemos visto una pequeña introducción a _material-web_, y siguiendo la documentación no deberíamos tener problemas para usarlo en nuestros proyectos. Cómo ya se ha comentado, profundizaremos en detalle cuando veamos [_Angular Material_](https://material.angular.io/) en la siguiente unidad.

## Componentes personalizados (_WebComponents_ nativos)

Por otra parte, también podemos crear nuestros propios componentes con el aspecto y comportamiento que necesitemos.

Veamos un ejemplo de creación de un componente simple mediante _javascript_.

Como la principal ventaja que buscamos es la encapsulación, lo primero que debemos hacer es crear un nuevo archivo, por ejemplo, `src/HelloWorld.js`, que contendrá toda la estructura, lógica y estilo del componente:

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

### Pasar atributos al componente

Pero por lo general, los componentes suelen tener un comportamiento algo más complejo. Vamos a pasarle un atributo para que se muestre un saludo personalizado:

```js title="src/HelloWorld.js" linenums="1" hl_lines="1 3 10"
class HelloWorld extends HTMLElement {

    constructor() {
        super();
        this.name = this.getAttribute('name');
    }

    connectedCallback() {
        this.innerHTML = /*html*/`
            <h1>Hola ${this.name}</h1>
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

### _Shadow DOM_, controlando el contenido del componente

Puede que hayas notado que el componente define una etiqueta de apertura y otra de cierre, pero no hay contenido entre ellas, de hecho, si añadimos contenido, no se mostrará. Esto es porque el contenido que se añade en el _html_ se sustituye por el contenido que se define en la función `connectedCallback`.

Para controlar poder controlar el contenido un componente debemos utilizar **_Shadow DOM_**, que es una característica de los componentes que permite encapsular el contenido, definiendo un **nuevo árbol DOM independiente** del DOM principal.

Para poder añadir contenido al componente, declarar  debemos usar la etiqueta `<slot>`

```js title="src/HelloWorld.js" linenums="1" hl_lines="6 10 12"
class HelloWorld extends HTMLElement {

    constructor() {
        super();
        this.name = this.getAttribute('name');
        this.attachShadow({ mode: "open" });
    }

    connectedCallback() {
        this.shadowRoot.innerHTML = /*html*/`
            <h1>Hola ${this.name}</h1>
            <slot></slot>
        `;
    }
}

customElements.define('hello-world', HelloWorld);
```

Ahora, si añadimos contenido entre las etiquetas `<hello-world>` y `</hello-world>` se mostrará en el componente:

```html title="index.html" linenums="1" hl_lines="4-7 10 13"
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

Se puede añadir cualquier contenido, incluso otros componentes.

### Añadir más de un slot

Si necesitamos crear componentes más complejos, podemos usar varios _slot_, para ello deberemos darle un nombre que los identifique en el componente con la etiqueta `name`, por ejemplo `<slot name="saludo"></slot>`. Y en el archivo _html_, añadir el atributo `slot` con el mismo nombre que hemos definido en el componente, por ejemplo `<div slot="saludo">Buenos días</div>`.

```js title="src/HelloWorld.js" linenums="1" hl_lines="11 13"
class HelloWorld extends HTMLElement {

    constructor() {
        super();
        this.name = this.getAttribute('name');
        this.attachShadow({ mode: "open" });
    }

    connectedCallback() {
        this.shadowRoot.innerHTML = /*html*/`
            <slot name="title"></slot>
            <h1>Hola ${this.name}</h1>
            <slot name="content"></slot>
        `;
    }
}

customElements.define('hello-world', HelloWorld);
```

Y desde el _html_ podemos usarlos de la siguiente forma, añadiendo el atributo `slot` a las etiquetas que queremos que se muestren en ese _slot_:

```html title="index.html" linenums="1" hl_lines="4-5"
<body>

  <hello-world name="Ana">
    <div slot="title">Buenos días</div>
    <div slot="content">
      <ul>
        <li>Lorem ipsum dolor</li>
        <li>sit amet consectetur</li>
        <li>adipisicing elit</li>
      </ul>
    </div>
  </hello-world>

</body>
```

Si comprobamos el código anterior, podremos observar que el orden de los `<slot>` se define en el componente, y es independiente del orden en el que se escriban en el _html_.

### Añadir eventos y estilos

Para añadir eventos a los componentes, podemos usar el método `addEventListener`, igual que lo haríamos con cualquier otro elemento del DOM.

Además, podemos añadir estilos al componente, que se aplicarán al componente y a su contenido, pero no afectarán al resto de la aplicación.

Es interesante utilizar el selector **`:host`** que hace referencia al estilo del componente que envuelve al _shadow DOM_. Es recomendable usarlo para definir propiedades que definan la maquetación global del componente, con propiedades como: `display`, `width`, `height`, `margin`, `padding`, `border`, `background`, etc.

```js title="src/HelloWorld.js" linenums="1" hl_lines="11 32 40 43"
class HelloWorld extends HTMLElement {

  constructor() {
      super();
      this.name = this.getAttribute('name');
      this.attachShadow({ mode: "open" });
  }

  connectedCallback() {
      this.shadowRoot.innerHTML = /*html*/`
          <style>
            :host {
                display: inline-block;
                padding: 1rem;
                margin: 1rem;
                background-color: #eee;
                border: 1px solid #333;
                border-radius: 6px;
                box-shadow: 0 2px 4px #0004;
                overflow: hidden;
                box-sizing: border-box;
            }
            h1 {
                cursor: pointer;
                user-select: none;
                transition: color 0.3s;
            }
            h1:hover {
                font-style: italic;
                text-shadow: 2px 2px #0004;
            }
          </style>

          <slot name="title"></slot>
          <h1>Hola ${this.name}</h1>
          <slot name="content"></slot>
      `;

      const headerContainer = this.shadowRoot.querySelector('h1')
      headerContainer.addEventListener('click', () => this.changeColorEvent());
  }

  changeColorEvent = () => {
      this.style.color = `#${Math.floor(Math.random()*16777215).toString(16)}`;
  }
}

customElements.define('hello-world', HelloWorld);
```

!!! question "ACTIVIDAD 2: `📂 UD5/act02/`"
    Crea los siguientes componentes personalizados:

    - `mi-card`: que muestre un título, un contenido y un pie.

        - Se le pasará el atributo `title` para el título.
        - Tendrá dos _slots_: `content` y `footer`.

        _Ejemplo:_
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

        _Ejemplo:_
        ```html
        <mi-counter></mi-counter>
        <mi-counter init="-1" min="-10"></mi-counter>
        <mi-counter init="50" min="0" max="100" step="2"></mi-counter>
        ```
    
    - Crea **dos componentes** tipo **_loader_** (animación de carga), escoge los que quieras de [https://cssloaders.github.io/](https://cssloaders.github.io/) y crea un componente para cada uno de ellos.

        Cada componente tendrá un atributo `color` que defina el color que por defecto será `#fff`
        
        Y otro atributo `speed` para la velocidad de la animación que por defecto será `1s`.

        Ponles el nombre que creas más apropiado.

        _Ejemplo:_
        ```html
        <mi-loader1></mi-loader1>
        <mi-loader2 color="#000" speed="0.5s"></mi-loader2>
        ```

    En un archivo _html_, añade los componentes creados con diferentes configuraciones, uno de ellos debe incluir `<mi-counter>` y un _loader_ dentro de `<mi-card>`.

### Comunicación entre componentes, eventos personalizados

En los ejemplos anteriores, hemos creado componentes personalizados, pero pero aún no pueden **comunicarse con el exterior**.

Para ello, podemos usar **eventos personalizados**, ([_unidad 3.1_](../../ud3/ud3-1-eventos#eventos-personalizados)). Vamos a hacer un pequeño repaso.

#### _CustomEvents_

Para crear un evento personalizado, debemos crear una instancia de la clase `CustomEvent` y pasarle como parámetro el nombre del evento. _Por ejemplo:_

```js title="CustomEvent"
const messageEvent = new CustomEvent("mi-evento-personalizado", options);
```

#### Nombre del evento

Es una buena práctica es elegir una buena **convención de nombres** para los eventos, que sea "**autoexplicativo**" en cuanto la acción que vamos a realizar y a la vez sea **coherente** y **fácil** de recordar.

Aunque no hay una forma universal de hacerlo, algunos **consejos**:

- Los eventos son _**case sensitive**_, por lo que es preferible usar todo en minúsculas.
- Evita _camelCase_, que suele inducir a dudas. Si hemos elegido minúsculas, mejor optar por _**kebab-case**_.
- Usar _**namespaces**_ y elegir un separador: _Por ejemplo_, `user:data-message` o `user.data-message`.

#### Opciones del evento

El segundo parámetro, **_`options`_**, del _CustomEvent_ es un **objeto** donde podremos especificar varios detalles en relación al comportamiento o contenido del evento.

A continuación, se muestra una lista de las propiedades que pueden contener estas opciones:

Valor | Default | Descripción
--- | --- | ---
**`detail`** | null | Objeto que contiene la información que queremos transmitir.
**`bubbles`** | false | Indica si el evento debe burbujear en el DOM "hacia la superficie"
**`composed`** | false | Indica si la propagación puede atravesar _**Shadow DOM**_
**`cancelable`** | false | Indica si el comportamiento se puede cancelar con `.preventDefault()`

#### Ejemplo de uso de eventos personalizados

Para enviar un evento personalizado, debemos crear una instancia de la clase `CustomEvent` y pasarle como parámetro el nombre del evento junto con las opciones, y después enviarlo con `dispatchEvent`.

```js title="Enviar un evento personalizado"
const customEvent = new CustomEvent("user:data-message", {
  detail: {
    from: "Paco",
    message: "Hola, ¿qué tal?",
  },
  bubbles: true,
  composed: true
});

dispatchEvent(customEvent);
```

Para escuchar un evento personalizado, registra `addEventListener` directamente sobre el elemento que lo va a recibir, o sobre el documento, para capturar todos los eventos personalizados.

```js title="Recibir un evento personalizado"
document.addEventListener("user:data-message", (event) => {
  console.log("Nuevo mensaje de " + event.detail.from);
  console.log("Mensaje: " + event.detail.message);
});
```

#### El método "mágico" `handleEvent`

Al registrar eventos, ya sean personalizados o no, dentro de una clase, tendremos problemas para acceder al objeto `this` de la clase, pues el `this` dentro de la función `addEventListener` hace referencia al elemento que recibe el evento.

Para solucionar este problema, podemos usar el método `handleEvent`, que nos permite registrar todos los eventos en un único lugar, y que se encargará de llamar al método correspondiente.

```js title="handleEvent dentro de una clase"
constructor() {
  document.getElementById("form").addEventListener("submit", this);
  document.addEventListener("user:data-message", this);
}

handleEvent = (event) => {
  switch (event.type) {
    case "user:data-message":
      console.log("Nuevo mensaje de " + event.detail.from);
      console.log("Mensaje: " + event.detail.message);
      break;

    case "submit":
      // código para el evento submit
      break;

    default:
      console.warn("evento no manejado", event);
  }
};
```

### _Ejemplo completo_: Componentes para un chat con eventos personalizados

Vamos a ilustrar todo lo aprendido hasta el momento con un ejemplo, un chat que tendrá dos componentes:

- **`<chat-input>`**: Componente que permitirá escribir y enviar un mensaje.
    - Atributo `user`: indicará el nombre del usuario que envía el mensaje.
    - Atributo `position` que indicará la posición del mensaje, que puede ser `left` o `right`.
    - Enviará un evento personalizado `chat:send-message` con la información del mensaje.
- **`<chat-messages>`**: Componente encargado de mostrar los mensajes.
    - Tendrá un listener para escuchar el evento `chat:send-message`, que tomará la información del mensaje y lo guardará en un array.
    - Cuando se renderice el componente, recorrerá el array de mensajes y mostrará todos los mensajes.

Empecemos por la creación del componente `<chat-input>`

```js title="ChatInput.js" linenums="1" hl_lines="34 41 43 53-59 62-69 72"
class ChatInput extends HTMLElement {
  constructor() {
    super();
    this.attachShadow({ mode: "open" });

    // almacena el nombre de usuario, por defecto es 'desconocido'
    this.user = this.getAttribute("user") || "desconocido";
    // genera un id único para el usuario
    this.userId = crypto.randomUUID();
    this.position = this.getAttribute("position") || "right";
  }

  connectedCallback() {
    this.render();
  }

  render() {
    this.shadowRoot.innerHTML = /*html*/ `
      <form class="chat-form">
        <label for="chatInput">${this.user}</label>
        <div class="chat-input-container">
          <input id="chatInput"
                 type="text"
                 class="chat-input"
                 placeholder="mensaje..."
                 maxlength="100" />
          <button type="submit">Enviar</button>
        </div>
      </form>
    `;

    // añade un listener al evento 'submit' del formulario
    this.shadowRoot.querySelector(".chat-form")
      .addEventListener("submit", this); 
      // Registra el evento submit en 'this'
      // esto se hace en las clases para que
      // el método 'handleEvent'
      // pueda acceder a las propiedades de la clase
  }

  handleEvent(event) {
    switch (event.type) {
      case "submit":
        // evita que se envíe el formulario y se recargue la página
        event.preventDefault();

        const input = event.target.chatInput;
        const message = input.value;
        input.value = "";
        input.focus();

        // crea un objeto con los datos a enviar
        const messageData = {
          userId: this.userId,
          user: this.user,
          message: message,
          timestamp: Date.now(),
          position: this.position,
        };

        // crea un nuevo evento personalizado
        const customEvent = new CustomEvent("chat:send-message", {
          // en 'detail' se almacenan los datos a enviar
          detail: messageData,
          // Los siguientes atributos son necesarios para que
          // el evento pueda atravesar el shadow DOM
          bubbles: true,
          composed: true,
        });

        // envía el evento personalizado
        this.dispatchEvent(customEvent);

        break;

      default:
        console.warn("evento no manejado", event);
    }
  }
}

customElements.define("chat-input", ChatInput);
```

Ahora vamos a definir el componente que recogerá y mostrará los mensajes:

```js title="ChatMessages.js" linenums="1" hl_lines="11-15 28-37"
class ChatMessages extends HTMLElement {
  constructor() {
    super();
    this.attachShadow({ mode: "open" });
    this.messages = [];
  }

  connectedCallback() {
    // Registra un listener en el documento
    // para capturar el evento 'chat:send-message'
    document.addEventListener("chat:send-message", (event) => {
      this.messages.unshift(event.detail);
      console.log(this.messages);
      this.render();
    });

    this.render();
  }

  render() {
    this.shadowRoot.innerHTML = /*html*/ `
      <div class="chat-messages-container">
        ${
          // Utiliza Array.map() para recorrer el array de mensajes
          // generando un nuevo Array que contiene strings
          // con el html que se mostrará para cada mensaje.
          // Al terminar, utiliza Array.join() para unir todos los strings
          this.messages.map((message) => `
                <div class="chat-message ${message.position}">
                    <p class="chat-message-user">${message.user}</p>
                    <p class="chat-message-text">${message.message}</p>
                    <p class="chat-message-timestamp">
                        ${new Date(message.timestamp).toLocaleString()}
                    </p>
                </div>
                `
            ).join("")
        }
      </div>
    `;
  }
}

customElements.define("chat-messages", ChatMessages);
```

Y por último, en el archivo _html_ podemos usar los componentes de la siguiente forma:

```html title="index.html" linenums="1" hl_lines="7-8 12-14"
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Component chat</title>
  <script type="module" src="ChatMessages.js"></script>
  <script type="module" src="ChatInput.js"></script>
</head>
<body>
  <div id="chat-app">
    <chat-input user="user1" position="left"></chat-input>
    <chat-input user="user2" position="right"></chat-input>
    <chat-messages></chat-messages>
  </div>
</body>
</html>
```

!!! question "ACTIVIDAD 3: `📂 UD5/act03/`"
    A partir de los componentes creados en la actividad 2; `<mi-card>`, `<mi-counter>` y dos `<mi-loader>`.

    - Partiendo de `<mi-counter>` crea un nuevo componente **`<mi-counter-emitter>`** que enviará un evento personalizado `counter:change` cada vez que se modifique el valor del contador.
    
        Dentro del evento, se enviará el valor actualizado del contador.

    - Partiendo de uno de los _loaders_, crea un nuevo componente **`<mi-loader-handled>`** que escuchará el evento `counter:change` y dependiendo del valor recibido, ajustará la velocidad de la animación.

        Recuerda que creamos los _loaders_ a partir de [https://cssloaders.github.io/](https://cssloaders.github.io/), y la velocidad de la animación se define con la propiedad _css_ `animation` o `animation-duration`, y el valor debe ser un número decimal seguido de la unidad `s` (segundos) o `ms` (milisegundos).

        _Por ejemplo, si el contador es `0`, la velocidad será `0`, si el contador es `1`, la velocidad será `0.1s`, si el contador es `20`, la velocidad será `2s`, etc. (no se pueden usar valores negativos)_

    - Muestra un componente **`<mi-card>`** que contenga un **`<mi-counter-emitter>`** y un **`<mi-loader-handled>`**.

    **Haz pruebas**. Ya sea dentro o fuera de `<mi-card>`:

    - ¿Qué ocurre si añades dos `<mi-loader-handled>`?
    - ¿Y si añades dos `<mi-counter-emitter>`? 

## Librería de creación de componentes _Lit_

[**Lit**](https://lit.dev/) es una librería de _Google_ que facilita la creación de _WebComponents_ nativos, reduciendo y simplificando la cantidad de código que hay que escribir, sin sacrificar rendimiento y con una sintaxis muy cercana a a la que acabamos de ver.

No tiene dependencias de terceros y el objetivo es mejorar la experiencia de desarrollador simplificando la creación de _WebComponents_, lo que permite acelerar la productividad de forma parecida a como lo hacen los frameworks de _Javascript_, pero enfocándose en el estándar.

!!!info "AVISO"
    **No vamos a profundizar** en el uso esta librería, pero **es necesario conocerla**, ya que se ha convertido en una de las librerías más populares para crear _WebComponents_ y seguramente la encuentres en algún proyecto.

    Con la base que hemos visto en esta unidad, no resultará difícil entender la documentación oficial y empezar a usar _Lit_.

    Si te resulta interesante y quieres saber más, puedes:
    
    - consultar la web [lit.dev](https://lit.dev/)
    - [documentación oficial](https://lit.dev/docs/)
    - realizar el [tutorial de introducción](https://lit.dev/tutorials/intro-to-lit/).

### Características

- **Elementos** personalizados

    Los componentes _Lit_ utilizan la clase **`LitElement`** que extiende la funcionalidad de la clase `HTMLElement`, por lo que el navegador los trata como elementos nativos.

- **Estilos**

    Aplica sus estilos de forma predeterminada, utilizando _Shadow DOM_. Esto mantiene los selectores de CSS simples y garantiza que los estilos del componente no afecten (ni se vean afectados por) ningún otro estilo de la página.

- Propiedades **reactivas**

    Las propiedades reactivas permiten modelar la _API_ y el estado interno de su componente. Un componente _Lit_ se vuelve a renderizar de manera eficiente cada vez que cambia una propiedad reactiva (o el atributo _HTML_ correspondiente).

- **Plantillas** declarativas

    Utiliza plantillas basadas en _template strings_, son simples, expresivas y rápidas, y permiten marcado _HTML_ junto expresiones _Javascript_ nativas. No es necesario aprender ninguna sintaxis ni se requiere compilación.
