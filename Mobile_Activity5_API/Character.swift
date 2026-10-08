import Foundation

// Ddatos que recibimos de la API
struct Character: Decodable, Identifiable {
    let id: Int
    let name: String
    let species: String
    let image: String
    let status: String
    let gender: String
    let origin: CharacterPlace
    let location: CharacterPlace
}

struct CharacterResponse: Decodable {
    let results: [Character]
}

struct CharacterPlace: Decodable {
    let name: String
}
