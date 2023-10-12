//
//  MapViewController.swift
//  RideSharer
//
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationService()
    }
    
    func checkLocationService() {
        DispatchQueue.global().async{
            if CLLocationManager.locationServicesEnabled(){
                 self.checkLocationAuthorization()
            } else {
                
            }
        }
    }
    
    func checkLocationAuthorization() {
        switch locationManager.authorizationStatus{
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
        case .authorizedAlways: break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            mapView.showsUserLocation = true
        case .denied:
            DispatchQueue.main.async{
                let alert = UIAlertController(title: "No location access", message: "User has not provided the permission for location access. Go to settings and allow location access for RideSharer App for full usage of this app.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(alert, animated: true, completion: nil)
            }
        case .restricted: break
        @unknown default:
            print("location service not found")
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
    
    
    
}
