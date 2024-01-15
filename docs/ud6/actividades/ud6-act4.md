# UD 6 - Actividad 4

En esta actividad vamos a adaptar el proyecto para trabajar con servicios web y que los cambios sean permanentes. Para ello, vamos a adaptar el servicio `EventosService` como los componentes afectados.

Se utilizará un servicio local, implementado con `json-server`, para simular el servicio web.

A partir de ahora, cuando hablemos de un servicio, por ejemplo `/eventos`, la ruta completa será concatenando la URL base al servicio, _ej: `http://localhost:3000/eventos`_.

Muestra por consola los posibles errores que se puedan producir en las peticiones, con `console.error`.

Debemos utilizar la interfaz `Evento` para reflejar que los eventos ahora tendrán un campo `id` (clave primaria).

```typescript title="src/app/interfaces/evento.ts"
export interface Evento {
  id?: string;
  title: string;
  image: string;
  date: string;
  description: string;
  price: number;
}
```

Las propiedades con `?` detrás implican que son opcionales (se accede a ellas sin el interrogante). Ya que, por ejemplo, cuando creamos un objeto `Evento` para añadir desde el formulario, este aún no tendrá `id` asignada. Por eso nos interesa que al crear un objeto de tipo `Evento`, _TypeScript_ no nos obligue a establecer el campo `id`.

## Crear el servicio local con `json-server`

Para simular el servicio web, vamos a utilizar `json-server`. Este es un paquete de `node.js` que nos permite crear un servidor web que sirve datos en formato `JSON` a partir de un archivo `JSON` que le pasemos.

Para instalarlo, crea una nueva carpeta en el directorio raíz del proyecto llamada `server/` y dentro de ella ejecuta:

```bash
npm init -y
npm install -g json-server
```

Crea un archivo `db.json` con el siguiente contenido:

```json title="server/db.json"
{
  "eventos": [
    {
      "id": "1",
      "title": "Evento 1",
      "image": "https://picsum.photos/200/300",
      "date": "2024-02-10",
      "description": "Descripción del primer evento",
      "price": 20.0
    },
    {
      "id": "2",
      "title": "Evento 2",
      "image": "https://picsum.photos/200/300",
      "date": "2024-05-20",
      "description": "Descripción del segundo evento",
      "price": 40.0
    }
  ]
}
```

Para arrancar el servidor, ejecuta:

```bash
npx json-server --watch db.json
```

Si todo ha ido bien, deberías poder acceder a la URL `http://localhost:3000/eventos` y ver los eventos que hemos creado en el archivo `db.json`.

!!!note "Otras opciones de configuración"
    Se puede cambiar el puerto por defecto (`3000`) con el parámetro `--port`, o también, simular un retardo en las respuestas con `--delay`.

    ```bash
    npx json-server --watch db.json --port 3001 --delay 500
    ```

## Obtener eventos

Los eventos se obtienen llamando al servicio `/eventos` por `GET`. Este servicio te devuelve un objeto JSON con un `Array` de eventos.

El método getEventos del servicio, ya no devolverá directamente `Evento[]`, sino un `Observable<Evento[]>`:

```typescript title="src/app/services/eventos.service.ts"
getEventos(): Observable<Evento[]> {
  ...
}
```

En el método `ngOnInit` del componente `eventos-show`, suscríbete al servicio para obtener el array de eventos. Inicializa la colección de eventos previamente a un array vacío para que no dé problemas la directiva `@for`.

## Añadir evento

Añadimos un evento llamado al servicio `/eventos` usando `POST`. Como datos enviamos el objeto `Evento` con los datos del evento (el objeto que generamos con el formulario). Este servicio nos devolverá un JSON con el evento añadido y el `id` que le ha asignado.

Crea el método `addEvento` en el servicio `EventosService`:

```typescript title="src/app/services/eventos.service.ts"
addEvento(evento: Evento): Observable<Evento> {
  ...
}
```

El método de añadir evento del componente `evento-add`, debe llamar a este método del servicio y suscribirse. Y cuando este nos devuelva el evento insertado, es cuando debemos usar el `EventEmitter` para informar a `eventos-show` (el componente padre) que debe de añadirlo y reiniciar el objeto del formulario (**importante**: debemos emitir el evento que nos devuelve el servidor y no el del formulario, ya que entre otras cosas, tendrá un `id` válido).

## Borrar evento

Para borrar un evento llamaremos al servicio `/eventos/:idEvento` usando el método `DELETE` (ej: `/eventos/jk3r`).

El método a crear en el servicio `EventosService` devolverá el observable con la respuesta, es decir, la llamada al servidor sin procesar nada.

```typescript title="src/app/services/eventos.service.ts"
deleteEvento(id: string): Observable<any> {
  ...
}
```

El método de borrar evento en `evento-item`, llamará a este servicio y se suscribirá. Al recibir la respuesta emitirá mediante el `EventEmitter` correspondiente al componente padre, `eventos-show` para indicar que lo borre del array de eventos.

**Importante**: A la hora de llamar al método del servicio, _TypeScript_ te marcará como error la `id` del producto, ya que esta es opcional en la interfaz `Evento`, por lo que podría ser `undefined` en lugar de `string` (los proyectos _Angular_ se crean con _TypeScript_ en modo estricto). Para indicar a _TypeScript_ que ignore esta posibilidad (siempre tendrá valor), ponemos el símbolo `!` detrás `this.producto.id!`.

## Interceptor

Se creará un interceptor llamado `base-url` que, al igual que en lo apuntes (ejemplo de productos), se encargue de concatenar la _url base_ del servidor a todas las llamadas HTTP que realicemos. Por ejemplo `http://localhost:3000`

Se recomienda (al igual que en el ejemplo) guardar el valor de dicha url dentro de los archivos de la carpeta `environments/`. Tanto en el desarrollo (`environment.ts`) como en el de producción (`environment.prod.ts`). El valor se guarda dentro del objeto `environment` como una propiedad adicional.
