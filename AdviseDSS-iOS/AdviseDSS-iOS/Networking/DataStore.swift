//
//  DataStore.swift
//  AdviseDSS-iOS
//
//  Created by Rida Aftab on 08/06/2024.
//

import Foundation
import Alamofire

protocol AppDataStore {
    func fetchForcastData(completion: @escaping (ResultType<ForecastDataResponse>) -> Void)
}

class AppDataStoreImpl {
    var networking: AlamofireNetworking
    
    init(_ networking: AlamofireNetworking) {
        self.networking = networking
    }
}

extension AppDataStoreImpl: AppDataStore {
    func fetchForcastData(completion: @escaping (ResultType<ForecastDataResponse>) -> Void) {
        let request = DataRequest(url: "http://203.156.108.67:1080/api/forecastdata")
        networking.run(request) { (response: DataResponseModel<ForecastDataResponse>) in
            switch response.result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let response):
                completion(.success(response))
            }
        }
    }
}
struct ForecastDataResponse: Decodable {
    let data: ResponseData
    let messages: String
    let status: Int
}

struct ResponseData: Decodable {
    let allDistrictsData: String
    let dataSource: String
    let districtAvgDataMobile: DistrictAvgDataMobile
}

struct DistrictAvgDataMobile: Decodable {
    let forecastMapDay1: ForecastMapDay
    let forecastMapDay2: ForecastMapDay
    let forecastMapDay3: ForecastMapDay
}

struct ForecastMapDay: Decodable {
    var allDistrictsData: [District]
    let forecastDate: String
}

struct District: Decodable {
    //val average_humidity: Double,
//    let max_temperature: String
//    let min_temperature: String
//    let rainFall: String
    let districtName: String
}

struct Coordinate {
    var lat: Double
    var long: Double
}

struct DistrictCoordinatesAndColors {
    let coordinates: [Coordinate]
    let DistrictName: String
    
}

struct DistrictsCoordinatesModel: Decodable {
    let crs: Crs?
    let features: [Feature]
    let name: String
    let type: String
}

struct Crs: Decodable {
    let properties: Properties
    let type: String
}

struct Feature: Decodable {
    let geometry: Geometry
    let properties: PropertiesX
    let type: String
}

struct Properties: Decodable {
    let name: String
}

struct PropertiesX: Decodable {
    let DISTRICT: String
    let DistrictID: String
    let LatCenter: Double
    let LongCenter: Double
    let PROVINCE: String
}

struct Geometry: Decodable {
    let coordinates: [[[[Double]]]]
    let type: String
}
