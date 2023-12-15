# UD5 - 3. Comunicación asíncrona

## Promesas

Las promesas son un concepto para resolver el problema de asincronía de una forma mucho más elegante y práctica que, por ejemplo, utilizando funciones _callback_ directamente.

Las promesas pueden tener varios estados:

- Resuelta. La promesa se cumple
- Rechazada. La promesa no se cumple
- Pendiente. La promesa se queda en un estado incierto indefinidamente

Con estas sencillas bases, podemos entender el funcionamiento de una promesa en Javascript. Antes de empezar, también debemos tener claro que existen dos partes importantes de las promesas:

- Consumirlas
- Crearlas, preparar una función para que use promesas y se puedan consumir.

Las promesas en _Javascript_ se representan a través de un objeto, y cada promesa estará en un estado concreto: pendiente, resuelta o rechazada. Además, cada promesa tiene los siguientes métodos, que podremos utilizar para utilizarla:

- **`.then(resolve)`**: ejecuta la función _callback_ `resolve` cuando la promesa se cumple.
- **`.catch(reject)`**: ejecuta la función _callback_ `reject` cuando la promesa se rechaza.
- **`.then(resolve, reject)`**: Método equivalente a los dos anteriores contenido en un solo método.
- **`.finally()`**: ejecuta la función _callback_ `finally` cuando la promesa se cumple o si se rechaza.

### Consumir promesas

La forma general de consumir una promesa es utilizando el `.then()` con un sólo parámetro, puesto que muchas veces lo único que nos interesa es realizar una acción cuando la promesa se cumpla:

```js
fetch("/datos.json").then(function(response) {
  /* Código a realizar cuando se cumpla la promesa */
});
```

Lo que vemos en el ejemplo anterior es el uso de la función `fetch()`, la cuál devuelve una promesa que se cumple cuando obtiene respuesta de la petición realizada. De esta forma, estaríamos preparando (de una forma legible) la forma de actuar de nuestro código a la respuesta de la petición realizada, todo ello de forma asíncrona.

Recuerda que podemos hacer uso del método `.catch()` para actuar cuando se rechaza una promesa:

```js
fetch("/datos.json")
  .then(function(response) {
    /* Código a realizar cuando se cumpla la promesa */
  })
  .catch(function(error) {
    /* Código a realizar cuando se rechaza la promesa */
  });
```

Observa como hemos indentado los métodos `.then()` y `.catch()`, ya que se suele hacer así para que sea mucho más legible. Además, se pueden encadenar varios `.then()` si se siguen generando promesas y se devuelven con un return:

```js
fetch("/datos.json")
  .then(response => {
    return response.text(); // Devuelve una promesa
  })
  .then(data => {
    console.log(data);
  })
  .catch(error => { /* Código a realizar cuando se rechaza la promesa */ });
```

Usando arrow functions se puede mejorar aún más la legibilidad de este código, recordando que cuando sólo tenemos una sentencia en el cuerpo de la arrow function hay un return implícito:

```js
fetch("/datos.json")
  .then(response => response.text())
  .then(data => console.log(data))
  .finally(() => console.log("Terminado."))
  .catch(error => console.error(data));
```

Se añade el método .finally() para añadir una función _callback_ que se ejecutará tanto si la promesa se cumple o se rechaza, lo que nos ahorrará tener que repetir la función en el `.then()` como en el `.catch()`.

### Código asíncrono

Algo muy importante, pero que quizás hemos pasado por alto es que el código que ejecutamos en el interior de un `.then()` es código asíncrono no bloqueante:

- **Asíncrono**: Porque no se ejecuterá de inmediato, sino que tardará en ejecutarse.
- **No bloqueante**: Porque mientras espera ser ejecutado, no bloquea el resto del programa.

Cuando llegamos a un `.then()`, el sistema no se bloquea, sino que deja la función «pendiente» hasta que se cumpla la promesa, pero mientras, continua procesando el resto del programa.

Observa el siguiente ejemplo:

```js
fetch("/datos.json")
  .then(response => response.text())
  .then(data => {
    console.log("Código asíncrono");
  });

console.log("Código síncrono")
```

Aunque el `console.log("Código asíncrono")` figure unas líneas antes del `console.log("Código síncrono")`, se mostrará más tarde. Esto ocurre porque el `console.log()` del interior del `.then()` no ocurre inmediatamente, y al no ser bloqueante, se continua con el resto del programa hasta que se ejecute, que lo retomará.

### Crear promesas

Para crear una promesa se utiliza el objeto `Promise`, de la siguiente forma `new Promise((resolve, reject) => { })` se le pasa por parámetro una función anónima con dos parámetros de _callback_:

- **`resolve`**. Lo utilizaremos cuando se cumpla la promesa.
- **`reject`**. Lo utilizaremos cuando se rechace la promesa.

Ejemplo de creación de una promesa:

```js
// Ejemplo sencillo donde se va llenando un array con números aleatorios
// se aparece un 6 se rechaza la promesa
  const doTask = (iterations) => {
    return new Promise((resolve, reject) => {
      const numbers = [];

      for (let i = 0; i < iterations; i++) {
        const number = 1 + Math.floor(Math.random() * 6);
        numbers.push(number);
        if (number === 6) {
          reject({
            error: true,
            message: "Se ha sacado un 6"
          });
        }
      }

      resolve({
        error: false,
        value: numbers
      });
    });  // new Promise
  }; // doTask
```

Como ves, se trata de una implementación muy similar a los callbacks que vimos en el apartado anterior, pero observa que se devuelve una  que envuelve toda la función, permitiendo así consumirla cómodamente más tarde:

```js
doTask(10)
  .then(result => console.log("Tiradas correctas: ", result.value))
  .catch(err => console.error("Ha ocurrido algo: ", err.message));
```

Imagina el caso de que cada lanzamiento del dado (la parte donde genera el número aleatorio) fuera un proceso más costoso que tardara un tiempo considerable, quizás de esa forma se vea más clara la necesidad de una tarea asíncrona, controlada con promesas.

## Async / Await

En _ES2017_ se introducen las palabras clave `async`/`await`, que no son más que una forma para gestionar las promesas. 

Con `async`/`await` seguimos manejando promesas, sin embargo, hay ciertos cambios importantes:

