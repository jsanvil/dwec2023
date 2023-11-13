# Entorno de trabajo

## Visual Studio Code

Descargamos el paquete **.deb** de la página de [Visual Studio Code](https://code.visualstudio.com/Download) y lo instalamos.

## npm

Es el gestor de paquetes de **Node.js**. Si no lo tenemos instalaremos node.js tal y como se indica en la página de [nodejs.org](https://nodejs.org/es/download/package-manager/).

### Instalación en el perfil local de usuario del aula

Las aulas de informática no tienen npm instalado de manera global, necesitaremos instalarlo en el perfil local del usuario, para ello utilizaremos nvm que es un gestor de versiones de node que nos permitirá utilizar la versión que escojamos [nvm-sh](https://github.com/nvm-sh/nvm#installation-and-update)

Para instalar nvm necesitamos ejecutar el siguiente comando, aunque es recomendable consultar la documentación de nvm para comprobar que no haya cambiado:

```bash
$ curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash
```

Cuando termine la instalación de nvm, para que tome la ruta del nuevo ejecutable, **abriremos un nuevo terminal** y procederemos a **instalar la versión 16 de _Node.js_** de la siguiente forma:

```bash
$ nvm install 16
```

