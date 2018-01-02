[![Build Status](https://travis-ci.org/mujeresentecnologia/portal.svg?branch=master)](https://travis-ci.org/mujeresentecnologia/portal)

Mujeres en Tecnología
===================

Este proyecto es una plataforma web que tiene por finalidad, servir como punto de encuentro a todas esas personas, en especial mujeres, que sientan un interés hacia eventos e iniciativas referidas a tecnología.

¿Cómo instalar las herramientas necesarias para la aplicación?
-------------
Siga las instrucciones que se encuentran en [INSTALL.md](https://github.com/mujeresentecnologia/portal/blob/master/INSTALL.md) 

¿Cómo levantar la aplicación?
-------------
Primero, clona el repositorio a tu computador:
```
git clone <PATH_TO_REPO>
```

Luego, entra a la carpeta generada del repositorio
```
cd REPOSITORY_FOLDER
```

Dentro de la carpeta, ejecuta el siguiente comando:
```
bundle install
```

Por último, sólo ejecuta:
```
jekyll serve
```

Ahora accede a la dirección de **localhost** para ver la página :)

Enjoy!

Ambientes y Repositorios
-------------

![alt tag](https://user-images.githubusercontent.com/29631412/34490223-f60f23fe-efbd-11e7-8d69-82abb8517497.jpg "Ambientes y Repositorios")

La figura muestra los repositorios (Repository) que se han creado para los ambientes de la plataforma Mujeres en Tecnología. Dichos repositorios pertenecen a la organización "Portal Mujeres en Tecnología Chile". 

El ambiente de desarrollo es gestionado en el repositorio "portal" que contiene dos branches: develop y master. Ambos branches se encuentran integrados a Travis CI. Al realizar un "push" hacia "origin/develop", Travis CI ejecuta el script "build_and_deploy.sh" el cual hace un "build" via jekyll del proyecto, generando la carpeta "_site" que contiene el código HTML estático del portal Mujeres en Tecnología, luego hace commit y push de este sitio en el branch "gh_pages" en el repositorio "staging-env". 

El ambiente de staging (staging-env) permite al equipo tener una vista previa del sitio web de Mujeres en Tecnología, recibir feedback oportuno y realizar pruebas funcionales. El nombre "gh_pages" del branch es intencional, pues es requisito para publicar el sitio web en Github Pages, en este caso, dado que el repositorio es "staging-env", el sitio a publicar quedará en la URL https://mujeresentecnologia.github.io/staging-env/

El ambiente productivo (home) sigue la misma arquitectura que el ambiente de staging, pero su contenido es actualizado a través de Travis CI al realizar un "pull request" en origin/master del repositorio "portal". Análogamente a "develop", el script "build_and_deploy.sh" se ejecuta en "master" luego del "pull request" generando la carpeta "_site", enseguida se hace un commit y push al branch "gh_pages" en el respositorio "home". El nombre "gh_pages" del branch es intencional, pues es requisito para publicar el sitio web en Github Pages, en este caso, dado que el repositorio es "home", el sitio a publicar quedará en la URL https://mujeresentecnologia.github.io/home/

El respositorio "mujeresentecnologia.github.io" se utiliza para disponer del sitio web productivo como URL amigable, y contiene sólo el archivo index.html que redireccion hacia el sitio web de "home".
