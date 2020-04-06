//
//  ViewController.swift
//  QWER-Hacks Project
//
//  Created by Adithya Nair on 1/25/20.
//  Copyright © 2020 Adithya Nair. All rights reserved.
//

import UIKit

var vSpinner: UIView?

class MainViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    
    let imagePicker = UIImagePickerController()
    var imageSelected = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func pictureButton(_ sender: UIButton) {
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func analyzeButton(_ sender: UIButton) {
        if imageSelected {
            self.performSegue(withIdentifier: "mainToResult", sender: self)
        } else {
            let alert = UIAlertController(title: "Uh-oh!", message: "You need to take a picture for us to analyze it!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Got it!", style: .default, handler: nil))
            
            self.present(alert, animated: true)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mainToResult" {
            let destinationVC = segue.destination as! ResultViewController
            destinationVC.image = imageView.image
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imagePicker.dismiss(animated: true, completion: nil)
        imageSelected = true
        imageView.image = info[.originalImage] as? UIImage
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        if imageSelected {
            imageSelected = true
        } else {
            imageSelected = false;
        }
        
        imagePicker.dismiss(animated: true, completion: nil)
    }

}
