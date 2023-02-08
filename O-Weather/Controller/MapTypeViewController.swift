//
//  MapTypeViewController.swift
//  O-Weather
//
//  Created by admin on 08.02.2023.
//

import UIKit

class MapTypeViewController: UIViewController {
    
    var delegate = MapViewController()
    
    var isGlobe = false
    var isRealistic = false
    
    @IBOutlet weak var OKButton: UIButton!
    @IBOutlet weak var GlobeView: UIView!
    @IBOutlet weak var RealisticView: UIView!
    @IBOutlet weak var GlobeSwitch: UISwitch!
    @IBOutlet weak var RealisticSwitch: UISwitch!
    
    @IBAction func GlobeChanged(_ sender: UISwitch) {
        isGlobe = sender.isOn
    }
    
    @IBAction func RealisticChanged(_ sender: UISwitch) {
        isRealistic = sender.isOn
        if isRealistic {
            GlobeSwitch.isEnabled = true
        } else {
            GlobeSwitch.isEnabled = false
            GlobeSwitch.isOn = false
            isGlobe = false
        }
    }
    
    @IBAction func SaveButton(_ sender: UIButton) {
        delegate.isRealistic = self.isRealistic
        delegate.isGlobe = self.isGlobe
        if isRealistic && isGlobe {
            delegate.mapView.mapType = .hybridFlyover
        } else if isRealistic {
            delegate.mapView.mapType = .hybrid
        } else {
            delegate.mapView.mapType = .standard
        }
        self.dismiss(animated: true)
    }
    
    let blurredEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        blurredEffectView.frame = view.bounds
        view.addSubview(blurredEffectView)
        setupOKButton()
        setupSwitchViews()
        setupSwithes()
    }
    
    
    func setupSwithes(){
        if isRealistic {
            RealisticSwitch.isOn = true
            GlobeSwitch.isEnabled = true
            if isGlobe{
                GlobeSwitch.isOn = true
            } else {
                GlobeSwitch.isOn = false
            }
        } else {
            RealisticSwitch.isOn = false
            GlobeSwitch.isOn = false
            GlobeSwitch.isEnabled = false
        }
    }
    
    func setupSwitchViews(){
        view.addSubview(GlobeView)
        view.addSubview(RealisticView)
        view.addSubview(view.viewWithTag(1)!)
        GlobeView.clipsToBounds = true
        GlobeView.layer.cornerRadius = GlobeView.frame.height/2
        GlobeView.backgroundColor = UIColor(cgColor: CGColor(red: 0, green: 0, blue: 0, alpha: 0.8))
        RealisticView.clipsToBounds = true
        RealisticView.layer.cornerRadius = RealisticView.frame.height/2
        RealisticView.backgroundColor = UIColor(cgColor: CGColor(red: 0, green: 0, blue: 0, alpha: 0.8))
    }
    
    func setupOKButton(){
        view.addSubview(OKButton)
        OKButton.clipsToBounds = true
        OKButton.layer.cornerRadius = OKButton.frame.height/2
        OKButton.backgroundColor = UIColor(cgColor: CGColor(red: 0, green: 0, blue: 0, alpha: 0.8))
    }

}