- El código se vuelve más legible, ya que se parece más a código síncrono.
- Se puede utilizar `try`/`catch` para gestionar los errores de una forma más cómoda.
- Se puede utilizar `await` para esperar a que se cumpla una promesa, y así evitar el uso de `.then()`.

### Await

La palabra clave `await` se utiliza para esperar a que se cumpla una promesa, y así evitar el uso de `.then()`.

```js
const response = await fetch("datos.txt");
const data = await response.text();
console.log(data);

console.log("Código síncrono.");
```

Lo que hace `await` es detener la ejecución y no continuar. Se espera a que se resuelva la promesa, y hasta que no lo haga, no continua. A diferencia del `fetch()`, tenemos un código bloqueante.

Lo normal es que se utilice `await` dentro de una función. Por ejemplo:

```js
function request() {
  const response = await fetch("datos.txt");
  const data = await response.text();
  return data;
}

request();
```

Sin embargo, aquí tenemos un problema. Estamos utilizando `await` (asíncrono) dentro de `request()` (síncrono), por lo que antes de ejecutarla, al intentarla definir, nos aparecerá el siguiente error:

```
Uncaught SyntaxError: await is only valid in async functions and the top level bodies of modules
```

Para solucionarlo, debemos indicar que la función `request()` es asíncrona, utilizando la palabra clave `async`

### Async

Para resolver el problema anterior y poder utilizar el await dentro de nuestra función, sólo tenemos que definir nuestra función como función asíncrona y al llamarla utilizar nuevamente el `await`:

```js
async function request() {
  const response = await fetch("datos.txt");
  const data = await response.text();
  return data;
}

await request();
```

Sin embargo, vamos a pararnos un poco a pensar esto desde las bases. Definamos dos funciones básicas exactamente iguales, ambas devuelven lo mismo, pero una es síncrona y otra asíncrona:

```js
function sincrona() { return 42; }
async function asincrona() { return 42; }

sincrona();   // 42
asincrona();  // Promise <fulfilled>: 42
```

En el caso de la función `sincrona()` devuelve directamente el valor, sin embargo, en el caso de la función `asincrona()` devuelve una promesa que se ha cumplido inmediatamente, con el valor 42.

Si queremos reescribirlas como _arrow function_, se definiría como vemos a continuación, colocando el `async` justo antes de los parámetros de la _arrow function_:

```js
const sincrona = () => 42;
const asincrona = async () => 42;
```

### Await/Async + .then()

En algunos casos, como al usar un `fetch()`, donde tenemos que manejar dos promesas, es posible que nos interese utilizar `.then()` para la primera promesa y `await` para la segunda. De esta forma podemos manejarlo todo directamente, sin tener que guardarlo en constantes o variables temporales que no utilizaremos sino una sola vez:

```js
async function request() {
  return await fetch("datos.txt")
      .then(response => response.text());
}

await request();
```

En este caso, observa que el `fetch()` devuelve una primera _Promise_ que es manejada por el `.then()`. La segunda _Promise_, devuelta por el método `response.text()` se devuelve hacia fuera y es manejada por el `await`, que espera a que se cumpla, y una vez cumplida, se devuelve como valor de la función `request()`.

### Asincronía en async/await

Volvamos al ejemplo de las tiradas de dados. La función `doTask()` realiza 10 lanzamientos de un dado y nos devuelve los resultados obtenidos o detiene la tarea si se obtiene un 6. La implementación de la función sufre algunos cambios, simplificándose considerablemente.

- En primer lugar, añadimos la palabra clave `async` antes de los parámetros de la _arrow function_.
- En segundo lugar, desaparece cualquier mención a promesas, se devuelven directamente los objetos, ya que al ser una función `async` se devolverá todo envuelto en una _Promise_:

```js
const doTask = async (iterations) => {
  const numbers = [];

  for (let i = 0; i < iterations; i++) {
    const number = 1 + Math.floor(Math.random() * 6);
    numbers.push(number);
    if (number === 6) {
      return {
        error: true,
        message: "Se ha sacado un 6"
      };
    }
  }

  return {
    error: false,
    value: numbers
  };
}
```

Pero donde se introducen cambios considerables es a la hora de consumir las promesas con `async`/`await`. No tendríamos que utilizar `.then()`, sino que podemos simplemente utilizar `await` para esperar la resolución de la promesa, obteniendo el valor directamente:

```js
const resultado = await doTask(10);   // Devuelve un objeto, no una promesa
```

Observa que el `await` se utiliza dentro de una función `async`, por lo que la función que lo contenga debe ser asíncrona:

```js
async function consume() {
  const result = await doTask(10);
  if (result.error) {
      console.log("Error: ", result.message);
  } else {
      console.log("Los números son: ", result.value);
  }
}
```

!!! question "ACTIVIDAD 4: `📂 UD5/act04/`"
    - Crea un fichero `index.html` con un **botón** que al pulsarlo llame a la función `getRandomMessage()`.
    - Crea un fichero `script.js` con la función `getRandomMessage()` y la función `getMessages()`.
    - Descarga el archivo [`jokes.txt`](https://raw.githubusercontent.com/yesinteractive/dadjokes/master/controllers/jokes.txt) y guárdalo en la carpeta `UD5/act04/`.
    - La función `getMessages()` hará un `fetch()` a `jokes.txt` y devolverá una promesa con el texto.
    - La función `getRandomMessage()` debe llamar a `getMessages()` dividir el texto en líneas (`.split('\n')`) y devolver una línea aleatoria que aparecerá en un `alert()`.

## Peticiones Ajax

AJAX es el acrónimo de **_Asynchronous Javascript And XML_** (Javascript asíncrono y XML) y es lo que usamos para hacer peticiones asíncronas al servidor desde Javascript. Cuando hacemos una petición al servidor no nos responde inmediatamente (la petición tiene que llegar al servidor, procesarse allí y enviarse la respuesta que llegará al cliente). 

Lo que significa **asíncrono** es que la página no permanecerá bloqueada esperando esa respuesta sino que continuará ejecutando su código e interactuando con el usuario, y en el momento en que llegue la respuesta del servidor se ejecutará la función que indicamos al hacer la llamada Ajax. Respecto a **XML**, es el formato en que se intercambia la información entre el servidor y el cliente, aunque actualmente el formato más usado es **JSON** que es más simple y legible.

Básicamente Ajax nos permite poder mostrar nuevos datos enviados por el servidor sin tener que recargar la página, que continuará disponible mientras se reciben y procesan los datos enviados por el servidor en segundo plano.

<a title="By DanielSHaischt, via Wikimedia Commons [CC BY-SA 3.0 
 (https://creativecommons.org/licenses/by-sa/3.0
)], via Wikimedia Commons" href="https://commons.wikimedia.org/wiki/File:Ajax-vergleich-en.svg"><img width="512" alt="Ajax-vergleich-en" src="https://upload.wikimedia.org/wikipedia/commons/thumb/0/0b/Ajax-vergleich-en.svg/512px-Ajax-vergleich-en.svg.png"></a>

