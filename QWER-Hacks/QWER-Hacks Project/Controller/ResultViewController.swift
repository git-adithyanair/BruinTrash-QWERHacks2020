//
//  ResultViewController.swift
//  QWER-Hacks Project
//
//  Created by Adithya Nair on 1/25/20.
//  Copyright © 2020 Adithya Nair. All rights reserved.
//

import UIKit
import AVKit
import Firebase

class ResultViewController: UIViewController {
    
    @IBOutlet weak var labelOne: UILabel!
    @IBOutlet weak var outputLabel: UILabel!
    @IBOutlet weak var labelTwo: UILabel!
    
    let db = Firestore.firestore()
    
    var image: UIImage?
    var labelTextArray: [String] = []
    var entityIdArray: [String] = []
    var confidenceArray: [NSNumber] = []
    var recycle: [String] = []
    var landfill: [String] = []
    var compost: [String] = []
    var trashType = "Sorry, we couldn't detect anything! Why don't you try again?"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        
        labelTwo.isHidden = true
        
        let visionImage = VisionImage(image: image!)
        let labeler = Vision.vision().cloudImageLabeler()
        
        labeler.process(visionImage) { labels, error in
            guard error == nil, let labels = labels else {
                print(error!.localizedDescription)
                return
            }

            // Task succeeded.
            for label in labels {
                let labelText = label.text
                let entityId = label.entityID
                let confidence = label.confidence
                self.labelTextArray.append(labelText)
                self.entityIdArray.append(entityId!)
                self.confidenceArray.append(confidence!)
            }
            
            // Adding to recycle array.
            let docRefRecycle = self.db.collection("Trash").document("recycle")
            docRefRecycle.getDocument { (document, error) in
                if let document = document, document.exists {
                    self.recycle = document.data()!["recycleItems"] as! [String]
                }
                
                // Adding to landfill array.
                let docRefLandfill = self.db.collection("Trash").document("landfill")
                docRefLandfill.getDocument { (document, error) in
                    if let document = document, document.exists {
                        self.landfill = document.data()!["landfillItems"] as! [String]
                    }
                    
                    // Adding to compost array.
                    let docRefCompost = self.db.collection("Trash").document("compost")
                    docRefCompost.getDocument { (document, error) in
                        if let document = document, document.exists {
                            self.compost = document.data()!["compostItems"] as! [String]
                        }
                        
                        print(self.recycle)
                        print(self.compost)
                        print(self.landfill)
                        
                        let labelTextArrayLowercased = self.labelTextArray.map {$0.lowercased()}
                        let recycleLowercased = self.recycle.map {$0.lowercased()}
                        let compostLowercased = self.compost.map {$0.lowercased()}
                        let landfillLowercased = self.landfill.map {$0.lowercased()}
                        
                        print(labelTextArrayLowercased)
                        
                        for label in labelTextArrayLowercased {
                            if compostLowercased.contains(label) {
                                self.trashType = "compost"
                                break
                            }
                        }
                        
                        for label in labelTextArrayLowercased {
                            if recycleLowercased.contains(label) {
                                self.trashType = "recycle"
                                break
                            }
                        }
                        
                        for label in labelTextArrayLowercased {
                            if landfillLowercased.contains(label) {
                                self.trashType = "landfill"
                                break
                            }
                        }
                        
                        self.labelTwo.isHidden = false
                        
                        switch self.trashType {
                        case "recycle":
                            self.outputLabel.text = "Recycling"
                            self.view.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
                        case "compost":
                            self.outputLabel.text = "Compost"
                            self.view.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
                            self.labelOne.textColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
                            self.labelTwo.textColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
                            self.outputLabel.textColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
                        case "landfill":
                            self.outputLabel.text = "Landfill"
                            self.view.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
                            self.labelOne.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                            self.labelTwo.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                            self.outputLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                        default:
                            self.outputLabel.text = "something we couldn't detect!"
                            self.view.backgroundColor = #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)
                            self.labelOne.textColor = #colorLiteral(red: 0.3098039329, green: 0.2039215714, blue: 0.03921568766, alpha: 1)
                            self.labelTwo.textColor = #colorLiteral(red: 0.3098039329, green: 0.2039215714, blue: 0.03921568766, alpha: 1)
                            self.outputLabel.textColor = #colorLiteral(red: 0.3098039329, green: 0.2039215714, blue: 0.03921568766, alpha: 1)
                        }
                        
                    }
                    
                }
                
            }
            
        }
        
    }
    
}
