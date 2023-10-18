# UD3 - Proyecto clave secreta

El objetivo de este proyecto es crear un programa que permita a dos usuarios jugar a un juego donde deben descubrir una clave secreta. Similar al popular juego _wordle_, pero utilizando números en lugar de letras.

El juego consiste en que la aplicación genera un número de 5 cifras y el jugador tiene que adivinarlo.

Para ello, cada vez que el jugador propone un número, la aplicación le indica cuántas cifras de ese número son correctas y están en la posición correcta (son aciertos) y cuántas cifras son correctas pero están en la posición incorrecta (son coincidencias).

_Por ejemplo:_

- Si el número secreto es `1` `0` `3` `4` `5`
- El jugador propone el número **`1`** `2` **`3`** _`5`_ `7`
- La aplicación indicará que los número en la 1ª y 2ª posición **aciertos**, por ejemplo cambiando el color de los números a **verde**.
- La aplicación indicará que el número en la 5ª posición son **coincidencias**, por ejemplo cambiando el color de los números a **amarillo**.
- La aplicación indicará que el número en la 1ª y 4ª posición es un **error**, por ejemplo cambiando el color de los números a **rojo**.

**Condición de victoria**: El juego termina cuando el jugador acierta el número secreto.
**Condición de derrota**: El juego termina cuando el jugador ha realizado 6 intentos sin haber acertado el número secreto.

## Requisitos

- La aplicación debe estar bien estructurada en archivos HTML, CSS y JS.
- El código debe estar estructurado en funciones con comentarios que expliquen brevemente su propósito.
- El programa debe generar un número secreto de 5 cifras, sin cifras repetidas.
- Presentar el tablero de juego en una tabla de 6 filas y 5 columnas.
- El jugador debe poder introducir un número de 5 cifras mediante botones con eventos asociados.
- Mostrar los intentos restantes (6 intentos como máximo).
- Indicar el número de aciertos, coincidencias y errores de cada intento, cambiando el color del número según corresponda.
- Mostrar un mensaje de victoria o derrota cuando se cumplan las condiciones de victoria o derrota.
- Mostrar el número secreto cuando se cumplan las condiciones de victoria o derrota.
- Incluir un botón que permita reiniciar el juego, previa confirmación del usuario. Que genera un nuevo número secreto, limpia la tabla y reinicia los intentos.

## Opcional

- Permitir al jugador elegir el número de intentos.
- Permitir al jugador elegir el número de cifras del número secreto.
- Añadir eventos para que también funcione mediante teclado.
- Crea eventos personalizados para las condiciones de victoria y derrota.
