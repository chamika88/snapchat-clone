//
//  PictureViewController.swift
//  firebase test
//
//  Created by Chamikara Dharmasena on 9/18/16.
//  Copyright © 2016 Chamikara Dharmasena. All rights reserved.
//

import UIKit
import Firebase

class PictureViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet weak var imageview: UIImageView!
    
    @IBOutlet weak var descTextField: UITextField!

    @IBOutlet weak var nextButton: UIButton!
    
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
       
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        imageview.image = image
        
        imageview.backgroundColor = UIColor.clear
        
        imagePicker.dismiss(animated: true, completion: nil)
    }


    @IBAction func nextBtnTapped(_ sender: AnyObject) {
        
        nextButton.isEnabled = false
        
        let imageFolder = FIRStorage.storage().reference().child("images")
        
        let imageData = UIImageJPEGRepresentation(imageview.image!, 0.1)!
        
        
        
        
        imageFolder.child("\(NSUUID().uuidString).jpg").put(imageData, metadata: nil) { (metadata, error) in
            print("we tried to upload")
            if error != nil {
                print("error occured\(error)")
            } else {
                print(metadata?.downloadURL())
                
                self.performSegue(withIdentifier: "selectUsersegue", sender: metadata?.downloadURL()!.absoluteString)
            }
        }

        
    }
    
    @IBAction func cameraTapped(_ sender: AnyObject) {
        
        imagePicker.sourceType = .savedPhotosAlbum
        imagePicker.allowsEditing = false
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let nextVC = segue.destination as! SelectUserViewController
        nextVC.imageURL =  sender as! String
        nextVC.desc = descTextField.text!
    }

    
}
