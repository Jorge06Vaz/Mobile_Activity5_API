import SwiftUI

struct ContentView: View {
    @State private var characterVM = CharacterViewModel()

    var body: some View {
        NavigationStack {
            Group {
                if characterVM.isLoading {
                    ProgressView("Cargando personajes...")
                } else if let errorMessage = characterVM.errorMessage {
                    VStack(spacing: 16) {
                        Image(systemName: "exclamationmark.triangle")
                            .font(.largeTitle)
                            .foregroundStyle(.secondary)

                        Text(errorMessage)
                            .multilineTextAlignment(.center)

                        Button("Reintentar") {
                            Task {
                                await characterVM.getCharacters()
                            }
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    .padding()
                } else if characterVM.arrCharacters.isEmpty {
                    Text("No hay personajes disponibles.")
                        .foregroundStyle(.secondary)
                } else {
                    characterList
                }
            }
            .navigationTitle("Rick and Morty")
            .task {
                await characterVM.getCharacters()
            }
        }
        .tint(.green)
    }

    // Separamos la lista para que el body sea facil de leer
    private var characterList: some View {
        List {
            Section {
                ForEach(characterVM.arrCharacters) { character in
                    NavigationLink {
                        CharacterDetailView(character: character)
                    } label: {
                        HStack(spacing: 16) {
                            CharacterImageView(imageURL: character.image)
                            VStack(alignment: .leading, spacing: 6) {
                                Text(character.name)
                                    .font(.headline)
                                Text(character.species)
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                            }
                        }
                        .padding(.vertical, 6)
                    }
                    .accessibilityElement(children: .combine)
                    .accessibilityHint("Abre los detalles del personaje")
                }
            } header: {
                Text("Personajes")
            } footer: {
                Text("Primera página Datos de Rick and Morty API")
            }
        }
        .refreshable {
            await characterVM.getCharacters()
        }
    }
}

#Preview {
    ContentView()
}
