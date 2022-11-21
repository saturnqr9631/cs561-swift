import XCTest
@testable import MyLibrary

final class WeatherServiceIntegrationTests: XCTestCase {
    func testWeatherServiceCallSuccess() async throws{
        // Given
        // Create a weather service (OOP)
        let testService = WeatherServiceImpl()
        var temp: Int?    
        // When
        // Get the temperature
        temp = try await testService.getTemperature()

        // Then
        // Check the temperature is what we expect
        // Real life Server
        XCTAssertNotNil(temp)
    }

}
