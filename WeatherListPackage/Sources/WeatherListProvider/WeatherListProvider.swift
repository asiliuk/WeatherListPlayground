import Foundation

public protocol WeatherListProviderDelegate: AnyObject {
    func weatherListProviderDidChange(_ weatherListProvider: any WeatherListProvider)
}

public protocol WeatherListProvider: AnyObject {
    var userCityName:  String { get }
    var savedCityWeather: [CityWeather] { get }
    var delegate: (any WeatherListProviderDelegate)? { get set }
}

#if DEBUG
public final class WeatherListProviderMock: WeatherListProvider {
    public var userCityName: String
    public var savedCityWeather: [CityWeather]
    public weak var delegate: (any WeatherListProviderDelegate)?

    public init(userCityName: String = "", savedCityWeather: [CityWeather] = []) {
        self.userCityName = userCityName
        self.savedCityWeather = savedCityWeather
    }
}

public final class WeatherListProviderDelegateSpy: WeatherListProviderDelegate {
    public private(set) var weatherListProviderDidChangeCallsCount = 0
    public func weatherListProviderDidChange(_ weatherListProvider: any WeatherListProvider) {
        weatherListProviderDidChangeCallsCount += 1
    }
}
#endif
