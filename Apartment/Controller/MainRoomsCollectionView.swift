//
//  MainRoomsCollectionView.swift
//  Apartment
//
//  Created by Kittikawin Sontinarakul on 22/4/2563 BE.
//  Copyright © 2563 Kittikawin Sontinarakul. All rights reserved.
//

import UIKit

class MainRoomsCollectionView: UIViewController {
    
    var rooms: [Room] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let building = CurrentBuilding.building else { return }
        let predict = NSPredicate(format: "building == %@", building)
        rooms = DataController.taskLoadData(type: Room.self, search: predict)
    }
}

extension MainRoomsCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return rooms.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.ReuseCell.collectionReuseCell, for: indexPath) as! MainRoomsCollectionViewCell
        cell.textRoom.text = rooms[indexPath.row].roomnumber
        print(rooms[indexPath.row].customer?.name)
        if rooms[indexPath.row].customer == nil {
            cell.backgroundColor = .green
        } else {
            cell.backgroundColor = .lightGray
        }
        return cell
    }
    
//MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.size.width/3
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
