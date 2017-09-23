//
//  MarsPhotoCollectionViewController.swift
//  NASApp
//
//  Created by Ty Schenk on 9/20/17.
//  Copyright © 2017 Ty Schenk. All rights reserved.
//

import UIKit

private let reuseIdentifier = "roverItem"

class MarsPhotoCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    // keep track of what rover you selected
    var selectedRover: Rover?
    
    // keep track of all the items for your current rover
    var roverItems: [RoverItem]? {
        didSet {
            self.pullImages()
        }
    }
    
    var images: [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "\(selectedRover!.rawValue.capitalized)'s photos"
    }

    // function that pulls the images from the web for each rover item
    func pullImages() {
        for item in self.roverItems! {
            getImage(withURL: item.imageURL , withID: item.id)
        }
    }
    
    // function to pull the image for one rover item
    func getImage(withURL url: String, withID id:String) {
        if let cachedImage = imageCache.image(for: URLRequest(url: URL(string: url)!), withIdentifier: id) {
            self.images.append(cachedImage)
            self.collectionView?.reloadData()
        } else {
            NetworkManager.pullImage(url: url, withIdentifier: id, completion: { image in
                imageCache.add(image, for: URLRequest(url: URL(string: url)!), withIdentifier: id)
                self.images.append(image)
                self.collectionView?.reloadData()
            })
        }
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! RoverItemCollectionViewCell
    
    
        cell.imageView.image = images[indexPath.row]
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (self.view.frame.width/3)-5
        return CGSize(width: size, height: size)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showImage" {
            if let indexPath = self.collectionView?.indexPathsForSelectedItems {
                if let nextVC = segue.destination as? ImageViewController {
                    let index = indexPath[0]
                    nextVC.image = self.images[index.row]
                }
            }
        }
    }
}
