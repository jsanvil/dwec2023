# 3. Programación orientada a Objetos en Javascript

- [Introducción](#introducción)
    - [Ojo con _this_](#ojo-con-this)
- [Herencia](#herencia)
- [Métodos estáticos](#métodos-estáticos)
- [Método _toString()_](#método-tostring)
- [Método _valueOf()_](#método-valueof)
- [Programación orientada a objetos en JS5](#programación-orientada-a-objetos-en-js5)
- [Bibliografía](#bibliografía)

## Introducción

Desde ES2015 la POO en Javascript es similar a como se hace en otros lenguajes:

```javascript
class Alumno {
    constructor(nombre, apellidos, edad) {
        this.nombre = nombre
        this.apellidos = apellidos
        this.edad = edad
    }
    getInfo() {
        return `El alumno ${this.nombre} ${this.apellidos} tiene ${this.edad} años`
    }
}

let alumno = new Alumno('Carlos', 'Pérez Ortiz', 19)

console.log(alumno.getInfo())
// imprime 'El alumno Carlos Pérez Ortíz tiene 19 años'
```

!!! question "ACTIVIDAD 1: `📂 UD4/act01/`"

    Crea las siguientes clases con sus propiedades y atributos:

    - Clase **_`Product`_**:

        Cada producto será un objeto con las propiedades _**`cod`**_, _**`name`**_, _**`price`**_ y _**`units`**_. Si no le pasamos unidades al constructor su número por defecto será `1`.
        
        Esta clase tendrá los siguientes métodos:
  
        - **`changeUnits`**_`(units)`_ : Recibe la cantidad a aumentar (positiva o negativa) e incrementa (o decrementa) las unidades en la cantidad recibida. Si se intentan restar más unidades de las que hay no hace nada y devuelve _`false`_ y en otro caso cambia las unidades y devuelve _`true`_
        - **`getImport`**`()` : Devuelve el importe total del producto (su precio multiplicado por el nº de unidades)
        - **`getDescription`**`()` : Mostrará su descripción, sus unidades entre paréntesis, su precio y el importe total. _Por ejemplo: `TV Samsung MP45 (5): 235,95 €/u => 1179,75 €`_

    - Clase **_`Store`_**

        Es el almacén de productos y tendrá las propiedades _**`id`**_ (código numérico que nos pasan al crear el almacén) y _**`products`**_ (array de productos que al crearlo estará vacío)
        
        Tendrá los siguientes los métodos:

        - **`findProduct`**`(cod)` : Recibe un código de producto y devuelve el producto que tiene dicho código o _`null`_ si ese código no existe en el almacén.
        - **`addProduct`**`(cod, units, nombre, precio)`: Recibe como parámetro el código y unidades a añadir y, opcionalmente, el nombre y precio (si se trata de un producto nuevo) y lo añade al almacén. Si ya existe el código suma al producto las unidades indicadas y si no existe crea un nuevo producto en el array. Devuelve _true_.
        - **`delProduct`**`(cod, units)`: recibe como parámetro el código y las unidades a quitar de un producto y lo resta del almacén. Devuelve _`true`_ a menos que haya menos unidades de las que quieren restarse, en cuyo caso no hace nada y devuelve _`false`_.
        - **`totalImport`**`()`: Devuelve el valor total de los productos del almacén.
        - **_orderByDescrip_**: devuelve el array de productos ordenado por el nombre
        - **_orderByUnits_**: devuelve el array de productos ordenado por unidades descendente

    Para probar que funciona correctamente añadiremos al fichero `main.js`:

    ```js
    let almacen = new Store(1);

    almacen.addProduct(1, 4, 'TV Samsung MP45', 345.95);
    almacen.addProduct(2, 8, 'Portátil Acer Travelmate 200', 245.95);
    almacen.addProduct(3, 15, 'Impresora Epson LX-455', 45.95);
    almacen.addProduct(4, 25, 'USB Kingston 16GB', 5.95);

    console.log('LISTADO DEL ALMACÉN');
    almacen.products.forEach( prod => console.log(prod.getDescription()) );

    almacen.addProduct(5, 15, 'USB Kingston 64GB', 15.95);
    almacen.delProduct(3, 11);
    almacen.delProduct(3, 7);
    almacen.addProduct(1, 9);

    console.log('LISTADO DEL ALMACÉN');
    almacen.products.forEach( prod => console.log(prod.getDescription()) );
    ```

    Además en nuestro main.js haremos que se muestren por consola todos los productos de los que tenemos menos de 5 unidades en stock o cuyo importe es inferior a 150 €.


### Ojo con _this_

Dentro de una función se crea un nuevo contexto y la variable _this_ pasa a hacer referencia a dicho contexto. Si en el ejemplo anterior hiciéramos algo como esto:

```js hl_lines="7"
class Alumno {
    ...
    getInfo() {
        return 'El alumno ' + nomAlum() + ' tiene ' + this.edad + ' años'

        function nomAlum() {
            return this.nombre + ' ' + this.apellidos
            // Aquí this no es el objeto Alumno
        }
    }
}
```

Este código fallaría porque dentro de la función _`nomAlum`_ la variable _`this`_ ya no hace referencia al objeto _`Alumno`_ sino al contexto de la función. Este ejemplo no tiene mucho sentido pero a veces nos pasará en _listeners_ de eventos. 

Si debemos llamar a una función dentro de un método (o de un _listener_ de eventos) tenemos varias formas de pasarle el valor de _this_:

- Usando una _**arrow function**_ que no crea un nuevo contexto por lo que _this_ conserva su valor:

    ```js hl_lines="3"
        getInfo() {
            return 'El alumno ' + nomAlum() + ' tiene ' + this.edad + ' años'
            let nomAlum = () => this.nombre + ' ' + this.apellidos
        }
    ```

- Pasándole _this_ como parámetro a la función:

    ```js hl_lines="3"
        getInfo() {
            return 'El alumno ' + nomAlum(this) +' tiene ' + this.edad + ' años'
            function nomAlum(alumno) {
                return alumno.nombre + ' ' + alumno.apellidos
            }
        }
    ```

- Guardando el valor en otra variable (como _that_):

    ```js hl_lines="3"
        getInfo() {
            let that = this;
            return 'El alumno ' + nomAlum() +' tiene ' + this.edad + ' años'
            function nomAlum() {
                return that.nombre + ' ' + that.apellidos
                // Aquí this no es el objeto Alumno
            }
        }
    ```

- Haciendo un _bind_ de _this_ en eventos.

## Herencia

Una clase puede heredar de otra utilizando la palabra reservada **extends** y heredará todas sus propiedades y métodos. Podemos sobrescribirlos en la clase hija. Seguimos pudiendo llamar a los métodos de la clase padre utilizando la palabra reservada **`super`**, es lo que haremos si creamos un constructor en la clase hija.

```js linenums="1"
class AlumnInf extends Alumno {

  constructor (nombre, apellidos, edad, ciclo) {
    super(nombre, apellidos, edad)
    this.ciclo = ciclo
  }

  getInfo() {
    return `${super.getInfo()} y estudia el Grado ${this.getGradoMedio() ? 'Medio' : 'Superior'} de ${this.ciclo}`
  }

  getGradoMedio() {
    return this.ciclo.toUpperCase === 'SMX'
  }
}

let alumnoInf = new AlumnInf('Carlos', 'Pérez Ortiz', 19, 'DAW')
console.log(alumnoInf.getInfo())
// imprime 'El alumno Carlos Pérez Ortíz tiene 19 años y estudia el Grado Superior de DAW'
```

!!! question "ACTIVIDAD 2: `📂 UD4/act02/`"

    Crea una clase _**`Screen`**_ que hereda de _**`Product`**_ y que tiene una nueva propiedad llamada _**`size`**_. El método _**getDescription()**_ mostrará el tamaño (`size`) junto al nombre.

## Métodos estáticos

Desde ES2015 podemos declarar métodos estáticos, pero no propiedades estáticas. Estos métodos se llaman directamente utilizando el nombre de la clase y no tienen acceso al objeto _`this`_ (ya que no hay objeto instanciado).

```js hl_lines="3"
class User {
    ...
    static getRoles() {
        return ["user", "guest", "admin"]
    }
}

console.log(User.getRoles())
// ["user", "guest", "admin"]

let user = new User("john")
console.log(user.getRoles())
// Uncaught TypeError: user.getRoles is not a function
```

## Método _toString()_

Al convertir un objeto a string (por ejemplo al concatenarlo con un _String_) se llama al método **_.toString()_** del mismo, que por defecto devuelve la cadena `[object Object]`. Podemos sobrecargar este método para que devuelva lo que queramos:

```javascript
class Alumno {
    ...
    toString() {
        return this.apellidos + ', ' + this.nombre
    }
}

let alumno = new Alumno('Carlos', 'Pérez Ortiz', 19);
console.log('Alumno:' + alumno) // imprime 'Alumno: Pérez Ortíz, Carlos'
                                // en vez de 'Alumno: [object Object]'
```

Este método también es el que se usará si queremos ordenar una array de objetos (recordad que _`.sort()`_ ordena alfabéticamente para lo que llama al método _`.toString()`_ del objeto a ordenar). Por ejemplo, tenemos el array de alumnos _`misAlumnos`_ que queremos ordenar alfabéticamente. Si la clase _`Alumno`_ no tiene un método _`toString`_ habría que hacer como vimos en la [ud1 Arrays](../ud1/ud1-2-2-arrays.md):

```js
misAlumnos.sort(function(alum1, alum2) {
    if (alum1.apellidos > alum2.apellidos)
      return -1
    if (alum1.apellidos < alum2.apellidos)
      return 1
    return 0
});
```

Pero con el método _`toString`_ que hemos definido antes podemos hacer directamente:

```js
misAlumnos.sort() 
```

Si las cadenas a comparar pueden tener acentos u otros caracteres propios del idioma ese código no funcionará bien. La forma correcta de comparar cadenas es usando el método `.localeCompare()`. El código anterior debería ser:

```javascript
misAlumnos.sort(function(alum1, alum2) {
    return alum1.apellidos.localeCompare(alum2.apellidos)
});   
```

que con _arrow function_ quedaría:

```javascript
misAlumnos.sort((alum1, alum2) => alum1.apellidos.localeCompare(alum2.apellidos))
```

o si queremos comparar por 2 campos ('apellidos' y 'nombre')

```javascript
misAlumnos.sort((alum1, alum2) => (alum1.apellidos+alum1.nombre).localeCompare(alum2.apellidos+alum2.nombre) )
```

Si queremos ordenar un array de objetos por un campo numérico lo mas sencillo es restar dicho campo:

```javascript
misAlumnos.sort((alum1, alum2) => alum1.edad - alum2.edad)
```

!!! question "ACTIVIDAD 3: `📂 UD4/act03/`"

    Adapta las clases `Product` y `Screen` para que el método que muestra los datos del producto se llame de la manera más adecuada sobrecargando _**`toString`**_

    Crea 5 productos y guárdalos en un array. Crea las siguientes funciones (todas reciben ese array como parámetro):

    - _**`prodsSortByName()`**_ : Devuelve un array con los productos ordenados alfabéticamente.
    - _**`prodsSortByPrice()`**_ : Devuelve un array con los productos ordenados por importe.
    - _**`prodsTotalPrice()`**_: Devuelve el importe total del los productos del array, con 2 decimales.
    - _**`prodsWithLowUnits(prods, units)`**_: Recibe el array de productos y como segundo parámetro un número. Devuelve un array con todos los productos de los que quedan menos de los unidades indicadas.
    - _**`prodsList()`**_: Devuelve una cadena que dice 'Listado de productos:' y en cada línea un guión y la información de un producto del array.

## Método _valueOf()_

Al comparar objetos (con `>`, `<`, `==`, `===`, etc.) se usa el valor devuelto por el método _`.toString()`_ pero si definimos un método **_.valueOf()_** será este el que se usará en comparaciones:

```javascript
class Alumno {
    ...
    valueOf() {
        return this.edad
    }
}

let alumno1 = new Alumno('Carlos', 'Pérez Ortiz', 19)
let alumno2 = new Alumno('Ana', 'Abad Tudela', 23)
console.log(alumno1 < alumno2)     // imprime true ya que 19 < 23
```

## Programación orientada a objetos en JS5

!!! note **NOTA**
    Este apartado está sólo para que comprendamos este código si lo vemos en algún programa pero nosotros programaremos como hemos visto antes.

En _Javascript_ un objeto se crea a partir de otro (al que se llama _prototipo_). Así se crea una cadena de prototipos, el primero de los cuales es el objeto _null_.

Las versiones de Javascript anteriores a ES2015 no soportan clases ni herencia. Si queremos emular en ellas el comportamiento de las clases lo que se hace es:

- Para crear el constructor se crea una función con el nombre del objeto.
- Para crear los métodos se aconseja hacerlo en el _prototipo_ del objeto para que no se cree una copia del mismo por cada instancia que creemos:

```javascript
function Alumno(nombre, apellidos, edad) {
    this.nombre = nombre
    this.apellidos = apellidos
    this.edad = edad
}

Alumno.prototype.getInfo = function() {
    return `El alumno ${this.nombre} ${this.apellidos} tiene ${this.edad} años`
}

let alumno = new Alumno('Carlos', 'Pérez Ortiz', 19)
console.log(alumno.getInfo())     // imprime 'El alumno Carlos Pérez Ortíz tiene 19 años'
```

Cada objeto tiene un prototipo del que hereda sus propiedades y métodos (es el equivalente a su clase, pero en realidad es un objeto que está instanciado). Si añadimos una propiedad o método al prototipo se añade a todos los objetos creados a partir de él lo que ahorra mucha memoria.

## Bibliografía

* Curso 'Programación con JavaScript'. CEFIRE Xest. Arturo Bernal Mayordomo
