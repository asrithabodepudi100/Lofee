//
//  SubscribeToPremiumViewController.swift
//  Lofee
//
//  Created by 65,115,114,105,116,104,98 on 10/8/20.
//  Copyright © 2020 Asritha Bodepudi. All rights reserved.
//

import UIKit
import StoreKit
import SystemConfiguration

class SubscribeToPremiumViewController: UIViewController, SKPaymentTransactionObserver {
    let defaults = UserDefaults(suiteName: "group.com.Tonnelier.Lofee")

    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            if transaction.transactionState == .purchased{
                //User payment successful
                defaults?.set(true, forKey: "isPremium")
                //when month expires, make sure defaults change 
                print ("Transaction successful")
            }
            else if transaction.transactionState == .failed{
                //Payment Failed
                print ("Transaction failed")
                
            }
        }
        
    }
    
    @IBOutlet weak var startSubscriptionButton: UIButton!
    @IBOutlet weak var describeLabel: UILabel!
    
    
    let productID = "RemoveAds"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        describeLabel.sizeToFit()
        describeLabel.adjustsFontSizeToFitWidth = true
        describeLabel.textAlignment = .center
        startSubscriptionButton.layer.cornerRadius = 18
        // Do any additional setup after loading the view.
        SKPaymentQueue.default().add(self)
        
    }
    @IBAction func purchaseButtonPressed(_ sender: UIButton) {
        if SKPaymentQueue.canMakePayments(){
            let paymentRequest = SKMutablePayment()
            paymentRequest.productIdentifier = productID
            SKPaymentQueue.default().add(paymentRequest)
        }
        else{
            
        }
    }
}
