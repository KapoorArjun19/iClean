//
//  MainViewController.swift
//  iClean
//
//  Created by Arjun on 20/06/17.
//  Copyright © 2017 Arjun. All rights reserved.
//

import UIKit
import CoreLocation

class MainViewController: UIViewController, CLLocationManagerDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate
{

    var data = [UserRecord]()
    
    var locationManager: CLLocationManager!
    
    var latitude: String!
    
    var longitude: String!
    
    var imageLocalPath: String!
    
    @IBOutlet weak var name: UITextField!
    
    @IBOutlet weak var mobilenumber: UITextField!
    
    @IBOutlet weak var myImage: UIImageView!
    
    @IBOutlet weak var label: UILabel!
    
    @IBAction func send(_ sender: UIButton)
    {
        HasuraApi.addUser(name: name.text!, mobilenumber: mobilenumber.text!, latitude: latitude , longitude: longitude, image: imageLocalPath) { (response) in
            switch response.result {
            case .failure(let error):
                print(error)
                break
            case .success(let data):
                self.data.append(contentsOf: data.returning!)
                break
            }
        }
        if name.text == "" || mobilenumber.text == "" || mobilenumber.text?.characters.count != 10
        {
                label.text = "Enter Required Details"
        }
        else
        {
                performSegue(withIdentifier: "sendDetails", sender: self)
        }
    }
    
    @IBAction func pickImage(_ sender: UIButton)
    {
        let image = UIImagePickerController()
        
        image.delegate = self
        
        image.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        image.allowsEditing = false
        
        self.present(image, animated: true)
        {
            // After it is complete
        }

    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        myImage.image = image
            
        let imageUrl = info[UIImagePickerControllerReferenceURL] as? NSURL
        let imageName = imageUrl?.lastPathComponent
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let photoUrl = NSURL(fileURLWithPath: documentDirectory)
        let localPath = photoUrl.appendingPathComponent(imageName!)
        
        imageLocalPath = localPath?.absoluteString
        
        if !FileManager.default.fileExists(atPath: localPath!.path)
            {
                do {
                    try UIImageJPEGRepresentation(image!, 1.0)?.write(to: localPath!)
                    print("File Saved")
                    //print(localPath!)
                } catch {
                    print("Error Saving File")
                }
            }
            else
            {
                print("File Already Exists")
                //print(localPath!)
            }
        
        self.dismiss(animated: true, completion: nil)
    }

    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        determineMyCurrentLocation()
    }
    
    func determineMyCurrentLocation()
    {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled()
        {
            locationManager.startUpdatingLocation()
            //locationManager.startUpdatingHeading()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let userLocation:CLLocation = locations[0] as CLLocation
        // Call stopUpdatingLocation() to stop listening for location updates,
        // other wise this function will be called every time when user location changes.
        
        manager.stopUpdatingLocation()
        
        //print("user latitude = \(userLocation.coordinate.latitude)")
        //print("user longitude = \(userLocation.coordinate.longitude)")
        
        latitude = (String)(userLocation.coordinate.latitude)
        longitude = (String)(userLocation.coordinate.longitude)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Error: \(error)")
    }
}

