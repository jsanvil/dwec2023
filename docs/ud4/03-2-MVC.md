# UD2 - 2. El patrón Modelo-Vista-Controlador (MVC)

- [Introducción](#introducción)
- [Una aplicación sin MVC](#una-aplicación-sin-mvc)
- [Patrón MVC](#patrón-mvc)

## Introducción

**Modelo-vista-controlador (MVC)** es el patrón de arquitectura de software más utilizado en la actualidad en desarrollo web (y también en muchas aplicaciones de escritorio). Este patrón propone separar la aplicación en tres **componentes** distintos: el **modelo**, la **vista** y el **controlador**:

``` mermaid
flowchart LR
    U((<font color=black> Usuario)) --> |Solicita| C[<font color=black> Controlador]
    style U fill:#fea,stroke:#888
    style C fill:#cfa,stroke:#888
    C --> |Actualiza| V
    V(<font color=black> Vista) --> |Muestra| U
    style V fill:#fdd,stroke:#888
    C --> |Solicita| M[(<font color=black> Modelo)]
    style M fill:#ddf,stroke:#888
    M --> |Envía| C
```

- El **modelo** es el conjunto de todos los datos o información con la que trabaja la aplicación. Normalmente serán variables extraídas de una **base de datos** y el modelo gestiona los **accesos** a dicha información, tanto **consultas** como actualizaciones, implementando también los **privilegios** de acceso que se hayan descrito en las especificaciones de la aplicación (lógica de negocio). Normalmente el modelo no tiene conocimiento de las otras partes de la aplicación.
- La **vista** muestra al usuario el modelo (información y lógica de negocio) en un formato adecuado para interactuar, usualmente la **interfaz de usuario**. Es la intermediaria entre la aplicación y el usuario.
- El **controlador** es el encargado de coordinar el funcionamiento de la aplicación. Responde a los eventos del usuario para lo que hace peticiones al modelo (para obtener o cambiar la información) y a la vista (para que muestre al usuario dicha información).

Este patrón de arquitectura de software se basa en las ideas de reutilización de código y la separación de conceptos, características que buscan facilitar la tarea de desarrollo de aplicaciones y su posterior mantenimiento.

## Una aplicación sin MVC

Si una aplicación no utiliza este modelo cuando una función modifica los datos debe además reflejar dicha modificación en la página para que la vea el usuario.

_Por ejemplo_, vamos a considerar una aplicación para gestionar un almacén. Entre otras muchas cosas tendrá una función _`addProduct`_ que se encargue de añadir un nuevo producto al almacén y dicha función deberá realizar:

- _**añadir el nuevo producto al almacén**_ (por ejemplo añadiéndolo a un array de productos)
- _**mostrar en la página ese nuevo producto**_ (por ejemplo añadiendo una nueva línea a una tabla donde se muestran los productos)

Es posible que en algún momento decidamos cambiar la forma en que se muestra la información al usuario para lo que deberemos modificar la función _`addProduct`_ y si cometemos algún error podría hacer que no se añadan correctamente los productos al almacén. Además va a ser una función muy grande y va a ser difícil mantener ese código.

## Patrón MVC

En una aplicación muy sencilla podemos no seguir este modelo pero en cuanto la misma se complica un poco es imprescindible programar siguiendo buenas prácticas ya que si no lo hacemos nuestro código se volverá rápidamente muy difícil de mantener.

Hay muchas formas de implementar este modelo. Si estamos haciendo un proyecto con POO podemos seguir el patrón MVC usando clases. Crearemos dentro de la carpeta _`src\`_ 3 subcarpetas:

- _`model\`_: aquí incluiremos las clases que constituyen el modelo de nuestra aplicación
- _`view\`_: aquí crearemos un fichero JS que será el encargado de la UI de nuestra aplicación
- _`controller\`_: aquí crearemos el fichero JS que contendrá el controlador de la aplicación

De este forma, si queremos cambiar la forma en que se muestra algo no hace falta tocar nada del modelo sino que vamos directamente a la vista y modificamos la función que se ocupa de ello.

La vista será una clase sin propiedades (no tendrá un constructor), sólo contendrá métodos para renderizar los distintos elementos de la vista.

El controlador será una clase cuyas propedades serán el modelo y la vista, de forma que pueda acceder a ambos elementos. Tendrá métodos para las distintas acciones que pueda hacer el usuario (que se ejecutarán como respuesta a las acciones del usuario sobre nuestra página, lo veremos cuando estudiemos los _eventos_). Cada uno de esos métodos llamará a métodos del modelo (para obtener o cambiar la información necesaria) y posteriormente de la vista (para reflejar esos cambios en lo que ve el usuario).

El fichero principal de la aplicación instanciará un controlador y lo inicializará.

Por ejemplo, siguiendo con la aplicación para gestionar un almacén. El modelo constará de la clase _`Store`_ que es nuestro almacén de productos (con métodos para añadir o eliminar productos, etc) y la clase _`Product`_ que gestiona cada producto del almacén (con métodos para crear un nuevo producto, cambiar sus características, etc).

El fichero principal sería algo como:

```js title="main.js" linenums="1"
const storeApp = new StoreController();		// crea el controlador
storeApp.init();				// lo inicializa, si es necesario

// Podemos añadir algunas líneas que luego quitaremos para imitar acciones del usuario 
// y así ver el funcionamiento de la aplicación:
storeApp.addProductToStore({ name: 'Portátil Acer Travelmate E2100', price: 523.12 });
storeApp.changeProduct({ id: 1, price: 515.95 });
storeApp.deleteProduct(1);
```

```js linenums="1" title="controller/index.js"
class StoreController {
    constructor() {
        this.productStore = new Store(1);		// crea el modelo, un Store con id 1
        this.storeView = new StoreView();		// crea la vista
    }

    init() {
        this.storeView.init();			// inicializa la vista, si es necesario
    }
	
    addProductToStore(prod) {
        // haría las comprobaciones necesarias sobre los datos y luego
        const newProd = this.productStore.addProduct(prod);	// dice al modelo que añada el producto
        if (newProd) {
            this.storeView.renderNewProduct(newProd);		// si lo ha hecho le dice a la vista que lo pinte
        } else {
            this.storeView.showErrorMessage('error', 'Error al añadir el producto');
        }
    }
    ...
    // También se incluirían los métodos escuchadores para las acciones del usuario sobre la página
}
```

```js linenums="1" title="view/index.js"
class StoreView{
    init() {
        ...			// inicializa la vista, si es necesario
    }

    renderNewProduct(prod) {
        // código para añadir a la tabla el producto pasado añadiendo una nueva fila
    }
    ...
  
    showMessage(type, message) {
        // código para mostrar mensajes al usuario y no tener que usar los alert
    }
}
```

```js linenums="1" title="model/store.class.js"
class Store {
    constructor (id) {
        this.id=Number(id);
        this.products=[];
    }

    addProduct(prod) {
        // comprueba que los datos sean correctos y llama a la clase Product para que cree un nuevo producto
        ...
        let newProd = new Product(id, name, price, units);
        this.products.push(newProd);
        return newProd;
    }
  
    findProduct(id) {
        ...
    }
    ...
}
```

```js linenums="1" title="model/product.class.js"
class Product {
    constructor (id, name, price, units) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.units = units;
    }
    ...
}
```

Podéis obtener más información y ver un ejemplo más completo en: [https://www.natapuntes.es/patron-mvc-en-vanilla-javascript/](https://www.natapuntes.es/patron-mvc-en-vanilla-javascript/)