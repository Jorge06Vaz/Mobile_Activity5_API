# Rick and Morty — Mobile Activity 5

Para esta actividad hice una app en SwiftUI que muestra personajes de Rick and Morty usando una API pública, en la pantalla principal aparece una lista con el nombre, la especie y la imagen de cada personaje y al tocar uno se abre su detalle con más información como su estado, género, origen y última ubicación.

## API que utilicé

La app hace una petición **GET** a este endpoint:

[https://rickandmortyapi.com/api/character](https://rickandmortyapi.com/api/character)

La API no necesita una clave para usarla. Por ahora, la app muestra la primera página, que incluye hasta 20 personajes. En la respuesta, los personajes vienen dentro de `results`.

También se puede consultar la [documentación de Rick and Morty API](https://rickandmortyapi.com/documentation/).

## Cómo correr el proyecto

Usé **Xcode 27.0** y el proyecto tiene configurado **iOS 27.0** como versión mínima.

1. Clona el repositorio o descarga el ZIP de GitHub y descomprímelo.
2. Abre el archivo `Mobile_Activity5_API.xcodeproj` en Xcode.
3. Selecciona el esquema `Mobile_Activity5_API` y un simulador de iPhone con iOS 27 o posterior. Si no tienes esa versión del simulador, descárgala desde Xcode.
4. Asegúrate de tener conexión a internet para consultar la API y cargar las imágenes.
5. Presiona **Command + R** o el botón de ejecutar.
6. Cuando aparezca la lista, toca un personaje para ver su información. Puedes regresar a la lista con el botón de atrás.

Puedes probar la app en el simulador sin configurar una cuenta de desarrollo.

## Cómo organicé el código

Usé **MVVM** para separar los datos, la consulta a la API y las pantallas.

| Archivo | Qué hace |
| --- | --- |
| `Character.swift` | Define los datos de los personajes y la estructura de la respuesta de la API. |
| `CharacterViewModel.swift` | Consulta la API con `getCharacters()` y maneja los personajes, la carga y los errores. |
| `ContentView.swift` | Muestra la lista y permite abrir el detalle con `NavigationStack` y `NavigationLink`. |
| `CharacterDetailView.swift` | Muestra la información del personaje que seleccionaste. |
| `CharacterImageView.swift` | Carga las imágenes y muestra qué pasa mientras cargan o si fallan. Se usa en las dos pantallas. |
| `MyApp.swift` | Inicia la app y muestra la pantalla principal. |

El ViewModel usa `@Observable` y la vista lo guarda con `@State`. Así, cuando cambian los datos o el estado de carga, la pantalla se actualiza. También usé `@MainActor` para actualizar esos estados en el hilo principal.

## Carga y manejo de errores

Mientras se consultan los personajes aparece un `ProgressView`. Las imágenes también muestran un indicador mientras cargan.

Si no hay internet, la consulta tarda demasiado o la API falla, aparece un mensaje y el botón **Reintentar**, cuando el servidor responde con un error, el mensaje incluye su código HTTP, también se maneja el caso en que los datos no se puedan leer.

Si falla una imagen, aparece un símbolo de reemplazo y, en la pantalla de detalle, un aviso y para actualizar la lista, puedes deslizar hacia abajo.

## Diseño y accesibilidad

Usé fuentes del sistema y espacios entre los elementos para que la información sea fácil de leer. El detalle se puede desplazar para ver todos los datos.

Para VoiceOver, agrupé el texto de las filas, agregué una indicación de que los enlaces abren el detalle y marqué los títulos como encabezados. Las imágenes se dejaron como elementos decorativos para evitar repetir el texto del personaje.

## Código limpio

Cada archivo tiene una tarea concreta. Separé la consulta de las pantallas y reutilicé la vista de imagen y el formato de las filas del detalle para no repetir código. Agregué comentarios cortos para explicar esas partes.

## Pruebas realizadas

La app compiló correctamente para el simulador de iPhone y se comprobó la navegación de la lista al detalle.

También se verificó el ViewModel con una respuesta real y errores simulados: falta de conexión, tiempo de espera agotado, error HTTP 500 y JSON inválido. Se comprobó que al reintentar se recuperaran los datos y se quitara el mensaje de error. Estas pruebas se hicieron por separado; no hay un target de pruebas automatizadas dentro del proyecto.
