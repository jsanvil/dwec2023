# UD1 Ejercicio de refuerzo 8: Programación funcional

En este ejercicio vamos a practicar la programación funcional en JavaScript.

El objetivo es completar una funciones que ordenen y filtren los datos de un array de objetos. Este tipo de controles se suelen utilizar para facilitar la navegación en páginas web con muchos elementos.

Utiliza las funciones de arrays vistas en la unidad.

## Pasos a seguir

Descarga los siguientes archivos:

- [comida.json](funcional/comida.json) JSON con los datos a tratar.

    Puedes revisar la estructura de los datos para entender la estructura de datos. No es necesario modificarlo.

- [style.css](funcional/style.css) Hoja de estilos para la página web.

    No se debería modificar este archivo.

- [comida.html](funcional/comida.html) Página web base donde se mostrarán los resultados.

    No de debería modificar este archivo. Está preparado para mostrar los resultados de las funciones que debes completar en `main.js`.

- [main.js](funcional/main.js) Archivo JavaScript donde debes completar el código.

    Contiene funciones ya preparadas para recoger los datos en de `comida.json` y mostrar los resultados.

Completa las funciones de `main.js`:

- **`btnSortByName()`**:

    Muestra los elementos del array "`comida`" ordenado por nombre.

- **`btnSortByPriceDescending()`**:

    Muestra los elementos del array "`comida`" ordenado por precio de forma ascendente.

- **`btnSortByCategory()`**:

    Muestra todos los elementos del array "`comida`" ordenados por categoría.

- **`btnFilterCheaperThan5`**:

    Muestra los elementos con precio menor a 5

- **`avgPrice(array)`**:

    Calcula y muestra la media de los precios de los elementos del array pasado como parámetro.

- **`getCategories()`**:

    Devuelve un array con las categorías de los elementos del array "`comida`". Si está bien implementado, el desplegable mostrará las categorías.

- **`changeCategory()`**:
  
    Muestra solo los elementos de la categoría seleccionada en el desplegable. Es necesario haber implementado correctamente la función `getCategories()`.

Las funciones tienen diferentes niveles de complejidad, completa las que puedas.