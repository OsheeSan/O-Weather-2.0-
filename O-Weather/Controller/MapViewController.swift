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

    
    @IBOutlet weak var SearchBar: UISearchBar!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var CitiesTableView: CitiesTableView!
    
    let blurredEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    
    var locations = [Location]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .dark
        }
        mapView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideCities)))
        mapView.mapType = .hybridFlyover
        blurredEffectView.frame = view.bounds
        blurredEffectView.alpha = 0
        mapView.addSubview(blurredEffectView)
        navigationController?.isNavigationBarHidden = true
    }
    
    @objc func hideCities(_ sender: UITapGestureRecognizer){
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, animations: {
            self.CitiesTableView?.alpha = 0
            self.blurredEffectView.alpha = 0
        })
        SearchBar.endEditing(true)
    }
    
    
    
    func showCities(){
        if CitiesTableView?.alpha != 1{
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, animations: {
                self.CitiesTableView?.alpha = 1
                self.blurredEffectView.alpha = 1
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
                }
            }
        } else {
            self.locations = [Location]()
        }
        CitiesTableView.reloadData()
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
            } else {
                tableView.clearBackground()
            }
        return locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        let label = cell.viewWithTag(1) as! UILabel
        label.text = locations[indexPath.row].title
        label.numberOfLines = 0
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        hideCities(UITapGestureRecognizer())
        guard let coordinate = locations[indexPath.row].coordinates else {
            return
        }
        let previousAnnotations = self.mapView.annotations
        if !previousAnnotations.isEmpty{
          self.mapView.removeAnnotation(previousAnnotations[0])
        }
        let pin = MKPointAnnotation()
        pin.coordinate = coordinate
        mapView.addAnnotation(pin)
        mapView.setRegion(MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.7, longitudeDelta: 0.7)), animated: true)
    }
    
    
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
