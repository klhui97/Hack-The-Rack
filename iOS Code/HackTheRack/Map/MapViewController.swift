//
//  MapViewController.swift
//  HackTheRack
//
//  Created by KL on 22/6/2018.
//  Copyright © 2018 KL. All rights reserved.
//

import UIKit
import MapKit
import Cluster
import Material

class MapViewController: UIViewController {

    @IBOutlet var menuLeadingConstraint: NSLayoutConstraint!
    
    @IBOutlet var menuView: UIView!
    @IBOutlet var mapView: MKMapView!
    @IBOutlet var showLocationButton: UIButton!
    @IBOutlet var visualEffect: UIVisualEffectView!
    
    let locationManager = CLLocationManager()
    let clusterManager = ClusterManager()
    
    let newTerritoriesPossition = CLLocationCoordinate2D(latitude: 22.3704243, longitude: 114.12341489999994)
    let kowloonPossition = CLLocationCoordinate2D(latitude: 22.3185673, longitude: 114.17960570000002)
    let hongKongIslandPossition = CLLocationCoordinate2D(latitude: 22.2587586, longitude: 114.19106959999999)
    let islandsDistrictPossition = CLLocationCoordinate2D(latitude: 22.2627924, longitude: 113.96554190000006)
    
    // MARK: - Life Cycle    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initNavigationBar()
        initMapView()
        initShowLocationButton()
        requestLocationAccess()
    }
    
    // MARK: - Init
    func initNavigationBar(){
        navigationItem.titleLabel.text = "Find nearby"
    }
    
    func initShowLocationButton(){
        showLocationButton.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi/4))
    }
    
    func initMapView(){
        mapView.delegate = self
        mapView.showsCompass = false
        
        // When zoom level is quite close to the pins, disable clustering in order to show individual pins and allow the user to interact with them via callouts.
        clusterManager.cellSize = 100
        clusterManager.maxZoomLevel = 17
        clusterManager.minCountForClustering = 2 // 1
        clusterManager.clusterPosition = .nearCenter
        
        let center = CLLocationCoordinate2D(latitude: 22.27956628, longitude: 114.08203118) // region center
        let delta = 0.1 // region span
        
        // Add annotations to the manager.
        generateClusterItems()
        
        mapView.region = .init(center: center, span: .init(latitudeDelta: delta, longitudeDelta: delta))
        mapView.showsUserLocation = true
        
    }
    
    // MARK: - Method
    func generateClusterItems(){

        var annotations: [Annotation] = []
        let extent = 0.2
        let positions = [newTerritoriesPossition, kowloonPossition, hongKongIslandPossition, islandsDistrictPossition]
        for position in positions{
            for _ in 1...50{
                let lat = position.latitude + extent*(Double(arc4random()) / Double(UINT32_MAX) * 2.0 - 1.0)
                let lng = position.longitude + extent*(Double(arc4random()) / Double(UINT32_MAX) * 2.0 - 1.0)
                let annotation = Annotation()
                annotation.title = "Title"
                annotation.subtitle = "subtitle"
                annotation.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lng)
                annotation.style = .color(UIColor.red, radius: 25) //.image(UIImage(named: "tick"))
                annotations.append(annotation)
            }
        }
        clusterManager.add(annotations)
    }
    
    func requestLocationAccess() {
        let status = CLLocationManager.authorizationStatus()
        
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            return
            
        case .denied, .restricted:
            print("location access denied")
            
        default:
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    // MARK: - Custom Map View
    func customAnnotation(customPin: MKAnnotationView) -> MKAnnotationView{
        customPin.image = UIImage(named: "seed")
        customPin.canShowCallout = true
        
        let button = UIButton(type: .detailDisclosure)
        customPin.rightCalloutAccessoryView = button
        
        let imageView = UIImageView.init(image: UIImage(named: "location"))
        imageView.contentMode = .scaleAspectFit
        customPin.leftCalloutAccessoryView = imageView
        
        return customPin
    }
    
    // MARK: - Action
    @IBAction func buttonClicked(_ sender: UIButton) {

        if sender == showLocationButton{
            mapView.setCenter(mapView.userLocation.coordinate, animated: true)
        }
    }
    
    @objc func toggleMenu(){
        if menuLeadingConstraint.constant == -250{
            menuLeadingConstraint.constant = 0
            visualEffect.isHidden = false
        }else{
            menuLeadingConstraint.constant = -250
            visualEffect.isHidden = true
        }
    }
    
    @objc func hideMenu(){
        menuLeadingConstraint.constant = -250
        visualEffect.isHidden = true
    }
}

extension MapViewController: MKMapViewDelegate{
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? ClusterAnnotation {
            // Cluster View
            guard let style = annotation.style else { return nil }
            let identifier = "Cluster"
            var view = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            if let view = view as? BorderedClusterAnnotationView {
                view.annotation = annotation
                view.configure(with: style)
            } else {
                view = BorderedClusterAnnotationView(annotation: annotation, reuseIdentifier: identifier, style: style, borderColor: .white)
            }
            return view
        } else {
            // Pin View
            guard let annotation = annotation as? Annotation else { return nil }
            let identifier = "Pin"
            
            if let view = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView  {
                view.annotation = annotation
                return view
            } else {
                let customPin = MKAnnotationView(annotation: annotation, reuseIdentifier: nil)
                return customAnnotation(customPin: customPin)
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let annotation = view.annotation else { return }
        
        if let cluster = annotation as? ClusterAnnotation {
            var zoomRect = MKMapRectNull
            for annotation in cluster.annotations {
                let annotationPoint = MKMapPointForCoordinate(annotation.coordinate)
                let pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0, 0)
                if MKMapRectIsNull(zoomRect) {
                    zoomRect = pointRect
                } else {
                    zoomRect = MKMapRectUnion(zoomRect, pointRect)
                }
            }
            mapView.setVisibleMapRect(zoomRect, animated: true)
        }
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        clusterManager.reload(mapView: mapView) { finished in
            print("regionDidChangeAnimated")
        }
    }
    
    func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView]) {
        views.forEach { $0.alpha = 0 }
        UIView.animate(withDuration: 0.35, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [], animations: {
            views.forEach { $0.alpha = 1 }
        }, completion: nil)
    }
}
