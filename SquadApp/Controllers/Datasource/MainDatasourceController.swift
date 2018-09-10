//
//  MainDatasourceController.swift
//  SquadApp
//
//  Created by Mauricio Takashi Kiyama on 4/12/18.
//  Copyright © 2018 Marcio Kazuo Kiyama. All rights reserved.
//


import LBTAComponents
import CoreData
import GoogleMobileAds
import SwiftyStoreKit

// MAIN DATASOURCE CONTROLLER
class MainDatasourceController: DatasourceController {
    
   
    
    // SQUAD NAME LABEL
    let squadNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.baselineAdjustment = .alignCenters
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 30, weight: .heavy)
        label.text = "Problem Here :("
        label.isUserInteractionEnabled = true
        return label
    }()
    
    // HANDLE NAME CHANGE
    @objc func handleNameChange() {
        let alertController = UIAlertController.init(title: "Change Squad Name", message: "What will it be son?", preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "e.g. Nacho & Esqueleto"
            textField.textAlignment = .center
        }
        
        let copy = UIAlertAction.init(title: "Change", style: .default, handler: { action in
            
            let textField = alertController.textFields![0]
            
            //do the name change
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let managedContext = appDelegate.persistentContainer.viewContext
            
            let userFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
            userFetch.fetchLimit = 1
            userFetch.predicate = NSPredicate(format: "userId = %@", "Nacho")
            userFetch.sortDescriptors = [NSSortDescriptor.init(key: "userId", ascending: true)]
            
            let users = try! managedContext.fetch(userFetch)
            
            let nacho: User = users.first as! User
            
            nacho.squadName = textField.text
            self.squadNameLabel.text = textField.text
            
            do {
                try managedContext.save()
            } catch {
                print("Failed saving")
            }
            
            print("Name Changed!")
        })
        let cancel = UIAlertAction.init(title: "Cancel", style: .cancel, handler: { action in
        })
        alertController.addAction(copy)
        alertController.addAction(cancel)
        present(alertController, animated: true, completion: nil)
    }
    
    // NO ADS BUTTON
    let noAdsButton: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.isUserInteractionEnabled = true
        image.image = #imageLiteral(resourceName: "noadsicon")
        return image
    }()
    
    // HANDLE NO ADS TAP ()
    @objc func handleNoAdsTap() {
    
        // price string
        let price: String = "U$1.99"
        
        // dispatch time
        let dispatchTime = DispatchTime.now() + .seconds(1)
        
        // wait a secound so the app can go get the price for the transaction
        DispatchQueue.main.asyncAfter(deadline: dispatchTime, execute: {
            // bring an alert to show options
            let alertController = UIAlertController.init(title: "Buy No-Ads Version", message: "Would you like to buy the No-Ads version of the app for \(price)(U$1.99)?", preferredStyle: .alert)
            
            let yes = UIAlertAction.init(title: "Yes", style: .default, handler: { action in
                
                purchaseProduct(with: inAppPurchaseId)
                
                self.collectionView?.reloadData()
                self.dismiss(animated: true, completion: nil)
            })
            let cancel = UIAlertAction.init(title: "Cancel", style: .cancel, handler: { action in
            })
            
            alertController.addAction(yes)
            alertController.addAction(cancel)
            self.present(alertController, animated: true, completion: nil)
        })
        
    }
    
    // SETTINGS BUTTON
    let settingsButton: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.isUserInteractionEnabled = true
        image.image = #imageLiteral(resourceName: "settingsicon")
        return image
    }()
    
    // handleSettingsTap()
    @objc func handleSettingsTap() {
        let settingsController = SettingsController()
        present(settingsController, animated: true, completion: nil)
    }
    
    
    // VIEW WILL APPEAR
    override func viewWillAppear(_ animated: Bool) {
    
        // reload the data
        self.collectionView?.reloadData()
        
        // JSON PARSING
        guard let path = Bundle.main.path(forResource: "challenges", ofType: "json") else { return }
        let url = URL(fileURLWithPath: path)
        do {
            let data = try Data(contentsOf: url)
            let challenges: [Challenges] = try JSONDecoder().decode([Challenges].self, from: data)
            userChallenges = challenges
        } catch let jsonErr {
            print("Error serializing json:", jsonErr)
        }
        
        // UserDidIt CORE DATA FETCHING
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let userFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        userFetch.fetchLimit = 1
        userFetch.predicate = NSPredicate(format: "userId = %@", "Nacho")
        userFetch.sortDescriptors = [NSSortDescriptor.init(key: "userId", ascending: true)]
        
        let users = try! managedContext.fetch(userFetch)
        let nacho: User = users.first as! User
        for index in 0...(userChallenges.count - 1) {
            userChallenges[index].userDidIt = nacho.arrayUserDidIt![index]
        }
        
        do {
            try managedContext.save()
        } catch {
            print("Failed saving")
        }
    }
    
    // VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // retrieve products info
        SwiftyStoreKit.retrieveProductsInfo([inAppPurchaseId]) { result in
            if let product = result.retrievedProducts.first {
            let priceString = product.localizedPrice!
                print("Product: \(product.localizedDescription), price: \(priceString)")
            }
            else if let invalidProductId = result.invalidProductIDs.first {
                print("Invalid product identifier: \(invalidProductId)")
            }
            else {
                print("Error: \(String(describing: result.error))")
            }
        }
        
        
        // VERIFY IF THE USER HAS MADE ANY PURCHASES
        verifyPurchase(with: inAppPurchaseId, sharedSecret: sharedSecret)
        
        
        self.navigationController?.navigationBar.barTintColor = supaWhite
        self.navigationController?.navigationBar.addBorder(side: .bottom, thickness: 3, color: supaGray)
        self.navigationController?.navigationBar.addSubview(squadNameLabel)
        squadNameLabel.centerXAnchor.constraint(equalTo: (navigationController?.navigationBar.centerXAnchor)!).isActive = true
        squadNameLabel.centerYAnchor.constraint(equalTo: (navigationController?.navigationBar.centerYAnchor)!).isActive = true
        squadNameLabel.widthAnchor.constraint(equalTo:  (navigationController?.navigationBar.widthAnchor)!, multiplier: 0.7).isActive = true
        squadNameLabel.heightAnchor.constraint(equalTo: (navigationController?.navigationBar.heightAnchor)!, multiplier: 0.9).isActive = true
        let squadtap = UITapGestureRecognizer(target: self, action: #selector(handleNameChange))
        squadNameLabel.addGestureRecognizer(squadtap)
        
        self.navigationController?.navigationBar.addSubview(noAdsButton)
        noAdsButton.centerYAnchor.constraint(equalTo: (navigationController?.navigationBar.centerYAnchor)!).isActive = true
        noAdsButton.leftAnchor.constraint(equalTo: (navigationController?.navigationBar.leftAnchor)!, constant: 16).isActive = true
        noAdsButton.widthAnchor.constraint(equalTo: (navigationController?.navigationBar.widthAnchor)!, multiplier: 0.07).isActive = true
        noAdsButton.heightAnchor.constraint(equalTo: (navigationController?.navigationBar.widthAnchor)!, multiplier: 0.07).isActive = true
        let noAdsTap = UITapGestureRecognizer(target: self, action: #selector(handleNoAdsTap))
        noAdsButton.addGestureRecognizer(noAdsTap)
        
        self.navigationController?.navigationBar.addSubview(settingsButton)
        settingsButton.centerYAnchor.constraint(equalTo: (navigationController?.navigationBar.centerYAnchor)!).isActive = true
        settingsButton.rightAnchor.constraint(equalTo: (navigationController?.navigationBar.rightAnchor)!, constant: -16).isActive = true
        settingsButton.widthAnchor.constraint(equalTo: (navigationController?.navigationBar.widthAnchor)!, multiplier: 0.07).isActive = true
        settingsButton.heightAnchor.constraint(equalTo: (navigationController?.navigationBar.widthAnchor)!, multiplier: 0.07).isActive = true
        let settingsTap = UITapGestureRecognizer(target: self, action: #selector(handleSettingsTap))
        settingsButton.addGestureRecognizer(settingsTap)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                squadNameLabel.text = (data.value(forKey: "squadName") as! String)
            }
        } catch {
            print("Failed")
        }
        
        let mainDatasource = MainDatasource()
        self.datasource = mainDatasource
        
        collectionView?.backgroundColor = supaYellow
        
        let layout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout
        layout?.sectionHeadersPinToVisibleBounds = true
        layout?.sectionFootersPinToVisibleBounds = true
        
        self.collectionView?.reloadData()
        
    }
    
    func verifyPurchase(with id: String, sharedSecret: String) {
        let appleValidator = AppleReceiptValidator(service: .production, sharedSecret: sharedSecret)
        SwiftyStoreKit.verifyReceipt(using: appleValidator) { result in
            switch result {
            case .success(let receipt):
                let productId = id
                // Verify the purchase of Consumable or NonConsumable
                let purchaseResult = SwiftyStoreKit.verifyPurchase(
                    productId: productId,
                    inReceipt: receipt)
                
                switch purchaseResult {
                case .purchased(let receiptItem):
                    print("\(productId) is purchased: \(receiptItem)")
            
                    didUserPay = true
                    
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    let managedContext = appDelegate.persistentContainer.viewContext
                    let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "UserPayed")
                    fetch.fetchLimit = 1
                    fetch.predicate = NSPredicate(format: "didUserPayName = %@", "Esqueleto")
                    fetch.sortDescriptors = [NSSortDescriptor.init(key: "didUserPay", ascending: true)]
                    
                    let users = try! managedContext.fetch(fetch)
                    
                    let esqueleto: UserPayed = users.first as! UserPayed
                    
                    esqueleto.didUserPay = true
                    
                    do {
                        try managedContext.save()
                    } catch {
                        print("Failed saving")
                    }
                    
                    
                    
                    self.collectionView?.reloadData()
                    
                case .notPurchased:
                    print("The user has never purchased \(productId)")
                }
            case .error(let error):
                print("Receipt verification failed: \(error)")
            }
        }
    }
    
    // DID SELECT ITEM AT ()
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        adsViewedCount += 1
        
        let explanationController = ExplanationController(gameTitle: userChallenges[indexPath.item].challengeName, explanationText: userChallenges[indexPath.item].challengeDescription, userDidIt: userChallenges[indexPath.item].userDidIt, indexId: indexPath.item )

        present(explanationController, animated: true, completion: nil)
        
    }
    
    // INSET FOR SECTION AT
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }
    
    // SIZE FOR ITEM AT
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let padding: CGFloat =  50
        let collectionViewSize = collectionView.frame.size.width - padding
        
        return CGSize(width: collectionViewSize/2, height: collectionViewSize/2)
    }
    
    // DID USER PAY
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
    
        if didUserPay == true {
            return CGSize(width: 0, height: 0)
        } else {
            return CGSize(width: view.frame.width, height: 50)
        }
    }
    
}


