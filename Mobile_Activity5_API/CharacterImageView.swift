import SwiftUI

// Muestra imagen y sus estados de carga y error
struct CharacterImageView: View {
    let imageURL: String
    var size: CGFloat = 72

    var body: some View {
        AsyncImage(url: URL(string: imageURL)) { phase in
            switch phase {
            case .empty:
                ProgressView()
                    .accessibilityLabel("Cargando imagen")
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
            case .failure:
                imagePlaceholder
            @unknown default:
                imagePlaceholder
            }
        }
        .frame(width: size, height: size)
        .background(Color.gray.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .accessibilityHidden(true)
    }

    // Reutilizamos el mismo aviso cuando la imagen no está disponible
    private var imagePlaceholder: some View {
        VStack(spacing: 8) {
            Image(systemName: "photo")
            if size > 100 {
                Text("No se pudo cargar la imagen")
                    .font(.caption)
                    .multilineTextAlignment(.center)
            }
        }
        .foregroundStyle(.secondary)
        .padding(8)
    }
}
