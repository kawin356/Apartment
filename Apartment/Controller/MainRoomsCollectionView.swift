//
//  MainRoomsCollectionView.swift
//  Apartment
//
//  Created by Kittikawin Sontinarakul on 22/4/2563 BE.
//  Copyright © 2563 Kittikawin Sontinarakul. All rights reserved.
//

import UIKit

class MainRoomsCollectionView: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

extension MainRoomsCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.ReuseCell.collectionReuseCell, for: indexPath) as! MainRoomsCollectionViewCell
        cell.textRoom.text = String(indexPath.row)
        
        return cell
    }
    
    
}
