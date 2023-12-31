# UD1 - 2.1. Objetos en Javascript

- [Introducción](#introducción)
- [Propiedades de un objeto](#propiedades-de-un-objeto)
- [Métodos de un objeto](#métodos-de-un-objeto)
- [Bibliografía](#bibliografía)

## Introducción

En Javascript podemos definir cualquier variable como un objeto declarándola con **new** (NO se recomienda) o creando un _literal object_ (usando notación **JSON**).

Ejemplo con _new_, **⚠️ NO recomendado**:

```js linenums="1" 
let alumno = new Object()
alumno.nombre = 'Carlos'     // se crea la propiedad 'nombre' y se le asigna un valor
alumno['apellidos'] = 'Pérez Ortiz'    // se crea la propiedad 'apellidos'
alumno.edad = 19
```

Creando un _literal object_, es la **forma recomendada**.

El ejemplo anterior sería:

```js linenums="1"
let alumno = {
    nombre: 'Carlos',
    apellidos: 'Pérez Ortiz',
    edad: 19,
};
```

## Propiedades de un objeto

Podemos acceder a las propiedades con `.` (punto) o `[ ]`:

```js linenums="1"
console.log(alumno.nombre)       // imprime 'Carlos'
console.log(alumno['nombre'])    // imprime 'Carlos'
let prop = 'nombre'
console.log(alumno[prop])        // imprime 'Carlos'
```

Si intentamos acceder a propiedades que no existen no se produce un error, se devuelve _undefined_:

```javascript
console.log(alumno.ciclo)      // muestra undefined
```

Sin embargo se genera un error si intentamos acceder a propiedades de algo que no es un objeto:

```javascript
console.log(alumno.ciclo)           // muestra undefined
console.log(alumno.ciclo.descrip)      // se genera un ERROR
```

Para evitar ese error antes había que comprobar que existan las propiedades previas:

```javascript
console.log(alumno.ciclo && alumno.ciclo.descrip)
// si alumno.ciclo es un objeto muestra el valor de 
// alumno.ciclo.descrip y si no muestra undefined
```

!!! info "NOTA:"
    Con ES2020 (ES11) se ha incluido el operador **?.** para evitar tener que comprobar esto nosotros:

    ```javascript
    console.log(alumno.ciclo?.descrip)
    // si alumno.ciclo es un objeto muestra el valor de 
    // alumno.ciclo.descrip y si no muestra undefined
    ```

Podremos recorrer las propiedades de un objecto con `for..in`:

```js linenums="1"
for (let prop in alumno) {
    console.log(prop + ': ' + alumno[prop])
}
```

Si el valor de una propiedad es el valor de una variable que se llama como la propiedad no es necesario ponerlo:

```js linenums="1"
let nombre = 'Carlos'

let alumno = {
    nombre,            // es equivalente a nombre: nombre
    apellidos: 'Pérez Ortiz',
    ...
```

## Métodos de un objeto

Una propiedad de un objeto puede ser una función:

```js linenums="1"
alumno.getInfo = function() {
    return 'El alumno ' + this.nombre + ' ' + this.apellidos + ' tiene ' + this.edad + 'años'
}
```

También podemos ponerlo con sintaxis _arrow function_:
```js linenums="1"
alumno.getInfo = () => 'El alumno ' + this.nombre + ' ' + this.apellidos + ' tiene ' + this.edad + 'años'
```

Y para llamarlo se hace como con cualquier otra propiedad:
```javascript
console.log(alumno.getInfo())    // imprime 'El alumno Carlos Pérez Ortíz tiene 19 años'
```

!!! question "ACTIVIDAD 10: `📂 UD1/act10/act10.html`"
    Crea un objeto llamado **`inventario`** con las propiedades:

    - `nombre` = TV Samsung 42
    - `categoria` = Televisores
    - `unidades` = 4
    - `precio` = 345.95
    - `importe` devuelve el valor total de las unidades (nº de unidades * precio).

    Introduce 2 productos más en el objeto inventario y comprueba que funciona correctamente.

## Bibliografía
* Curso 'Programación con JavaScript'. CEFIRE Xest. Arturo Bernal Mayordomo
