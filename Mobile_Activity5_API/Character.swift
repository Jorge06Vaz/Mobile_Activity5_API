import Foundation

// Ddatos que recibimos de la API
struct Character: Decodable, Identifiable {
    let id: Int
    let name: String
    let species: String
    let image: String
}

struct CharacterResponse: Decodable {
    let results: [Character]
}
