//
//  HomeViewController.swift
//  Marmeto
//
//  Created by thincnext on 27/09/18.
//  Copyright © 2018 thincnext. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase
import Photos
import PhotosUI

class HomeViewController: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var sub: UIButton!
    @IBOutlet weak var location: UITextField!
    
    @IBOutlet weak var bottomLine4: UIView!
    @IBOutlet weak var bottomLine3: UIView!
    @IBOutlet weak var bottomLine2: UIView!
    @IBOutlet weak var bottomeLine1: UIView!
    @IBOutlet weak var locationLabl: UILabel!
    @IBOutlet weak var phoneLbl: UILabel!
    @IBOutlet weak var name: UITextField!
    
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var phone: UITextField!
    var localValue = UserDefaults()
    
    
    var datamodel1: DatabaseReference!
    
    
    override func viewDidLoad() {
        name.delegate = self
        phone.delegate = self
        address.delegate = self
        location.delegate = self
        
        nameLbl.isHidden = true
        phoneLbl.isHidden = true
        addressLbl.isHidden = true
        locationLabl.isHidden = true
        
        
        checkPermission()
        
        super.viewDidLoad()
        sub.layer.cornerRadius = 10
        
        datamodel1 = Database.database().reference().child("DataModel")
        
        
    }
    func checkPermission() {
        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        switch photoAuthorizationStatus {
        case .authorized:
            print("Access is granted by user")
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization({
                (newStatus) in
                print("status is \(newStatus)")
                if newStatus ==  PHAuthorizationStatus.authorized {
                    
                    print("success")
                }
            })
            print("It is not determined until now")
        case .restricted:
            
            print("User do not have access to photo album.")
        case .denied:
            
            print("User has denied the permission.")
        }
    }
    
    
    @IBAction func submit_btn_tapped(_ sender: Any) {
        
        if ((name.text?.isEmpty)! || (phone.text?.isEmpty)! || (location.text?.isEmpty)! || (address.text?.isEmpty)!){
            self.alert(message: "All fields are required to be filled!", title: "Alert")
        }else {
            getData()
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "abc") as! UINavigationController
            controller.title = "Dteail View"
            self.present(controller, animated: true, completion: nil)
        }
        
        
    }
    
    
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField == name {
            nameLbl.isHidden = true
            name.placeholder = "Name"
            bottomeLine1.backgroundColor = UIColor.darkGray
            
        }else if textField == phone {
            phoneLbl.isHidden = true
            phone.placeholder = "Phone"
            bottomLine2.backgroundColor = UIColor.darkGray
            
        }else if textField == address {
            addressLbl.isHidden = true
            address.placeholder = "Address"
            bottomLine3.backgroundColor = UIColor.darkGray
            
        }else if textField == location {
            locationLabl.isHidden = true
            location.placeholder = "Location"
            bottomLine4.backgroundColor = UIColor.darkGray
            
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == name {
            nameLbl.isHidden = false
            nameLbl.text = name.placeholder
            name.placeholder = ""
            bottomeLine1.backgroundColor = UIColor(red: 0/255, green: 144/255, blue: 81/255, alpha: 1.0)
            
        }else if textField == phone{
            phoneLbl.isHidden = false
            phoneLbl.text = phone.placeholder
            phone.placeholder = ""
            bottomLine2.backgroundColor = UIColor(red: 0/255, green: 144/255, blue: 81/255, alpha: 1.0)
            
        }else if textField == address{
            addressLbl.isHidden = false
            addressLbl.text = address.placeholder
            address.placeholder = ""
            bottomLine3.backgroundColor = UIColor(red: 0/255, green: 144/255, blue: 81/255, alpha: 1.0)
            
        }else if textField == location{
            locationLabl.isHidden = false
            locationLabl.text = location.placeholder
            location.placeholder = ""
            bottomLine4.backgroundColor = UIColor(red: 0/255, green: 144/255, blue: 81/255, alpha: 1.0)
            
        }
    }
    
    
    func getData(){
        
        let key = datamodel1.childByAutoId().key
        let artist = ["address": address.text! as String,
                      "location": location.text! as String,
                      "name": name.text! as String,
                      "phone": phone.text! as String
        ]
        
        
        datamodel1.child(key).setValue(artist)
        
        
        
    }
    func alert(message: String, title: String = "") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: {(action:UIAlertAction) in
        }));
        
        self.present(alertController, animated: true, completion: nil)
    }
    
}
