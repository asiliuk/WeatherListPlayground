import Foundation

public struct CityWeather {
    public let id: Int
    public let cityName: String
    public let currentTemperature: Double
}


#if DEBUG
extension CityWeather {
    public static func mock(
        id: Int = 0,
        cityName: String = "",
        currentTemperature: Double = 0
    ) -> Self {
        Self(
            id: id,
            cityName: cityName,
            currentTemperature: currentTemperature
        )
    }
}
#endif
