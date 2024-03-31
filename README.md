# WeatherListPlayground
This is repository with WeatherList.playground sample project with simple specification to discuss different solutions and architectures 

## Specification
1. Show list of cities from `WeatherProviderService` in alphabetical order
2. In each cell title show city name
3. If city is equal to `userCityName` show `Current location` prefix in the cell title
4. In each cell subtitle show city temperature in format `Temperature %d℃`
5. If there's more than 3 cities show only first 3 cities in the list and button `Show more`
6. When `Show more` button is tapped show all cities in the list

## How to participate
- Open `WeatherListPackage/Package.swift`
- Add new target named `<your name><architecture name>`
  - Optionally add new test target named `<your name><architecture name>Tests`
- Put your solution in newly created target
- Add presentation of your component in `WeatherListPackage/WeatherListPackage.swift`
- Preview your's and other's solutions in Xcode preview

## Exanple UI
<img src="https://github.com/asiliuk/WeatherListPlayground/assets/1136316/4e264365-b5d8-4ac5-b8a1-9a7a8c480642" width=320>
