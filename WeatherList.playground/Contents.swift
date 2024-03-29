//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

// Дано

struct CityWeather {
    let id: Int
    let cityName: String
    let currentTemperature: String
}

protocol WeatherProviderService {
    var userCityName: String { get }
    var savedCityWeather: [CityWeather] { get }
}

// ТЗ

//1. Показать список сохраненных городов в алфавитном порядке
//2. В каждой ячейке в заголовке отобразить название города
//3. Если город совпадает с городом юзера отобразить перед названием города "Текущее положение"
//4. В подзаголовке ячейки отобразить температуру в городе. В формате "Температура X℃"
//5. Если городов больше чем 3 показать первые три города и кнопку "Отобразить еще"
//6. По нажатию на кнопку показать список всех городов

// Имплементация

class MyViewController : UIViewController {
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white

        let label = UILabel()
        label.frame = CGRect(x: 150, y: 200, width: 200, height: 20)
        label.text = "Hello World!"
        label.textColor = .black
        
        view.addSubview(label)
        self.view = view
    }
}

// Present the view controller in the Live View window

PlaygroundPage.current.liveView = MyViewController()
