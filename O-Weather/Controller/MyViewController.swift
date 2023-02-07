//
//  MyViewController.swift
//  O-Weather
//
//  Created by admin on 06.02.2023.
//

import UIKit

class MyViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

}

extension MyViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PlacesCollectionViewCell
        cell.bounds = CGRect(x: 10, y: 0, width: Int(collectionView.viewWidth)-20, height: 200)
        return cell
    }
    
    
}
