//
//  MapViewController.swift
//  O-Weather
//
//  Created by admin on 07.02.2023.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {

    //MARK: - MapView
    var isGlobe = false
    var isRealistic = false
    
    var location = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    
    let Manager = CLLocationManager()
    
    var cityInfoRow = 0
    
    @IBOutlet weak var SearchBar: UISearchBar!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var CitiesTableView: CitiesTableView!
    
    @IBOutlet weak var MyLocationButton: SmallButton!
    @IBOutlet weak var MapTypeButton: SmallButton!
    
    
    let blurredEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    
    var locations = [Location]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .dark
        }
        mapView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideCities)))
        blurredEffectView.frame = view.bounds
        blurredEffectView.alpha = 0
        mapView.addSubview(blurredEffectView)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mapType"{
            let controller = segue.destination as! MapTypeViewController
            controller.delegate = self
            controller.isGlobe = self.isGlobe
            controller.isRealistic = self.isRealistic
        }
    }
    
    @IBAction func MapTypeTouched(_ sender: SmallButton) {
    }
    
    
    @IBAction func MyLocationTouched(_ sender: SmallButton) {
        findMyLocation()
    }
    
    @objc func hideCities(_ sender: UITapGestureRecognizer){
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, animations: {
            self.CitiesTableView?.alpha = 0
            self.CitiesTableView.transform = CGAffineTransform(translationX: 0, y: 20)
            self.blurredEffectView.alpha = 0
            self.MapTypeButton.alpha = 1
            self.MyLocationButton.alpha = 1
        })
        SearchBar.endEditing(true)
    }
    
    
    
    func showCities(){
        if CitiesTableView?.alpha != 1{
            self.CitiesTableView.transform = CGAffineTransform(translationX: 0, y: 20)
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, animations: {
                self.CitiesTableView?.alpha = 1
                self.blurredEffectView.alpha = 1
                self.CitiesTableView.transform = CGAffineTransform(translationX: 0, y: 0)
                self.MapTypeButton.alpha = 0
                self.MyLocationButton.alpha = 0
            })
        }
    }
    
    
    
}

extension MapViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text, !text.isEmpty {
            LocationManager.shared.findLocations(with: text) { [weak self] locations in
                DispatchQueue.main.async {
                    self?.locations = locations
                    self?.CitiesTableView.reloadData()
                    self?.cityInfoRow = 0
                }
            }
        } else {
            self.locations = [Location]()
        }
        CitiesTableView.reloadData()
        cityInfoRow = 0
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        showCities()
        return true
    }
  }

extension MapViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if locations.count == 0 {
                tableView.setMessage("No results")
                return 0
            } else {
                tableView.clearBackground()
            }
        return locations[0].rows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        let Row = cell.viewWithTag(1) as! UILabel
        Row.numberOfLines = 0
        Row.text = ""
        let infoLabel = cell.viewWithTag(2) as! UILabel
        infoLabel.numberOfLines = 0
        infoLabel.text = ""
        if cityInfoRow == 0 {
            if let city = locations[0].city{
                Row.text = "City"
                infoLabel.text = city
                cityInfoRow+=1;
                return cell
            } else {
                cityInfoRow+=1;
            }
        }
        if cityInfoRow == 1 {
            if let subAdminRegion = locations[0].subAdminRegion{
                Row.text = "SubAdmin Region"
                infoLabel.text = subAdminRegion
                cityInfoRow+=1;
                return cell
            } else {
                cityInfoRow+=1;
            }
        }
        if cityInfoRow == 2 {
            if let adminRegion = locations[0].adminRegion{
                Row.text = "Admin Region"
                infoLabel.text = adminRegion
                cityInfoRow+=1;
                return cell
            } else {
                cityInfoRow+=1;
            }
        }
        if cityInfoRow == 3 {
            if let country = locations[0].country{
                Row.text = "Country"
                infoLabel.text = country
                cityInfoRow+=1;
                return cell
            } else {
                cityInfoRow+=1;
            }
        }
        if cityInfoRow == 4 {
            if let index = locations[0].index{
                Row.text = "Postal Code"
                infoLabel.text = index
                cityInfoRow+=1;
                return cell
            } else {
                cityInfoRow+=1;
            }
        }
        if cityInfoRow == 5 {
            if let coordinates = locations[0].coordinates{
                Row.text = "Coordinates"
                infoLabel.text = "la:\(coordinates.latitude), lo:\(coordinates.longitude)"
                return cell
            }
        }
        return cell
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//        hideCities(UITapGestureRecognizer())
//        guard let coordinate = locations[indexPath.row].coordinates else {
//            return
//        }
//        let previousAnnotations = self.mapView.annotations
//        if !previousAnnotations.isEmpty{
//          self.mapView.removeAnnotation(previousAnnotations[0])
//        }
//        let pin = MKPointAnnotation()
//        pin.coordinate = coordinate
//        mapView.addAnnotation(pin)
//        mapView.setRegion(MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.7, longitudeDelta: 0.7)), animated: true)
//    }
    
    
}
extension UITableView {

    func setMessage(_ message: String) {
        let lblMessage = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        lblMessage.text = message
        lblMessage.textColor = .gray
        lblMessage.numberOfLines = 0
        lblMessage.textAlignment = .center
        lblMessage.font = UIFont(name: "TrebuchetMS", size: 30)
        lblMessage.sizeToFit()

        self.backgroundView = lblMessage
        self.separatorStyle = .none
    }

    func clearBackground() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}

extension MapViewController: CLLocationManagerDelegate{
    
    func findMyLocation(){
        Manager.requestWhenInUseAuthorization()
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                self.Manager.delegate = self
                self.Manager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
                self.Manager.startUpdatingLocation()
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        location = locValue
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        Manager.stopUpdatingLocation()
        let previousAnnotations = self.mapView.annotations
        if !previousAnnotations.isEmpty{
          self.mapView.removeAnnotation(previousAnnotations[0])
        }
        let pin = MKPointAnnotation()
        pin.coordinate = location
        mapView.addAnnotation(pin)
        mapView.setRegion(MKCoordinateRegion(center: location, span: MKCoordinateSpan(latitudeDelta: 0.7, longitudeDelta: 0.7)), animated: true)
    }

}
