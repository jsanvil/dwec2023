# UD 6 - Actividad 2

## Listar los eventos

Vamos a mostrar imágenes con los eventos. En este caso podéis descargar las imágenes que se proporcionan o usar las que queráis. En cualquier caso debéis situarlas dentro de la carpeta `src/assets`, y referenciarlas en los objetos de los eventos.

[evento1.jpg](img/evento1.jpg) | [evento2.jpg](img/evento2.jpg)

```typescript
eventos: Evento[] = [{
    ...
    image: 'assets/evento1.jpg',
    ...
}, {
    ...
    image: 'assets/evento2.jpg',
    ...
}];
```

Posteriormente, hay que mostrar la imagen en la plantilla HTML. Para ello situamos el elemento `<img>` correspondiente dentro del elemento `<div class="card">`, de la siguiente manera:

```html
    <div class="card">
        <img class="card-img-top">
        <div class="card-body">
            ...
```

Se debe vincular el atributo `src` de la imagen a la propiedad `evento.image` del objeto correspondiente.

Además hay que filtrar el título del evento con el filtro `titlecase` (pone la primera letra de cada palabra en mayúscula), para poder usarlo deberás importar el filtro predefinido `TitleCasePipe` del módulo `@angular/common`.

El precio se mostrará con el símbolo del euro mediante un filtro (ver ejemplo en apuntes) y la fecha en formato `dd/MM/y` (ver ejemplo en apuntes). Los eventos listados tendrán este aspecto:

![eventos](img/act2-1.png)

## Filtrar y ordenar eventos

Vamos a introducir una barra de búsqueda (igual que en el ejemplo de los apuntes) para filtrar los eventos por título. Crea un filtro (_pipe_) personalizado llamado `evento-filter`. Recibirá el array de eventos (`Evento[]`) y una cadena de búsqueda (`string`), y devolverá los eventos que contengan la cadena en su título (podéis incluir también la búsqueda en la descripción).

Además, vamos a crear 2 enlaces para ordenar los eventos por **fecha** o por **precio**. Al hacer clic sobre estos enlaces se llamará a un método del componente, que borrará el filtro actual de búsqueda (ponemos la variable a cadena vacía `''`) y ordenará el array en base a la fecha o al precio. Para ordenar por fecha, al estar almacenada como cadena en formato `yyyy-mm-dd`, puedes ordenar alfabéticamente.

**Importante**: Si quieres reordenar el array sin borrar el filtro verás como no funciona. Esto pasa porque los _pipes_ en _Angular_, no detectan los cambios internos en el objeto a filtrar (array de eventos en este caso) para optimizar el rendimiento, por lo que no se volvería a ejecutar el filtrado y no se actualizaría la vista. Para forzar los cambios debemos generar un nuevo array. Esto es sencillo utilizando el operador spread ‘`...`’ de _JavaScript_.

```typescript
this.eventos = [...this.eventos].sort(...);
```

Cuando no hay filtro siempre funcionaría porque se devuelve el array original (`@for` sí detecta cambios internos) y no el array previamente filtrado por el _pipe_.

Este es el HTML a añadir para mostrar tanto el campo de búsqueda como los 2 enlaces:

```html
<nav class="navbar navbar-light bg-light justify-content-between mt-3">
    <div class="container-fluid">
        <ul class="nav">
            <li class="nav-item">
                <a class="nav-link"
                    href="#"
                    (click)="orderDate()">Orden por fecha</a>
            </li>
            <li class="nav-item">
                <a class="nav-link"
                    href="#"
                    (click)="orderPrice()">Orden por precio</a>
            </li>
        </ul>
        <form class="d-flex mb-0">
            <input class="form-control me-2"
                type="text"
                [(ngModel)]="search"
                name="search"
                placeholder="Search"
                aria-label="Search">
        </form>
    </div>
</nav>
<div class="mb-4 row row-cols-1 row-cols-md-2 row-cols-xl-3 g-4">
    <!-- (Aquí es donde se listan los eventos) -->
</div>
```

¡No olvides importar el módulo `FormsModule` en el módulo de tu aplicación!

## Nuevo evento

Como último apartado del ejercicio, vamos a crear un formulario para insertar un nuevo evento. Por ahora se creará en la misma página, encima del listado de eventos. Tampoco se guardarán en una base de datos por ahora. Ya iremos solucionando estos "problemas" más adelante.

En lugar de que cada campo de texto haga referencia a una variable o atributo de la clase del componente por separado. Es más recomendable crear un objeto de evento vacío y referenciar sus campos. De esta forma cuando enviemos el formulario, lo único que tendremos que hacer es añadir el objeto con sus propiedades ya rellenadas al array de eventos.

