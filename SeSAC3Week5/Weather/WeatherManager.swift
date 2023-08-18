//
//  WeatherManager.swift
//  SeSAC3Week5
//
//  Created by 권현석 on 2023/08/17.
//

import Foundation
import Alamofire
import SwiftyJSON

class WeatherManager {
    
    static let shared = WeatherManager()
    
    func callRequestCodable(success: @escaping (WeatherData) -> Void, failure: @escaping () -> Void ) {
        let url = "https://api.openweathermap.org/data/2.5/weather?lat=44.34&lon=10.99&appid=8df2c657dcbff9b24b611b7afc158876"
        
        AF.request(url, method: .get).validate(statusCode: 200...500)
            .responseDecodable(of: WeatherData.self) { response in
                
                switch response.result {
                case .success(let value): success(value)
                    
                case .failure(let error): failure()
                    print(error)
                    failure()
                }
                
            }
        
    }
    
    func callRequestJSON(completionHandler: @escaping (JSON) -> Void ) {
        let url = "https://api.openweathermap.org/data/2.5/weather?lat=44.34&lon=10.99&appid=8df2c657dcbff9b24b611b7afc158876"
        
        AF.request(url, method: .get).validate(statusCode: 200...500)
            .responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                completionHandler(json)
                
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    func callRequestString(completionHandler: @escaping (String, String) -> Void ) {
        let url = "https://api.openweathermap.org/data/2.5/weather?lat=44.34&lon=10.99&appid=8df2c657dcbff9b24b611b7afc158876"
        
        AF.request(url, method: .get).validate()
            .responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                let temp = json["main"]["temp"].doubleValue - 273.15
                let humidity = json["main"]["humidity"].intValue
                
                completionHandler("\(temp)도 입니다.", "\(humidity)% 입니다.")
                
            case .failure(let error):
                print(error)
            }
        }
        
    }
}
