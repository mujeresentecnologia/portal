Mujeres en Tecnología
===================

Este proyecto es una plataforma web que tiene por finalidad, servir como punto de encuentro a todas esas personas, en especial mujeres, que sientan un interés hacia eventos e iniciativas referidas a tecnología.


Herramientas
------------
 - MacOS.
 - Jekyll.
 - Gihub.
 - Git.

Instalación
-------------
> **Nota:** Estas instrucciones de instalación son para **macOS**, al final encontrarás la configuración para **Windows**.

Para instalar Jekyll en tu computador, es necesario configurar algunas dependencias.
Este documento es un paso a paso.

Primero, debes verificar si ya existe GCC y Make en el computador:
``` 
gcc -v
make -v
```
Si ninguna versión aparece, entonces:
```
xcode-select --install
```
Aparecerá un mensaje "the xcode-select requires the command line developer tools …" 
Haz click en "Install"

Luego, para Ruby, macOS (High) Sierra y OS X El Capitan cuentan con la versión 2.0, pero, en este proyecto utilizamos la versión 2.4.2.

Entonces, verifica si cuentas con Ruby:
```
ruby -v
```
Si tu versión es menor a 2.4.X, entonces:
```
\curl -sSL https://get.rvm.io | bash -s stable

rvm list known

rvm install ruby-2.4.2
```
Ahora, si ejecutas **ruby -v** debería aparecer la versión **2.4.2**

Actualiza RubyGems: 
```
gem update --system
```
Finalmente, instala Jekyll:
```
gem install jekyll
```
Si te utilizas Windows, por favor, sigue las siguientes instrucciones:
https://jekyllrb.com/docs/windows/#installation
