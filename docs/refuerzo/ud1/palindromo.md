# UD1 Ejercicio de refuerzo 2: Palíndromo

Vamos a pedir al usuario que introduzca una frase y a continuación mostraremos en la consola:

- El número de caracteres (incluyendo espacios) y de palabras que tiene
- La frase en mayúsculas
- La frase con la primera letra de cada palabra en mayúsculas
- La frase escrita con las letras al revés
- La frase escrita con las palabras al revés
- Si es o no un palíndromo (si se lee igual al revés) pero omitiendo espacios en blanco y sin diferenciar mayúsculas y minúsculas.

Debes crear funciones para cada una de las tareas anteriores.

- `letras(frase)`: devuelve el número de caracteres (incluyendo espacios) de la cadena pasada como parámetro (sólo un número)
- `palabras(frase)`: devuelve el número de palabras de la cadena pasada como parámetro (sólo un número)
- `maysc(frase)`: devuelve la cadena pasada como parámetro convertida a mayúsculas
- `titulo(frase)`: devuelve la cadena pasada como parámetro con la primera letra de cada pañabra convertida a mayúsculas
- `letrasReves(frase)`: devuelve la cadena pasada como parámetro al revés
- `palabrasReves(frase)`: devuelve la cadena pasada como parámetro con sus palabras al revés
- `palindromo(frase)`: devuelve true si la cadena pasada como parámetro es un palíndromo y false si no lo es. Para ello no se tendrán en cuenta espacios en blanco ni la capitalización de las letras

Por ejemplo, si el usuario introduce la frase:

> La ruta nos aporto otro paso natural

El programa mostraría en la consola lo siguiente:

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
