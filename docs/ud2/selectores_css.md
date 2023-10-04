# Uso básico de selectores CSS

## Introducción

Los selectores CSS se utilizan para seleccionar elementos de un documento `html`. Podemos dividirlos en las siguientes categorías:

- Selectores básicos (seleccionan elementos según su nombre, id, clase)
- Selectores de combinación (seleccionan elementos según una relación específica entre ellos)
- Selectores de pseudo-clases (seleccionan elementos según un estado determinado)
- Selectores de pseudo-elementos (seleccionan y estilizan una parte de un elemento)
- Selectores de atributos (seleccionan elementos según un atributo o valor de atributo)

## Selectores básicos

Son los más utilizados y seleccionan elementos según su nombre, id, clase, etc.

| Selector | Ejemplo | Descripción del ejemplo |
|---|:---:|---|
| elemento | _`p`_ | Selecciona todos los elementos `<p>` |
| #id | _`#nombre`_ | Selecciona el elemento con `id="nombre"` |
| .clase | _`.intro`_ | Selecciona todos los elementos con `class="intro"` |
| elemento.clase | _`p.intro`_ | Selecciona solo los elementos `<p>` con `class="intro"` |
| elemento, elemento, .. | _`div, p`_ | Selecciona todos los elementos `<div>` y todos los elementos `<p>` |
| * | _`*`_ | Selecciona todos los elementos |

<div class="container border border-dark rounded p-3">
  <h3>Nota</h3>
  <p>Los selectores CSS son sensibles a mayúsculas y minúsculas.</p>
  <ul>
    <li><code></code> selecciona elementos nombre <code>nombre</code></li>
    <li><code></code> selecciona elementos con #id <code>id="identificador"</code></li>
    <li><code></code> selecciona elementos con .class <code>class="nombre-clase"</code></li>
    <li><code></code> selecciona elementos que tienen una clase <code>elemento class="nombre"</code></li>
  </ul>
</div>

## Selectores de combinación

Seleccionan un elemento dependiendo de otros elementos que le preceden.

| Selector | Ejemplo | Descripción del ejemplo |
|---|:---:|---|
| elemento elemento | _`div p`_ | `<p>` dentro de un elemento `<div>` |
| elemento>elemento | _`div > p`_ | `<p>` donde el padre es un elemento `<div>` |
| elemento+elemento | _`div + p`_ | `<p>` que están colocados inmediatamente después de un elemento `<div>` |
| elemento1~elemento2 | _`p ~ ul`_ | `<ul>` que están precedidos por un elemento `<p>` |

## Selectores de pseudo-clases

Dependen de un estado especial del elemento, como un enlace visitado o un elemento que tiene el cursor encima.

| Selector | Ejemplo | Descripción del ejemplo |
|---|:---:|---|
| elemento:active | _`a:active`_ | `<a>` activo |
| elemento:hover | _`a:hover`_ | `<a>` cuando el usuario mueve el ratón sobre él |
| elemento:focus | _`input:focus`_ | `<input>` cuando está enfocado |
| elemento:lang(language) | _`p:lang(it)`_ | Selecciona todos los elementos `<p>` con un atributo de idioma establecido en "it" (italiano) |
| :root | _`:root`_ | Selecciona el elemento raíz del documento (normalmente `<html>`) |
| elemento:target | _`#news:target`_ | Selecciona el elemento `<div id="news">` si es el destino actual del enlace "news" |
| elemento:empty | _`p:empty`_ | Selecciona todos los elementos `<p>` que no tienen hijos (incluidos los textos) |
| elemento:nth-child(n) | _`p:nth-child(2)`_ | Selecciona todos los elementos `<p>` que son el segundo hijo de su padre |
| elemento:nth-last-child(n) | _`p:nth-last-child(2)`_ | Selecciona todos los elementos `<p>` que son el segundo hijo de su padre, contando desde el final |
| elemento:nth-of-type(n) | _`p:nth-of-type(2)`_ | Selecciona todos los elementos `<p>` que son el segundo elemento de su padre |
| elemento:nth-last-of-type(n) | _`p:nth-last-of-type(2)`_ | Selecciona todos los elementos `<p>` que son el segundo elemento de su padre, contando desde el final |
| elemento:first-child | _`p:first-child`_ | Selecciona todos los elementos `<p>` que son el primer hijo de su padre |
| elemento:last-child | _`p:last-child`_ | Selecciona todos los elementos `<p>` que son el último hijo de su padre |
| elemento:first-of-type | _`p:first-of-type`_ | Selecciona todos los elementos `<p>` que son el primer elemento de su padre |
| elemento:last-of-type | _`p:last-of-type`_ | Selecciona todos los elementos `<p>` que son el último elemento de su padre |
| elemento:only-child | _`p:only-child`_ | Selecciona todos los elementos `<p>` que son el único hijo de su padre |
| elemento:only-of-type | _`p:only-of-type`_ | Selecciona todos los elementos `<p>` que son el único elemento de su padre |
| elemento:checked | _`input:checked`_ | Selecciona todos los elementos `<input>` que están marcados |
| elemento::selection | _`::selection`_ | Selecciona el elemento que el usuario ha seleccionado |

## Selectores de pseudo-elementos

Seleccionan una parte de un elemento.

| Selector | Ejemplo | Descripción del ejemplo |
|---|:---:|---|
| elemento::first-line | _`p::first-line`_ | Selecciona la primera línea de cada elemento `<p>` |
| elemento::first-letter | _`p::first-letter`_ | Selecciona la primera letra de cada elemento `<p>` |
| elemento::before | _`p::before`_ | Inserta algo antes del contenido de cada elemento `<p>` |
| elemento::after | _`p::after`_ | Inserta algo después del contenido de cada elemento `<p>` |

## Selectores de atributos

| Selector | Ejemplo | Descripción del ejemplo |
|---|:--------:|--|
| [atributo] | _`[src]`_ | Elementos con un atributo de nombre "`src`" |
| [atributo="valor"] | _`[target="_blank"]`_ | Elementos con un atributo de nombre "`target`" y cuyo valor es "`_blank`" |
| [atributo~="valor"] | _`[title~="flower"]`_ | Elementos con un atributo de nombre "`title`" y cuyo valor **contiene** la palabra "`flower`" |
| [atributo^="valor"] | _`a[href^="https"]`_ | Elementos con un atributo de nombre "`href`" y cuyo valor **comienza** con "`https`" |
| [atributo$="valor"] | _`a[href$=".pdf"]`_ | Elementos con un atributo de nombre "`href`" y cuyo valor **termina** con "`.pdf`" |
| [atributo*="valor"] | _`a[href*="w3schools"]`_ | Elementos con un atributo de nombre "`href`" y cuyo valor **contiene la subcadena** "`w3schools`" |
