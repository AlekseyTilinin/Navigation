//
//  MapViewController.swift
//  Navigation
//
//  Created by Aleksey on 22.03.2023.
//

import UIKit
import CoreLocation
import MapKit

final class Annotation: NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
        super.init()
    }
}

class MapViewController: UIViewController, UIGestureRecognizerDelegate {
    
    var route: CLLocationCoordinate2D?
    
    private lazy var locationManager : CLLocationManager = {
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        return locationManager
    }()
    
    private lazy var map: MKMapView = {
        let map = MKMapView()
        map.translatesAutoresizingMaskIntoConstraints = false
        map.showsUserLocation = true
        map.delegate = self
        return map
    }()
    
    private lazy var getLocationButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "location"), for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(getLocation), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var getRouteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "mappin"), for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(getRoute), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isEnabled = false
        return button
    }()
    
    private lazy var removeAllPinsButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "mappin.slash"), for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(deleteAllPins), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isEnabled = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        locationManager.requestWhenInUseAuthorization()
        
        view.addSubview(map)
        map.addSubview(getLocationButton)
        map.addSubview(getRouteButton)
        map.addSubview(removeAllPinsButton)
        
        setConstraint()
        
        let lpgr = UILongPressGestureRecognizer(target: self, action:#selector(self.handleLongPress))
        lpgr.minimumPressDuration = 1
        lpgr.delaysTouchesBegan = true
        lpgr.delegate = self
        
        self.map.addGestureRecognizer(lpgr)
        
    }
    
    func setConstraint() {
        NSLayoutConstraint.activate([
            map.topAnchor.constraint(equalTo: super.view.topAnchor, constant: 0),
            map.leftAnchor.constraint(equalTo: super.view.leftAnchor, constant: 0),
            map.rightAnchor.constraint(equalTo: super.view.rightAnchor, constant: 0),
            map.bottomAnchor.constraint(equalTo: super.view.bottomAnchor, constant: 0),
            
            getLocationButton.heightAnchor.constraint(equalToConstant: 44),
            getLocationButton.widthAnchor.constraint(equalToConstant: 44),
            getLocationButton.rightAnchor.constraint(equalTo: super.view.rightAnchor, constant: -20),
            getLocationButton.bottomAnchor.constraint(equalTo: super.view.bottomAnchor, constant: -100),
            
            getRouteButton.heightAnchor.constraint(equalToConstant: 44),
            getRouteButton.widthAnchor.constraint(equalToConstant: 44),
            getRouteButton.rightAnchor.constraint(equalTo: super.view.rightAnchor, constant: -20),
            getRouteButton.topAnchor.constraint(equalTo: super.view.topAnchor, constant: 70),
            
            removeAllPinsButton.heightAnchor.constraint(equalToConstant: 44),
            removeAllPinsButton.widthAnchor.constraint(equalToConstant: 44),
            removeAllPinsButton.rightAnchor.constraint(equalTo: super.view.rightAnchor, constant: -20),
            removeAllPinsButton.topAnchor.constraint(equalTo: super.view.topAnchor, constant: 120)
        ])
    }
    
    @objc func handleLongPress(gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state != UIGestureRecognizer.State.ended {
            return
        }
        else if gestureRecognizer.state != UIGestureRecognizer.State.began {
            
            let touchPoint = gestureRecognizer.location(in: self.map)
            let touchMapCoordinate =  self.map.convert(touchPoint, toCoordinateFrom: map)
            
            map.addAnnotation(Annotation(coordinate: touchMapCoordinate))
            self.removeAllPinsButton.isEnabled = true
            print("Установлена новая точка")
        }
    }
    
    @objc
    private func getLocation() {
        print("click to getLocationButton")
        locationManager.requestLocation()
    }
    
    @objc
    private func getRoute() {
        print("click to getRouteButton")
        let location = CLLocation(latitude: route!.latitude, longitude: route!.longitude)
        print(locationManager.location?.distance(from: location) ?? "")
        
        let loc1 = CLLocationCoordinate2D.init(latitude: (locationManager.location?.coordinate.latitude)!, longitude: (locationManager.location?.coordinate.longitude)!)
        let loc2 = CLLocationCoordinate2D.init(latitude: route!.latitude, longitude: route!.longitude)
        
        showRouteOnMap(pickupCoordinate: loc1, destinationCoordinate: loc2)
    }
    
    @objc
    private func deleteAllPins(){
        print("click to deletePinsbutton")
        map.removeAnnotations(map.annotations)
        map.removeOverlays(map.overlays)
        self.getRouteButton.isEnabled = false
        self.removeAllPinsButton.isEnabled = false
        
    }
}

extension MapViewController : MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print("Выбрана точка")
        route = view.annotation?.coordinate ?? CLLocationCoordinate2D()
        self.getRouteButton.isEnabled = true
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        self.getRouteButton.isEnabled = false
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.red
        renderer.lineWidth = 5.0
        return renderer
    }
    
    func showRouteOnMap(pickupCoordinate: CLLocationCoordinate2D, destinationCoordinate: CLLocationCoordinate2D) {
        
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: pickupCoordinate, addressDictionary: nil))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: destinationCoordinate, addressDictionary: nil))
        request.requestsAlternateRoutes = true
        request.transportType = .automobile
        
        let directions = MKDirections(request: request)
        
        directions.calculate { [unowned self] response, error in
            guard let unwrappedResponse = response else { return }
            
            if let route = unwrappedResponse.routes.first {
                self.map.addOverlay(route.polyline)
                self.map.setVisibleMapRect(route.polyline.boundingMapRect, edgePadding: UIEdgeInsets.init(top: 80.0, left: 20.0, bottom: 100.0, right: 20.0), animated: true)
            }
        }
    }
}

extension MapViewController: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(
        _ manager: CLLocationManager
    ) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse:
            print("Определение локации разрешено однократно (authorizedWhenInUse)")
        case .authorizedAlways:
            print("Определение локации разрешено при использоваении (authorizedAlways)")
        case .denied, .restricted:
            print("Определение локации невозможно")
        case .notDetermined:
            print("Определение локации не запрошено")
        @unknown default:
            fatalError()
        }
    }
    
    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        if let location = locations.first {
            
            print("Местоположение: \(location)")
            
            map.setCenter(
                location.coordinate,
                animated: true
            )
            
            let region = MKCoordinateRegion(
                center: location.coordinate,
                latitudinalMeters: 1_000,
                longitudinalMeters: 1_000
            )
            map.setRegion(
                region,
                animated: true
            )
        }
        
    }
    
    func locationManager(
        _ manager: CLLocationManager,
        didFailWithError error: Error
    ) {
        print("Местоположение не удалось определить")
    }
}
