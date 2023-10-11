# UD1 Ejercicio de refuerzo 4: Intervalos de x minutos

Crea un programa que pida al usuario:

- Una hora de inicio (ej. `15:00`)
- Una hora de finalización (ej. `17:00`)
- El intervalo de minutos (sólo el número, ej. `15`)

Mostrará por consola todas las horas que van desde la hora de inicio a la de finalización de X en X minutos (ej. `15:00`, `15:15`, `15:30`, `15:45`, `16:00`, `16:15`, `16:30`, `16:45`, `17:00`).

Debes controlar:

- Las horas de inicio y finalización deben ser una hora válida (la hora un número entero entre `0` y `23` y los minutos un número entero entre `0` y `59`, ambos separados por el carácter "`:`")
- El intervalo de minutos deben ser un número entero mayor que `0` y menor o igual que `59`.
- Si un valor introducido no es correcto se muestra al usuario un mensaje informando del error (un alert) y se le vuelve a pedir el valor.
- En la consola las horas y los minutos se deben mostrar siempre con 2 dígitos (**`09:03`** y NO _`9:3`_).
