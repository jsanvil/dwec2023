// almacena los datos del fichero comida.json
let comida = []

// obtiene los datos del fichero comida.json
fetch('comida.json')
    .then(response => response.json())
    .then(data => {
        comida = data
        init()
    })
    .catch(error => console.error(error))

const divResultado = document.getElementById('resultado')

const categoryDropdown = document.getElementById('category')

const precioMedio = document.getElementById('avgPrice')

function init() {
    // Muestra todos los elementos del array "comida"
    printArray(comida)

    // Rellena el desplegable con las categorías
    getCategories().forEach(category => {
        const option = document.createElement('option')
        option.value = category
        option.text = category
        categoryDropdown.appendChild(option)
    })
}

// Devuelve un string con los datos del objeto
// útil si se necesita depurar datos por consola
const getString = (item) => {
    return `id: ${item.id}
    categoría: ${item.categoria}
    nombre:    ${item.nombre}
    precio:    ${item.precio} €/kg
    emoji:     ${item.emoji}`
}

// Crea un elemento div con la clase "card" y los datos del objeto
function createCard(item) {
    const card = document.createElement('div')
    card.classList.add('card')
    card.classList.add(item.categoria)

    const emoji = document.createElement('div')
    emoji.textContent = item.emoji
    emoji.classList.add('emoji')
    card.appendChild(emoji)

    const title = document.createElement('p')
    title.textContent = item.nombre
    title.classList.add('title')
    card.appendChild(title)

    const price = document.createElement('p')
    price.textContent = `${item.precio} €/kg`
    card.appendChild(price)

    return card
}

// Recorre un array de objetos y los imprime en el html
function printArray(array) {
    cleanResults()
    array.forEach(item => {
        divResultado.appendChild(createCard(item))
    })
    avgPrice(array)
}

function cleanResults() {
    while (divResultado.firstChild) {
        divResultado.removeChild(divResultado.firstChild)
    }
}

// Ejemplo de función que se ejecuta al pulsar un botón
function btnShowAll() {
    printArray(comida)
}

/*************************************
 * 
 * Completa las siguientes funciones
 *
 *************************************/

// Muestra el array "comida" ordenado por nombre
function btnSortByName() {
    let comidaOrdenada = []

    // COMPLETA ESTA FUNCIÓN
    alert('Esta función no está implementada')

    printArray(comidaOrdenada)
}

// Muestra el array "comida" ordenado por precio de forma ascendente
function btnSortByPriceDescending() {
    let comidaOrdenada = []

    // COMPLETA ESTA FUNCIÓN
    alert('Esta función no está implementada')

    printArray(comidaOrdenada)
}

//  Muestra todos los elementos ordenados por categoría
function btnSortByCategory() {
    let comidaOrdenada = []

    // COMPLETA ESTA FUNCIÓN
    alert('Esta función no está implementada')

    printArray(comidaOrdenada)
}

// Muestra los elementos con precio menor a 5
function btnFilterCheaperThan5() {
    let comidaFiltrada = []

    // COMPLETA ESTA FUNCIÓN
    alert('Esta función no está implementada')

    printArray(comidaFiltrada)
}

// Muestra el precio medio de los elementos recibidos en el array
function avgPrice(array) {
    let price = 0

    // COMPLETA ESTA FUNCIÓN

    precioMedio.textContent = `${price.toFixed(2)} €/kg`
}

// Devuelve un array con las categorías de los elementos del array "comida"
function getCategories() {
    // Utiliza map para extraer un array de categorías.
    //
    // Ten en cuenta que no puede haber categorías repetidas.
    // Utiliza el método Set y Array.from para eliminar duplicados.
    //
    // El resultado debe ser un array de strings del tipo
    // ["fruta", "verdura", "pescado", "carne"] 
    
    const categorias = []

    // COMPLETA ESTA FUNCIÓN

    return categorias;
}

// Muestra solo los elementos de la categoría seleccionada en el desplegable
function changeCategory() {
    // categoriaSeleccionada es un string con el valor del desplegable
    const categoriaSeleccionada = document.getElementById('category').value

    const comidaFiltrada = []

    // COMPLETA ESTA FUNCIÓN
    alert('Esta función no está implementada')

    printArray(comidaFiltrada)
}