let sharedSecret = "34b65009a608462c8dd0f0dc4ee2634a"
let inAppPurchaseId = "marciokiyama.SquadApp.noadsversion"

func purchaseProduct(with id: String) {
    SwiftyStoreKit.retrieveProductsInfo([id]) { result in
        if let product = result.retrievedProducts.first {
            SwiftyStoreKit.purchaseProduct(product, quantity: 1, atomically: true) { result in
                
                switch result {
                case .success(let product):
                    // fetch content from your server, then:
                    if product.needsFinishTransaction {
                        SwiftyStoreKit.finishTransaction(product.transaction)
                    }
                    print("Purchase Success: \(product.productId)")
                case .error(let error):
                    switch error.code {
                    case .unknown: print("Unknown error. Please contact support")
                    case .clientInvalid: print("Not allowed to make the payment")
                    case .paymentCancelled: break
                    case .paymentInvalid: print("The purchase identifier was invalid")
                    case .paymentNotAllowed: print("The device is not allowed to make the payment")
                    case .storeProductNotAvailable: print("The product is not available in the current storefront")
                    case .cloudServicePermissionDenied: print("Access to cloud service information is not allowed")
                    case .cloudServiceNetworkConnectionFailed: print("Could not connect to the network")
                    case .cloudServiceRevoked: print("User has revoked permission to use this cloud service")
                    }
                }
                
            }
        }
    }
}