```typescript
export class EventosShowComponent {
    newEvento: Evento = {
        title: '',
        description: '',
        image: '',
        price: 0,
        date: ''
    };
    ...
}
```

Esta es la estructura del formulario que se debe implementar. Se ha vinculado con [(ngModel)] el título del evento. Vinculad el resto vosotros/as:

```html
<form class="mt-4" (ngSubmit)="addEvento()">
    <div class="mb-3">
        <label for="name" class="form-label">Nombre</label>
        <input type="text" class="form-control"
            name="title"
            [(ngModel)]="newEvento.title"
            placeholder="Enter name">
    </div>
    <div class="mb-3">
        <label for="date">Fecha</label>
        <input type="date" class="form-control" name="date">
    </div>
    <div class="mb-3">
        <label for="description" class="form-label">Descripción</label>
        <textarea class="form-control" name="description" rows="3"></textarea>
    </div>
    <div class="mb-3">
        <label for="price" class="form-label">Precio</label>
        <input type="number" class="form-control" name="price"
            min="0.00" max="10000.00" step="0.01" />
    </div>
    <div class="mb-3">
        <label for="image" class="form-label">Imagen</label>
        <input type="file" class="form-control"
            name="image"
            #fileImage
            (change)="changeImage(fileImage)">
    </div>
    <img [src]="newEvento.image" alt="" class="img-thumbnail">
    <div class="mb-3">
       <button type="submit" class="btn btn-primary">Create</button>
    </div>
</form>
```

Como se puede observar, se utiliza el evento `ngSubmit` para llamar a un método, `addEvento()`, cuando el formulario se envía. Normalmente se usaría el evento submit, pero `ngSubmit` tiene ciertas ventajas como la de no recargar la página automáticamente cuando se lanza.

En el método `addEvento()`, debemos añadir el evento (`newEvento`) al array de eventos y reiniciar los campos del formulario otra vez. Es decir, volver a asignar a `newEvento` un nuevo objeto con los campos vacíos. No vale con vaciar los campos del objeto, ya que en array se guarda la referencia al objeto y las modificaciones se reflejarían en ambos lados (otra opción es generar una copia del objeto, que guardaremos en el array, y entonces, vaciar los campos de `newEvento`).

Para mejorar la visualización de la imagen en el formulario, cuando la imagen del evento asociado al formulario esté vacía (no se haya seleccionado ninguna) ponle la clase "`d-none`" (equivale a `display:none`) para que no se vea un icono de imagen rota o un círculo vacío que ocupa espacio. Utiliza `ngClass` para ello.

No se requiere validar nada del formulario por ahora. Esa parte veremos más adelante como gestionarla con _Angular_.

## Mostrar la descripción del evento

Al añadir un evento directamente desde el formulario, los saltos de línea tendrán el carácter `\n` en lugar de la etiqueta `<br>`. Para que se reconozcan estos saltos de línea en HTML, podemos hacer 2 cosas.

Mediante la propiedad de CSS `white-space`:

```css
.card-text {
    white-space: pre-wrap;
}
```

O usando el atributo `innerText`:

```html
<!-- Sólo reconoce el <br> como salto -->
<p class="card-text">{{evento.description}}</p>

<!-- Reconoce el \n como salto -->
<p class="card-text" [innerText]="evento.description"></p>
```

## Convertir la imagen a Base64 y previsualizarla

Desde un formulario, el navegador no deja acceder a la ruta local del archivo cargado (imagen), por lo que la única opción que nos queda es transformar esta imagen a `Base64` (string).

Si observas el formulario, verás que el input de la imagen tiene un atributo llamado `#fileImage` (ya entenderemos que significa más adelante), y el evento `(change)`, para cuando cambia el archivo seleccionado. Este es el método que debéis añadir en el componente:

```typescript
changeImage(fileInput: HTMLInputElement) {
    if (!fileInput.files || fileInput.files.length === 0) { return; }
    const reader: FileReader = new FileReader();
    reader.readAsDataURL(fileInput.files[0]);
    reader.addEventListener('loadend', e => {
        this.newEvento.image = reader.result as string;
    });
}
```

La imagen convertida la guardará en la propiedad `this.newEvento.image`. Esta imagen en `Base64` se puede asignar directamente al campo `src` de la imagen como se puede observar en el elemento `<img>` del formulario. De esta manera la podremos previsualizar antes de añadir el nuevo evento.
