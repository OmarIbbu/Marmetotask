//
//  DetailViewController.swift
//  Marmeto
//
//  Created by thincnext on 27/09/18.
//  Copyright © 2018 thincnext. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import PhotosUI
import Photos

class DetailViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var emailLabel: UILabel!
    var dataRef: DatabaseReference!
    var dataList = [DataModel]()
    
    var localValue = UserDefaults()
    
    var imagePicker = UIImagePickerController()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData()
      let email  =   localValue.value(forKey: "email") as! String
        emailLabel.text = email 

    }
    

    @IBAction func backbtn_tapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "HomeView") as! HomeViewController
        self.present(controller, animated: true, completion: nil)
        
        
    }
    @IBAction func edit_btn_tapped(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            print("Button capture")
            
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum;
            imagePicker.allowsEditing = false
            
            self.present(imagePicker, animated: true, completion: nil)
        }

    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
       
        guard let image = info[UIImagePickerController.InfoKey.originalImage]  as? UIImage else {
            return
        }
        let data = image.pngData()
        localValue.set(data, forKey: "imageKey")
        imageView.image = image
        dismiss(animated:true, completion: nil) //5
    }
    
    
}

extension DetailViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let items = dataList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath) as! DetailTableViewCell
        cell.name.text = items.name
        cell.phone.text = items.phone
        cell.address.text = items.address
        cell.location.text = items.location
        
        return cell
    }
    
    func getData(){
        dataRef = Database.database().reference().child("DataModel");
        
        
        dataRef.observe(DataEventType.value, with: { (snapshot) in
            
            
            if snapshot.childrenCount > 0 {
                

                self.dataList.removeAll()
                
              
                for artists in snapshot.children.allObjects as! [DataSnapshot] {
                    //getting values
                    let artistObject = artists.value as? [String: AnyObject]
                    let address = artistObject?["address"] as! String
                    let location = artistObject?["location"] as! String
                    let name  = artistObject?["name"] as! String
                    let phone  = artistObject?["phone"] as! String
                    
                    
                    
                    let listItems = DataModel(name: name , phone: phone, location: location, address: address)
                    
                   
                    self.dataList.append(listItems)
                }
                
              
                self.tableView.reloadData()
            }
        })
    }
    
    
}
