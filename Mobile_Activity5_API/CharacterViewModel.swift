import Foundation
import Observation

@MainActor
@Observable
class CharacterViewModel {
    private(set) var arrCharacters = [Character]()
    private(set) var isLoading = false
    private(set) var errorMessage: String?

    // Consulta y estados se manejan aqui fuera de la vista
    func getCharacters() async {
        guard !isLoading else { return }

        isLoading = true
        errorMessage = nil
        defer { isLoading = false }

        guard let url = URL(string: "https://rickandmortyapi.com/api/character") else {
            errorMessage = "La dirección de la API no es válida."
            return
        }

        do {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.timeoutInterval = 20
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse else {
                errorMessage = "No se recibió una respuesta válida del servidor."
                return
            }

            guard (200...299).contains(httpResponse.statusCode) else {
                errorMessage = "La API respondió con el código \(httpResponse.statusCode). Intenta de nuevo."
                return
            }

            let characterResponse = try JSONDecoder().decode(CharacterResponse.self, from: data)
            arrCharacters = characterResponse.results
        } catch is CancellationError {
            return
        } catch let error as URLError {
            switch error.code {
            case .cancelled:
                return
            case .notConnectedToInternet, .networkConnectionLost:
                errorMessage = "Sin conexión. Revisa tu internet e intenta de nuevo."
            case .timedOut:
                errorMessage = "La consulta tardó demasiado. Intenta de nuevo."
            default:
                errorMessage = "No se pudo conectar con la API. Intenta de nuevo."
            }
        } catch is DecodingError {
            errorMessage = "No se pudieron leer los datos de los personajes."
        } catch {
            errorMessage = "No se pudieron cargar los personajes. Intenta de nuevo."
        }
    }
}
