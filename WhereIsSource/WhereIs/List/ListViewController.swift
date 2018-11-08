//
//  ListViewController.swift
//  WhereIs
//
//  Created by Glny Gl on 28.10.2018.
//  Copyright © 2018 Glny Gl. All rights reserved.
//

import UIKit
import SVProgressHUD

class ListViewController: BaseViewController {
    
    @IBOutlet weak var listTableView: UITableView!
    
    var city = ""
    var place = ""
    var model: PlaceModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.listTableView.delegate = self
        self.listTableView.dataSource = self
        
        SVProgressHUD.show()
        JSONServise.getJSON(self.city, self.place, success: { (responseData) in
            self.model = responseData
            self.listTableView.reloadData()
            SVProgressHUD.dismiss()
        }) { (error) in
            print(error)
        }
    }
}

extension ListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model?.response?.groups?.first?.items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell", for: indexPath) as! ListTableViewCell
        
        if let placeResult = self.model?.response?.groups?.first?.items?[indexPath.row]{
            guard let name  = placeResult.venue?.name,
                let location = placeResult.venue?.location?.city ?? placeResult.venue?.location?.country,
                let people = placeResult.venue?.hereNow?.count else { return UITableViewCell()}
            
            cell.placeNameLabel.text = name
            cell.placeLocationLabel.text = location
            cell.peopleCountLabel.text = people.toString()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let mainStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
        let popViewController = mainStoryboard.instantiateViewController(withIdentifier: "PopUpViewController") as! PopUpViewController
        
        if let placeResult = self.model?.response?.groups?.first?.items?[indexPath.row]{
            popViewController.venueId  = placeResult.venue?.id
            popViewController.lat = placeResult.venue?.location?.lat
            popViewController.lng = placeResult.venue?.location?.lng
        }
        
        self.present(popViewController, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let navBarHeight = view.safeAreaInsets.top
        let bottomBarHeight = view.safeAreaInsets.bottom
        let barHeight = navBarHeight + bottomBarHeight
        let heightSize = (UIScreen.main.bounds.height - barHeight) / 7.2
        return heightSize
    }
}

extension Int
{
    func toString() -> String
    {
        return String(self)
    }
}
