# UD 6 - Actividad 6

## Página de inicio

Crea un componente `HomeComponent` que será la página de inicio de la aplicación, que dará la bienvenida a la aplicación y será la ruta inicial `/home`.

- La ruta por defecto será este componente.
- Añade un enlace en el menú superior ("Inicio") que lleve a esta página.
- Incluye el HTML que quieras para dar la bienvenida, con al menos tu nombre, ciclo y curso.

## Menú de navegación

Crea un componente `NavbarComponent` que será el menú de navegación de la aplicación. Mueve el código HTML del menú de navegación de `app.component.html` a este componente, e incluye el nuevo componente en `app.component.html`.

## Login

Se va a crear un servicio de login de prueba, que permitirá entrar a la aplicación. Para simular el login, se guardará el nombre de usuario en el `localStorage`, y se comprobará si existe para saber si estamos logueados.

- Crea un componente `LoginComponent` que será la página de login de la aplicación, que tendrá un formulario con dos campos: `usuario` y `contraseña`.
- Crear un servicio `AuthService` que tenga los siguientes un métodos:
    - `login(usuario, password)` que devuelva un booleano. Si el usuario es `admin` y la contraseña es `admin` devuelve `true`, en caso contrario devuelve `false`. Utiliza `localStorage.setItem` para guardar el nombre de usuario logueado.
    - `logout()` que borre el nombre de usuario logueado. Utiliza `localStorage.removeItem`.
    - `getLoggedUser()` que devuelva el nombre de usuario logueado. Utiliza `localStorage.getItem`.
- Integra el componente `LoginComponent` en la página de inicio. Sólo se mostrará si no estamos logueados.
- Crea un _guard_ `AuthGuard` de tipo `CanActivate` que compruebe si el usuario está logueado. Si no lo está, redirige a la página de inicio. Utiliza el servicio `AuthService` para comprobar si el usuario está logueado.
- Añade el _guard_ a las rutas de la aplicación que requieran estar logueado para acceder a ellas. En este caso, la página de añadir evento.
- Añade un enlace en el menú de navegación ("Login") que lleve a la página de login. Sólo se mostrará si no estamos logueados.
- Añade un enlace en el menú de navegación ("Logout") que nos desloguee. Sólo se mostrará si estamos logueados. Redirigirá a la página de inicio.
- El enlace en el menú superior ("Añadir evento") sólo se mostrará si estamos logueados.
