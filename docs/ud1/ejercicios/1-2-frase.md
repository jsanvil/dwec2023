# Bloc 1: Javascript. UD 1: Sintaxis

## Práctica 1.2 - Frase

Vamos a pedir al usuario que introduzca una frase y a continuación mostraremos en la consola:

- el número de caracteres (incluyendo espacios) y de palabras que tiene
- la frase en mayúsculas
- la frase con la primera letra de cada palabra en mayúsculas
- la frase escrita con las letras al revés
- la frase escrita con las palabras al revés
- si es o no un palíndromo (si se lee igual al revés) pero omitiendo espacios en blanco y sin diferenciar mayúsculas y minúsculas.

Para hacer más sencillo el pasar los tests a nuestro programa para comprobar si funciona crearemos (e incluiremos en el fichero HTML) 2 ficheros JS distintos:

- _`functions.js`_: este fichero sólo incluye las funciones indicadas más abajo
- _`index.js`_: es el programa principal que contiene el código que pide la frase al usuario y, si ha introducido algo, la muestra y llama a las distintas funciones y muotrando por consola la información devuelta por las mismas.

En el _`index.html`_ deberás incluir cada fichero en su etiqueta _`script`_ (en primer lugar el de las funciones).

Las funciones que contendrá el fichero _`functions.js`_ deben llamarse **EXACTAMENTE** como se indica a continuación:

- `letras`: devuelve el número de caracteres (incluyendo espacios) de la cadena pasada como parámetro (sólo un número)
- `palabras`: devuelve el número de palabras de la cadena pasada como parámetro (sólo un número)
- `maysc`: devuelve la cadena pasada como parámetro convertida a mayúsculas
- `titulo`: devuelve la cadena pasada como parámetro con la primera letra de cada pañabra convertida a mayúsculas
- `letrasReves`: devuelve la cadena pasada como parámetro al revés
- `palabrasReves`: devuelve la cadena pasada como parámetro con sus palabras al revés
- `palindromo`: devuelve true si la cadena pasada como parámetro es un palíndromo y false si no lo es. Para ello no se tendrán en cuenta espacios en blanco ni la capitalización de las letras

Por ejemplo, si el usuario introduce la frase:

> La ruta nos aporto otro paso natural

el programa de _`index.js`_ mostraría en la consola lo siguiente:

```
Frase: "La ruta nos aporto otro paso natural"
36 letras y 7 palabras
LA RUTA NOS APORTO OTRO PASO NATURAL 
La Ruta Nos Aporto Otro Paso Natural 
larutan osap orto otropa son atur aL 
natural paso otro aporto nos ruta La 
Sí es un palíndromo
```

Intenta usar en cada caso el bucle más adecuado. Las funciones `split` y `join` (lo opuesto) de _`String`_ y _`Array`_ nos pueden ayudar a algunas cosas.

**RECUERDA**:

- El código deberá estar en un fichero externo y se incluirá al final del `body`.
- Debes comentarlo para tener claro qué hace.
- Tanto el código JS como el HTML deben estar correctamente indentados.
- Uen en cuenta los datos que pueden “estropearnos” el programa: que el usuario introduzca un dato de un tipo que no te esperas, que omita algún parámetro, etc.
- Usa las recomendaciones indicadas: ‘use strict’, etc.
- El código debe ser lo más limpio y claro posible, sin variables o código innecesario.
- Siempre es bueno refactorizar el código: cuando nuestro programa ya funciona bien le damos un “repaso” para mejorar su claridad (y lo volvemos a probar).

### Pasar los test

Por último debes comprobar tu código antes de entregarlo para asegurarte que apruebas esta práctica. Para hacer accesibles las funciones al test debes añadir al final de tu fichero _functions.js_ la instrucción:

```javascript
module.exports = {
	letras,
	palabras,
	maysc,
	titulo,
	letrasReves,
	palabrasReves,
	palindromo
}
```

(a partir de ahora, a menos que comentes esta instrucción, cuando lo ejecutes en el navegador mostrará en la consola el error de Javascript '`ReferenceError: module is not defined`' pero continuará funcionando correctamente).

!!! warning "NOTA"
	si aún no lo has hecho, [instala ahora _npm_](../12-tests.md#instalar-npm)

En el repositorio ya tienes el proyecto inicializado (ya está el fichero _`package.json`_) por lo que no tienes que hacerlos tú. SI por algún motivo lo quieres volver a inicializar debes hacerlo con el comando `npm init`. Cuando pregunte por el comando para ejecutar los tests indicaremos que es **jest**. 

Si aún no has [instalado _jest_](../12-tests.md#instalar-jest) en tu equipo debes hacerlo antes de pasar los test.

Para pasar los test escribimos en la terminal:

```bash
$ npm run test
```
