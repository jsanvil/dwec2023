# UD1 - 2.3. Programación funcional

- [filter](#filter)
- [find](#find)
- [findIndex](#findindex)
- [every / some](#every--some)
- [map()](#map)
- [reduce](#reduce)
- [forEach](#foreach)
- [includes](#includes)
- [Array.from](#arrayfrom)
- [Referencia vs Copia](#referencia-vs-copia)
- [Rest y Spread](#rest-y-spread)
- [Desestructuración de arrays](#desestructuración-de-arrays)
- [Map (Diccionario)](#map-diccionario)
- [Set (Colección)](#set-colección)

Se trata de un paradigma de programación (una forma de programar) donde se intenta que el código se centre más en qué debe hacer una función que en cómo debe hacerlo. El ejemplo más claro es que intenta evitar los bucles _`for`_ y _`while`_ sobre arrays o listas de elementos. Normalmente cuando hacemos un bucle es para recorrer la lista y realizar alguna acción con cada uno de sus elementos. Lo que hace _functional programing_ es que a la función que debe hacer eso se le pasa como parámetro la función que debe aplicarse a cada elemento de la lista.

Desde la versión 5.1 javascript incorpora métodos de _functional programing_ en el lenguaje, especialmente para trabajar con arrays:

## filter

**Devuelve un nuevo array con los elementos que cumplen determinada condición del array al que se aplica**. Su parámetro es una función, habitualmente anónima, que va interactuando con los elementos del array. Esta función recibe como primer parámetro el elemento actual del array (sobre el que debe actuar). Opcionalmente puede tener como segundo parámetro su índice y como tercer parámetro el array completo. La función debe devolver **true** para los elementos que se incluirán en el array a devolver como resultado y **false** para el resto.

Ejemplo: dado un array con notas devolver un array con las notas de los aprobados. Esto usando programación _imperativa_ (la que se centra en _cómo se deben hacer las cosas_) sería algo como:

```js linenums="1"
let arrayNotas = [5.2, 3.9, 6, 9.75, 7.5, 3]
let aprobados = []
for (let i = 0 i++ i < arrayNotas.length) {
  let nota = arrayNotas[i]
  if (nota >= 5) {
    aprobados.push(nota)
  } 
}
// aprobados = [5.2, 6, 9.75, 7.5]
```

Usando _functional programming_ (la que se centra en _qué resultado queremos obtener_) sería:

```js linenums="1"
let arrayNotas = [5.2, 3.9, 6, 9.75, 7.5, 3]
let aprobados = arrayNotas.filter(function(nota) {
  if (nota >= 5) {
    return true
  } else {
    return false
  } 
})
// aprobados = [5.2, 6, 9.75, 7.5]
```

Podemos **refactorizar** esta función para que sea más compacta:

```js linenums="1"
let arrayNotas = [5.2, 3.9, 6, 9.75, 7.5, 3]
let aprobados = arrayNotas.filter(function(nota) {
  return nota >= 5
})
```

Y usando funciones lambda la sintaxis queda mucho más simple:

```js linenums="1"
let arrayNotas = [5.2, 3.9, 6, 9.75, 7.5, 3]
let aprobados = arrayNotas.filter(nota => nota >= 5)
```

Las 7 líneas del código usando programación _imperativa_ quedan reducidas a sólo una.

!!! question "ACTIVIDAD 14: `📂 UD1/funcional/act14.html`"
    Dado un array con los días de la semana obtén todos los días que empiezan por 'M'

## find

Como _`filter`_ pero NO devuelve un **array** sino el primer **elemento** que cumpla la condición (o _`undefined`_ si no la cumple ningún elemento). Ejemplo:

```js linenums="1"
let arrayNotas = [5.2, 3.9, 6, 9.75, 7.5, 3]
let primerAprobado = arrayNotas.find(nota => nota >= 5)
// primerAprobado = 5.2
```

Este método tiene más sentido con objetos. Por ejemplo, si queremos encontrar la persona con DNI '21345678Z' dentro de un array llamado personas cuyos elementos son objetos con un campo 'dni' haremos:

```js linenums="1"
let personaBuscada = personas.find(persona => persona.dni === '21345678Z')
// devolverá el objeto completo
```

!!! question "ACTIVIDAD 15: `📂 UD1/funcional/act15.html`"
    Dado un array con los días de la semana obtén el primer día que empieza por 'M'

## findIndex

Como _`find`_ pero en vez de devolver el elemento devuelve su posición (o `-1` si nadie cumple la condición). En el ejemplo anterior el valor devuelto sería 0 (ya que el primer elemento cumple la condición). Al igual que el anterior tiene más sentido con arrays de objetos.

!!! question "ACTIVIDAD 16: `📂 UD1/funcional/act16.html`"
    Dado un array con los días de la semana obtén la posición en el array del primer día que empieza por 'M'

## every / some

La primera devuelve **true** si **TODOS** los elementos del array cumplen la condición y **false** en caso contrario. La segunda devuelve **true** si **ALGÚN** elemento del array cumple la condición. Ejemplo:

```js linenums="1"
let arrayNotas = [5.2, 3.9, 6, 9.75, 7.5, 3]
let todosAprobados = arrayNotas.every(nota => nota >= 5)   // false
let algunAprobado = arrayNotas.some(nota => nota >= 5)     // true
```

!!! question "ACTIVIDAD 17: `📂 UD1/funcional/act17.html`"
    Dado un array con los días de la semana indica si algún día empieza por 'S'.
    Dado un array con los días de la semana indica si todos los días acaban por 's'

## map()

Permite modificar cada elemento de un array y devuelve un nuevo array con los elementos del original modificados.

*Ejemplo: queremos subir un 10% cada nota:*

```js linenums="1"
let arrayNotas = [5.2, 3.9, 6, 9.75, 7.5, 3]
let arrayNotasSubidas = arrayNotas.map(nota  => nota + nota * 10%)
```

!!! question "ACTIVIDAD 18: `📂 UD1/funcional/act18.html`"
    Dado un array con los días de la semana devuelve otro array con los días en mayúsculas

## reduce

Devuelve un valor calculado a partir de los elementos del array. En este caso la función recibe como primer parámetro el valor calculado hasta ahora y el método tiene como 1º parámetro la función y como 2º parámetro al valor calculado inicial (si no se indica será el primer elemento del array).

Ejemplo: queremos obtener la suma de las notas:

```js linenums="1"
let arrayNotas = [5.2, 3.9, 6, 9.75, 7.5, 3]
let sumaNotas = arrayNotas.reduce((total,nota) => total + =  nota, 0)    // total = 35.35
// podríamos haber omitido el valor inicial 0 para total
let sumaNotas = arrayNotas.reduce((total,nota) => total + =  nota)    // total = 35.35
```

Ejemplo: queremos obtener la nota más alta:

```js linenums="1"
let arrayNotas = [5.2, 3.9, 6, 9.75, 7.5, 3]
let maxNota = arrayNotas.reduce((max,nota) => nota > max ? nota : max)    // max = 9.75
```

En el siguiente ejemplo gráfico tenemos un "array" de verduras al que le aplicamos una función _map_ para que las corte y al resultado le aplicamos un _reduce_ para que obtenga un valor (el sandwich) con todas ellas:

![Functional Programming Sandwich](https://miro.medium.com/max/1268/1*re1sGlEEm1C95_Luq3cJbw.png)

!!! question "ACTIVIDAD 19: `📂 UD1/funcional/act19.html`"
    Dado el array de notas anterior `[5.2, 3.9, 6, 9.75, 7.5, 3]` devuelve la nota media utilizando `reduce`

## forEach

Es el método más general de los que hemos visto. No devuelve nada sino que permite realizar algo con cada elemento del array.

```js linenums="1"
let arrayNotas = [5.2, 3.9, 6, 9.75, 7.5, 3]
arrayNotas.forEach((nota, indice) => {
  console.log('El elemento de la posición ' + indice + ' es: ' + nota)
})
```

## includes

Devuelve **true** si el array incluye el elemento pasado como parámetro. Ejemplo:

```js linenums="1"
let arrayNotas = [5.2, 3.9, 6, 9.75, 7.5, 3]
arrayNotas.includes(7.5)     // true
```

!!! question "ACTIVIDAD 20: `📂 UD1/funcional/act20.html`"
    Dado un array con los días de la semana, utilizando `includes`, indica si algún día es el 'Martes'

## Array.from

Devuelve un array a partir de otro al que se puede aplicar una función de transformación (es similar a _map_). Ejemplo: queremos subir un 10% cada nota:

```js linenums="1"
let arrayNotas = [5.2, 3.9, 6, 9.75, 7.5, 3]
let arrayNotasSubidas = Array.from(arrayNotas, nota => nota + nota * 10%)
```

Puede usarse para hacer una copia de un array, igual que _slice_:

```js linenums="1"
let arrayA = [5.2, 3.9, 6, 9.75, 7.5, 3]
let arrayB = Array.from(arrayA)
```

También se utiliza mucho para convertir colecciones en arrays y así poder usar los métodos de arrays que hemos visto. Por ejemplo si queremos mostrar por consola cada párrafo de la página que comience por la palabra 'If' en primer lugar obtenemos todos los párrafos con:

```js linenums="1"
let parrafos = document.getElementsByTagName('p')
```

Esto nos devuelve una colección con todos los párrafos de la página (lo veremos más adelante al ver DOM). Podríamos hacer un **for** para recorrer la colección y mirar los que empiecen por lo indicado pero no podemos aplicarle los métodos vistos aquí porque son sólo para arrays así que hacemos:

```js linenums="1"
let arrayParrafos = Array.from(parrafos);
// y ya podemos usar los métodos que queramos:
arrayParrafos
  .filter(parrafo  => parrafo.textContent.startsWith('If'))
  .forEach(parrafo  => alert(parrafo.textContent));
```

!!! danger "**IMPORTANTE**:"
    Desde este momento se deben evitar los bucles _`for`_ en nuestro código para trabajar con arrays. Se valorará muy positivamente el uso de las funciones apropiadas.

## Referencia vs Copia

Cuando copiamos una variable de tipo _boolean_, _string_ o _number_ o se pasa como parámetro a una función se hace una copia de la misma y si se modifica la variable original no es modificada. Ej.:

```js linenums="1"
let a = 54
let b = a      // a = 54 b = 54
b = 86         // a = 54 b = 86
```

Sin embargo al copiar objetos (y los arrays son un tipo de objeto) la nueva variable apunta a la misma posición de memoria que la antigua por lo que los datos de ambas son los mismos:

```js linenums="1"
let a = [54, 23, 12]
let b = a
// a = [54, 23, 12] b = [54, 23, 12]

b[0] = 3
// a = [3, 23, 12] b = [3, 23, 12]

let fecha1 = new Date('2023-09-23')
let fecha2 = fecha1
// fecha1 = '2023-09-23'   fecha2 = '2023-09-23'

fecha2.setFullYear(1999)
// fecha1 = '1999-09-23'   fecha2 = '1999-09-23'
```

Si queremos obtener una copia de un array que sea independiente del original podemos obtenerla con `slice` o con `Array.from`:

```js linenums="1"
let a = [2, 4, 6]
let copiaDeA = a.slice()       // ahora ambos arrays contienen lo mismo pero son diferentes
let otraCopiaDeA = Array.fom(a)
```

En el caso de objetos es algo más complejo. ES6 incluye [`Object.assign`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object/assign) que hace una copia de un objeto:

```js linenums="1"
let a = {id:2, name: 'object 2'}
let copiaDeA = Object.assign({}, a)       // ahora ambos objetos contienen lo mismo pero son diferentes
```

Sin embargo si el objeto tiene como propiedades otros objetos estos se continúan pasando por referencia. Es ese caso lo más sencillo sería hacer:

```js linenums="1"
let a = {id: 2, name: 'object 2', address: {street: 'C/ Ajo', num: 3} }
let copiaDeA =  JSON.parse(JSON.stringify(a))       // ahora ambos objetos contienen lo mismo pero son diferentes
```

!!! question "ACTIVIDAD 21: `📂 UD1/funcional/act21.html`"
    
    - Dado el array `arr1` con los días de la semana haz un array `arr2` que sea igual al `arr1`.
    
    - Elimina de `arr2` el último día y comprueba quá ha pasado con `arr1`.
    
    - Repite la operación con un array llamado `arr3` pero que crearás haciendo una copia de `arr1`.

También podemos copiar objetos usando _`rest`_ y _`spread`_.

## Rest y Spread

Permiten extraer a parámetros los elementos de un array o string (_`spread`_) o convertir en un array un grupo de parámetros (_`rest`_). El operador de ambos es **`...`** (3 puntos).

Para usar _rest_ como parámetro de una función debe ser siempre el último parámetro. 

_**Ejemplo:** queremos hacer una función que calcule la media de las notas que se le pasen como parámetro y que no sabemos cuántas són. Para llamar a la función haremos:_

```js linenums="1"
console.log(notaMedia(3.6, 6.8)) 
console.log(notaMedia(5.2, 3.9, 6, 9.75, 7.5, 3)) 
```

La función convertirá los parámetros recibidos en un array usando _`rest`_:

```js linenums="1"
function notaMedia(...notas) {
  let total = notas.reduce((total, nota) => total +=  nota)
  return total / notas.length
}
```

Si lo que queremos es convertir un array en un grupo de elementos haremos _`spread`_.

_**Por ejemplo** el objeto _`Math`_ proporciona métodos para trabajar con números como _`.max`_ que devuelve el máximo de los números pasados como parámetro. Para saber la nota máxima en vez de _`.reduce`_ como hicimos en el ejemplo anterior podemos hacer:_

```js linenums="1"
let arrayNotas = [5.2, 3.9, 6, 9.75, 7.5, 3]

let maxNota = Math.max(...arrayNotas)    // maxNota = 9.75
// si hacemos Math.max(arrayNotas) devuelve NaN porque arrayNotas es un array y no un número
```

Estas funcionalidades nos ofrecen otra manera de copiar objetos (_pero sólo a partir de ES-2018_):

```js linenums="1"
let a = { id: 2, name: 'object 2' }
let copiaDeA = { ...a }       // ahora ambos objetos contienen lo mismo pero son diferentes

let b = [2, 8, 4, 6]
let copiaDeB = [ ...b ]       // ahora ambos objetos contienen lo mismo pero son diferentes
```


## Desestructuración de arrays

Similar a _`rest`_ y _`spread`_, permiten extraer los elementos del array directamente a variables y viceversa.

_Ejemplo:_

```js linenums="1"
let arrayNotas = [5.2, 3.9, 6, 9.75, 7.5, 3]
let [primera, segunda, tercera] = arrayNotas   // primera = 5.2, segunda = 3.9, tercera = 6
let [primera, , , cuarta] = arrayNotas         // primera = 5.2, cuarta = 9.75
let [primera, ...resto] = arrayNotas           // primera = 5.2, resto = [3.9, 6, 9.75, 3]
```

También se pueden asignar valores por defecto:

```js linenums="1"
let preferencias = ['Javascript', 'NodeJS']
let [lenguaje, backend = 'Laravel', frontend = 'VueJS'] = preferencias 
// lenguaje = 'Javascript', backend = 'NodeJS', frontend = 'VueJS'
```

La desestructuración también funciona con objetos. Es normal pasar un objeto como parámetro para una función pero si sólo nos interesan algunas propiedades del mismo podemos desestructurarlo:

```js linenums="1"
const miProducto = {
    id: 5,
    name: 'TV Samsung',
    units: 3,
    price: 395.95
}

function muestraNombre({name, units}) {
    console.log('Del producto ' + name + ' hay ' + units + ' unidades')
}

muestraNombre(miProducto)
```

También podemos asignar valores por defecto:

```js linenums="1"
function miProducto({name, units = 0}) {
    console.log('Del producto ' + name + ' hay ' + units + ' unidades')
}

muestraNombre({name: 'USB Kingston'})
// mostraría: Del producto USB Kingston hay 0 unidades
```

## Map (Diccionario)

Es una colección de parejas de **`clave: valor`**. Un objeto en Javascript es un tipo particular de _Map_ en que las claves sólo pueden ser texto o números. Se puede acceder a una propiedad con **`.`** o **`[clave]`**. Ejemplo:

```js linenums="1"
let persona = {
  nombre: 'John',
  apellido: 'Doe',
  edad: 39
}
console.log(persona.nombre)      // John
console.log(persona['nombre'])   // John
```

Un _`Map`_ permite que la clave sea cualquier cosa (array, objeto, ...). No vamos a ver en profundidad estos objetos pero podéis saber más en [MDN](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Map) o cualquier otra página. 

## Set (Colección)

Es similar a un _`Map`_ pero que **no almacena los valores sino sólo la clav**e. Podemos verlo como una colección que **no permite duplicados**. Tiene la propiedad **`size`** que devuelve su tamaño y los métodos **`.add`** (añade un elemento), **`.delete`** (lo elimina) o **`.has`** (indica si el elemento pasado se encuentra o no en la colección) y también podemos recorrerlo con **`.forEach`**.

Una forma sencilla de eliminar los duplicados de un array es crear con él un _`Set`_:

```js linenums="1"
let ganadores = ['Márquez', 'Rossi', 'Márquez', 'Lorenzo', 'Rossi', 'Márquez', 'Márquez']
let ganadoresNoDuplicados = new Set(ganadores)
// {'Márquez, 'Rossi', 'Lorenzo'}

// o si lo queremos en un array:
let ganadoresNoDuplicados = Array.from(new Set(ganadores))
// ['Márquez, 'Rossi', 'Lorenzo']
```
