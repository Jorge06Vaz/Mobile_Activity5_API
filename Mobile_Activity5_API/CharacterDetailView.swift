import SwiftUI

struct CharacterDetailView: View {
    let character: Character

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                CharacterImageView(imageURL: character.image, size: 240)

                VStack(spacing: 8) {
                    Text(character.name)
                        .font(.title2)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .accessibilityAddTraits(.isHeader)

                    Text(character.species)
                        .font(.headline)
                        .foregroundStyle(.secondary)
                }

                VStack(alignment: .leading, spacing: 16) {
                    Text("Información del personaje")
                        .font(.headline)
                        .accessibilityAddTraits(.isHeader)

                    infoRow(title: "Estado", value: character.status)
                    Divider()
                    infoRow(title: "Especie", value: character.species)
                    Divider()
                    infoRow(title: "Género", value: character.gender)
                    Divider()
                    infoRow(title: "Origen", value: character.origin.name)
                    Divider()
                    infoRow(title: "Última ubicación", value: character.location.name)
                }
                .padding(20)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.gray.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 16))

                Text("Datos de Rick and Morty API")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
            .padding(20)
            .frame(maxWidth: .infinity)
        }
        .navigationTitle("Detalle")
        .navigationBarTitleDisplayMode(.inline)
    }

    // Todas las filas usan el mismo formato para no repetir el codigo
    private func infoRow(title: String, value: String) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.subheadline)
                .foregroundStyle(.secondary)
            Text(value)
                .font(.body)
        }
        .accessibilityElement(children: .combine)
    }
}
