# UD6 - 7. Internacionalización

## Introducción

La _**internacionalización**_, a veces denominada _i18n_, es el proceso de diseñar y preparar un proyecto para su uso en diferentes lugares del mundo. La _**localización**_ es el proceso de crear versiones del proyecto para diferentes configuraciones regionales. El proceso de localización incluye las siguientes acciones.

- Extraer texto para traducir a diferentes idiomas.
- Formatear datos para una ubicación específica.

Un _**locale**_ identifica una región en la que la gente habla un idioma o variante lingüística particular. Las regiones posibles incluyen países y regiones geográficas. Una configuración regional determina el formato y el análisis de los siguientes detalles.

- Unidades de medida que incluyen fecha y hora, números y monedas.
- Nombres traducidos, incluidas zonas horarias, idiomas y países.

[Introduction to Internationalization in Angular](https://youtu.be/KNTN-nsbV7M)

## Añadir el paquete de localización

En el directorio del proyecto, ejecutamos el siguiente comando para añadir el paquete de localización.

```bash
ng add @angular/localize
```

Esto añade el paquete de localización en el archivo `package.json` y modifica el archivo `angular.json` para incluir la localización en el proceso de construcción.

## Identificadores de configuración regional

_Angular_ utiliza el identificador de configuración regional _Unicode_ para encontrar los datos de configuración regional para la internacionalización de cadenas de texto.

El identificador de configuración regional _Unicode_ es una cadena que consta de dos partes.

- Un código de idioma de dos letras, que es el código de idioma [_ISO 639_](https://es.wikipedia.org/wiki/ISO_639-1)[_Listado oficial_](https://www.loc.gov/standards/iso639-2/php/code_list.php)
- Un código de país de dos letras, que es el código de país [_ISO 3166-2_](https://en.wikipedia.org/wiki/ISO_3166-2).

```text
{language_id}-{locale_extension}
```

Ejemplos de identificadores de configuración regional _Unicode_:

- `es-ES` para español de España.
- `ca-ES` para catalán/valenciano de España.
- `eu-ES` para euskera de España.
- `en-US` para inglés de Estados Unidos.
- `en-GB` para inglés de Reino Unido.
- `pt-PT` para portugués de Portugal.
- `fr-FR` para francés de Francia.
- `it-IT` para italiano de Italia.
- `de-DE` para alemán de Alemania.


## Establecer el idioma predeterminado

En el archivo `angular.json` se añade la configuración de localización. Por ejemplo, para establecer el idioma predeterminado en español de España (`es-ES`), además se añade soporte para inglés de Estados Unidos (`en-US`)


```yaml hl_lines="8-13 19-21"
{
  "$schema": "./node_modules/@angular/cli/lib/config/schema.json",
  "version": 1,
  "newProjectRoot": "projects",
  "projects": {
    "angular-products": {
      "projectType": "application",
      "i18n": {
        "sourceLocale": "es-ES",
        "locales": {
          "en-US": "src/locale/messages.en.xlf"
        }
      },
...
      "architect": {
        "build": {
          "builder": "@angular-devkit/build-angular:application",
          "options": {
            "localize": [
              "en-US"
            ],
...
```

En la sección `i18n` se añade la configuración de localización. El idioma predeterminado es `es-ES` y se añade soporte para el idioma `en-US`. El archivo `src/locale/messages.en.xlf` es el archivo de localización para el idioma `en-US`. Este archivo se generará más adelante mediante un comando de _Angular_.

En la sección `architect`, para que funcione en modo desarrollo, se añade un único idioma predeterminado, `en-US`.

## Marcadores de localización

Los marcadores de localización son directivas que se añaden a las plantillas de los componentes para marcar las cadenas de texto que se deben traducir. Los marcadores de localización se añaden a las plantillas mediante el atributo `i18n`.

```html
<h1 i18n="{i18n_metadata}">{string_to_translate}</h1>
```

Ejemplos:

```html
<span i18n>hola</span>
<span i18n="goodbye">adiós</span>
<span i18n="good wish|shown at login">Qué tengas un buen día</span>
```

En los ejemplos anteriores, se añaden marcadores de localización a las cadenas de texto `hola`, `adiós` y `Qué tengas un buen día`.

Se pueden añadir metadatos a los marcadores de localización para identificar el contexto de la cadena de texto. En el ejemplo anterior, se añade el metadato `good wish|shown at login` para identificar el significado y el contexto.

También se pueden añadir marcadores de localización a los **atributos** de los elementos HTML.

```html
<input i18n-placeholder placeholder="Introduce tu nombre" type="text">
<img [src]="profileImage" i18n-title title="Imagen de perfil" alt="Imagen de perfil"/>
```

### Textos en código fuente

Los marcadores de localización también se pueden añadir a los textos en el código fuente de los componentes. Para ello, se utiliza la función `$localize`, se deben utilizar template strings para añadir los marcadores de localización.

```typescript
table_title = $localize`Listado de productos`;
table_headings = {
  image: $localize`Imagen`,
  description: $localize`Descripción`,
  price: $localize`Precio`,
  available: $localize`Disponible`,
  rating: $localize`Valoración`
}
total_products = $localize`Total: ${products.length}:products_length`;
```

### Generar archivos de localización

Para generar los archivos de localización, se utiliza el comando `ng extract-i18n`.

```bash
ng extract-i18n --output-path src/locale
```

Ahora, se puede copiar el archivo `messages.xlf` a `messages.en.xlf` y traducir las cadenas de texto al inglés, utilizando la etiqueta `<target>`.

```xlf hl_lines="7" title="src/locale/messages.en.xlf"
<?xml version="1.0" encoding="UTF-8" ?>
<xliff version="1.2" xmlns="urn:oasis:names:tc:xliff:document:1.2">
  <file source-language="es-ES" datatype="plaintext" original="ng2.template">
    <body>
      <trans-unit id="1878944583384618422" datatype="html">
        <source>Cargando...</source>
        <target>Loading...</target>
      </trans-unit>
      ...
```

Una vez extraídas las cadenas de texto y traducidas, se puede compilar el proyecto para que se generen los archivos de localización.

```bash
ng build --localize
```

Si no se han terminado de marcar los textos en el código fuente, deberemos volver a generar los archivos de localización, pero se perderán las traducciones que ya se hayan realizado. Para evitar esto, se puede utilizar el paquete `ng-extract-i18n-merge` que permite añadir las nuevas cadenas de texto a los archivos de localización existentes.

```bash
ng add ng-extract-i18n-merge
ℹ Using package manager: npm
✔ Found compatible package version: ng-extract-i18n-merge@2.9.1.
✔ Package information loaded.

The package ng-extract-i18n-merge@2.9.1 will be installed and executed.
Would you like to proceed? Yes
```

Una vez instalado, se puede añadir las nuevas cadenas de texto a los archivos de localización existentes.

```bash
ng extract-i18n
```

## Distribución

Angular genera un directorio para cada idioma que se ha añadido en la configuración de localización. Ejemplo para los idiomas `es-ES` y `en-US`:

```text
dist/angular-products/browser/
  es-ES/
    ...
  en-US/
    ...
```

Se generan dos proyectos independientes, uno para cada idioma. Cada proyecto contiene los archivos de localización y los archivos de configuración regional para el idioma correspondiente. En la configuración del servidor, se puede añadir un _middleware_ para detectar el idioma del navegador del usuario y redirigir a la versión correspondiente. Esto queda fuera del alcance de este módulo.

Para probarlo en local, podemos utilizar el paquete `http-server` que se instala de forma global.

```bash
npm install -g http-server

cd dist/angular-products/browser

http-server
```

Podremos acceder a la versión en español y en inglés mediante las siguientes URLs.

- [http://127.0.0.1:8080/es-ES/](http://127.0.0.1:8080/es-ES/)
- [http://127.0.0.1:8080/en-US/](http://127.0.0.1:8080/en-US/)
