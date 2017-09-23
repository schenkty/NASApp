//
//  ImageViewController.swift
//  NASApp
//
//  Created by Ty Schenk on 9/20/17.
//  Copyright © 2017 Ty Schenk. All rights reserved.
//

import UIKit
import iOSPhotoEditor

class ImageViewController: UIViewController, PhotoEditorDelegate {
    
    var image: UIImage?
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // update the image
        self.imageView.image = image!
    }
    
    @IBAction func editImage(_ sender: UIButton) {
        guard let image = imageView.image else { return }
        let photoEditor = PhotoEditorViewController(nibName:"PhotoEditorViewController",bundle: Bundle(for: PhotoEditorViewController.self))
        
        // PhotoEditorDelegate
        photoEditor.photoEditorDelegate = self
        
        // The image to be edited
        photoEditor.image = image
        
        // hiding sticker button because it has no use right now
        photoEditor.hiddenControls = [.sticker]
        
        // Present the View Controller
        present(photoEditor, animated: true, completion: nil)
    }
    
    func doneEditing(image: UIImage) {
        
    }
    
    func canceledEditing() {
        print("Canceled")
    }
}
