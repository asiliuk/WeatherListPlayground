import XCTest
import WeatherListProvider
@testable import AsiliukMVVM

final class AsiliukMVVMViewModelTests: XCTestCase {
    private var provider: WeatherListProviderMock!
    private var sut: AsiliukMVVMViewModel!

    override func setUpWithError() throws {
        provider = WeatherListProviderMock()
        sut = AsiliukMVVMViewModel(provider: provider)
    }

    override func tearDownWithError() throws {
        sut = nil
        provider = nil
    }

    func testIsEmptyWhenNoCities() {
        // Then
        XCTAssertEqual(sut.visibleRows, [])
        XCTAssertFalse(sut.isShowMoreButtonShown)
    }

    func testMoreButtonIsHiddenWhenHasThreeCities() {
        // Given
        provider.savedCityWeather = [.mock(), .mock(), .mock()]
        sut = AsiliukMVVMViewModel(provider: provider)

        // Then
        XCTAssertFalse(sut.isShowMoreButtonShown)
    }

    func testMoreButtonIsVisibleWhenHasMoreThanThreeCities() {
        // Given
        provider.savedCityWeather = [.mock(), .mock(), .mock(), .mock()]
        sut = AsiliukMVVMViewModel(provider: provider)

        // Then
        XCTAssertEqual(sut.visibleRows.count, 3)
        XCTAssertTrue(sut.isShowMoreButtonShown)
    }

    func testHidesButtonAndShowsAllRowsWhenButtonTapped() {
        // Given
        provider.savedCityWeather = [.mock(), .mock(), .mock(), .mock(), .mock()]
        sut = AsiliukMVVMViewModel(provider: provider)

        // When
        sut.showMoreButtonTapped()

        // Then
        XCTAssertEqual(sut.visibleRows.count, 5)
        XCTAssertFalse(sut.isShowMoreButtonShown)
    }

    func testShowsButtonAndShowsOnlyFirstThreeRowsWhenProviderChanges() {
        // Given
        provider.savedCityWeather = [.mock(), .mock(), .mock(), .mock(), .mock()]
        sut = AsiliukMVVMViewModel(provider: provider)

        // When
        provider.delegate?.weatherListProviderDidChange(provider)

        // Then
        XCTAssertEqual(sut.visibleRows.count, 3)
        XCTAssertTrue(sut.isShowMoreButtonShown)
    }

    func testRowsAreSortedAlphabetically() {
        // Given
        provider.savedCityWeather = [
            .mock(cityName: "B"),
            .mock(cityName: "D"),
            .mock(cityName: "A"),
            .mock(cityName: "C"),
            .mock(cityName: "E")
        ]
        sut = AsiliukMVVMViewModel(provider: provider)
        sut.showMoreButtonTapped()

        // Then
        XCTAssertEqual(sut.visibleRows.map(\.title), ["A", "B", "C", "D", "E"])
    }

    func testUserCityRowHasCorrectPrefix() {
        // Given
        provider.savedCityWeather = [
            .mock(cityName: "B"),
            .mock(cityName: "D"),
            .mock(cityName: "A"),
            .mock(cityName: "C"),
            .mock(cityName: "E")
        ]
        provider.userCityName = "C"
        sut = AsiliukMVVMViewModel(provider: provider)
        sut.showMoreButtonTapped()

        // Then
        XCTAssertEqual(sut.visibleRows.map(\.title), ["A", "B", "Current location · C", "D", "E"])
    }

    func testUserLocationRowOnCityChange() {
        // Given
        provider.savedCityWeather = [
            .mock(cityName: "B"),
            .mock(cityName: "D"),
            .mock(cityName: "A"),
            .mock(cityName: "C"),
            .mock(cityName: "E")
        ]
        provider.userCityName = "C"
        sut = AsiliukMVVMViewModel(provider: provider)
        sut.showMoreButtonTapped()

        // When
        provider.userCityName = "A"
        provider.delegate?.weatherListProviderDidChange(provider)
        sut.showMoreButtonTapped()

        // Then
        XCTAssertEqual(sut.visibleRows.map(\.title), ["Current location · A", "B", "C", "D", "E"])
    }
}
