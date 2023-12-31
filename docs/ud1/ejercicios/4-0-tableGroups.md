# Bloc 1: Javascript. Práctica 4.0 - DOM (grupos)

Siguiendo con la práctica de 'Alumnos y grupos' vamos a crear una página donde mostrar en una tabla los grupos de nuestro ejercicio anterior. Cada fila corresponderá a un grupo y se mostrarán todos sus datos. En el fichero `index.html` está el esqueleto de la vista, que usa **_bootstrap_** para mejorar la presentación. La página está dividida en 3 zonas:

- Un `div` con `id` _`messages`_ donde mostrar mensajes al usuario y poder prescindir de `console.log` o `alert`
- Una tabla vacía con `id` _`grupos`_ donde pintaremos esos grupos. Debajo de la misma mostraremos el número total de grupos de la tabla.
- Un `div` para modificarlos, que contiene 2 formularios:
    - **`newgroup`**: formulario para añadir nuevos grupos. Debéis modificarlo para que tenga un *input* para introducir el **código** (obligatorio, entre 3 y 5 caracteres), el **nombre** (obligatorio, al menos 3 caracteres), el **grado** (*radiobuttons*, también obligatorio) y la **familia** (obligatorio) además de los botones de 'Enviar' y 'Reset'
    - **`delgroup`**: formulario para borrar un producto. Tendrá un *input* para introducir su **id** (obligatorio, debe ser un número entero positivo)

El usuario interactuará con la aplicación usando los formularios que hay bajo la tabla. Para mejorar su presentación hemos usado _bootstrap_ por lo que cada input del formulario tiene la siguiente estructura básica:

```html
<div class="form-group">
    <label for="newprod-name">Nombre: </label>
    <input type="text" class="form-control" id="newprod-name">
</div>
```

Respecto a los botones de cada formulario tienen el siguiente aspecto:

```html
<button type="submit" class="btn btn-default btn-primary">Añadir</button>
<button type="reset" class="btn btn-secondary">Reset</button>
```

El grado lo mostraremos mediante *radiobuttons* (ya los tenéis hechos pero falta añadirles los atributos que necesiten).

Debemos crear los inputs para _`cod`_, _`nombre`_ y _`familia`_ en el formulario de añadir así como los botones de enviar ese formulario (tipo '`submit`') y borrarlo (tipo '`reset`'). Además hay que añadir a los *inputs* ya creados los atributos necesarios para que funcionen correctamente y también para que se validen por HTML. Es conveniente ponerle un _`id`_ a cada campo para que sea más sencillo acceder a ellos desde el código.

En el `index.js` tienes ya creadas las funciones manejadoras de eventos que se ejecutarán automáticamente cuando se envíe cada formulario pero debes completar su código. Dichas funciones deben ocuparse de:

- recoger los datos del formulario
- ejecutar la acción necesaria (crear el grupo o eliminarlo). Para ello usaremos las funciones que hicimos en el ejercicio anterior
- reflejar en la página el cambio producido (añadir un `<tr>` para el nuevo grupo o eliminar el `<tr>` del grupo borrado)

Las funciones manejadores de eventos reciben como parámetro un objeto _`event`_ con información sobre el evento producido y su primera línea será `event.preventDefault()` para que no se recargue la página al enviar el formulario (en el tema de _Eventos_ veremos el por qué de todo esto). 

Tenéis que tener en cuenta que:

- no podéis volver a renderizar toda la tabla, sólo hay que cambiar lo que nos dicen porque el renderizado es lo que más consumo de recursos hace y no queremos perjudicar el rendimiento de nuestra aplicación (imaginad una tabla con muchos grupos). Por tanto en ningún momento podemos cambiar el innerHTML de la tabla ni de su `<tbody>` sino sólo añadir o elimnar `<tr>`
- recordad que bajo la tabla hay un TOTAL que siempre debe estar actualizado

Además deberás crear tendrá un método llamado **renderErrorMessage** al que se le pasa un texto y añade dentro del DIV con _`id`_ **`messages`** un nuevo `<div>` con el mensaje a mostrar al usuario para evitar los `console.error`. Su código HTML será:

```html
<div class="col-sm-12 alert alert-danger">
    <span>Aquí pondremos el texto que nos han pasado para mostrar</span>
    <button type="button" class="close" aria-label="Close" onclick="this.parentElement.remove()">
        <span aria-hidden="true">&times;</span>
    </button>
</div>
```

Fijaos que el botón tiene un atributo _`onclick`_ cuyo valor es el código Javascript que borra este `<div>`. No es lo más correcto pero de momento lo haremos así.

**CONSEJO**: nuestro fichero index.js está haciéndose muy grande y es difícil encontrar lo que buscamos. Si queremos podemos organizar nuestro código dividiéndolo en varios ficheros distintos. Esto si queréis podéis hacerlo al final, cuando todo funcione correctamente, o antes de empezar a programar. Si seguimos el patrón MVC podemos crear los ficheros:

- `model.js`: aquí definimos los datos y las funciones que los modifican. Sería el contenido del `index.js` del ejercicio 3.0
- `view`: aquí pondremos las funciones que cambian la página (las que modifican el DOM). Necesitaremos una para añadir un grupo, otra para eliminar un grupo, otra para cambiar el total de la tabla y la de _renderErrorMessage_
- `controller`: aquí ponemos las funciones que controlan nuestra aplicación, es decir, _formAddGroup_ y _formDelGroup_
- `index.js`: se quedaría sólo con el código que pone los escuchadores:

```javascript
window.addEventListener('load', () => {
    document.getElementById('new-group').addEventListener('submit', formAddGroup)
    document.getElementById('del-group').addEventListener('submit', formDelGroup)
})
```

De esta manera cada fichero es más corto y tenemos las funciones separadas según el tipo de tarea que realizan. Recordad que en el _`index.html`_ deberemos cargar todos estos fichero y en el orden adecuado ya que _`index.js`_ llama a las funciones de _`controller.js`_ (por lo que _`controller`_ debe cargarse antes de _`index`_) y _`controller.js`_ llama a funciones de _`model.js`_ y _`view.js`_ por lo que debe cargarse después de ellos.
