import Foundation

public final class StaticWeatherListProvider: WeatherListProvider {
    public var userCityName: String {
        didSet { delegate?.weatherListProviderDidChange(self) }
    }

    public var savedCityWeather: [CityWeather] {
        didSet { delegate?.weatherListProviderDidChange(self) }
    }

    public weak var delegate: (any WeatherListProviderDelegate)?

    public init(userCityName: String, savedCityWeather: [CityWeather]) {
        self.userCityName = userCityName
        self.savedCityWeather = savedCityWeather
    }
}

// MARK: - Predefined

extension StaticWeatherListProvider {
    public static func empty(userCityName: String = "Amsterdam") -> Self {
        Self(userCityName: userCityName, savedCityWeather: [])
    }

    public static func short(userCityName: String = "Amsterdam") -> Self {
        Self(
            userCityName: userCityName,
            savedCityWeather: [
                .init(id: 0, cityName: "Amsterdam", currentTemperature: 10.1),
                .init(id: 1, cityName: "Homel", currentTemperature: 14.5),
                .init(id: 2, cityName: "Minsk", currentTemperature: 11.7),
            ]
        )
    }

    public static func long(userCityName: String = "Amsterdam") -> Self {
        Self(
            userCityName: userCityName,
            savedCityWeather: [
                .init(id: 0, cityName: "Amsterdam", currentTemperature: 10.1),
                .init(id: 1, cityName: "Homel", currentTemperature: 14.5),
                .init(id: 2, cityName: "Minsk", currentTemperature: 11.7),
                .init(id: 3, cityName: "The Hague", currentTemperature: 9.9),
                .init(id: 4, cityName: "Utrecht", currentTemperature: 9.5),
                .init(id: 5, cityName: "Gouda", currentTemperature: 8.7),
                .init(id: 6, cityName: "Brest", currentTemperature: 12.7),
            ]
        )
    }
}
