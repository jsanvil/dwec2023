# UD3 - 2. Validación de formularios

- [Introducción](#introducción)
    - [Validación del navegador incorporada en HTML5](#validación-del-navegador-incorporada-en-html5)
    - [Validación mediante la API de validación de formularios](#validación-mediante-la-api-de-validación-de-formularios)
        - [Ejemplo](#ejemplo)
- [Expresiones regulares](#expresiones-regulares)
    - [Patrones](#patrones)
    - [Métodos](#métodos)

## Introducción

Veremos cómo realizar una de las acciones principales de _Javascript_ que es la **validación de formularios en el lado cliente**.

Se trata de una verificación útil porque evita enviar datos al servidor que sabemos que no son válidos pero **NUNCA puede sustituir a la validación en el lado servidor** ya que en el lado cliente se puede manipular el código desde la consola para que se salte las validaciones que le pongamos.

Podéis encontrar una guía muy completa de validación de formularios en el lado cliente el la página de [MDN web docs](https://developer.mozilla.org/es/docs/Learn/HTML/Forms/Validacion_formulario_datos) que ha servido como base para estos apuntes.

Básicamente tenemos 2 maneras de validar un formulario en el lado cliente:

- **`HTML5`**: Usar la **validación incorporada en HTML**5 y dejar que sea el navegador quien se encargue de todo
- **`Javascript`**: Realizar la **validación mediante _Javascript_**

La ventaja de la primera opción, `HTML5`, es que no tenemos que escribir código sino simplemente poner unos atributos a los `INPUT` que indiquen qué se ha de validar. La principal desventaja es que **no tenemos ningún control sobre el proceso**, lo que provocará cosas como:

- El navegador valida campo a campo: cuando encuentra un error en un campo lo muestra y **hasta que no se soluciona no valida el siguiente** lo que hace que el proceso sea molesto para el usuario que no ve todo lo que hay mal de una vez.
- Los **mensajes son los predeterminados** del navegador y en ocasiones pueden no ser muy claros para el usuario.
- Los mensajes se muestran en el **idioma en que está configurado** el navegador, no en el de nuestra página.

Al final, veremos una pequeña introducción a las expresiones regulares en _Javascript_.

### Validación del navegador incorporada en HTML5

Funciona añadiendo atributos a los campos del formulario que queremos validar. Los más usados son:

- **`required`**

    Indica que el campo es obligatorio. La validación fallará si no hay nada escrito en el `<input>`.
    
    En el caso de un grupo de _`radiobuttons`_ se pone sobre cualquiera de ellos (o sobre todos) y obliga a que haya seleccionada una opción cualquiera del grupo.

- **`pattern`**

    Obliga a que el contenido del campo cumpla la expresión regular indicada. _Por ejemplo_, para un código postal sería _`pattern="^[0-9]{5}$"`_

- **`minlength`** / **`maxlength`**

    Indica la longitud mínima / máxima del contenido del campo.

- **`min`** / **`max`**

    Indica el valor mínimo / máximo del contenido de un campo numérico.

También producen errores de validación si el contenido de un campo no se adapta al _**`type`**_ indicado (`email`, `number`, `email` ...) o si el valor de un campo numérico no cumple con el _`step`_ indicado.

Cuando el contenido de un campo es valido dicho campo obtiene automáticamente la pseudo-clase **`:valid`** y si no lo es tendrá la pseudo-clase **`:invalid`** lo que nos permite poner reglas en nuestro `CSS` para destacar dichos campos, por ejemplo:

```css title="style.css" hl_lines="1"
input:invalid {
  border: 2px dashed red;
}
```

La validación se realiza al enviar el formulario y al encontrar un error se muestra, se detiene la validación del resto de campos y no se envía el formulario.

### Validación mediante la API de validación de formularios

Mediante _Javascript_ tenemos acceso a todos los campos del formulario por lo que podemos hacer la validación como queramos, pero es una tarea pesada, repetitiva y que provoca _código espagueti_ difícil de leer y mantener más adelante.

Para hacerla más simple podemos usar la [API de validación de formularios](https://developer.mozilla.org/en-US/docs/Web/API/Constraint_validation) de HTML5 que permite que sea el navegador quien se encargue de comprobar la validez de cada campo pero las acciones (_mostrar mensajes de error, no enviar el formulario, ..._) las realizamos desde _Javascript_.

**Ventajas**:

- Los **requisitos de validación** de cada campo están como **atributos HTML** de dicho campo por lo que son fáciles de ver.
- **Evitamos** la mayor parte del código dedicada a **comprobar si el contenido del campo es válido**. Nosotros mediante la API sólo preguntamos si se cumplen o no y tomamos las medidas adecuadas.
- Aprovechamos las **pseudo-clases** _`:valid`_ o _`:invalid`_ que el navegador pone automáticamente a los campos por lo que no tenemos que añadirles clases para destacarlos.

Las **principales propiedades y métodos** que nos proporciona esta API son:

- **`checkValidity()`**: **Método** que nos dice si el campo al que se aplica es o no válido. También se puede aplicar al formulario para saber si es válido o no.
- **`validationMessage`**: En caso de que un campo no sea válido esta **propiedad** contiene el texto del error de validación proporcionado por el navegador. Si es válido esta propiedad es una cadena vacía.
- **[`validity`](https://developer.mozilla.org/en-US/docs/Web/API/ValidityState)**: es un **objeto** que tiene **propiedades booleanas** para saber qué requisito del campo es el que falla:
    - **`valueMissing`**: Indica si no se cumple el atributo **_`required`_** _(es decir, valdrá _`true`_ si el campo tiene el atributo _`required`_ pero no se ha introducido nada en él)_
    - **`typeMismatch`**: Indica si el contenido del campo no cumple con su atributo **_`type`_** _(ej. `type="email"`)_.
    - **`patternMismatch`**: Indica si no se cumple con el **_`pattern`_** indicado en su atributo.
    - **`tooShort`** / **`tooLong`**: Indican si no se cumple el atributo **_`minlength`_** o **_`maxlength`_** respectivamente.
    - **`rangeUnderflow`** / **`rangeOverflow`**: Indica si no se cumple el atributo **_`min`_** / **_`max`_**
    - **`stepMismatch`**: Indica si no se cumple el atributo **_`step`_** del campo.
    - **`customError`**: Indica al campo se le ha puesto un error personalizado con **_`setCustomValidity`_**
    - **`valid`**: Indica si es campo es válido.
- **`setCustomValidity(mensaje)`**: Añade un error personalizado al campo (que ahora ya NO será válido) con el mensaje pasado como parámetro. Para quitar este error se hace `setCustomValidity('')`

En la página de [W3Schools](https://www.w3schools.com/js/js_validation_api.asp) podéis ver algún ejemplo básico. A continuación tenéis un ejemplo simple del valor de las diferentes propiedades involucradas en la validación de un campo de texto que es obligatorio y cuyo tamaño debe estar entre 5 y 50 caracteres:

<script async src="//jsfiddle.net/juansegura/vbdrxjsz/embed/"></script>

Para validar un formulario nosotros pero usando esta API debemos añadir al `<FORM>` el atributo **`novalidate`** que hace que no se encargue el navegador de mostrar los mensajes de error ni de decidir si se envía o no el formulario (aunque sí valida los campos) sino que lo haremos nosotros.

#### Ejemplo

Un ejemplo sencillo de validación de un formulario podría ser:

```html title="index.html" linenums="1"
<form novalidate>
  <label for="nombre">Por favor, introduzca su nombre (entre 5 y 50 caracteres): </span>
  <input type="text" id="nombre" name="nombre" required minlength="5" maxlength="50">
  <span class="error"></label>
  <br />
  <label for="mail">Por favor, introduzca una dirección de correo electrónico: </label>
  <input type="email" id="mail" name="mail" required minlength="8">
  <span class="error"></span>
  <button type="submit">Enviar</button>
</form>
```

```js title="script.js" linenums="1"
const form  = document.getElementsByTagName('form')[0];

const nombre = document.getElementById('nombre');
const nombreError = document.querySelector('#nombre + span.error');
const email = document.getElementById('mail');
const emailError = document.querySelector('#mail + span.error');

form.addEventListener('submit', (event) => {
  if(!form.checkValidity()) {
    event.preventDefault();
  }
  nombreError.textContent = nombre.validationMessage;
  emailError.textContent = email.validationMessage;
});
```

```css title="style.css" linenums="1"
.error {
  color: red;
}

input:invalid {
  border: 2px dashed red;
}
```

Se utiliza:

- `validationMessage` para mostrar el posible error de cada campo, o quitar el error cuando el campo sea válido.
- `checkValidity()` para no enviar/procesar el formulario si contiene errores.

Si no nos gusta el mensaje del navegador y queremos personalizarlo podemos hacer una función que reciba un `<input>` y usando su propiedad `validity` devuelva un mensaje en función del error detectado:

```js title="script.js" linenums="1" hl_lines="12-13 16"
const form  = document.getElementsByTagName('form')[0];

const nombre = document.getElementById('nombre');
const nombreError = document.querySelector('#nombre + span.error');
const email = document.getElementById('mail');
const emailError = document.querySelector('#mail + span.error');

form.addEventListener('submit', (event) => {
  if(!form.checkValidity()) {
    event.preventDefault();
  }
  nombreError.textContent = customErrorValidationMessage(nombre);
  emailError.textContent = customErrorValidationMessage(email);
});

function customErrorValidationMessage(input) {

  if (input.checkValidity()) {
    return ''
  }

  if (input.validity.valueMissing) {
    return 'Este campo es obligatorio'
  }

  if (input.validity.tooShort) {
    return `Debe tener al menos ${input.minLength} caracteres` 
  }

// Y seguiremos comprobando cada atributo que hayamos usado en el HTML
  return 'Error en el campo'   // por si se nos ha olvidado comprobar algo
}
```

En lugar de `nombreError.textContent = nombre.validationMessage` hacemos `nombreError.textContent = customErrorValidationMessage(nombre)`.

Si tenemos que validar algo que no puede hacerse mediante atributos HTML (por ejemplo si el nombre de usuario ya está en uso) deberemos hacer la validación "a mano" y en caso de no ser válido ponerle un error con `.setCustomValidation()`, pero debemos recordar quitar el error si todo es correcto o el formulario siempre será inválido. Modificando el ejemplo:

```js title="script.js"
const nombre = document.getElementById('nombre');
const nombreError = document.querySelector('#nombre + span.error');

if (nombreEnUso(nombre)) {
  nombre.setCustomValidation('Ese nombre de usuario ya está en uso')
} else {
  nombre.setCustomValidation('')  // Se quita el error personalizado
}
form.addEventListener('submit', (event) => {
  if(!form.checkValidity()) {
    ...
  }
})
```

!!! note "yup"
    Existen múltiples librerías que facilitan enormemente el tedioso trabajo de validar un formulario. Un ejemplo es [yup](https://www.npmjs.com/package/yup).

!!! question "ACTIVIDAD 3: `📂 UD3/act03/`"
    Construye un formulario de registro con los siguientes campos:

    - **`Nombre de usuario`**: Requerido, entre 5 y 20 caracteres, sólo letras y números.
    - **`Contraseña`**: Requerido, entre 8 y 20 caracteres, al menos una letra mayúscula, una minúscula y un número.
    - **`Repetir contraseña`**: Requerido, debe ser igual a la `contraseña`.
    - **`E-mail`**: Requerido, debe ser un e-mail válido.
    - **`Código postal`**. Debe ser un código postal válido.
    - **`Fecha de nacimiento`**: Debe ser una fecha válida.
    - **`Acepto las condiciones`**: Requerido, _checkbox_ que debe estar marcado.
    - **`Enviar`**. Botón que envía el formulario si es válido.

    Valida el formulario usando la API de validación de formularios de HTML5 y personaliza los mensajes de error.

## Expresiones regulares

Las expresiones regulares permiten buscar un patrón dado en una cadena de texto. Se usan mucho a la hora de validar formularios o para buscar y reemplazar texto. En _Javascript_ se crean poniéndolas entre caracteres `/` (o instanciándolas de la clase _`RegExp`_, aunque es mejor de la otra forma):

```js title="script.js" linenums="1"
let cadena='Hola mundo';
let expr=/mundo/;
expr.test(cadena);
// devuelve true porque en la cadena se encuentra la expresión 'mundo'
```

### Patrones

La potencia de las expresiones regulares es que podemos usar patrones para construir la expresión. Los más comunes son:

* **`[ ]`** (corchetes): dentro se ponen varios caracteres o un rango y permiten comprobar si el carácter de esa posición de la cadena coincide con alguno de ellos. Ejemplos:
    * `[abc]`: Cualquier carácter de los indicados ('`a`' o '`b`' o '`c`').
    * `[^abc]`: Cualquiera excepto los indicados.
    * `[a-z]`: Cualquier minúscula (el carácter '`-`' **indica el rango** entre '`a`' y '`z`', incluidas).
    * `[a-zA-Z]`: Cualquier letra.
* `( | )` (_pipe_): debe coincidir con una de las opciones indicadas:
    * `(x|y)`: La letra `x` o la `y` (sería equivalente a `[xy]`).
    * `(http|https)`: Cualquiera de las 2 palabras.
* **Metacaracteres**:
    * `.` (punto): Un único carácter, sea el que sea.
    * `\d`: Un dígito (`\D`: lo opuesto, cualquier cosa menos dígito).
    * `\s`: Espacio en blanco (`\S`: lo opuesto).
    * `\w`: Una palabra o carácter alfanumérico (`\W` lo contrario).
    * `\b`: Delimitador de palabra (espacio, principio, fin).
    * `\n`: Nueva línea.
* **Cuantificadores**:
    * `+`: Al menos 1 vez (ej. `[0-9]+` al menos un dígito)
    * `*`: 0 o más veces.
    * `?`: 0 o 1 vez.
    * `{n}`: _**n**_ caracteres (ej. `[0-9]{5}` = 5 dígitos).
    * `{n,}`: _**n**_ o más caracteres.
    * `{n,m}`: Entre _**n**_ y _**m**_ caracteres.
    * `^`: Al principio de la cadena (ej.: `^[a-zA-Z]` = empieza por letra).
    * `$`: Al final de la cadena (ej.: `[0-9]$` = que acabe en dígito).
* **Modificadores**:
    * `/i`: Que no distinga entre Mayúsculas y minúsculas (Ej. `/html/i` = buscará _`html`_, _`Html`_, _`HTML`_, ...)
    * `/g`: Búsqueda global, busca todas las coincidencias y no sólo la primera.
    * `/m`: Busca en más de 1 línea (para cadenas con saltos de línea).

<!-- !!! question "ACTIVIDAD 4: `📂 UD3/act04/`"
    Construye una expresión regular para lo que se pide a continuación y pruébala con distintas cadenas:

    - Un código postal.
    - Un NIF formado por 8 números, un guion y una letra mayúscula o minúscula.
    - Un número de teléfono y aceptamos 2 formatos: XXX XX XX XX o XXX XXX XXX. EL primer número debe ser un 6, un 7, un 8 o un 9. -->

### Métodos

Los usaremos para saber si la cadena coincide con determinada expresión o para buscar y reemplazar texto:

* `expr.test(cadena)`: Devuelve **true** si la cadena coincide con la expresión. Con el modificador _`/g`_ hará que cada vez que se llama busque desde la posición de la última coincidencia. Ejemplo:

    ```js title="test.js" linenums="1"
    let str = "I am amazed in America";

    let reg = /am/g;
    console.log(reg.test(str));
    // Imprime true

    console.log(reg.test(str));
    // Imprime true

    console.log(reg.test(str));
    // Imprime false, hay solo dos coincidencias


    let reg2 = /am/gi;
    // ahora no distinguirá mayúsculas y minúsculas

    console.log(reg.test(str));
    // Imprime true

    console.log(reg.test(str));
    // Imprime true

    console.log(reg.test(str));
    // Imprime true. Ahora tenemos 3 coincidencias con este nuevo patrón
    ```

* `expr.exec(cadena)`: Igual que _`test`_ pero en vez de _`true`_ o _`false`_ devuelve un objeto con la coincidencia encontrada, su posición y la cadena completa:

    ```js title="exec.js" linenums="1"
    let str = "I am amazed in America";
    let reg = /am/gi;

    console.log(reg.exec(str));
    // Imprime ["am", index: 2, input: "I am amazed in America"]

    console.log(reg.exec(str));
    // Imprime ["am", index: 5, input: "I am amazed in America"]

    console.log(reg.exec(str));
    // Imprime ["Am", index: 15, input: "I am amazed in America"]

    console.log(reg.exec(str));
    // Imprime null
    ```

* `cadena.match(expr)`: Igual que _`exec`_ pero se aplica a la cadena y se le pasa la expresión. Si ésta tiene el modificador _`/g`_ devolverá un array con todas las coincidencias:

    ```js title="match.js" linenums="1"
    let str = "I am amazed in America";
    let reg = /am/gi;
    console.log(str.match(reg)); // Imprime ["am", "am", "Am"}
    ```

* `cadena.search(expr)`: Devuelve la posición donde se encuentra la coincidencia buscada o `-1` si no aparece.
* `cadena.replace(expr, cadena2)`: Devuelve una nueva cadena con las coincidencias de la cadena reemplazadas por la cadena pasada como segundo parámetro:

    ```js title="replace.js" linenums="1"
    let str = "I am amazed in America";
    console.log(str.replace(/am/gi, "xx"));
    // Imprime "I xx xxazed in xxerica"

    console.log(str.replace(/am/gi, function(match) {
        return "-" + match.toUpperCase() + "-";
    }));
    // Imprime "I -AM- -AM-azed in -AM-erica"
    ```

No vamos a profundizar más sobre las expresiones regulares. Es muy fácil encontrar por internet la que necesitemos en cada caso (para validar un e-mail, un NIF, un CP, ...). Podemos aprender más en:

* [w3schools](http://www.w3schools.com/jsref/jsref_obj_regexp.asp)
* [regular-expressions.info](http://www.regular-expressions.info/)
* [html5pattern](http://html5pattern.com/) atributo
* y muchas otras páginas

También, hay páginas que nos permiten probar expresiones regulares con cualquier texto, como [regexr](http://regexr.com/).
