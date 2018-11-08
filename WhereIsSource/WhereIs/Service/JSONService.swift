//
//  JSONService.swift
//  WhereIs
//
//  Created by Glny Gl on 28.10.2018.
//  Copyright © 2018 Glny Gl. All rights reserved.
//

import Foundation
import Alamofire
class JSONServise: NSObject {
    
    static func getJSON(_ city: String, _ query: String, success:@escaping (PlaceModel) -> Void, failure: @escaping (String) -> Void)  {
        
        let baseURL = "https://api.foursquare.com/v2/venues/explore"
        let clientID = "JZ2LCCN0GZDOSZ2PTOI4WRGFLULVXEEL1M4DWHSTZ14UXI1R"
        let clientSecret = "NSK2E43XD5F4FK2GD0VXNLVZYTGIFFAQFHAY2HXWP2P2HXD0"
        let URL = "\(baseURL)?near=\(city)&query=\(query)&venuePhotos=1&client_id=\(clientID)&client_secret=\(clientSecret)&v=20150214"
        
        var placeModel: PlaceModel?
        
        Alamofire.request(URL).responseJSON { (response) -> Void in
            if response.result.isFailure {
                print("Error")
            } else {
                guard let data = response.data else { return }
                do {
                    let decoder = JSONDecoder()
                    let jData = try decoder.decode(PlaceModel.self, from: data)
                    placeModel = jData
                    success(placeModel!)
                } catch let err {
                    print("Err", err)
                }
            }
        }
    }
    
    static func getImageJSON(_ venueId: String, success:@escaping (PhotoModel) -> Void, failure: @escaping (String) -> Void)  {
        
        let clientID = "JZ2LCCN0GZDOSZ2PTOI4WRGFLULVXEEL1M4DWHSTZ14UXI1R"
        let clientSecret = "NSK2E43XD5F4FK2GD0VXNLVZYTGIFFAQFHAY2HXWP2P2HXD0"
        let URL = "https://api.foursquare.com/v2/venues/\(venueId)/photos?limit=1&client_id=\(clientID)&client_secret=\(clientSecret)&v=20161107"
        
        print(URL)
        
        var photoModel: PhotoModel?
        
        Alamofire.request(URL).responseJSON { (response) -> Void in
            if response.result.isFailure {
                print("Error")
            } else {
                guard let data = response.data else { return }
                do {
                    let decoder = JSONDecoder()
                    let jData = try decoder.decode(PhotoModel.self, from: data)
                    photoModel = jData
                    success(photoModel!)
                } catch let err {
                    print("Err", err)
                }
            }
        }
    }
}
