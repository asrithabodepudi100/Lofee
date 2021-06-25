//
//  ProgressViewController.swift
//  Design
//
//  Created by 65,115,114,105,116,104,98 on 8/12/20.
//  Copyright © 2020 Asritha Bodepudi. All rights reserved.
//
import UIKit
import RealmSwift
import GoogleMobileAds
 class ProgressViewController: UIViewController {
     let realm = try! Realm()
     var allSets: Results<Set>?
     var inital: CGFloat!
     
     let defaults = UserDefaults(suiteName: "group.com.Tonnelier.Lofee")
     @IBOutlet weak var circleProgress: CircleProgressBarView!
     @IBOutlet weak var seeQuestionsAnsweredCorrectlyButton: UIButton!
     @IBOutlet weak var bannerView: GADBannerView!
     @IBOutlet weak var menuTableView: UITableView!
     @IBOutlet weak var menuView: UIView!
     @IBOutlet weak var transparentView: UIView!
     
     override func viewDidLoad() {
         super.viewDidLoad()
         seeQuestionsAnsweredCorrectlyButton.layer.cornerRadius = 18
         self.inital = self.menuView.frame.origin.x
         
         transparentView.isUserInteractionEnabled = false
         transparentView.backgroundColor = UIColor.clear
         menuView.layer.cornerRadius = 30
         
         let nib = UINib(nibName: "MenuTableViewCell", bundle:
             nil)
         self.menuTableView.register(nib, forCellReuseIdentifier: "MenuTableViewCell")
         self.menuTableView.tableFooterView = UIView()
         self.menuTableView.dataSource = self
         self.menuTableView.delegate = self
         self.menuTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
       
     
         let gesture = UITapGestureRecognizer(target: self, action: #selector(self.someAction(_:)))
         // or for swift 2 +
         _ = UITapGestureRecognizer(target: self, action:  #selector (self.someAction (_:)))
         self.transparentView.addGestureRecognizer(gesture)
     }
     
     @objc func someAction(_ sender:UITapGestureRecognizer){
         UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
             self.menuView.frame.origin.x = self.inital
         } completion: { _ in ()
             
         }
         transparentView.isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.3) {
            self.transparentView.backgroundColor = UIColor.clear
         }

     }
     override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(true)
         //Banner View
         if defaults?.bool(forKey: "premium") == false{
             bannerView.rootViewController = self
             bannerView.adUnitID = "ca-app-pub-1093493132842059~4613068867"
             bannerView.load(GADRequest())
         }
         transparentView.isUserInteractionEnabled = false
         transparentView.backgroundColor = UIColor.clear
         tabBarController?.tabBar.backgroundColor =  UIColor.clear
         allSets = realm.objects(Set.self)
         circleProgress.setNeedsDisplay()
         if let count = defaults?.integer(forKey: "setToStudyCount"){
             if let selectedSet = defaults?.object(forKey: "questionArray"){
                 let set:[String] = selectedSet as! [String]
                 seeQuestionsAnsweredCorrectlyButton.setTitle( "\(String((Int(count - set.count)))) Questions Answered Correctly", for: .normal)
             }
             else{
                 seeQuestionsAnsweredCorrectlyButton.setTitle("See Questions Answered Correctly", for: .normal)
             }
         }
         
       
     }
     
     
     
     
     //MARK: - Menu Methods
     @IBAction func xButtonPressed(_ sender: UIButton) {
         UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
             self.menuView.frame.origin.x = self.inital
         } completion: { _ in ()
             
         }
         transparentView.isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.3) {
            self.transparentView.backgroundColor = UIColor.clear
         }
     }
     @IBAction func openMenuButtonPressed(_ sender: UIButton) {
       
        
         self.menuView.alpha = 1
        UIView.animate(withDuration: 0.3) {
            self.transparentView.backgroundColor = UIColor.black
            self.transparentView.alpha = 0.5
         }
         transparentView.isUserInteractionEnabled = true

        
          UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
              self.menuView.frame.origin.x = self.view.frame.origin.x
          } completion: { _ in ()
               
        }
         tabBarController?.tabBar.backgroundColor = UIColor.clear
         
     }
     
    
 }




 //MARK: - Table View Methods

 extension ProgressViewController: UITableViewDelegate, UITableViewDataSource {
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 3
   }
   
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell", for: indexPath) as! MenuTableViewCell
         //Help Center
         if indexPath.row == 0{
             cell.iconImageView.image = UIImage(systemName: "questionmark.circle.fill")
             cell.titleLabel.text = "Help Center"
         }
         //About us/ Contact
         else if indexPath.row == 1{
             cell.iconImageView.image = UIImage(systemName: "info.circle.fill")
             cell.titleLabel.text = "About Us/ Contact"
         }
         //Lofee Study Premium an
         else {
             cell.iconImageView.image =  UIImage(systemName: "checkmark.seal.fill")
             cell.titleLabel.text = "Lofee Study Premium"
         }
         return cell
     }
     
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         print (indexPath.row)
         if indexPath.row == 1{
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "AboutUsContact") as! AboutUsContactViewController
            self.present(newViewController, animated: false, completion: nil)
        }
     }
 }


