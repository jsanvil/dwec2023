# 1. Sintaxis

## Variables

Javascript es un lenguaje **débilmente tipado**. Esto significa que no se indica de qué tipo es una variable al declararla e incluso puede cambiar su tipo a lo largo de la ejecución del programa. 

Ejemplo:

```js linenums="1"
let miVariable;          // declaro miVariable y como no se asigno un valor valdrá undefined
miVariable = 'Hola';     // ahora su valor es 'Hola', por tanto contiene una cadena de texto
miVariable = 34;         // pero ahora contiene un número
miVariable = [3, 45, 2]; // y ahora un array
miVariable = undefined;  // para volver a valer el valor especial undefined
```

!!! question "EJERCICIO:"
    Ejecuta en la consola del navegador las instrucciones anteriores y comprueba el valor de `miVariable` tras cada instrucción (para ver el valor de una variable simplemente ponemos en la consola su nombre: `miVariable`)

Ni siquiera estamos obligados a declarar una variable antes de usarla, aunque es recomendable para evitar errores que nos costará depurar. Podemos hacer que se produzca un error si no declaramos una variable incluyendo al principio de nuestro código la instrucción

```js
'use strict'
```

Las variables de declaran con **`let`** (lo recomendado desde ES2015), aunque también pueden declararse con **`var`**. La diferencia es que con _`let`_ la variable sólo existe en el bloque en que se declara mientras que con _`var`_ la variable existe en toda la función en que se declara:

```js linenums="1"
if (edad < 18) {
  let textoLet = 'Eres mayor de edad';
  var textoVar = 'Eres mayor de edad';
} else {
  let textoLet = 'Eres menor de edad';
  var textoVar = 'Eres menor de edad';
}
console.log(textoLet);  // mostrará undefined porque fuera del if no existe la variable
console.log(textoVar);  // mostrará la cadena
```

Cualquier variable que no se declara dentro de una función (o si se usa sin declarar) es _global_. Debemos siempre intentar NO usar variables globales.

Se recomienda que los nombres de las variables sigan la sintaxis _camelCase_ (ej.: _miPrimeraVariable_).

Desde ES2015 también podemos declarar constantes con **`const`**. Se les debe dar un valor al declararlas y si intentamos modificarlo posteriorment se produce un error.

