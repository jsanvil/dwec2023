# Proyecto 2 - To Do List

El objetivo de este proyecto es crear una aplicación en _JavaScript_ que permita gestionar una lista de tareas.

- Tendrá un peso del **40%** sobre la calificación de la primera evaluación.
- Fecha límite de entrega **26/11/2023** a las **23:59**.
- _GitHub Classroom_: [https://classroom.github.com/a/5lS5NodN](https://classroom.github.com/a/5lS5NodN)

## Requisitos

- **Estructura del proyecto**.
    - El proyecto debe estar bien estructurado en archivos HTML, CSS y JS.
    - Separar el código en módulos bien definidos mediante **import** y **export**.
    - Utilizar el empaquetador **Vite**
- **Código estructurado**. Las clases y funciones están bien comentadas. Los nombres de las clases, funciones y variables son descriptivos.
- **Utilizar clases** para representar las tareas y la lista de tareas.
- Las **tareas** tendrán los siguientes **atributos**:
    - **`Nombre`**. **Obligatorio**. Máximo 50 caracteres. 
    - **`Descripción`**. Máximo 200 caracteres.
    - **`Prioridad`**. `alta`, `media` o `baja`.
    - **`Estado`**. `completada` o `pendiente`. Por defecto, `pendiente`.
    - **`Fecha límite`**. **Obligatorio**. No puede ser anterior a la fecha actual.
    - **`Fecha y hora de creación`**. Calculada automáticamente. No modificable por el usuario.
- **Funcionalidades**:
    - **Mostrar lista** de tareas.
        - La prioridad se debe representar con **colores** y/o **iconos**.
        - Los cambios en las tareas deben **actualizar** la lista automáticamente.
    - **Añadir** nueva tarea. Se debe validar el formulario y mostrar todos los errores antes de añadir la tarea.
    - **Editar** tarea.
        - Tendrá una opción para **cancelar** la edición.
        - Si hay cambios y se cancela la edición, se debe pedir confirmación al usuario.
        - Se debe validar el formulario y mostrar todos los errores antes de guardar los cambios.
    - **Marcar** tarea completada o pendiente. Se deben actualizar los estilos de la lista al marcar una tarea.
    - **Eliminar** tarea. Debe pedir confirmación al usuario. Se debe actualizar la lista al eliminar una tarea.
    - **Búsqueda**. Campo de texto.
        - Se filtra el listado según se escribe.
        - Si el texto está contenido en nombre o descripción.
    - **Filtrar** y **ordenar** tareas, en orden ascendiente y descendiente, por los siguientes atributos:
        - Estado.
        - Nombre.
        - Fecha de creación.
        - Prioridad.
    - **Botón** para **limpiar** filtros.
    - **Leer y escribir** la lista de tareas en el **almacenamiento local** del navegador.
- **Documentación**. Incluir fichero **`README.md`** en la raíz del proyecto con la siguiente información:
    - Nombre del proyecto.
    - Nombre y apellidos.
    - Detalles de implementación.
- **Repositorio** de _GitHub Classroom_.
    - El repositorio debe reflejar el trabajo diario.
    - Se deben hacer al menos 10 commits.
    - Los commits deben se concisos e informativos.
