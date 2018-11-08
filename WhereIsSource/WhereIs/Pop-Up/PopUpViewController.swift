//
//  PopUpViewController.swift
//  WhereIs
//
//  Created by Glny Gl on 28.10.2018.
//  Copyright © 2018 Glny Gl. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import AlamofireImage
import SVProgressHUD

class CustomPin: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?

    init(_ pinTitle:String, _ pinSubTitle:String, _ location:CLLocationCoordinate2D) {
        self.title = pinTitle
        self.subtitle = pinSubTitle
        self.coordinate = location
    }
}

class PopUpViewController: UIViewController{
    
    @IBOutlet weak var locationMapView: MKMapView!
    @IBOutlet weak var placeImageView: UIImageView!
    @IBOutlet weak var backgroundView: UIView!
    
    var venueId: String?
    var lat, lng: Double?
    var photo: PhotoModel?
    let regionRadius: CLLocationDistance = 1000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let initialLocation = CLLocation(latitude: self.lat ?? 0.0, longitude: self.lng ?? 0.0)
        
        SVProgressHUD.show()
        JSONServise.getImageJSON(self.venueId!, success: { (responseData) in
           self.photo = responseData
            guard let prefix  = self.photo?.response?.photos?.items?.first?.prefix,
                let suffix = self.photo?.response?.photos?.items?.first?.suffix else { return}
           let link = prefix + "300x200" + suffix
           self.placeImageView.af_setImage(withURL: URL(string: link)!)
           self.pinCoordinate()
           self.zoomOnMap(initialLocation)
            SVProgressHUD.dismiss()
        }) { (error) in
            print(error)
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.hidePopUp))
        tapGesture.cancelsTouchesInView = false
        self.backgroundView.addGestureRecognizer(tapGesture)
    }
    
    func pinCoordinate() {
        let pin = MKPointAnnotation()
        pin.coordinate = CLLocationCoordinate2D(latitude: self.lat ?? 0.0, longitude: self.lng ?? 0.0)
        locationMapView.addAnnotation(pin)
    }
    
    @objc func hidePopUp(){
        SVProgressHUD.dismiss()
        dismiss(animated: true, completion: nil)
    }
    
    @objc func zoomOnMap(_ location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, self.regionRadius * 2.0, self.regionRadius * 2.0)
        locationMapView.setRegion(coordinateRegion, animated: true)
    }
}

