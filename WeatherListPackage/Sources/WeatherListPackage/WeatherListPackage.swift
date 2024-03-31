import SwiftUI
import WeatherListProvider
import AsiliukMVVM

#Preview {
    NavigationStack {
        List {
            NavigationLink("Asiliuk MVVM") {
                AsiliukMVVMView()
                    .ignoresSafeArea()
                    .navigationTitle("Asiliuk MVVM")
            }
        }
    }
}

// MARK: - Asiliuk

private struct AsiliukMVVMView: UIViewControllerRepresentable {
    func updateUIViewController(_ uiViewController: some UIViewController, context: Context) {
        // noop
    }
    func makeUIViewController(context: Context) -> some UIViewController {
        let viewModel = AsiliukMVVMViewModel(provider: StaticWeatherListProvider.long())
        let viewController = AsiliukMVVMViewController(viewModel: viewModel)
        return viewController
    }
}
