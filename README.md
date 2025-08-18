# challenge_pinapp

Aplicación realizada con el proposito de resolver el challenge técnico para pinapp.
La misma muestra una lista de posts obtenidas de una [API](https://jsonplaceholder.typicode.com/posts), 
mediante una barra de búsqueda estos posts pueden ser filtrados por título.
Al hacer click en un post, se muestra una nueva pantalla con los comentarios relacionados a ese post.
Esta página támbien ofrece la posibilidad de poder dar un "like" al post, el cual se verá reflejado en la lista de posts.

## Dependencias utilizadas

* **flutter_bloc**
  * Librería para la gestión de estados en Flutter, permite separar lógica de negocio de la interfaz de usuario.
* **get_it**
  * Librería para la inyección de dependencias. Permite la centralización de creación de objetos y su uso en diferentes partes del código.
* **equatable**
  * Simplifica la comparación de objetos y así ayudar a la gestión de estados.
* **dio**
  * Librería para realizar peticiones HTTP. Elegido por sus caracteristicas como los interceptores, si bien no son utilizados en este caso, prepara la app para la escalabilidad.
  * El siguiente header ```User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36``` fue agregado para evitar los constantes bloqueaos de la API utilizada.
* **sqflite**
  * Librería para el manejo de bases de datos, utilizado para la implementación de "likes" para almacenarlos en una fuente de datos local y estructurada
* **mockito y bloc_test**
  * Librerías para pruebas unitarias. Facilitan la creación de mocks y el testeo de los cubits. 
