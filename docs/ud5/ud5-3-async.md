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
fetch("/robots.txt").then(function(response) {
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

- Asíncrono: Porque no se ejecuterá de inmediato, sino que tardará en ejecutarse.
- No bloqueante: Porque mientras espera ser ejecutado, no bloquea el resto del programa.

Cuando llegamos a un `.then()`, el sistema no se bloquea, sino que deja la función «pendiente» hasta que se cumpla la promesa, pero mientras, continua procesando el resto del programa.

Observa el siguiente ejemplo:activ
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

### Asincronía en asyn/await

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

* **GET**: suele usarse para **obtener datos** sin modificar nada (equivale a un `SELECT` en _SQL_). Si enviamos datos (ej. la `ID` del registro a obtener) suelen ir en la _url_ de la petición (formato _URIEncoded_). Ej.: `locahost/users/3`, [https://jsonplaceholder.typicode.com/users](https://jsonplaceholder.typicode.com/users)
* **POST**: suele usarse para **añadir un dato** en el servidor (equivalente a un `INSERT` de _SQL_). Los datos enviados van en el cuerpo de la petición HTTP (igual que sucede al enviar desde el navegador un formulario por _POST_)
* **PUT**: es similar al _POST_ pero suele usarse para **actualizar datos** del servidor (como un `UPDATE` de _SQL_). Los datos se envían en el cuerpo de la petición (como en el _POST_) y la información para identificar el objeto a modificar en la url (como en el `GET`). El servidor hará un `UPDATE` sustituyendo el objeto actual por el que se le pasa como parámetro
* **PATCH**: es similar al _PUT_ pero la diferencia es que en el _PUT_ hay que pasar todos los campos del objeto a modificar (los campos no pasados se eliminan del objeto) mientras que en el _PATCH_ sólo se pasan los campos que se quieren cambiar y en resto permanecen como están.
* **DELETE**: se usa para eliminar un dato del servidor (como un `DELETE` de _SQL_). La información para identificar el objeto a eliminar se envía en la url (como en el _GET_)

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

### Json Server

Las peticiones Ajax se hacen a un servidor que proporcione una API. Como ahora no tenemos ninguno podemos utilizar Json Server que es un servidor API-REST que funciona bajo Node.js (que ya tenemos instalado para usar NPM) y que utiliza un fichero JSON como contenedor de los datos en lugar de una base de datos.

Para instalarlo en nuestra máquina (lo instalaremos global para poderlo usar en todas nuestras prácticas) ejecutamos:

```bash
npm install json-server
```

Para que sirva un fichero `datos.json`, dentro del fichero `package.json` añadimos la línea:

```json hl_lines="3"
"scripts": {
  ...
  "server": "json-server --watch datos.json"
  ...
}
```

Le podemos poner la opción _`--watch`_ ( o `-w`) para que actualice los datos si se modifica el fichero _.json_ externamente (si lo editamos).

El fichero _datos.json_ será un fichero que contenga un objeto JSON con una propiedad para cada "_tabla_" de nuestra BBDD. Por ejemplo, si queremos simular una BBDD con las tablas _users_ y _posts_ vacías el contenido del fichero será:

```json
{
  "users": [],
  "posts": []
}
```

La API escucha en el puerto 3000 y servirá los diferentes objetos definidos en el fichero _.json_. Por ejemplo:

* http://localhost:3000/users: devuelve un array con todos los elementos de la tabla _users_ del fichero _.json_
* http://localhost:3000/users/5: devuelve un objeto con el elemento de la tabla _users_ cuya propiedad _id_ valga 5

También pueden hacerse peticiones más complejas como:

* http://localhost:3000/users?rol=3: devuelve un array con todos los elementos de _users_ cuya propiedad _rol_ valga 3

Para más información: [https://github.com/typicode/json-server](https://github.com/typicode/json-server).

Si queremos acceder a la API desde otro equipo (no desde _localhost_) tenemos que indicar la IP de la máquina que ejecuta _json-server_ y que se usará para acceder, por ejemplo si vamos a ejecutarlo en la máquina 192.168.0.10 pondremos:

```[bash]
json-server --host 192.168.0.10 datos.json 
```

Y la ruta para acceder a la API será `http://192.168.0.10:3000`.

