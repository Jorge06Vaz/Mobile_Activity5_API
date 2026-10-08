import Foundation

// El modelo solo describe los datos que recibimos de la API.
struct Character: Decodable, Identifiable {
    let id: Int
    let name: String
    let species: String
    let image: String
}

// Los personajes vienen dentro de "results", no como un arreglo directo.
struct CharacterResponse: Decodable {
    let results: [Character]
}
