# UD3 1. Eventos

- [Introducción](#introducción)
- [Cómo escuchar un evento](#cómo-escuchar-un-evento)
    - [Event listeners](#event-listeners)
- [Tipos de eventos](#tipos-de-eventos)
    - [Eventos de página](#eventos-de-página)
    - [Eventos de ratón](#eventos-de-ratón)
    - [Eventos de teclado](#eventos-de-teclado)
    - [Eventos de toque](#eventos-de-toque)
    - [Eventos de formulario](#eventos-de-formulario)
- [Los objetos _this_ y _event_](#los-objetos-this-y-event)
    - [_Bindeo_ del objeto _this_](#bindeo-del-objeto-this)
- [Propagación de eventos (bubbling)](#propagación-de-eventos-bubbling)
- [innerHTML y _listeners_ de eventos](#innerhtml-y-listeners-de-eventos)
- [Eventos personalizados](#eventos-personalizados)


## Introducción

Nos permiten detectar acciones que realiza el usuario o cambios que suceden en la página y reaccionar en respuesta a ellas. Existen muchos eventos diferentes (podéis ver la lista en [w3schools](https://www.w3schools.com/jsref/dom_obj_event.asp)) aunque nos centraremos en los más comunes.

Javascript permite ejecutar código cuando se produce un evento (por ejemplo el evento _click_ del ratón) asociando al mismo una función. Hay varias formas de hacerlo.

## Cómo escuchar un evento

La primera manera "estándar" de asociar código a un evento era añadiendo un atributo con el nombre del evento a escuchar (con '_on_' delante) en el elemento HTML. Por ejemplo, para ejecutar código al producirse el evento '_click_' sobre un botón se escribía:

```html title="html"
<input type="button" id="boton1" onclick="alert('Se ha pulsado');" />
```

Una mejora era llamar a una función que contenía el código:

```html title="html"
<input type="button" id="boton1" onclick="clicked()" />
```

```javascript title="js"
function clicked() {
  alert('Se ha pulsado');
}
```

Esto "ensucia" con código la página HTML por lo que se creó el modelo de registro de eventos tradicional que permitía asociar a un elemento HTML una propiedad con el nombre del evento a escuchar (con 'on' delante). En el caso anterior:

```javascript title="js"
document.getElementById('boton1').onclick = function () {
  alert('Se ha pulsado');
}
...
```

!!!note "NOTA:"
    Debemos tener cuidado porque si se ejecuta el código antes de que se haya creado el botón estaremos asociando la función al evento _click_ de un elemento que aún no existe así que no hará nada.
    
    Para evitarlo siempre es conveniente poner el código que atiende a los eventos dentro de una función que se ejecute al producirse el evento _load_ de la ventana. Este evento se produce cuando se han cargado todos los elementos HTML de la página y se ha creado el árbol DOM. Lo mismo habría que hacer con cualquier código que modifique el árbol DOM. 

    Por ejemplo:

    ```html title="html"
    <input type="button" id="boton1" value="Pulsa" />
    ```

    ```javascript title="js" hl_lines="1"
    window.onload = function() {
        document.getElementById('boton1').onclick = function() {
            alert('Se ha pulsado');
        }
    }
    ```

### Event listeners

La forma recomendada de hacerlo es usando el **modelo avanzado de registro de eventos del W3C**. Se usa el método **`addEventListener`** que recibe como primer parámetro el nombre del evento a escuchar (sin '_on_') y como segundo parámetro la función a ejecutar, sin paréntesis:

```javascript title="js" hl_lines="1"
document.getElementById('boton1').addEventListener('click', pulsado);

function pulsado() {
  alert('Se ha pulsado');
}
```

Habitualmente se usan **funciones anónimas** ya que no necesitan ser llamadas desde fuera del _listener_:

```javascript
document.getElementById('boton1').addEventListener('click', function() {
  alert('Se ha pulsado');
});
```

<!-- <script async src="//jsfiddle.net/juansegura/L5pkg93w/1/embed/js,html,result/"></script> -->

<iframe width="100%" height="300" src="//jsfiddle.net/juansegura/L5pkg93w/1/embedded/js,html,result/" allowfullscreen="allowfullscreen" allowpaymentrequest frameborder="0"></iframe>


Si queremos pasarle algún parámetro a la función _listener_ (cosa bastante poco usual) debemos usar funciones anónimas:

!!!note "NOTA:"
    Igual que antes debemos asegurarnos que se ha creado el árbol DOM antes de poner un _listener_ por lo que se recomienda ponerlos siempre dentro de la función asociada al evento `window.onload` (o mejor `window.addEventListener('load', ...)` como en el ejemplo anterior).
    
    ```javascript hl_lines="1"
    window.addEventListener('load', function() {
        ...
    })
    ```

Una ventaja de este método es que podemos poner varios _listeners_ para el mismo evento y se ejecutarán todos ellos. Para eliminar un _listener_ se usa el método `removeEventListener`.

```javascript
document.getElementById('acepto').removeEventListener('click', aceptado);
```

!!!note "NOTA:"
    No se puede quitar un _listener_ si hemos usado una función anónima, para quitarlo debemos usar como _listener_ una función con nombre.

## Tipos de eventos

Según qué o dónde se produce un evento estos se clasifican en:

### Eventos de página

Se producen en el documento HTML, normalmente en el BODY:

* **`load`**: se produce cuando termina de cargarse la página (cuando ya está construido el árbol DOM). Es útil para hacer acciones que requieran que el DOM esté cargado como modificar la página o poner _listeners_ de eventos.
* **`unload`**: al destruirse el documento (_ej. cerrar_).
* **`beforeUnload`**: antes de destruirse (_podríamos mostrar un mensaje de confirmación_).
* **`resize`**: si cambia el tamaño del documento (_porque se redimensiona la ventana_).

### Eventos de ratón

Los produce el usuario con el ratón:

* **`click`** / **`dblclick`**: cuando se hace click/doble click sobre un elemento.
* **`mousedown`** / **`mouseup`**: al pulsar/soltar cualquier botón del ratón.
* **`mouseenter`** / **`mouseleave`**: cuando el puntero del ratón entra/sale del elemento.
* **`mouseover`**/**`mouseout`**: cuando el puntero del ratón entra/sale del elemento o de cualquiera de sus descendientes (se produce en el elemento y en todos sus descendientes).
* **`mousemove`**: se produce continuamente mientras el puntero se mueva dentro del elemento.

!!!note "NOTA"
    Si hacemos **doble click** sobre un elemento la secuencia de eventos que se produciría es: _`mousedown`_ -> _`mouseup`_ -> _`click`_ -> _`mousedown`_ -> _`mouseup`_ -> _`click`_ -> _`dblclick`_

!!! question "ACTIVIDAD 1: `📂 UD3/act01/`"
    Dada la siguiente página: [calculadora](./ejercicios/calculadora.html) asocia los eventos necesarios para que funcione la calculadora.
    
    * El botón _`=`_ debe ejecutar la función _`calcular()`_ que recibe como parámetro el contenido de la caja de texto y muestra el resultado de la operación.
        * Para realizar el cálculo puedes usar la función `eval` de JavaScript que recibe como parámetro una cadena de texto con una expresión matemática y devuelve el resultado de evaluarla. Por ejemplo: `eval('2+3')` devuelve `5`.

    * El botón _`C`_ debe borrar el contenido de la caja de texto.
    * Debes poner un _listener_ al resto de botones para que al hacer click se ejecute la función _`pulsado()`_ que recibe como parámetro el valor del botón pulsado. Esta función debe mostrar en la caja de texto el valor del botón pulsado.

### Eventos de teclado

Los produce el usuario al usar el teclado:

* **`keydown`**: se produce al presionar una tecla y se repite continuamente si la tecla se mantiene pulsada
* **`keyup`**: cuando se deja de presionar la tecla

### Eventos de toque

Se producen al usar una pantalla táctil:

* **`touchstart`**: se produce cuando se detecta un toque en la pantalla táctil
* **`touchend`**: cuando se deja de pulsar la pantalla táctil
* **`touchmove`**: cuando un dedo es desplazado a través de la pantalla
* **`touchcancel`**: cuando se interrumpe un evento táctil.

### Eventos de formulario

Se producen en los formularios:

* **`focus`** / **`blur`**: al obtener/perder el foco el elemento
* **`change`**: al perder el foco un `<input>` o `<textarea>` si ha cambiado su contenido o al cambiar de valor un `<select>` o un `<checkbox>`
* **`input`**: al cambiar el valor de un `<imput>` o `<textarea>` (se produce cada vez que escribimos una letra es estos elementos)
* **`select`**: al cambiar el valor de un `<select>` o al seleccionar texto de un `<input>` o `<textarea>`
* **`submit`** / **`reset`**: al enviar/recargar un formulario

## Los objetos _this_ y _event_

Al producirse un evento se generan automáticamente el _listener_ **2 objetos**:

* **`this`**: hace referencia al elemento que contiene el código en donde se encuentra la variable _`this`_. En el caso de una función _listener_ será el elemento que tiene el _listener_ que ha recibido el evento.
* **`event`**: es un objeto y la función _listener_ lo recibe como parámetro. Tiene propiedades y métodos que nos dan información sobre el evento, como:
    * **`.type`**: qué evento se ha producido (`click`, `submit`, `keyDown`, etc.).
    * **`.target`**: el elemento donde se produjo el evento (puede ser _`this`_ o un descendiente de _`this`_, como en el ejemplo siguiente). 
    * **`.currentTarget`**: el elemento que contiene el _listener_ del evento lanzado (normalmente el mismo que _`this`_).
    
        !!! note "Ejemplo"
            Si tenemos un _`<p>`_ al que le ponemos un _listener_ de '`click`' que dentro tiene un elemento _`<span>`_, si hacemos _`click`_ sobre el _`<span>`_ **`event.target`** será el _`<span>`_ que es donde hemos hecho click (está dentro de _`<p>`_) pero tanto _`this`_ como _`event.currentTarget`_ será _`<p>`_ (que es quien tiene el _listener_ que se está ejecutando).

    * **`.relatedTarget`**: en un evento '`mouseover`' **`event.target`** es el elemento donde ha entrado el puntero del ratón y **`event.relatedTarget`** el elemento del que ha salido. En un evento '`mouseout`' sería al revés.
    * **`cancelable`**: si el evento puede cancelarse. En caso afirmativo se puede llamar a **`event.preventDefault()`** para cancelarlo
    * **`.preventDefault()`**: si un evento tiene un _listener_ asociado, se ejecuta el código de dicho _listener_ y después el navegador realiza la acción que correspondería por defecto al evento si no tuviera _listener_ (por ejemplo un _listener_ del evento _`click`_ sobre un hiperenlace hará que se ejecute su código y después saltará a la página indicada en el _`href`_ del hiperenlace). Este método cancela la acción por defecto del navegador para el evento. Por ejemplo si el evento era el _`submit`_ de un formulario éste no se enviará o si era un _`click`_ sobre un hiperenlace no se irá a la página indicada en él.
    * **`.stopPropagation`**: un evento se produce sobre un elemento y todos su padres. Por ejemplo si hacemos click en un `<span>` que está en un `<p>` que está en un `<div>` que está en el BODY el evento se va propagando por todos estos elementos y saltarían los _listeners_ asociados a todos ellos (si los hubiera). Si alguno llama a este método el evento no se propagará a los demás elementos padre.
    * **Eventos de ratón:**
        * **`.button`**: qué botón del ratón se ha pulsado (`0`: izquierdo, `1`: central (rueda); `2`: derecho).
        * **`.screenX`** / **`.screenY`**: las coordenadas del ratón respecto a la pantalla.
        * **`.clientX`** / **`.clientY`**: las coordenadas del ratón respecto a la ventana cuando se produjo el evento.
        * **`.pageX`** / **`.pageY`**: las coordenadas del ratón respecto al documento (si se ha hecho un scroll será el clientX/Y más el scroll).
        * **`.offsetX`** / **`.offsetY`**: las coordenadas del ratón respecto al elemento sobre el que se produce el evento.
        * **`.detail`**: si se ha hecho click, doble click o triple click.
    * **Eventos de teclado:** son los más incompatibles entre diferentes navegadores. En el teclado hay teclas normales y especiales (`Alt`, `Ctrl`, `Shift`, `Enter`, `Tab`, flechas, `Supr`, ...). En la información del teclado hay que distinguir entre el código del carácter pulsado (`e=101`, `E=69`, `€=8364`) y el código de la tecla pulsada (para los 3 caracteres es el 69 ya que se pulsa la misma tecla). Las principales propiedades de _`event`_ son:
        * **`.key`**: devuelve el nombre de la tecla pulsada.
        * **`.which`**: devuelve el código de la tecla pulsada.
        * **`.keyCode`** / **`.charCode`**: código de la tecla pulsada y del carácter pulsado (según navegadores).
        * **`.shiftKey`** / **`.ctrlKey`** / **`.altKey`** / **`.metaKey`**: si está o no pulsada la tecla SHIFT / CTRL / ALT / META. Esta propiedad también la tienen los eventos de ratón.

!!!note "NOTA:"
    A la hora de saber qué tecla ha pulsado el usuario es conveniente tener en cuenta:
    
    * para saber qué carácter se ha pulsado lo mejor usar la propiedad _`key`_ o _`charCode`_ de _`keyPress`_, pero varía entre navegadores.
    * para saber la tecla especial pulsada mejor usar el _`key`_ o el _`keyCode`_ de _`keyUp`_
    * captura sólo lo que sea necesario, se producen muchos eventos de teclado.
    * para obtener el carácter a partir del código: `String fromCharCode(código);`
      
Lo mejor para familiarizarse con los diferentes eventos es consultar los [ejemplos de w3schools](https://www.w3schools.com/js/js_events_examples.asp).

!!! question "ACTIVIDAD 2: `📂 UD3/act02/`"
    Añade a la calculadora del ejercicio anterior los siguientes eventos:

    * Al pulsar una tecla numérica se debe mostrar en la caja de texto el número pulsado.
    * Al pulsar una tecla de operación se debe mostrar en la caja de texto el símbolo de la operación pulsada.
    * Al pulsar la tecla _`Enter`_ se debe ejecutar la función _`calcular()`_ que recibe como parámetro el contenido de la caja de texto y muestra el resultado de la operación.
    * Al pulsar la tecla _`Backspace`_ se debe borrar el último carácter de la caja de texto.
    * Al pulsar la tecla _`Escape`_ o _`Supr`_ se debe borrar el contenido de la caja de texto.

### _Bindeo_ del objeto _this_

En ocasiones no queremos que _`this`_ sea el elemento sobre quien se produce el evento sino que queremos conservar el valor que tenía antes de entrar a la función. Por ejemplo, la función _listener_ es un método de una clase, en _`this`_ tenemos el objeto de la clase sobre el que estamos actuando pero al entrar en la función perdemos esa referencia.

El método _`.bind()`_ nos permite pasarle a una función el valor que queremos darle a la variable _`this`_ dentro de dicha función. Por defecto a un `listener` de eventos se le _bindea_ le valor de **event.currentTarget**. Si queremos que tenga otro valor se lo indicamos con **.bind()**: 

```javascript
document.getElementById('acepto').removeEventListener('click', aceptado.bind(variable));
```

En este ejemplo el valor de _`this`_ dentro de la función _`aceptado`_ será _`variable`_. En el ejemplo que habíamos comentado de un _listener_ dentro de una clase, para mantener el valor de _`this`_ y que haga referencia al objeto sobre el que estamos actuando haríamos:

```javascript
document.getElementById('acepto').removeEventListener('click', aceptado.bind(this));
```

por lo que el valor de _`this`_ dentro de la función _`aceptado`_ será el mismo que tenía fuera, es decir, el objeto.

Podemos _bindear_, es decir, pasarle al _listener_ más variables declarándolas como parámetros de _`bind`_. El primer parámetro será el valor de _this_ y los demás serán parámetros que recibirá la función antes de recibir el parámetro _`event`_ que será el último. Por ejemplo:

```javascript
document.getElementById('acepto').removeEventListener('click', aceptado.bind(var1, var2, var3));
...
function aceptado(param1, param2, event) {
  // Aquí dentro tendremos los valores
  // this = var1
  // param1 = var2
  // param2 = var3
  // event es el objeto con la información del evento producido
}
```

## Propagación de eventos (bubbling)

Normalmente en una página web los elementos HTML se solapan unos con otros, por ejemplo, un `<span>` está en un `<p>` que está en un `<div>` que está en el `<body>`. Si ponemos un _listener_ del evento _click_ a todos ellos se ejecutarán todos ellos, pero ¿en qué orden?.

Pues el W3C establecíó un modelo en el que primero se disparan los eventos de fuera hacia dentro (primero el `<body>`) y al llegar al más interno (el `<span>`) se vuelven a disparar de nuevo pero de dentro hacia afuera. La primera fase se conoce como **fase de captura** y la segunda como **fase de burbujeo**. Cuando ponemos un _listener_ con `addEventListener` el tercer parámetro indica en qué fase debe dispararse:

- **`true`**: en fase de captura
- **`false`** (valor por defecto): en fase de burbujeo

Podéis ver un ejemplo en:

<script async src="//jsfiddle.net/juansegura/n3b6fph0/embed/js,html,result/"></script>

Sin embargo si al método `.addEventListener` le pasamos un tercer parámetro con el valor _`true`_ el comportamiento será el contrario, lo que se conoce como _captura_ y el primer _listener_ que se ejecutará es el del `<body>` y el último el del `<span>` (podéis probarlo añadiendo ese parámetro al ejemplo anterior).

En cualquier momento podemos evitar que se siga propagando el evento ejecutando el método `.stopPropagation()` en el código de cualquiera de los _listeners_.

Podéis ver las distintas fases de un evento en la página [domevents.dev](https://domevents.dev/).

## innerHTML y _listeners_ de eventos

Si cambiamos la propiedad _`innerHTML`_ de un elemento del árbol DOM todos sus `listeners` de eventos desaparecen ya que es como si se volviera a crear ese elemento.

Por ejemplo, tenemos una tabla de datos y queremos que al hacer doble click en cada fila se muestre su id. La función que añade una nueva fila podría ser:

```js title="js" hl_lines="4-5" linenums="1"
function renderNewRow(data) {
  let miTabla = document.getElementById('tabla-datos');
  let nuevaFila = `<tr id="${data.id}"><td>${data.dato1}</td><td>${data.dato2}...</td></tr>`;
  miTabla.innerHTML += nuevaFila;
  document.getElementById(data.id).addEventListener('dblclick', event => alert('Id: '+ event.target.id));
}
```

Sin embargo esto sólo funcionaría para la última fila añadida ya que la línea `miTabla.innerHTML += nuevaFila` equivale a `miTabla.innerHTML = miTabla.innerHTML + nuevaFila`. Por tanto estamos asignando a _miTabla_ un código HTML que ya no contiene `listeners`, excepto el de _nuevaFila_ que lo ponemos después de hacer la asignación.

La forma correcta de hacerlo sería:

```js title="js" linenums="1" hl_lines="4-6"
function renderNewRow(data) {
  let miTabla = document.getElementById('tabla-datos');
  let nuevaFila = document.createElement('tr');
  nuevaFila.id = data.id;
  nuevaFila.innerHTML = `<td>${data.dato1}</td><td>${data.dato2}...</td>`;
  nuevaFila.addEventListener('dblclick', event => alert('Id: ' + event.target.id) );
  miTabla.appendChild(nuevaFila);
}
```

De esta forma además mejoramos el rendimiento ya que el navegador sólo tiene que renderizar el nodo correspondiente a la nuevaFila. Si lo hacemos como estaba al principio se deben volver a crear y a renderizar todas las filas de la tabla (todo lo que hay dentro de miTabla).

## Eventos personalizados

También podemos mediante código lanzar manualmente cualquier evento sobre un elemento con el método `dispatchEvent()` e incluso crear eventos personalizados, por ejemplo:

```js title="js" linenums="1"
// crear el evento
const event = new Event('build');

// escuchar el evento
elem.addEventListener( 'build', (e) => { /* ... */ }, false );

// enviar el evento
elem.dispatchEvent(event);
```

Incluso podemos añadir datos al objeto _`event`_ si creamos el evento con `new CustomEvent()`. Podéis obtener más información en la [página de MDN](https://developer.mozilla.org/en-US/docs/Web/Events/Creating_and_triggering_events).

```js title="js" linenums="1" hl_lines="2 6"
// crear el evento personalizado
const customEvent = new CustomEvent('log', { detail: { message: 'Prueba de evento personalizado' } });

// escuchar el evento
elem.addEventListener( 'log', (e) => {
    console.log(e.detail.message);
}, false );

// enviar el evento
elem.dispatchEvent(customEvent);
```

!!! abstract "PROYECTO:"
    Para comprobar tus conocimientos hasta el momento, puedes realizar el proyecto [**Clave secreta**](./ud3-proyecto-clave-secreta.md).
    
    

