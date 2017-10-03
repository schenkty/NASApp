//
//  DailyTableViewController.swift
//  NASApp
//
//  Created by Ty Schenk on 9/20/17.
//  Copyright © 2017 Ty Schenk. All rights reserved.
//

import UIKit
import Alamofire
import iOSPhotoEditor

class DailyTableViewController: UITableViewController, PhotoEditorDelegate {
    
    var daily: Daily?

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var explanationLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
    }
    
    func setLayout() {
        self.titleLabel.text = daily?.title
        self.imageView.image = daily?.image
        self.explanationLabel.text = daily?.explanation
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

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    
    // Photo Editor Delegate Methods
    func doneEditing(image: UIImage) {
        // really have no use for this spot right now but would like to setup some sort of save function that happens when the image is done editing
    }
    
    func canceledEditing() {
        print("Image Edit Canceled")
    }

}
