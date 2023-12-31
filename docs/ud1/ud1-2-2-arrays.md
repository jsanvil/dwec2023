# UD1 - 2.2. Arrays

- [Introducción](#introducción)
  - [Arrays de objetos](#arrays-de-objetos)
- [Operaciones con Arrays](#operaciones-con-arrays)
  - [length](#length)
  - [Añadir elementos](#añadir-elementos)
  - [Eliminar elementos](#eliminar-elementos)
  - [splice](#splice)
  - [slice](#slice)
  - [Arrays y Strings](#arrays-y-strings)
  - [sort](#sort)
  - [Otros métodos comunes](#otros-métodos-comunes)

## Introducción

Son un tipo de objeto y no tienen tamaño fijo sino que podemos añadirle elementos en cualquier momento. 

Se recomienda crearlos usando notación JSON:

```js linenums="1"
let a = []
let b = [2,4,6]
```

aunque también podemos crearlos como instancias del objeto Array (NO recomendado):

```js linenums="1"
let a = new Array()        // a = []
let b = new Array(2,4,6)   // b = [2, 4, 6]
```

Sus elementos pueden ser de cualquier tipo, incluso podemos tener elementos de tipos distintos en un mismo array. Si no está definido un elemento su valor será _undefined_. Ej.:

```js linenums="1"
let a = ['Lunes', 'Martes', 2, 4, 6]
console.log(a[0])  // imprime 'Lunes'
console.log(a[4])  // imprime 6
a[7] = 'Juan'        // ahora a = ['Lunes', 'Martes', 2, 4, 6, , , 'Juan']
console.log(a[7])  // imprime 'Juan'
console.log(a[6])  // imprime undefined
console.log(a[10])  // imprime undefined
```

Acceder a un elemento de un array que no existe no provoca un error (devuelve _undefined_) pero sí lo provoca acceder a un elemento de algo que no es un array.

!!! info "Operador `?.`"
    En ES2020 (ES11) se ha incluido el operador **`?.`** para evitar tener que comprobar nosotros que sea un array:

    ```javascript
    console.log(alumnos?.[0])
    // si alumnos es un array muestra el valor de su primer
    // elemento y si no muestra undefined
    ```

### Arrays de objetos

Es habitual almacenar datos en arrays en forma de objetos, por ejemplo:

```js linenums="1"

let alumnos = [
  {
    id: 1,
    name: 'Marc Peris',
    course: '2nDAW',
    age: 21
  },
  {
    id: 2,
    name: 'Júlia Tortosa',
    course: '2nDAW',
    age: 23
  },
]
```

## Operaciones con Arrays

Vamos a ver los principales métodos y propiedades de los arrays.

### length

Esta propiedad devuelve la longitud de un array: 

```js linenums="1"
let a = ['Lunes', 'Martes', 2, 4, 6]
console.log(a.length)  // imprime 5
```

Podemos reducir el tamaño de un array cambiando esta propiedad:

```js linenums="1"
a.length = 3  // ahora a = ['Lunes', 'Martes', 2]
```

### Añadir elementos

Podemos añadir elementos al final de un array con `push` o al principio con `unshift`:

```js linenums="1"
let a = ['Lunes', 'Martes', 2, 4, 6]
a.push('Juan')   // ahora a = ['Lunes', 'Martes', 2, 4, 6, 'Juan']
a.unshift(7)     // ahora a = [7, 'Lunes', 'Martes', 2, 4, 6, 'Juan']
```

### Eliminar elementos

Podemos borrar el elemento del final de un array con `pop` o el del principio con `shift`. Ambos métodos devuelven el elemento que hemos borrado:

```js linenums="1"
let a = ['Lunes', 'Martes', 2, 4, 6]
let ultimo = a.pop()         // ahora a = ['Lunes', 'Martes', 2, 4] y ultimo = 6
let primero = a.shift()      // ahora a = ['Martes', 2, 4] y primero = 'Lunes'
```

### [splice](https://developer.mozilla.org/es/docs/Web/JavaScript/Referencia/Objetos_globales/Array/splice)

Permite eliminar elementos de cualquier posición del array y/o insertar otros en su lugar. Devuelve un array con los elementos eliminados. Sintaxis:

```js
Array.splice(inicio, cantidad de elementos a extraer, 1º elemento a insertar, 2º elemento a insertar, 3º...)
```

Ejemplo:

```js linenums="1"
let a = ['Lunes', 'Martes', 2, 4, 6]
let borrado = a.splice(1, 3)       // a = ['Lunes', 6] y borrado = ['Martes', 2, 4]

a = ['Lunes', 'Martes', 2, 4, 6]
borrado = a.splice(1, 0, 45, 56)   // a = ['Lunes', 45, 56, 'Martes', 2, 4, 6] y borrado = []

a = ['Lunes', 'Martes', 2, 4, 6]
borrado = a.splice(1, 3, 45, 56)   // a = ['Lunes', 45, 56, 6] y borrado = ['Martes', 2, 4]
```

!!! question "ACTIVIDAD 11: `📂 UD1/act11/act11.html`"
    Guarda en un array la lista de la compra con `Peras`, `Manzanas`, `Kiwis`, `Plátanos` y `Mandarinas`. Haz los siguiente con splice:

    - **Elimina** las `Manzanas` (debe quedar Peras, Kiwis, Plátanos y Mandarinas)
    - **Añade** detrás de los `Plátanos` `Naranjas` y `Sandía` (debe quedar Peras, Kiwis, Plátanos, Naranjas, Sandía y Mandarinas)
    - **Quita** los `Kiwis` y pon en su lugar `Cerezas` y `Nísperos` (debe quedar Peras, Cerezas, Nísperos, Plátanos, Naranjas, Sandía y Mandarinas)

### slice

Devuelve un subarray con los elementos indicados pero sin modificar el array original (sería como hacer un `substr` pero de un array en vez de una cadena). Sintaxis:

```javascript
Array.slice(posicion, num. de elementos a devolver)
```

Ejemplo:

```js linenums="1"
let a = ['Lunes', 'Martes', 2, 4, 6]
let subArray = a.slice(1, 3)       // ahora a = ['Lunes', 'Martes', 2, 4, 6] y subArray = ['Martes', 2, 4]
```

Es muy útil para hacer una copia de un array:

```js linenums="1"
let a = [2, 4, 6]
let copiaDeA = a.slice()       // ahora ambos arrays contienen lo mismo pero son diferentes arrays
```

### Arrays y Strings

Cada objeto (y los arrays son un tipo de objeto) tienen definido el método `.toString()` que lo convierte en una cadena. Este método es llamado automáticamente cuando, por ejemplo, queremos mostrar un array por la consola. En realidad `console.log(a)` ejecuta `console.log(a.toString())`. En el caso de los arrays esta función devuelve una cadena con los elementos del array dentro de corchetes y separados por coma.

Además podemos convertir los elementos de un array a una cadena con `.join()` especificando el carácter separador de los elementos. Ej.:

```js linenums="1"
let a = ['Lunes', 'Martes', 2, 4, 6]
let cadena = a.join('-')       // cadena = 'Lunes-Martes-2-4-6'
```

Este método es el contrario del m `.split()` que convierte una cadena en un array. Ej.:

```js linenums="1"
let notas = '5-3.9-6-9.75-7.5-3'
let arrayNotas = notas.split('-')        // arrayNotas = [5, 3.9, 6, 9.75, 7.5, 3]
let cadena = 'Que tal estás'
let arrayPalabras = cadena.split(' ')    // arrayPalabras = ['Que`, 'tal', 'estás']
let arrayLetras = cadena.split('')       // arrayLetras = ['Q','u','e`,' ','t',a',l',' ','e',s',t',á',s']
```

### sort

Ordena **alfabéticamente** los elementos del array

```js linenums="1"
let a = ['hola','adios','Bien','Mal',2,5,13,45]
let b = a.sort()       // b = [13, 2, 45, 5, "Bien", "Mal", "adios", "hola"]
```

También podemos pasarle una función que le indique cómo ordenar que devolverá un valor negativo si el primer elemento es mayor, positivo si es mayor el segundo o 0 si son iguales. Ejemplo: ordenar un array de cadenas sin tener en cuenta si son mayúsculas o minúsculas:

```js linenums="1"
let a = ['hola','adios','Bien','Mal']
let b = a.sort(function(elem1, elem2) {
  if (elem1.toLocaleLowerCase > elem2.toLocaleLowerCase)
    return -1
  if (elem1.toLocaleLowerCase < elem2.toLocaleLowerCase)
    return 1
  return 0
})       // b = ["adios", "Bien", "hola", "Mal"]
```

Como más se utiliza esta función es para ordenar arrays de objetos. Por ejemplo si tenemos un objeto _alumno_ con los campos _name_ y _age_, para ordenar un array de objetos _alumno_ por su edad haremos:

```js linenums="1"
let alumnosOrdenado = alumnos.sort(function(alumno1, alumno2) {
  return alumno1.age - alumno2.age
})
```

Usando _arrow functions_ quedaría más sencillo:

```js linenums="1"
let alumnosOrdenado = alumnos.sort((alumno1, alumno2)  => alumno1.age - alumno2.age)
```

Si lo que queremos es ordenar por un campo de texto debemos usar la función _toLocaleCompare_:

```js linenums="1"
let alumnosOrdenado = alumnos.sort((alumno1, alumno2)  => alumno1.name.localeCompare(alumno2.name))
```

!!! question "ACTIVIDAD 12: `📂 UD1/act12/act12.html`"
    Haz una función que ordene las notas de un array pasado como parámetro. Si le pasamos `[4,8,3,10,5]` debe devolver `[3,4,5,8,10]`. Pruébalo en la consola

### Otros métodos comunes

Otros métodos que se usan a menudo con arrays son:

* `.concat()`: concatena arrays

```js linenums="1"
let a = [2, 4, 6]
let b = ['a', 'b', 'c']
let c = a.concat(b)       // c = [2, 4, 6, 'a', 'b', 'c']
```

* `.reverse()`: invierte el orden de los elementos del array

```js linenums="1"
let a = [2, 4, 6]
let b = a.reverse()       // b = [6, 4, 2]
```

* `.indexOf()`: devuelve la primera posición del elemento pasado como parámetro o `-1` si no se encuentra en el array
* `.lastIndexOf()`: devuelve la última posición del elemento pasado como parámetro o `-1` si no se encuentra en el array

!!! question "ACTIVIDAD 13: `📂 UD1/act13/act13.html`"
    Dado el siguiente array de objetos:

    ```
    alumnado = [
      { nombre: "Sara", edad: 19 },
      { nombre: "Pepe", edad: 61 },
      { nombre: "Lara", edad: 24 },
      { nombre: "Álex", edad: 17 },
      { nombre: "Inés", edad: 31 }
    ];
    ```

    Crea dos funciones:
    
    - `ordenaEdad()` que ordene por edad de mayor a menor.
    - `ordenaNombre()` que ordene por nombre.
    
    *¿Qué ocurre si algún elemento del array no es un objeto? por ejemplo, `alumnado.push("Fran")`*

    Captura los posibles errores.
