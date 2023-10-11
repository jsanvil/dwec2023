# UD1 Ejercicio de refuerzo 3: Bola Mágica 8

En este proyecto construiremos una _Bola Mágica 8_ utilizando el flujo de control en JavaScript.

El usuario podrá ingresar una pregunta que se pueda responder con un simple sí o no. Nuestro programa devolverá una respuesta aleatoria.

## Pasos a seguír

- En la primera línea del programa, define una variable llamada `userName` que esté vacía.

    Si el usuario quiere, puede ingresar su nombre.

- A continuación de esta variable, crea una expresión que decida qué hacer si el usuario ingresa un nombre o no.
   
   Si el usuario ingresa un nombre, por ejemplo "`Paco`", utiliza la concatenación de cadenas para mostrar "`Hola, Paco!`" en la consola.
   
   De lo contrario, simplemente muestra `¡Hola!`.

- Crea una variable llamada `userQuestion`. El valor de la variable debe ser una cadena que sea la pregunta que el usuario quiere hacerle a la _Bola Mágica 8_.

- Escribe un `console.log()` para `userQuestion`, indicando lo que se preguntó. (Puedes incluir el nombre del usuario en la declaración `console.log()` si lo deseas).

- Necesitamos generar un número aleatorio entre `0` y `7`.

    Crea otra variable, y nómbrala `randomNumber`. Asígnale el valor de esta expresión, que utiliza dos métodos (`Math.floor()` y `Math.random()`) de la biblioteca `Math`.

    `Math.floor(Math.random() * 8);`

- Crea una variable más llamada `eightBall`, y asígnale una cadena vacía. Guardará un valor dependiendo del valor de `randomNumber`, descritos en los siguientes pasos.

- Necesitamos tomar valor de la variable `randomNumber`, y luego asigne a `eightBall` a una respuesta que devolvería una _Bola Mágica_ 8.

    Aquí hay 8 frases de _Bola Mágica 8_ que almacenará en la variable `eightBall`:

    - `Es cierto`
    - `Es decididamente así`
    - `Puedes confiar en ello`
    - `Vuelve a preguntar más tarde`
    - `No puedo predecirlo ahora`
    - `No cuentes con ello`
    - `Mis fuentes dicen que no`
    - `Las perspectivas no son muy buenas`

    > NOTA: Aunque sería lo más lógico, **no utilices un array** para almacenar los valores.
    
    Utiliza condicionales `if/else` o `switch`. Si `randomNumber` es `0`, entonces guarda una respuesta en la variable `eightBall`; si `randomNumber` es `1`, guarda la siguiente respuesta, y así sucesivamente.

- Escribe un `console.log()` para imprimir la respuesta de la _Bola Mágica 8_, el valor de la variable `eightBall`.

- Ejecuta tu programa varias veces para ver resultados aleatorios aparecer en la consola.

Si quieres práctica adicional:

- Si comenzaste con una declaración `switch`, conviértela en declaraciones `if/else`.

- Si comenzaste con declaraciones `if/else`, conviértelas en una declaración `switch`.