!!! info "NOTA:"
    en la página de [Babel](https://babeljs.io/) podemos teclear código en ES2015 y ver cómo quedaría una vez transpilado a ES5.

## Tipos de datos básicos

En Javascript ES2015 existen 9 tipos de datos:

- Primitivos:
    - Number
    - String
    - Boolean
    - BigInt
    - Symbol
    - Undefined
    - Null
- No primitivos:
    - Object

Para saber de qué tipo es el valor de una variable tenemos el operador **typeof**. Ej.:

* `typeof 3` devuelve _number_
* `typeof 'Hola'` devuelve _string_

En Javascript hay 2 valores especiales:

* **undefined**: es lo que vale una variable a la que no se ha asignado ningún valor
* **null**: es un tipo de valor especial que podemos asignar a una variable. Es como un objeto vacío (`typeof null` devuelve _object_)

También hay otros valores especiales relacionados con operaciones con números:

- **NaN** (_Not a Number_): indica que el resultado de la operación no puede ser convertido a un número (ej. `'Hola'*2`, aunque `'2'*2` daría 4 ya que se convierte la cadena '2' al número 2)
- **Infinity** y **-Infinity**: indica que el resultado es demasiado grande o demasiado pequeño (ej. `1/0` o `-1/0`)

### _Casting_ de variables

Como hemos dicho las variables pueden contener cualquier tipo de valor y, en las operaciones, Javascript realiza **automáticamente** las conversiones necesarias para, si es posible, realizar la operación. Por ejemplo:

* `'4' / 2` devuelve 2 (convierte '4' en 4 y realiza la operación)
* `'23' - null` devuelve 0 (hace 23 - 0)
* `'23' - undefined` devuelve _NaN_ (no puede convertir undefined a nada así que no puede hacer la operación)
* `'23' * true` devuelve 23 (23 * 1)
* `'23' * 'Hello'` devuelve _NaN_ (no puede convertir 'Hello')
* `23 + 'Hello'` devuelve '23Hello' (+ es el operador de concatenación así que convierte 23 a '23' y los concatena)
* `23 + '23'` devuelve 2323 (OJO, convierte 23 a '23', no al revés)

Además comentar que en Javascript todo son ojetos por lo que todo tiene métodos y propiedades. Veamos brevemente los tipos de datos básicos.

!!! question "EJERCICIO:"
    Prueba en la consola las operaciones anteriores y alguna más con la que tengas dudas de qué devolverá

### Number

Sólo hay 1 tipo de números, no existen enteros y decimales. El tipo de dato para cualquier número es **number**. El carácter para la coma decimal es el **.** (como en inglés, así que 23,12 debemos escribirlo como 23.12).

Tenemos los operadores aritméticos **`+`**, **`-`**, **`*`**, **`/`** y **`%`** y los unarios **`++`** y **`--`** y existen los valores especiales **`Infinity`** y **`-Infinity`** (`23 / 0` no produce un error sino que devuelve _Infinity_).

Podemos usar los operadores artméticos junto al operador de asignación **`=`** (`+=`, `-=`, `*=`, `/=` y `%=`).

Algunos métodos útiles de los números son:

- **.toFixed(num)**: redondea el número a los decimales indicados. Ej. `23.2376.toFixed(2)` devuelve `23.24`
- **.toLocaleString()**: devuelve el número convertido al formato local. Ej. `23.76.toLocaleString()` devuelve `"23,76"` (convierte el punto decimal en coma)

Podemos forzar la conversión de una cade de texto a número con la función **Number(valor)**. Ejemplo `Number("23.12")` devuelve `23.12`

Otras funciones útiles son:

- **isNaN(valor)**: nos dice si el valor pasado es un número (false) o no (true)
- **isFinite(valor)**: devuelve _true_ si el valor es finito (no es _Infinity_ ni _-Infinity_). 
- **parseInt(valor)**: convierte el valor pasado a un número entero. Siempre que compience por un número la conversión se podrá hacer. Ej.:
    ```javascript
    parseInt(3.65)      // Devuelve 3
    parseInt('3.65')    // Devuelve 3
    parseInt('3 manzanas')    // Devuelve 3
    parseInt('tres')        // Devuelve NaN
    ```

- **parseFloat(valor)**: como la anterior pero conserva los decimales

!!! warning "OJO:"
    al sumar *floats* podemos tener problemas:

    ```javascript
    console.log(0.1 + 0.2)    // imprime 0.30000000000000004
    ```

Para evitarlo redondead los resultados (o `(0.1*10 + 0.2*10) / 10`).

!!! question "ACTIVIDAD 1: `📂 UD1/act1/act1.html`"
    Modifica la función que calcula nota media para que devuelva la media con 1 decimal

    ```js
    function notaMedia(arrayNotas) {
        let suma = 0;
        let totalNotas = 0;
        for (nota of arrayNotas) {
            suma += nota;
            totalNotas++;
        }
        return suma / totalNotas;
    }
    ```

!!! question "ACTIVIDAD 2: `📂 UD1/act2/act2.html`"
    Modifica la función que devuelve el cubo de un número para que compruebe si el parámetro pasado es un número entero. Si no es un entero o no es un número mostrará un `alert` indicando cuál es el problema y devolverá `false`.

    ```js
    function cubo(numero) {
        let resultado = numero;
        for (let i=0; i<numero; i++) {
            resultado *= numero;
        }
        return resultado;
    }
    ```

### String

Las cadenas de texto van entre comillas simples o dobles, es indiferente. Podemos escapar un caràcter con `\` (ej. `'Hola \'Mundo\''` devuelve _Hola 'Mundo'_).

Para forzar la conversión a cadena se usa la función **`String(value)`** (ej. `String(23)` devuelve '23')

El operador de concatenación de cadenas es **`+`**. Ojo porque si pedimos un dato con _prompt_ siempre devuelve una cadena así que si le pedimos la edad al usuario (por ejemplo 20) y se sumamos 10 tendremos 2010 ('20'+10).

Algunos métodos y propiedades de las cadenas son:

* **`.length`**: devuelve la longitud de una cadena. Ej.: `'Hola mundo'.length` devuelve 10
* **`.charAt(position)`**: `'Hola mundo'.charAt(0)` devuelve 'H'
* **`.indexOf(character)`**: `'Hola mundo'.indexOf('o')` devuelve 1. Si no se encuentra devuelve -1
* **`.lastIndexOf(character)`**: `'Hola mundo'.lastIndexOf('o')` devuelve 9
* **`.substring(from, to)`**: `'Hola mundo'.substring(2,4)` devuelve 'la'
* **`.substr(from, num chars)`**: `'Hola mundo'.substr(2,4)` devuelve 'la m'
* **`.replace(search, replace)`**: `'Hola mundo'.replace('Hola', 'Adiós')` devuelve 'Adiós mundo'
* **`.toLocaleLowerCase()`**: `'Hola mundo'.toLocaleLowerCase()` devuelve 'hola mundo'
* **`.toLocaleUpperCase()`**: `'Hola mundo'.toLocaleUpperCase()` devuelve 'HOLA MUNDO'
* **`.localeCompare(string)`**: devuelve -1 si la cadena a que se aplica el método es anterior alfabéticamente a 'cadena', 1 si es posterior y 0 si ambas son iguales. Tiene en cuenta caracteres locales como acentos ñ, ç, etc
* **`.trim(string)`**: `'   Hola mundo   '.trim()` devuelve 'Hola mundo'
* **`.startsWith(string)`**: `'Hola mundo'.startsWith('Hol')` devuelve _true_
* **`.endsWith(string)`**: `'Hola mundo'.endsWith('Hol')` devuelve _false_
* **`.includes(string)`**: `'Hola mundo'.includes('mun')` devuelve _true_
* **`.repeat(times)`**: `'Hola mundo'.repeat(3)` devuelve 'Hola mundoHola mundoHola mundo'
* **`.split(separator)`**: `'Hola mundo'.split(' ')` devuelve el array \['Hola', 'mundo']. `'Hola mundo'.split('')` devuelve el array \['H', 'o', 'l', 'a', ' ', 'm', 'u', 'n', 'd', 'o']

Podemos probar los diferentes métodos en la página de [w3schools](https://www.w3schools.com/jsref/jsref_obj_string.asp).

!!! question "ACTIVIDAD 3: `📂 UD1/act3/act3.html`"
    Haz una función a la que se le pasa un DNI (ej. 12345678w o 87654321T) y devolverá si es correcto o no. La letra que debe corresponder a un DNI correcto se obtiene dividiendo la parte numérica entre 23 y cogiendo de la cadena '`TRWAGMYFPDXBNJZSQVHLCKE`' la letra correspondiente al resto de la divisón. Por ejemplo, si el resto es 0 la letra será la T y si es 4 será la G. Prueba la función en la consola con tu DNI

#### Template literals

Desde ES2015 también podemos poner una cadena entre **`` ` ``** (acento grave) y en ese caso podemos poner dentro **variables** y **expresiones** que serán evaluadas al ponerlas dentro de **`${}`**. También se respetan los **saltos de línea**, tabuladores, etc que haya dentro. Ejemplo:

```js linenums="1"
let edad=25;

console.log(
`El usuario tiene:

${edad} años`)
```

Mostrará en la consola:
> El usuario tiene:

> 25 años

### Boolean

Los valores booleanos son **true** y **false**. Para convertir algo a booleano se usar **Boolean(valor)** aunque también puede hacerse con la doble negación (**!!**). Cualquier valor se evaluará a _true_ excepto 0, NaN, null, undefined o una cadena vacía ('') que se evaluarán a _false_.

Los operadores lógicos son ! (negación), && (and), \|\| (or).

Para comparar valores tenemos **==** y **===**. La triple igualdad devuelve _true_ si son igual valor y del mismo tipo. Como Javascript hace conversiones de tipos automáticas conviene usar la **===** para evitar cosas como:

* `'3' == 3` true
* `3 == 3.0` true
* `0 == false` true
* `'' == false` true
* `' ' == false` true
* `[] == false` true
* `null == false` false
* `undefined == false` false
* `undefined == null` true

También tenemos 2 operadores de _diferente_: **!=** y **!==** que se comportan como hemos dicho antes.

Los operadores relacionales son >, >=, <, <=. Cuando se compara un número y una cadena ésta se convierte a número y no al revés (`23 > '5'` devuelve _true_, aunque `'23' > '5'` devuelve _false_) 

## Funciones

Se declaran con **function** y se les pasan los parámetros entre paréntesis. La función puede devolver un valor usando **return** (si no tiene _return_ es como si devolviera _undefined_). 

Puede usarse una función antes de haberla declarado por el comportamiento de Javascript llamado _hoisting_: el navegador primero carga todas las funciones y mueve las declaraciones de las variables al principio y luego ejecuta el código.

!!! question "ACTIVIDAD 4:"
    Haz una función que te pida que escribas algo con `prompt` y muestre un `alert` diciendo 'Has escrito...' y el valor introducido. Pruébala en la consola (pegas allí la función y luego la llamas desde la consola)

### Parámetros

Si se llama una función con menos parámetros de los declarados el valor de los parámetros no pasados será _undefined_:

```js linenums="1"
function potencia(base, exponente) {
    console.log(base);            // muestra 4
    console.log(exponente);       // muestra undefined
    let valor = base ** exponente;
    return valor;
}

potencia(4);    // devolverá 4
```

Podemos dar un **valor por defecto** a los parámetros por si no los pasan asignándoles el valor al definirlos:

```js linenums="1"
function potencia(base, exponente=2) {
    console.log(`Base: ${base}`);            // muestra 4
    console.log(`Exp.: ${exponente}`);       // muestra 2 la primera vez y 5 la segunda
    return base ** exponente;
}

console.log(potencia(4));         // mostrará 16 (4^2)
console.log(potencia(4,5));       // mostrará 1024 (4^5)
```

!!! info "NOTA:"
    En ES5 para dar un valor por defecto a una variable se hacía
    ```javascript
    function potencia(base, exponente) {
        exponente = exponente || 2;       // si exponente vale undefined se la asigna el valor 2
    ...
    ```

También es posible acceder a los parámetros desde el array **`arguments[]`** si no sabemos cuántos recibiremos:

```js linenums="1"
function suma () {
    var result = 0;
    for (var i=0; i<arguments.length; i++)
        result += arguments[i];
    return result;
}

console.log(suma(4, 2));                    // mostrará 6
console.log(suma(4, 2, 5, 3, 2, 1, 3));     // mostrará 20
```

En Javascript las funciones son un tipo de datos más por lo que podemos hacer cosas como pasarlas por argumento o asignarlas a una variable:

```js linenums="1"
const cuadrado = function(value) {
  return value * value
}
function aplica_fn(dato, funcion_a_aplicar) {
    return funcion_a_aplicar(dato);
}

aplica_fn(3, cuadrado);     // devolverá 9 (3^2)
```

A este tipo de funciones se llama _funciones de primera clase_ y son típicas de lenguajes funcionales.

### Funciones anónimas

Como acabamos de ver podemos definir una función sin darle un nombre. Dicha función puede asignarse a una variable, autoejecutarse o asignarse a un manejador de eventos. Ejemplo:

```js linenums="1"
let holaMundo = function() {
    alert('Hola mundo!');
}

holaMundo();        // se ejecuta la función
```

Como vemos asignamos una función a una variable de forma que podamos "ejecutar" dicha variable.

### Arrow functions (funciones _lambda_)

ES2015 permite declarar una función anónima de forma más corta. Ejemplo sin _arrow function_:

```js linenums="1"
let potencia = function(base, exponente) {
    let resultado = base ** exponente;
    return resultado;
}
```

Al escribirla con la sintaxis de una _arrow function_ lo que hacemos es:

* Eliminamos la palabra _`function`_
* Si sólo tiene 1 parámetro podemos eliminar los paréntesis de los parámetros
* Ponemos el símbolo _`=>`_
* Si la función sólo tiene 1 línea podemos eliminar las `{ }` y la palabra _`return`_

El ejemplo con _arrow function_:

```js linenums="1"
let potencia = (base) => {
    let resultado = base ** 2;
    return resultado;
}
```

Otro ejemplo, sin _arrow function_:

```js linenums="1"
let cuadrado = function(base) {
    return base ** 2;
}
```

con _arrow function_:

```js linenums="1"
let cuadrado = (base) => base * 2;
```

!!! question "ACTIVIDAD 5: `📂 UD1/act5/act5.html`"
    Haz una _arrow function_ que devuelva el cubo del número pasado como parámetro y pruébala desde la consola. Escríbela primero en la forma habitual y luego la "traduces" a _arrow function_.

## Estructuras y bucles

### Estructura condicional: if

El **if** es como en la mayoría de lenguajes. Puede tener asociado un **else** y pueden anidarse varios con **else if**.

```javascript
if (condicion) {
    ...
} else if (condicion2) {
    ...
} else if (condicion3) {
    ...
} else {
    ...
}
```

Ejemplo:

```js linenums="1"
if (edad < 18) {
    console.log('Es menor de edad');
} else if (edad > 65) {
    console.log('Está jubilado');
} else {
    console.log('Edad correcta');
}
```

Se puede usar el operador **? :** que es como un _if_ que devuelve un valor:

```javascript
let esMayorDeEdad = (edad>18)?true:false;
```

### Estructura condicional: switch

El **switch** también es como en la mayoría de lenguajes. Hay que poner _break_ al final de cada bloque para que no continúe evaluando:

```js linenums="1"
switch(color) {
    case 'blanco':
    case 'amarillo':    // Ambos colores entran aquí
        colorFondo='azul';
        break;
    case 'azul':
        colorFondo='amarillo';
        break;
    default:            // Para cualquier otro valor
        colorFondo='negro';
}
```

Javascript permite que el _switch_ en vez de evaluar valores pueda evaluar expresiones. En este caso se pone como condición _true_:

```js linenums="1"
switch(true) {
    case age < 18:
        console.log('Eres muy joven para entrar');
        break;
    case age < 65:
        console.log('Puedes entrar');
        break;
    default:
        console.log('Eres muy mayor para entrar');
}
```

### Bucle _while_

Podemos usar el bucle _while...do_

```javascript
while (condicion) {
    // sentencias
}
```

que se ejecutará 0 o más veces. Ejemplo:

```js linenums="1"
let nota=prompt('Introduce una nota (o cancela para finalizar)');
while (nota) {
    console.log('La nota introducida es: '+nota);
    nota=prompt('Introduce una nota (o cancela para finalizar)');
}
```

O el bucle _do...while_:

```javascript
do {
    // sentencias
} while (condicion)
```

que al menos se ejecutará 1 vez. Ejemplo:

```js linenums="1"
let nota;
do {
    nota=prompt('Introduce una nota (o cancela para finalizar)');
    console.log('La nota introducida es: '+nota);
} while (nota)
```

!!! question "ACTIVIDAD 6: `📂 UD1/act6/act6.html`"
    Haz un programa para que el usuario juegue a adivinar un número.
    
    Obtén un número al azar (busca por internet cómo se hace o simplemente guarda el número que quieras en una variable) y ve pidiendo al usuario que introduzca un número.
    
    Si es el que busca le dices que lo ha encontrado y si no le mostrarás si el número que busca el mayor o menor que el introducido.
    
    El juego acaba cuando el usuario encuentra el número o cuando pulsa en `Cancelar` (en ese caso le mostraremos un mensaje de que ha cancelado el juego).

### Bucle: for

Tenemos muchos _for_ que podemos usar.

### Bucle: for con contador

Creamos una variable contador que controla las veces que se ejecuta el for:

```js linenums="1"
let datos=[5, 23, 12, 85]
let sumaDatos=0;

for (let i=0; i<datos.length; i++) {
    sumaDatos += datos[i];
}  
// El valor de sumaDatos será 125
```

!!! question "ACTIVIDAD 7: `📂 UD1/act7/act7.html`"
    El factorial de un número entero `n` es una operación matemática que consiste en multiplicar ese número por todos los enteros menores que él: **`n x (n-1) x (n-2) x ... x 1`**.
    
    Así, el factorial de 5 (se escribe *`5!`*) vale: **`5! = 5 x 4 x 3 x 2 x 1 = 120`**.
    
    Haz un script que calcule el factorial de un número entero.

#### Bucle: for...in

El bucle se ejecuta una vez para cada elemento del array (o propiedad del objeto) y se crea una variable contador que toma como valores la posición del elemento en el array:

```js linenums="1"
let datos=[5, 23, 12, 85]
let sumaDatos=0;

for (let indice in datos) {
    sumaDatos += datos[indice];     // los valores que toma indice son 0, 1, 2, 3
}  
// El valor de sumaDatos será 125
```

También sirve para recorrer las propiedades de un objeto:

```js linenums="1"
let profe={
    nom:'Juan', 
    ape1='Pla', 
    ape2='Pla'
}
let nombre='';

for (var campo in profe) {
   nombre += profe.campo + ' '; // o profe[campo];
}  
// El valor de nombre será 'Juan Pla Pla '
```

#### Bucle: for...of

Es similar al _for...in_ pero la variable contador en vez de tomar como valor cada índice toma cada elemento. Es nuevo en ES2015:

```js linenums="1"
let datos = [5, 23, 12, 85]
let sumaDatos = 0;

for (let valor of datos) {
    sumaDatos += valor;       // los valores que toma valor son 5, 23, 12, 85
}  
// El valor de sumaDatos será 125
```

También sirve para recorrer los caracteres de una cadena de texto:

```js linenums="1"
let cadena = 'Hola';

for (let letra of cadena) {
    console.log(letra);     // los valores de letra son 'H', 'o', 'l', 'a'
}  
```

!!! question "ACTIVIDAD 8: `📂 UD1/act8/act8.html`"
    Haz 3 funciones a las que se le pasa como parámetro un array de notas y devuelve la nota media. Cada una usará un for de una de las 3 formas vistas. Pruébalas en la consola

## Manejo de errores

Si sucede un error en nuestro código el programa dejará de ejecutarse por lo que el usuario tendrá la sensación de que no hace nada (el error sólo se muestra en la consola y el usuario no suele abrirla nunca). Para evitarlo debemos intentar capturar los posibles errores de nuestro código antes de que se produzcan.

En javascript (como en muchos otros lenguajes) el manejo de errores se realiza con sentencias

```javascript
try {
    ...
} 
catch(error) {
    ...
}
```

Dentro del bloque _`try`_ ponemos el código que queremos proteger y cualquier error producido en él será pasado al bloque `_catch_` donde es tratado. Opcionalmente podemos tener al final un bloque _`finally`_ que se ejecuta tanto si se produce un error como si no. El parámetro que recibe _`catch`_ es un objeto con las propiedades _`name`_, que indica el tipo de error (_`SyntaxError`_, _`RangeError`_, ... o el genérico _`Error`_), y _`message`_, que indica el texto del error producido.

En ocasiones podemos querer que nuestro código genere un error. Esto evita que tengamos que comprobar si el valor devuelto por una función es el adecuado o es un código de error. Por ejemplo tenemos una función para retirar dinero de una cuenta que recibe el saldo de la misma y la cantidad de dinero a retirar y devuelve el nuevo saldo, pero si no hay suficiente saldo no debería restar nada sino mostrar un mensaje al usuario. Sin gestión de errores haríamos:

```js linenums="1"
function retirar(saldo, cantidad) {
  if (saldo < cantidad) {
    return false
  }
  return saldo - cantidad
} 

// Y donde se llama a la función_
...
resultado = retirar(saldo, importe)
if (resultado === false) {
  alert('Saldo insuficiente')
} else {
  saldo = resultado
}
...
```

Se trata de un código poco claro que podemos mejorar lanzando un error en la función. Para ello se utiliza la instrucción `throw`:

```js linenums="1"
  if (saldo < cantidad) {
    throw 'Saldo insuficiente'
  }
```

Por defecto al lanzar un error este será de clase _Error_ pero (el código anterior es equivalente a `throw new Error('Valor no válido')`) aunque podemos lanzarlo de cualquier otra clase (`throw new RangeError('Saldo insuficiente')`) o personalizarlo.

Siempre que vayamos a ejecutar código que pueda generar un error debemos ponerlo dentro de un bloque _`try`_ por lo que la llamada a la función que contiene el código anterior debería estar dentro de un _`try`_. El código del ejemplo anterior quedaría:

```js linenums="1"
function retirar(saldo, cantidad) {
  if (saldo < cantidad) {
    throw "Saldo insuficiente"
  }
  return saldo - cantidad
} 

// Siempre debemos llamar a esa función desde un bloque _try_
...
try {
  saldo = retirar(saldo, importe)
} catch(err) {
  alert(err)
}
...
```

Podemos ver en detalle cómo funcionan en la página de [MDN web docs](https://developer.mozilla.org/es/docs/Web/JavaScript/Referencia/Sentencias/try...catch) de Mozilla.

!!! question "ACTIVIDAD 9: `📂 UD1/act9/act9.html`"
    Toma una función de la actividad anterior para que emita un error si detecta una nota que no esté entre 0 y 10 y prueba que funciona capturando los errores.

## Buenas prácticas

Javascript nos permite hacer muchas cosas que otros lenguajes no nos dejan por lo que debemos tener mucho cuidado para no cometer errores de los que suele avisar.

### 'use strict'

Si ponemos siempre esta sentencia al principio de nuestro código el intérprete nos avisará si usamos una variable sin declarar (muchas veces por equivocarnos al escribir su nombre). En concreto fuerza al navegador a no permitir:

* Usar una variable sin declarar
* Definir más de 1 vez una propiedad de un objeto
* Duplicar un parámetro en una función
* Usar números en octal
* Modificar una propiedad de sólo lectura

### Variables

Algunas de las prácticas que deberíamos seguir respecto a las variables son:

* Elegir un buen nombre es fundamental. Evitar abreviaturas o nombres sin significado (a, b, c, ...)
* Evitar en lo posible variables globales
* Usar _let_ para declararlas
* Usar _const_ siempre que una variable no deba cambiar su valor
* Declarar todas las variables al principio
* Inicializar las variables al declararlas
* Evitar conversiones de tipo automáticas
* Usar para nombrarlas la notación _camelCase_
* Utilizar nombres en inglés siempre que sea posible

También es conveniente, por motivos de eficiencia no usar objetos Number, String o Boolean sino los tipos primitivos (no usar `let numero = new Number(5)` sino `let numero = 5`) y lo mismo al crear arrays, objetos o expresiones regulares (no usar `let miArray = new Array()` sino `let miArray = []`).

### Errores

No se debería estar comprobando lo devuelto por una función para ver si se ha ejecutado correctamente o ha devuelto algún código de error. Si algo es erróneo no debemos devolver un código sino lanzar un error y quien ha llamado a esa función debería hacerlo dentro de un `try...catch` para capturar dicho error. Por ejemplo:

- Mal

```js linenums="1" hl_lines="4-6"
function getNombreMes(mes) {
   mes = mes - 1; // Ajustar el número de mes al índice del array (1 = Ene, 12 = Dic)
   var meses = new Array("Ene", "Feb", "Mar", "Abr", "May", "Jun", "Jul", "Ago", "Sep", "Oct", "Nov", "Dic");
   return meses[mes];
}

function muestraDatos(datos) {
   ...
   const nombreMes = getNombreMes(datos.mes);
   if (nombreMes === null) {
       alert('El mes ' + datos.mes + ' es erróneo');
   }
   ...
}
```

- Bien

```js linenums="1" hl_lines="3-7"
function getNombreMes(mes) {
   mes = mes - 1; // Ajustar el número de mes al índice del array (1 = Ene, 12 = Dic)
   var meses = new Array("Ene", "Feb", "Mar", "Abr", "May", "Jun", "Jul", "Ago", "Sep", "Oct", "Nov", "Dic");
   if (meses[mes] === null) {
       throw 'El mes ' + mes + ' es erróneo';
   }
   return meses[mes];
}

function muestraDatos(datos) {
   ...
   try {
      const nombreMes = getNombreMes(datos.mes);
   } catch(err) {
      alert(err)
   }
   ...
}
```

### Otras

Algunas reglas más que deberíamos seguir son:

* Debemos ser coherentes a la hora de escribir código: por ejemplo podemos poner (recomendado) o no espacios antes y después del `=` en una asignación pero debemos hacerlo siempre igual. Existen muchas guías de estilo y muy buenas: [Airbnb](https://github.com/airbnb/javascript), [Google](https://google.github.io/styleguide/javascriptguide.xml), [Idiomatic](https://github.com/rwaldron/idiomatic.js), etc. Para obligarnos a seguir las reglas podemos usar alguna herramienta [_linter_](https://www.codereadability.com/what-are-javascript-linters/).
* También es conveniente para mejorar la legibilidad de nuestro código separar las líneas de más de 80 caracteres.
* Usar `===` en las comparaciones
* Si un parámetro puede faltar al llamar a una función darle un valor por defecto
* Y para acabar **comentar el código** cuando sea necesario, pero mejor que sea lo suficientemente claro como para no necesitar comentarios

## Clean Code

Estas y otras muchas recomendaciones se recogen el el libro [Clean Code](https://books.google.es/books?id=hjEFCAAAQBAJ&dq=isbn:9780132350884&hl=es&sa=X&ved=0ahUKEwik8cfJwdLpAhURkhQKHcWBAxgQ6AEIJjAA) de _Robert C. Martin_ y en muchos otros libros y articulos. Aquí tenéis un pequeño resumen traducido al castellano:
- [https://github.com/devictoribero/clean-code-javascript](https://github.com/devictoribero/clean-code-javascript)
