//
//  MainScreenViewController.swift
//  SnapChat
//
//  Created by Xiaohao Li on 2017/5/16.
//  Copyright © 2017年 Xiaohao Li. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class AddSnapViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .lightGray
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFit
        return iv
        
        
        
    }()
    
    let textField: UITextField = {
        let tf = UITextField()
        tf.font = UIFont.boldSystemFont(ofSize: 14)
        tf.placeholder = "Descriptions"
//        tf.textAlignment = .center
        tf.borderStyle = .roundedRect
        return tf
        
    }()
    
    let nextButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Next", for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        btn.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        return btn
        
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(handleCamera))
        
        view.addSubview(imageView)
        imageView.anchor(top: topLayoutGuide.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 20, paddingLeft: 30, paddingBottom: 0, paddingRight: 30, width: 0, height: 200)
        
        view.addSubview(textField)
        textField.anchor(top: imageView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 10, paddingLeft: 30, paddingBottom: 0, paddingRight: 30, width: 0, height: 0)
        
        view.addSubview(nextButton)
        nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nextButton.anchor(top: textField.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
    }
    
    
    
    func handleCamera() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        // enable zoom image
        imagePickerController.allowsEditing = true
        present(imagePickerController, animated: true, completion: nil)
    }
    
    // to get the image user picked
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            imageView.image = editedImage
            imageView.backgroundColor = .clear
        } else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            imageView.image = originalImage
            imageView.backgroundColor = .clear
        }
        
      
        
        dismiss(animated: true, completion: nil)
        
        
    }
    
    func handleNext() {
        
        guard let image = imageView.image else { return }
        guard let imageData = UIImageJPEGRepresentation(image, 0.1) else { return }
        
        nextButton.isEnabled = false
        
        let imagesFolder = FIRStorage.storage().reference().child("images")
        
        imagesFolder.child("\(NSUUID().uuidString).jpg").put(imageData, metadata: nil) { (metaData, err) in
         
            if let error = err {
                print(error)
                return
            }
            print(metaData?.downloadURLs)
            self.nextButton.isEnabled = true
            self.navigationController?.pushViewController(SelectUserTableViewController(), animated: true)

        }
        
        
    }
    
}

