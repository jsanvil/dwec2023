# UD 6 - Actividad 5

En esta actividad vamos a dividir la aplicación en páginas. Para ello tendremos que hacer algunas pequeñas modificaciones a la aplicación existente.

## Rutas de la aplicación

Añadiremos las siguientes rutas a la aplicación:

- `/eventos` : Listado de eventos (`EventosShowComponent`)
- `/eventos/add` : Añadir evento (`EventoAddComponent`)
- `/eventos/:id` : Detalle de un evento (`EventoDetailComponent`). Este componente es nuevo.
- Por defecto, se redirigirá al listado de eventos.

Además, pondremos los enlaces para navegar al listado de eventos y al formulario de añadir evento en la barra superior de navegación:

```html
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <a class="navbar-brand" href="#">Angular Events</a>
    <ul class="navbar-nav mr-auto">
        <li class="nav-item">
            <a class="nav-link" ... >Eventos</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" ... >Añadir evento</a>
        </li>
    </ul>
</nav>
```

En el enlace del listado de eventos, se recomienda incluir también el atributo `[routerLinkActiveOptions]="{exact: true}"`, para que no aparezca resaltado cuando navegamos a "_Añadir evento_", ya que si no, comprueba que la ruta `/eventos/add` contiene el prefijo `/eventos` y la resalta también.

## Página: Mostrar eventos

A la página de mostrar eventos le podemos quitar el componente del formulario de añadir evento, ahora estará en una página aparte, así como el método de añadir un evento al _array_, dado que los cargará del servidor directamente.

- _Consejo_: Los enlaces de ordenar por precio y fecha hacen _scroll_ en la página (culpa de `href="#"`). Lo ideal sería que no fueran enlaces, pero entonces tendríamos que poner CSS para que lo parecieran (tal vez la mejor opción). Otra manera de no recargar la página es cancelando el evento por defecto:

    ```html
    <li class="nav-item">
        <a class="nav-link" href="#" (click)="orderDate($event)">Orden por fecha</a>
    </li>
    ```

    ```typescript
    orderDate(event: Event) { // Recibe evento click de HTML
        event.preventDefault(); // Cancelamos comportamiento por defecto
        ... // Ordenamos array
    }
    ```

## Página: Detalle de un evento

Navegaremos a esta página cuando hagamos clic en la foto o el título de un evento. Esta página recibirá el evento a mostrar obtenido gracias a un `Resolve` que se explica más adelante. Para mostrar el evento, reutilizaremos el componente `evento-item`. Cuando el evento se borre nos limitaremos a volver al listado de eventos y veremos como ya no aparece:

```html
<div class="mt-4">
    <evento-item [evento]="evento" (borrado)="goBack()"></evento-item>
</div>
```

Necesitaremos implementar un nuevo método en `EventosService` que nos devuelva la información de un evento a partir de su `id`. La ruta del servidor será `/eventos/:id`. _Por ejemplo, si la `id` es `F4K31D`, llamaríamos a `/eventos/F4K31D`_.

```typescript
getEvento(id: string): Observable<Evento> {
    ...
}
```

## Página: Añadir evento

Esta página contendrá el formulario de añadir evento (quitarlo de `eventos-show`). Este formulario ya no necesita emitir ningún evento, borra el `EventEmitter`, simplemente redirige a la página de listado de eventos si todo ha ido bien.

## Guard: `SaveChangesGuard`

Crea el _guard_ `SaveChangesGuard` de tipo **`CanDeactivate`**, preguntará si queremos abandonar la página (con un `confirm`). Se lo aplicaremos a la página del formulario de añadir evento (similar al ejemplo de los apuntes).

- _Consejo_: Añade un booleano al componente que indique si se ha añadido un evento correctamente. Inicialmente será `false`, y cuando se añada el evento, antes de redirigir, ponlo a `true`. En el método `canDeactivate` comprueba si has añadido un evento y en ese caso no preguntes nada (devuelve `true`).

## Resolver: `EventoResolver`

`EventoResolver` Obtendrá del servidor el evento cuya `id` haya sido pasada por parámetro (como en el ejemplo de los apuntes). Hay que aplicárselo a la ruta de detalle de un evento.