Sin Ajax cada vez que necesitamos nuevos datos del servidor la página deja de estar disponible para el usuario hasta que se recarga con lo que envía el servidor. Con Ajax la página está siempre disponible para el usuario y simplemente se modifica (cambiando el DOM) cuando llegan los datos del servidor:

![Uniwebsidad: Introducción a Ajax](https://uniwebsidad.com/static/libros/imagenes/ajax/f0103.gif)
_Fuente Uniwebsidad_

### Métodos HTTP

Las peticiones Ajax usan el protocolo HTTP (el mismo que utiliza el navegador para cargar una página). Este protocolo envía al servidor unas cabeceras HTTP (con información como el _userAgent_ del navegador, el idioma, etc), el tipo de petición y, opcionalmente, datos o parámetros (por ejemplo en la petición que procesa un formulario se envían los datos del mismo).

Hay diferentes tipos de petición que podemos hacer:

* **`GET`**: suele usarse para **obtener datos** sin modificar nada (equivale a un `SELECT` en _SQL_). Si enviamos datos (ej. la `ID` del registro a obtener) suelen ir en la _url_ de la petición (formato _URIEncoded_). Ej.: `locahost/users/3`, [https://jsonplaceholder.typicode.com/users](https://jsonplaceholder.typicode.com/users)
* **`POST`**: suele usarse para **añadir un dato** en el servidor (equivalente a un `INSERT` de _SQL_). Los datos enviados van en el cuerpo de la petición HTTP (igual que sucede al enviar desde el navegador un formulario por _POST_)
* **`PUT`**: es similar al _POST_ pero suele usarse para **actualizar datos** del servidor (como un `UPDATE` de _SQL_). Los datos se envían en el cuerpo de la petición (como en el _POST_) y la información para identificar el objeto a modificar en la url (como en el `GET`). El servidor hará un `UPDATE` sustituyendo el objeto actual por el que se le pasa como parámetro
* **`PATCH`**: es similar al _PUT_ pero la diferencia es que en el _PUT_ hay que pasar todos los campos del objeto a modificar (los campos no pasados se eliminan del objeto) mientras que en el _PATCH_ sólo se pasan los campos que se quieren cambiar y en resto permanecen como están.
* **`DELETE`**: se usa para eliminar un dato del servidor (como un `DELETE` de _SQL_). La información para identificar el objeto a eliminar se envía en la url (como en el _GET_)

El servidor acepta la petición, la procesa y le envía una respuesta al cliente con el recurso solicitado y además unas cabeceras de respuesta (con el tipo de contenido enviado, el idioma, etc) y el código de estado. Los códigos de estado más comunes son:

- `2xx`: son peticiones procesadas **correctamente**. Las más usuales son `200` (_ok_) o `201` (_created_, como respuesta a una petición _POST_ satisfactoria)
- `3xx`: son códigos de **redirección** que indican que la petición se redirecciona a otro recurso del servidor, como `301` (el recurso se ha movido permanentemente a otra URL) o `304` (el recurso no ha cambiado desde la última petición por lo que se puede recuperar desde la caché)
- `4xx`: indican un **error** por parte del **cliente**, como `404` (_Not found_, no existe el recurso solicitado) o `401` (_Not authorized_, el cliente no está autorizado a acceder al recurso solicitado)
- `5xx`: indican un **error** por parte del **servidor**, como `500` (error interno del servidor) o `504` (_timeout_, el servidor no responde).

En cuanto a la información enviada por el servidor al cliente normalmente serán datos en formato **JSON** o XML (cada vez menos usado) que el cliente procesará y mostrará en la página al usuario. También podría ser HTML, texto plano, etc.

El formato _JSON_ es una forma de convertir un objeto Javascript en una cadena de texto para poderla enviar, por ejemplo el objeto

```javascript
let alumno = {
  id: 5,
  nombre: Marta,
  apellidos: Pérez Rodríguez
}
```

se transformaría en la cadena de texto

```javascript
{ "id": 5, "nombre": "Marta", "apellidos": "Pérez Rodríguez" }
```

y el array

```javascript
let alumnos = [
  {
    id: 5,
    nombre: "Marta",
    apellidos: "Pérez Rodríguez"
  },
  {
    id: 7,
    nombre: "Joan",
    apellidos: "Reig Peris"
  },
]
```

en la cadena:

```javascript
[{ "id": 5, "nombre": Marta, "apellidos": Pérez Rodríguez }, { "id": 7, "nombre": "Joan", "apellidos": "Reig Peris" }]
```

Para convertir objetos en cadenas de texto _JSON_ y viceversa Javascript proporciona 2 funciones:

- **JSON.stringify(_objeto_)**: recibe un objeto JS y devuelve la cadena de texto correspondiente. Ej.: `const cadenaAlumnos = JSON.stringify(alumnos)`
- **JSON.parse(_cadena_)**: realiza el proceso inverso, convirtiendo una cadena de texto en un objeto. Ej.: `const alumnos = JSON.parse(cadenaAlumnos)`

## _API Fetch_

La [API Fetch](https://developer.mozilla.org/es/docs/Web/API/Fetch_API/Utilizando_Fetch) permite realizar una petición Ajax genérica que directamente devuelve en forma de **promesa**. 

La API Fetch proporciona una interfaz _JavaScript_ para acceder y manipular partes del canal HTTP, tales como peticiones y respuestas. También provee un método global `fetch()` que proporciona una forma fácil y lógica de obtener recursos de forma asíncrona por la red.

- **_`fetch`_ devuelve los datos "en crudo"** por lo que si la respuesta está en formato JSON habrá con convertirlos. Para ello dispone del método **_`.json()`_** que hace el `JSON.parse`. Este método devuelve una nueva promesa a la que nos suscribimos con un nuevo _`.then()`_. Ejemplo.:

    ```javascript
    fetch('https://jsonplaceholder.typicode.com/posts?userId=' + idUser)
    .then(response => response.json())    // los datos son una cadena JSON
    .then(myData => {
        // ya tenemos los datos en _myData_ como un objeto o array
        // Aquí procesamos los datos
        console.log(myData)
    }) 
    .catch(err => console.error(err));
    ```

- **_`fetch`_ llama a _`resolve`_ siempre que el servidor conteste**, sin comprobar si la respuesta es de éxito (`200`, `201`, etc.) o de error (`4xx`, `5xx`). Por tanto siempre se ejecutará el _`then`_ excepto si se trata de un error de red y el servidor no responde.

#### Propiedades y métodos de la respuesta

La respuesta devuelta por _`fetch()`_ tiene las siguientes propiedades y métodos:

- **`status`**: el **código de estado** devuelto por el servidor (`200`, `404`, etc.)
- **`statusText`**: el texto correspondiente a ese código (`Ok`, `Not found`, etc.)
- **`ok`**: booleano que vale _`true`_ si el status está entre `200` y `299` y _`false`_ en caso contrario
- **`json()`**: devuelve una promesa que se resolverá con los datos de la respuesta convertidos a un objeto (les hace un _JSON.parse()_) 
- otros métodos para convertir los datos según el formato que tengan: **`text()`**, **`blob()`**, **`formData()`**, etc. Todos devuelven una promesa con los datos de distintos formatos convertidos.

**Ejemplo** de usando _**`fetch()`**_ para obtener los `posts` de un usuario y presentarlos en una tabla:

```html title="index.html" linenums="1"
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>REST Client</title>
  <script type="module" src="main.js"></script>
</head>

<body>

  <h1>Mostrar posts de un usuario</h1>

  <!-- FORMULARIO para introducir el id del usuario -->

  <form id="form-user-posts">
    <div>
      <label for="user-id">Introduce el id del usuario: </label>
      <input type="text" id="user-id" name="userId" size="2">
      <span id="error-message" class="error"></span>
    </div>
    <button type="submit">Mostrar posts</button>
  </form>

  <!-- TABLA para mostrar los posts -->

  <div id="user-posts">
    <table>
      <thead>
        <tr><th>userId</th><th>Id</th><th>Título</th><th>Post</th></tr>
      </thead>
      <tbody>
        <!-- Aquí se añadirán los posts -->
      </tbody>
    </table>
    <p>Total: <span id="num-posts"><!-- Aquí se mostrará el total --></span></p>
  </div>

</body>
</html>
```

```javascript title="main.js" linenums="1"
const SERVER = "https://jsonplaceholder.typicode.com";

const form = document.getElementById("form-user-posts");
const errorMessage = document.getElementById("error-message");
const userPosts = document.getElementById("user-posts");
const postTbody = document.querySelector("tbody");

hideError();
userPosts.style.display = "none";

form.addEventListener("submit", (event) => {
  // evitamos que se envíe el formulario y se recargue la página
  event.preventDefault();

  // ocultamos el mensaje de error y la tabla de posts
  userPosts.style.display = "none";
  hideError();

  // obtenemos el id del usuario
  let inputIdUser = event.target["user-id"];
  let idUser = inputIdUser.value;

  // comprobamos que el id sea un número
  if (isNaN(idUser) || idUser.trim() == "") {
    showError("Debes introducir un número");
  } else {
    // creamos la petición GET para obtener los posts del usuario
    fetch(SERVER + "/posts?userId=" + idUser)
      // convertimos la respuesta de texto a objeto
      // en este caso, la respuesta es un array de posts
      .then((response) => response.json())
      // en posts tenemos un array con los posts del usuario
      .then((posts) => {
        // mostramos los posts en la tabla
        postTbody.innerHTML = "";

        // si no hay posts, mostramos un mensaje de error
        if (posts.length == 0) {
          showError("No hay posts para este usuario");
        }
        else {
          // mostramos los posts en la tabla
          posts.forEach((post) => {
            const newPost = document.createElement("tr");
            newPost.innerHTML = `
                  <td>${post.userId}</td>
                  <td>${post.id}</td>
                  <td>${post.title}</td>
                  <td>${post.body}</td>`;
            postTbody.appendChild(newPost);
          });

          // mostramos el número de posts
          document.getElementById("num-posts").textContent = posts.length;

          // por último, mostramos el resultado
          userPosts.style.display = "block";
        }
      })
      .catch((error) => showError(error));
  }

  // devolvemos el foco al input y seleccionamos su contenido
  inputIdUser.focus();
  inputIdUser.select();
});

function showError(message) {
  errorMessage.textContent = message;
  errorMessage.style.color = "red";
  errorMessage.style.display = "inline-block";
}

function hideError() {
  errorMessage.textContent = "";
  errorMessage.style.display = "none";
}
```

Pero este ejemplo fallaría si hubiéramos puesto mal la url ya que contestaría con un `404` pero se ejecutaría el _`.then()`_ igualmente.

#### Gestión de errores con _fetch_

Según [MDN](https://developer.mozilla.org/es/docs/Web/API/Fetch_API) la promesa devuelta por la _API fetch_ sólo es rechazada en el caso de un error de red, es decir, el _`.catch()`_ sólo saltará si no hemos recibido respuesta del servidor; en caso contrario la promesa siempre es resuelta.

Por tanto para saber si se ha resuelto satisfactoriamente o no debemos comprobar la propiedad **_.ok_** de la respuesta. El código correcto del ejemplo anterior gestionando los posibles errores del servidor sería:

```js linenums="1" hl_lines="3-6 14"
fetch('https://jsonplaceholder.typicode.com/posts?userId=' + idUser)
  .then(response => {
    if (!response.ok) {
      // lanzamos un error que interceptará el .catch()
      throw `Error ${response.status} de la BBDD: ${response.statusText}`
    } 
    return response.json()  // devolvermos la promesa que hará el JSON.parse          
  })
  .then(myData => {
    // ya tenemos los datos en _myData_ 
    // Aquí procesamos los datos (en nuestro ejemplo los pintaríamos en la tabla)
    console.log(myData)
  }) 
  .catch(err => console.error(err));
```

En este caso si la respuesta del servidor no es _`ok`_ lanzamos un error que es interceptado por nuestro propio _`catch`_

#### Otros métodos de petición

Los ejemplos anteriores hacen peticiones `GET` al servidor. Para peticiones que no sean `GET` la función _`fetch()`_ admite un segundo parámetro con un objeto con la información a enviar en la petición HTTP. Ej.:

```javascript
fetch(url, {
  method: 'POST', // o 'PUT', 'GET', 'DELETE'
  body: JSON.stringify(data), // los datos que enviamos al servidor en el 'send'
  headers:{
    'Content-Type': 'application/json'
  }
}).then
```

Ejemplo de una petición para añadir datos:

```javascript
fetch(url, {
  method: 'POST', 
  body: JSON.stringify(data), // los datos que enviamos al servidor en el 'send'
  headers:{
    'Content-Type': 'application/json'
  }
})
.then(response => {
  if (!response.ok) {
    throw `Error ${response.status} de la BBDD: ${response.statusText}`
  } 
  return response.json()
})
.then(datos => {
  alert('Datos recibidos')
  console.log(datos)
})
.catch(err => {
  alert('Error en la petición HTTP: ' + err.message);
})
```

Podéis ver mś ejemplos en [MDN web docs](https://developer.mozilla.org/es/docs/Web/API/Fetch_API/Utilizando_Fetch#Enviando_datos_JSON) y otras páginas.

### Peticiones con _async / await_

Estas nuevas instrucciones introducidas en ES2017 nos permiten escribir el código de peticiones asíncronas como si fueran síncronas lo que facilita su comprensión.

Se puede llamar a cualquier función asíncrona (por ejemplo una promesa como _`fetch()`_) anteponiendo la palabra **`await`** a la llamada. Esto provocará que la ejecución se "espere" a que se resuelva la promesa devuelta por esa función. Así nuestro código se asemeja a código síncrono ya que no continúan ejecutándose las instrucciones que hay después de un _`await`_ hasta que esa petición se ha resuelto.

Cualquier función que realice un _`await`_ pasa a ser asíncrona ya que no se ejecuta en ese momento sino que se espera un tiempo. Y para indicarlo debemos anteponer la palabra **`async`** a su declaración _`function`_. Al hacerlo automáticamente se "envuelve" esa función en una promesa (o sea que esa función pasa a devolver una promesa, a la que podríamos ponerle un `await` o un `.then()`).

Siguiendo con el ejemplo anterior:

```javascript
async function getUserPosts() {
  const response = await fetch('https://jsonplaceholder.typicode.com/posts?userId=' + idUser);
  if (!response.ok) {
    throw `Error ${response.status} de la BBDD: ${response.statusText}`
  }
  const userPosts = await response.json(); // recordad que .json() tb es una promesa
  return userPosts;
}
...
// Y llamaremos a esa función con
const userPosts = await getUserPosts();
```

### Diferencia entre _async/await_ y _promesas_

La diferencia entre usar _**async/await**_ y _**promesas**_ es que con _async/await_ no tenemos que usar `.then()` para obtener el valor devuelto por la promesa sino que lo obtenemos directamente en la variable.

- Por ejemplo, si hacemos una petición _`fetch`_ y queremos obtener los _posts_ de un usuario con `id` _`idUser`_ podemos hacerlo **con _promesas_** así:

    ```javascript
    const response = fetch('https://jsonplaceholder.typicode.com/posts?userId=' + idUser);
    ```

    y en _`response`_ tendremos una promesa que se resolverá cuando llegue la respuesta del servidor. Para obtener los datos de la respuesta debemos suscribirnos a esa promesa con un `.then()`:

    ```javascript
    response.then(response => response.json())
    ```

    y en el _`then`_ tendremos los datos de la respuesta convertidos a un objeto o array. Si queremos obtenerlos en una variable debemos hacer:

    ```javascript
    response
        .then(response => response.json())
        .then(data => {
            const userPosts = data;
            // aquí ya podemos usar los datos
        })
    ```

- Con _async/await_ podemos hacer:

    ```javascript
    const response = await fetch('https://jsonplaceholder.typicode.com/posts?userId=' + idUser);
    const userPosts = await response.json();
    // aquí ya podemos usar los datos
    ```

    En este caso _`response`_ es una promesa que se resolverá cuando llegue la respuesta del servidor y _`userPosts`_ es una promesa que se resolverá cuando se conviertan los datos de la respuesta a un objeto o array. Pero como hemos puesto _`await`_ lo que obtenemos en _`response`_ es ya el valor devuelto por la promesa cuando se resuelve.

    Con esto conseguimos que llamadas asíncronas se comporten como instrucciones síncronas lo que aporta claridad al código.

Podéis ver algunos ejemplos del uso de _async / await_ en la [página de MDN](https://developer.mozilla.org/es/docs/Web/JavaScript/Referencia/Sentencias/funcion_asincrona).

El ejemplo de los posts quedaría:

```js title="main.js (usando async/await)" hl_lines="11-18 20 34" linenums="1"
const SERVER = "https://jsonplaceholder.typicode.com";

const form = document.getElementById("form-user-posts");
const errorMessage = document.getElementById("error-message");
const userPosts = document.getElementById("user-posts");
const postTbody = document.querySelector("tbody");

hideError();
userPosts.style.display = "none";

async function getPosts(idUser) {
  const response = await fetch(SERVER + "/posts?userId=" + idUser);
  if (!response.ok) {
    throw `Error ${response.status} de la BBDD: ${response.statusText}`;
  }
  const posts = await response.json();
  return posts;
}

form.addEventListener("submit", async (event) => {
  event.preventDefault();

  userPosts.style.display = "none";
  hideError();

  let inputIdUser = event.target["user-id"];
  let idUser = inputIdUser.value;

  if (isNaN(idUser) || idUser.trim() == "") {
    showError("Debes introducir un número");
  } else {
    let posts;
    try {
      posts = await getPosts(idUser);
      // La ejecución se para en la sentencia anterior hasta que 
      // contesta la función getPosts() y se asigna el valor a la variable posts
    } catch (error) {
      showError(error);
      console.error(error);
      return;
    }

    postTbody.innerHTML = "";

    if (posts != null && posts.length == 0) {
      showError("No hay posts para este usuario");
    } else {
      posts.forEach((post) => {
        const newPost = document.createElement("tr");
        newPost.innerHTML = `
                  <td>${post.userId}</td>
                  <td>${post.id}</td>
                  <td>${post.title}</td>
                  <td>${post.body}</td>`;
        postTbody.appendChild(newPost);
      });

      document.getElementById("num-posts").textContent = posts.length;

      userPosts.style.display = "block";
    }
  }

  inputIdUser.focus();
  inputIdUser.select();
});

function showError(message) {
  errorMessage.textContent = message;
  errorMessage.style.color = "red";
  errorMessage.style.display = "inline-block";
}

function hideError() {
  errorMessage.textContent = "";
  errorMessage.style.display = "none";
}
```

En este código estamos tratando los posibles errores que se pueden producir. Con _async/await_ los errores se tratan como en las excepciones, con _**`try ... catch`**_:

También podemos tratarlos sin usar _`try...catch`_ porque como una función asíncrona devuelve una promesa podemos suscribirnos directamente a su _`.catch()`_

### Hacer varias peticiones simultáneamente. `Promise.all()`

En ocasiones necesitamos hacer más de una petición al servidor. Por ejemplo para obtener los productos y sus categorías podríamos hacer:

```js title="peticiones separadas" hl_lines="1 16 19" linenums="1"
function getTable(table) {
  return new Promise((resolve, reject) => {
    fetch(SERVER + table)
      .then(response => {
        if (!response.ok) {
          throw `Error ${response.status} de la BBDD: ${response.statusText}`
        } 
        return response.json()
      })
      .then((data) => resolve(data))
      .catch((error) => reject(error))
  })
}

function getData() {
  getTable('/categories')
    .then((categories) => categories.forEach((category) => renderCategory(category)))
    .catch((error) => renderErrorMessage(error))
  getTable('/products')
    .then((products) => products.forEach((product) => renderProduct(product)))
    .catch((error) => renderErrorMessage(error))
}
```

Pero si para renderizar los productos necesitamos tener las categorías este código no nos lo garantiza ya que el servidor podría devolver antes los productos aunque los pedimos después.

Una solución sería no pedir los productos hasta tener las categorías:

```js title="encadenar peticiones" hl_lines="2 5" linenums="1"
function getData() {
  getTable('/categories')
    .then((categories) => {
      categories.forEach((category) => renderCategory(category))
      getTable('/products')
        .then((products) => products.forEach((product) => renderProduct(product)))
        .catch((error) => renderErrorMessage(error))
    })
    .catch((error) => renderErrorMessage(error))
}
```

pero **esto hará más lento nuestro código al no hacer las dos peticiones simultáneamente**.

La solución es usar el método **`Promise.all()`** al que se le pasa un array de promesas a hacer y devuelve una promesa que:

- **se resuelve** en el momento en que **todas las promesas se han resuelto** satisfactoriamente o
- **se rechaza** en el momento en que **alguna de las promesas es rechazada**

El código anterior de forma correcta sería:

```js title="Promise.all()" hl_lines="2" linenums="1"
function getData() {
  Promise.all([
    getTable('/categories')
    getTable('/products')
  ])
  .then(([categories, products]) => {
    categories.forEach((category) => renderCategory(category))
    products.forEach((product) => renderProduct(product))
  })
  .catch((error) => renderErrorMessage(error))
}
```

Lo mismo pasa si en vez de promesas usamos _async/await_. Si hacemos:

```js title="async/await en peticiones separadas" hl_lines="1 11-12" linenums="1"
async function getTable(table) {
    const response = await fetch(SERVER + table)
    if (!response.ok) {
      throw `Error ${response.status} de la BBDD: ${response.statusText}`
    }
    const data = await response.json()
    return data
}

async function getData() {
  const responseCategories = await getTable('/categories');
  const responseProducts = await getTable('/products');
  categories.forEach((category) => renderCategory(category))
  products.forEach((product) => renderProduct(product))
}
```

tenemos el problema de que no comienza la petición de los productos hasta que se reciben las categorías.

La solución con `Promise.all()` sería:

```js title="Promise.all() con async/await" hl_lines="2" linenums="1"
async function getData() {
  const [categories, products] = await Promise.all([
    getTable('/categories')
    getTable('/products')
  ])
  categories.forEach((category) => renderCategory(category))
  products.forEach((product) => renderProduct(product))
}
```

## Realizar peticiones Ajax

### Json Server

Las peticiones Ajax se hacen a un servidor que proporcione una API. Como ahora no tenemos ninguno podemos utilizar _**Json Server**_ que es un servidor **API-REST** que funciona bajo _Node.js_ (que ya tenemos instalado para usar NPM) y que utiliza un fichero _JSON_ como contenedor de los datos en lugar de una base de datos.

Para instalarlo en nuestra máquina (lo instalaremos global para poderlo usar en todas nuestras prácticas) ejecutamos:

```bash
npm install -D json-server
```

Para que sirva un fichero `datos.json`, dentro del fichero `package.json` añadimos la línea:

```json hl_lines="3"
"scripts": {
  ...
  "server": "json-server datos.json"
  ...
}
```

Le podemos poner la opción _`--watch`_ ( o `-w`) para que actualice los datos si se modifica el fichero _`.json`_ externamente (si lo editamos).

El fichero _`datos.json`_ será un fichero que contenga un objeto JSON con una propiedad para cada "_tabla_" de nuestra BBDD. Por ejemplo, si queremos simular una BBDD con las tablas _`users`_ y _`posts`_ vacías el contenido del fichero será:

```json
{
  "users": [],
  "posts": []
}
```

La API escucha en el puerto `3000` y servirá los diferentes objetos definidos en el fichero _.json_. Por ejemplo:

* http://localhost:3000/users: devuelve un array con todos los elementos de la tabla _users_ del fichero _.json_
* http://localhost:3000/users/5: devuelve un objeto con el elemento de la tabla _users_ cuya propiedad _id_ valga 5

También pueden hacerse peticiones más complejas como:

* http://localhost:3000/users?rol=3: devuelve un array con todos los elementos de _users_ cuya propiedad _rol_ valga 3

Para más información: [https://github.com/typicode/json-server](https://github.com/typicode/json-server).

Si queremos acceder a la API desde otro equipo (no desde _localhost_) tenemos que indicar la IP de la máquina que ejecuta _json-server_ y que se usará para acceder, por ejemplo si vamos a ejecutarlo en la máquina 192.168.0.10 pondremos:

```bash
json-server --host 192.168.0.10 datos.json 
```

Y la ruta para acceder a la API sería `http://192.168.0.10:3000`.

!!! note "liveServer"
    Si utilizamos `liveServer` en _vsCode_, cada vez que se actualice el fichero `datos.json` recargará la página, ignorando el `.preventDefault()` del formulario. Para evitarlo podemos desactivar la recarga automática de liveServer añadiendo la siguiente línea al fichero `.vscode/settings.json` de _vsCode_:

    ```json title=".vscode/settings.json"
    {
        "liveServer.settings.ignoreFiles": [
                "**/*.json",
                ".vscode/**",
                "**/*.scss",
                "**/*.sass",
                "**/*.ts"
        ]
    }
    ```

### REST client

Para probar las peticiones `GET` podemos poner la URL en la barra de direcciones del navegador pero para probar el resto de peticiones debemos instalar en nuestro navegador una extensión que nos permita realizar las peticiones indicando el método a usar, las cabeceras a enviar y los datos que enviaremos a servidor, además de la URL.

Existen multitud de aplicaciones para realizar peticiones HTTP, como [Advanced REST client](https://install.advancedrestclient.com/install). Cada navegador tiene sus propias extensiones para hacer esto, como [_Advanced Rest Client_](https://chrome.google.com/webstore/detail/advanced-rest-client/hgmloofddffdnphfgcellkdfbfbjeloo?hl=es) para Chrome o [_RestClient_](https://addons.mozilla.org/es/firefox/addon/restclient/) para Firefox.

## Ejemplos de envío de datos

Para poder añadir datos a la BBDD necesitamos hacer peticiones `POST` al servidor.

Vamos a ver un ejemplo de creación de un nuevo usuario. Supondremos que tenemos una página con un formulario para dar de alta nuevos usuarios:

```html title="index.html" linenums="1"
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Crear usuario con POST</title>
  <script type="module" src="main.js"></script>
</head>

<body>

  <h1>Crear usuario con POST</h1>

  <!-- FORMULARIO para introducir los datos del usuario -->

  <form id="create-user">
    <div>
      <label for="name">Nombre: </label>
      <input type="text"
             name="name"
             id="name" required>
    </div>
    <div>
      <label for="email">Email: </label>
      <input type="text"
             name="email"
             id="email"
             required>
    </div>

    <input type="submit" value="Añadir usuario">
  </form>

  <div id="users">
    <!-- Aquí se mostrará la lista de usuarios -->
  </div>
</body>
</html>
```

En este ejemplo se usa el método _`fetch()`_ para hacer la petición `POST` al servidor. En el objeto de opciones que le pasamos como segundo parámetro indicamos:

- **`method: 'POST'`**: para indicar que es una petición `POST`
- **`body: JSON.stringify(userData)`**: para convertir el objeto _`userData`_ en una cadena de texto JSON que se enviará en el cuerpo de la petición
- **`headers: { 'Content-type': 'application/json' }`**: para indicar que el formato en el que se envía la información es JSON


```js title="main.js" linenums="1"
const form = document.getElementById("create-user");

form.addEventListener("submit", (event) => {
  event.preventDefault();

  const userData = {
    name: document.getElementById("name").value,
    email: document.getElementById("email").value,
  };

  createUser(userData);
});

function createUser(userData) {
  fetch("http://localhost:3000/users", {
    // Tipo de petición
    method: "POST",
    // Convertir el objeto a una cadena de texto JSON para enviarlo en el cuerpo de la petición
    body: JSON.stringify(userData),
    // En Content-type indicamos el formato en el que se envía la información
    headers: {
      "Content-type": "application/json",
    },
  })
    .then((response) => response.json())
    .then((data) => {
      console.log("Success:", data);
      getUsers();
    })
    .catch((error) => {
      console.error("Error:", error);
    });
}

getUsers();

// obtiene y presenta la lista de usuarios
function getUsers() {
  fetch("http://localhost:3000/users")
    .then((response) => response.json())
    .then((data) => {
      document.getElementById("users").innerHTML = "<h2>Users</h2>";
      data.reverse().forEach((user) => {
        document.getElementById("users").innerHTML += `
        <div id="user-${user.id}" class="user">
        <span>id: ${user.id}</span> -
        <span class="user-name">name: ${user.name}</span> -
        <span class="user-email">email: ${user.email}</span>
      </div>
      <hr>
        `;
      });
    });
}
```

!!! question "ACTIVIDAD 5: `📂 UD5/act05/`"

    Crear una pequeña aplicación para gestionar una lista de deseos de Navidad, mediante peticiones Ajax a un servidor local _json-server_.

    1. **Crea** dos carpetas _**`client/`**_ y _**`server/`**_.
    2. **Dentro de `server/`** realiza los siguientes pasos:
        1. **Crea** un fichero **_`datos.json`_** con el siguiente contenidos:
        ```json
        {
            "products": [
                {
                    "id": 0,
                    "name": "Smile",
                    "price": 0.0
                }
            ]
        }
        ```
        2. **Instala _json-server_** como dependencia de desarrollo, ejecuta en la consola:
        ```bash
        npm init -y
        npm install -D json-server
        ```
        3. **Edita _`package.json`_** y añade la siguiente línea en el apartado **"scripts"**:
        ```json hl_lines="2"
        "scripts": {
            "server": "json-server -d 400 datos.json"
        }
        ```
        Permitirá poner en marcha el servicio con un pequeño retardo de _400ms_ para simular retraso en la respuesta del servidor.
        4. **Inicia el servicio** con:
        ```
        npm run server
        ```
    3. **Dentro de `client/`** **crea** un fichero **_`index.html`_** con el siguiente contenido:
        1. En el **título** de la página: **_`Xmas Wishlist`_**.
        2. Un **formulario** para **buscar** productos por nombre:
            - Un campo de texto para introducir el nombre del producto
            - Un botón para enviar el formulario
        3. Un **formulario** para **crear nuevos** productos:
            - Nombre del producto
            - Precio
            - Botón para enviar el formulario
        4. Un **formulario** para **borrar** un producto por su `id`:
            - Un campo de texto para introducir el `id` del producto
            - Un botón para enviar el formulario
        5. Un `div` para mostrar los **resultados** de las peticiones
        6. Un `div` para mostrar **mensajes de error**
        7. Un `loader` para mostrar mientras se realizan las peticiones, _puedes utilizar uno de los que creamos en las actividades anteriores_.
    4. **Dentro de `client/`** **crea** un fichero **_`main.js`_** con el siguiente contenido:
        1. Añade un _eventListener_ al **formulario de búsqueda** para que cuando se envíe haga una **petición `GET`** al servidor con el **nombre del producto a buscar** y muestre los resultados en la página.
        2. Añade un _eventListener_ al **formulario de añadir productos** para que cuando se envíe haga una **petición `POST`** al servidor con los **datos del producto** a añadir y muestre los resultados en la página.
        3. Añade un _eventListener_ al **formulario de borrar** productos para que cuando se envíe haga una **petición `DELETE`** al servidor con el **`id` del producto a borrar** y muestre los resultados en la página.
        4. Crea un **componente _`product-info`_** que muestre la información de un producto individual, con su id, nombre y precio. Este componente se usará para mostrar los resultados de las peticiones.
        5. El código de las peticiones debe estar en **funciones independientes**.
        6. Se debe **mostrar un mensaje de error** si la petición no se ha podido realizar y **ocultarlo** si se realiza correctamente.
        7. Se debe **mostrar un _loader_** mientras se realizan las peticiones y **ocultarlo** cuando se han terminado, tanto si se han realizado correctamente como si no.
        8. Se debe **ocultar** el `div` de **resultados** al realizar cualquier petición.

    **Estructura de carpetas:**
    ```
    📂 UD5/
    └── 📂 act05/
        ├── 📂 client/
        │   ├── 📄 index.html
        │   ├── 📄 main.js
        │   ├── 📄 ProductInfoComponent.js
        │   └── 📄 RequestLoaderComponent.js
        └── 📂 server/
            ├── 📄 datos.json
            └── 📄 package.json
    ```

## Single Page Application

Ajax es la base para construir SPAs que permiten al usuario interactuar con una aplicación web como si se tratara de una aplicación de escritorio (sin "esperas" que dejen la página en blanco o no funcional mientras se recarga desde el servidor).

En una SPA sólo se carga la página de inicio (es la única página que existe) que se va modificando y cambiando sus datos como respuesta a la interacción del usuario. Para obtener los nuevos datos se realizan peticiones al servidor (normalmente Ajax). La respuesta son datos (JSON, XML, etc.) que se muestran al usuario modificando mediante DOM la página mostrada (o podrían ser trozos de HTML que se cargan en determinadas partes de la página, o ...).

## Resumen de llamadas asíncronas

Una llamada Ajax es un tipo de llamada asíncrona que podemos hacer en Javascript aunque hay muchas más, como un `setTimeout()` o las funciones manejadoras de eventos. Como hemos visto, para la gestión de las llamadas asíncronas tenemos varios métodos y los más comunes son:

- funciones _callback_
- _promesas_
- _async / await_

Cuando se produce una llamada asíncrona el orden de ejecución del código no es el que vemos en el programa ya que el código de respuesta de la llamada no se ejecutará hasta completarse esta. Podemos ver [un ejemplo](https://repl.it/DhKt/1) de esto extraído de **todoJS** usando **funciones _callback_**.

Además, si hacemos varias llamadas tampoco sabemos el qué orden se ejecutarán sus respuestas ya que depende de cuándo finalice cada una como podemos ver en [este otro ejemplo](https://repl.it/DhLA/0).

Si usamos funciones _callback_ y necesitamos que cada función no se ejecute hasta que haya terminado la anterior debemos llamarla en la respuesta a la función anterior lo que provoca un tipo de código difícil de leer llamado [_callback hell_](https://repl.it/DhLN/0).

Para evitar esto surgieron las **_promesas_** que permiten evitar las funciones _callback_ tan difíciles de leer. Podemos ver [el primer ejemplo](https://repl.it/DhMA/1) usando promesas. Y si necesitamos ejecutar secuencialmente las funciones evitaremos la pirámide de llamadas _callback_ como vemos en [este ejemplo](https://repl.it/DhMK/0).

Aún así el código no es muy claro. Para mejorarlo tenemos **_async_ y _await_** como vemos en [este ejemplo](https://repl.it/DhMa/0). Estas funciones forman parte del estándar ES2017 por lo que no están soportadas por navegadores muy antiguos (aunque siempre podemos transpilar con _Babel_).

Fuente: [todoJs: Controlar la ejecución asíncrona](https://www.todojs.com/controlar-la-ejecucion-asincrona/)

## CORS

_Cross-Origin Resource Sharing_ (CORS) es un mecanismo de seguridad que incluyen los navegadores y que por defecto impiden que se pueden realizar peticiones Ajax desde un navegador a un servidor con un dominio diferente al de la página cargada originalmente. 

Si necesitamos hacer este tipo de peticiones necesitamos que el servidor  al que hacemos la petición añada en su respuesta la cabecera _Access-Control-Allow-Origin_ donde indiquemos el dominio desde el que se pueden hacer peticiones (o __*__ para permitirlas desde cualquier dominio).

El navegador comprobará las cabeceras de respuesta y si el dominio indicado por ella coincide con el dominio desde el que se hizo la petición, esta se permitirá.

Como en desarrollo normalmente no estamos en el dominio de producción (para el que se permitirán las peticiones) podemos instalar en el navegador la extensión _allow CORS_ que al activarla deshabilita la seguridad CORS en el navegador.

Podéis ampliar la información en numerosas páginas web como ["Entendiendo CORS y aplicando soluciones"](https://www.enmilocalfunciona.io/entendiendo-cors-y-aplicando-soluciones/).