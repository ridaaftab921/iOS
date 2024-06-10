//
//  MapViewController.swift
//  AdviseDSS-iOS
//
//  Created by Rida Aftab on 03/06/2024.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController, Storyboarded, GMSMapViewDelegate {
    var mapView: GMSMapView!
    var activityView: UIActivityIndicatorView?

    static var storyboard = AppStoryboard.map
    
    var dataStore: AppDataStore = AppDataStoreImpl(AlamofireNetworkManager.sharedInstance)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white  
        let options = GMSMapViewOptions()
        
        options.camera = GMSCameraPosition.camera(withLatitude: 30.337448, longitude: 72.84369, zoom: 6.0)
        options.frame = self.view.frame
       
        mapView = GMSMapView(options: options)
        mapView.delegate = self
        self.view.addSubview(mapView)
        
        fetchData()
    }
    
    func showActivityIndicator() {
        activityView = UIActivityIndicatorView(style: .large)
        activityView?.center = self.view.center
        self.view.addSubview(activityView!)
        activityView?.startAnimating()
    }

    func hideActivityIndicator(){
        if (activityView != nil){
            activityView?.stopAnimating()
        }
    }
    
    func fetchData() {
        showActivityIndicator()
        dataStore.fetchForcastData { response in
            switch response {
            case .success(let forecastData):
                print(forecastData)
                self.convertJson(forecastData: forecastData)
            case .failure( _):
                break
            }
        }
    }
    
    func convertJson(forecastData: ForecastDataResponse) {
        let string = forecastData.data.allDistrictsData
        let data = string.data(using: .utf8)!
        do {
            let districtsCoordinatesModel = try JSONDecoder().decode(DistrictsCoordinatesModel.self, from: data)
            print(districtsCoordinatesModel)
            DispatchQueue.main.async {
                self.drawPolygons(districtsCoordinatesModel: districtsCoordinatesModel)
            }
        } catch let error as NSError {
            print(error)
        }
    }

    func drawPolygons(districtsCoordinatesModel: DistrictsCoordinatesModel) {
        var districtCoordinatesAndColors = [DistrictCoordinatesAndColors]()
        
        for feature in districtsCoordinatesModel.features {
            let districtName = feature.properties.DISTRICT
            var areaLocationList: [Coordinate] = []
            for areaLatLong in feature.geometry.coordinates[0][0] {
                areaLocationList.append(Coordinate(lat: areaLatLong[0], long: areaLatLong[1]))
            }
            districtCoordinatesAndColors.append(DistrictCoordinatesAndColors(coordinates: areaLocationList, DistrictName: districtName))
        }
        
        let colors: [UIColor] = [.red, .blue, .purple, .green, .brown, .cyan, .darkGray, .lightGray, .link, .magenta, .orange] // couldn't find colors in API data
        var index = 0
        
        for district in districtCoordinatesAndColors {
            let path = GMSMutablePath()
            for coordinate in district.coordinates {
                path.add(CLLocationCoordinate2D(latitude: coordinate.long, longitude: coordinate.lat))
                
                let polyline = GMSPolyline(path: path)
                polyline.strokeColor = colors[index % colors.count]
                polyline.strokeWidth = 2.0
                polyline.map = mapView
            }
            index += 1
        }
        hideActivityIndicator()
    }
}
