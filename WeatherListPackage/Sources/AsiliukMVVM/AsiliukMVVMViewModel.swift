import Foundation
import WeatherListProvider

public final class AsiliukMVVMViewModel {
    // MARK: UI State
    struct RowState: Hashable { var title: String; var subtitle: String }

    let title: String = "Weather List"
    private(set) var visibleRows: [RowState]
    var isShowMoreButtonShown: Bool { visibleRows.count != cityWeatherList.count }
    var viewModelDidChange: () -> Void = {}

    // MARK: State
    private let initialyVisibleRowsCount = 3
    private var cityWeatherList: [RowState]

    public init(provider: WeatherListProvider) {
        cityWeatherList = Self.cityWeatherList(
            currentCityName: provider.userCityName,
            citiesWeather: provider.savedCityWeather
        )
        visibleRows = Array(cityWeatherList.prefix(initialyVisibleRowsCount))
        provider.delegate = self
    }
}

// MARK: - Actions

extension AsiliukMVVMViewModel {
    func showMoreButtonTapped() {
        visibleRows = cityWeatherList
        viewModelDidChange()
    }
}

extension AsiliukMVVMViewModel: WeatherListProviderDelegate {
    public func weatherListProviderDidChange(_ provider: any WeatherListProvider) {
        cityWeatherList = Self.cityWeatherList(
            currentCityName: provider.userCityName,
            citiesWeather: provider.savedCityWeather
        )
        visibleRows = Array(cityWeatherList.prefix(initialyVisibleRowsCount))
        viewModelDidChange()
    }
}

// MARK: - Helpers

private extension AsiliukMVVMViewModel {
    static func cityWeatherList(currentCityName: String, citiesWeather: [CityWeather]) -> [RowState] {
        citiesWeather
            .sorted(by: { $0.cityName < $1.cityName })
            .map { cityWeather in
                RowState(
                    title: "\(cityWeather.cityName == currentCityName ? "Current location · " : "")\(cityWeather.cityName)",
                    subtitle: String(format: "Temperature %.1f℃", cityWeather.currentTemperature)
                )
            }
    }
}
