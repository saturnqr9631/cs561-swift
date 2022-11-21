import Alamofire

public protocol WeatherService {
    func getTemperature() async throws -> Int
}
enum BaseURL : String {
    case realURL = "https://api.openweathermap.org"
    case mockURL = "http://localhost:7878"
}
class WeatherServiceImpl: WeatherService {
    //let url = "https://api.openweathermap.org/data/2.5/weather?q=corvallis&units=imperial&appid=4cceabeb997cdb3644b3dcce6d09d820"
    //let url = "\(BaseURL.realURL.rawValue)/data/2.5/weather?q=tucson&units=imperial&appid=4cceabeb997cdb3644b3dcce6d09d820"
    let url = "\(BaseURL.mockURL.rawValue)/data/2.5/weather?q=tucson&units=imperial&appid=4cceabeb997cdb3644b3dcce6d09d820"
    func getTemperature() async throws -> Int {
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(url, method: .get).validate(statusCode: 200..<300).responseDecodable(of: Weather.self) { response in
                switch response.result {
                case let .success(weather):
                    let temperature = weather.main.temp
                    let temperatureAsInteger = Int(temperature)
                    continuation.resume(with: .success(temperatureAsInteger))

                case let .failure(error):
                    continuation.resume(with: .failure(error))
                }
            }
        }
    }
}

struct Weather: Decodable {
    let main: Main

    struct Main: Decodable {
        let temp: Double
    }
}
