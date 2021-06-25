//
//  NotecardSetsTableViewController.swift
//  Design
//
//  Created by 65,115,114,105,116,104,98 on 8/12/20.
//  Copyright © 2020 Asritha Bodepudi. All rights reserved.
//

import StoreKit
import UIKit
import UserNotifications
import RealmSwift
import GoogleMobileAds


class NotecardSetsTableViewController: UITableViewController, GADRewardedAdDelegate {
//Variables
   
    let realm = try! Realm()
    var notecardSets: Results<Set>?
    var notecardSetImages: [UIImage] = []
    let viewNotecardSetViewControllerObject = ViewNotecardSetViewController()
    var rewardedAd: GADRewardedAd?

    @IBOutlet weak var createNewSetButton: UIButton!
    
//View Hseirarchy Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "NotecardSetCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "NotecardSetCell")
        if notecardSets?.count ?? 0 == 2 || notecardSets?.count ?? 0 == 5 || notecardSets?.count ?? 0 == 10{
         //   AppStoreReviewManager.requestReviewIfAppropriate()
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
        notecardSets = realm.objects(Set.self)
        tableView.reloadData()
        configureAppearance()
    }

    //Segue Methods
    func rewardedAd(_ rewardedAd: GADRewardedAd, userDidEarn reward: GADAdReward) {
          performSegue(withIdentifier: "goToNewSetViewController", sender: send)
    }
    @IBAction func newSetButtonPressed(_ sender: UIButton) {
        if notecardSets != nil{
            if notecardSets!.count > 2 && notecardSets!.count % 2 != 0{
                let alertController = UIAlertController(title: "Watch ad to continue", message: "", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                    UIAlertAction in
                    self.rewardedAd = GADRewardedAd(adUnitID: "ca-app-pub-1093493132842059/8505211831")
                    
                    self.rewardedAd = GADRewardedAd(adUnitID: "ca-app-pub-1093493132842059/8505211831")
                    self.rewardedAd?.load(GADRequest()) { error in
                        if error != nil {
                            // Handle ad failed to load case.
                        } else {
                            if self.rewardedAd?.isReady == true {
                                self.rewardedAd?.present(fromRootViewController: self, delegate:self)
                            }
                        }
                    }
                }
                let cancelAction = UIAlertAction(title: "Back", style: UIAlertAction.Style.cancel) {
                    UIAlertAction in
                    print ("Back")
                }
                alertController.addAction(okAction)
                alertController.addAction(cancelAction)
                self.present(alertController, animated: true, completion: nil)
            }
            else {
                performSegue(withIdentifier: "goToNewSetViewController", sender: send)
            }
        }
    }
    
    @IBAction func unwindToViewControllerA(segue: UIStoryboardSegue) {
        DispatchQueue.global(qos: .userInitiated).async {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "goToViewNotecardSet"){
            let destinationVC = segue.destination as! ViewNotecardSetViewController
            if let indexPath = tableView.indexPathForSelectedRow{
                destinationVC.selectedNotecardSet = notecardSets?[indexPath.row]
            }
        }
    }
    
//Appearance Methods
    func configureAppearance(){
        tabBarController?.tabBar.backgroundColor = #colorLiteral(red: 0.9684234262, green: 0.9680920243, blue: 1, alpha: 1)
        
        //Table View Appearance
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        self.tableView.backgroundColor = UIColor(red: 0.97, green: 0.97, blue: 1.00, alpha: 1.00)
        
        //Navigation Bar Appearance
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = UIColor(red: 0.97, green: 0.97, blue: 1.00, alpha: 1.00)
        navBarAppearance.shadowColor = .clear
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        
        //Navigation Bar Items
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Notecard Sets"
        label.textColor = UIColor(red: 0.12, green: 0.22, blue: 0.47, alpha: 1.00)
        label.font = UIFont(descriptor: UIFontDescriptor(name: "Avenir Next Bold", size: 25), size: 25)
        navigationItem.titleView = label
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: Any?.self, action: nil)
        
        //CreateNewSetButton Appearnace
        createNewSetButton.layer.cornerRadius = 18
    }
}
