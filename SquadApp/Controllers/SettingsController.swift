//
//  SettingsController.swift
//  SquadApp
//
//  Created by Mauricio Takashi Kiyama on 4/12/18.
//  Copyright © 2018 Marcio Kazuo Kiyama. All rights reserved.
//

import UIKit
import CoreData
import SwiftyStoreKit
import FirebaseDatabase

class SettingsController: UIViewController {
    
    // RETURN BUTTON
    let returnButton: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Return"
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.baselineAdjustment = .alignCenters
        label.textColor = supaBlue
        label.font = UIFont.systemFont(ofSize: 50, weight: .medium)
        label.isUserInteractionEnabled = true
        return label
    }()
    
    // handleReturn()
    @objc func handleReturn() {
        dismiss(animated: true, completion: nil)
    }
    
    // SETTINGS LABEL
    let setttingsLabel: UILabel = {
        let label = UILabel()
        label.text = "Settings"
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.baselineAdjustment = .alignCenters
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 100, weight: .light)
        label.textColor = supaBlack
        return label
    }()
    
    // ABOUT DEV CONTAINER VIEW
    let aboutDevContainerView: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.backgroundColor = .white
        container.isUserInteractionEnabled = true
        return container
    }()
    
    // handleAboutDev()
    @objc func handleAboutDev() {
        let aboutController = AboutController()
        present(aboutController, animated: true, completion: nil)
    }
    
    // ABOUT DEV LABEL
    let aboutDevLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = supaBlack
        label.font = settingsFont
        label.text = "About the Developer"
        return label
    }()
    
    // NOTIFICATIONS CONTAINER VIEW
    let notificationsContainerView: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.backgroundColor = .white
        container.isUserInteractionEnabled = true
        return container
    }()
    
    // NOTIFICATIONS LABEL
    let notificationsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = supaBlack
        label.font = settingsFont
        label.text = "Notifications"
        return label
    }()
    
    // NOTIFICATIONS SWITCH
    let notificationsSwitch: UISwitch = {
        let nSwitch = UISwitch()
        nSwitch.translatesAutoresizingMaskIntoConstraints = false
        nSwitch.addTarget(self, action: #selector(handleSwitch), for: .valueChanged)
        return nSwitch
    }()
    
    // handleSwitch()
    @objc func handleSwitch() {
        
        if notificationsSwitch.isOn {
            
            let alertController = UIAlertController.init(title: "Not Available", message: "This feature is not available in your planet. We are working on getting this ready for ya. Sorry!", preferredStyle: .alert)
            let cancel = UIAlertAction.init(title: "Cancel", style: .cancel, handler: { action in
                
            })
            alertController.addAction(cancel)
            self.present(alertController, animated: true, completion: nil)
            
        } else {
            print("desligou")
        }}
    
    // NO ADS CONTAINER VIEW
    let noAdsContainerView: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.backgroundColor = .white
        return container
    }()
    
    // NO ADS LABEL
    let noAdsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = supaBlack
        label.font = settingsFont
        label.text = "No Ads"
        return label
    }()
    
    // NO ADS BUTTON
    let noAdsButton: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "$1.99"
        label.textAlignment = .right
        label.adjustsFontSizeToFitWidth = true
        label.baselineAdjustment = .alignCenters
        label.textColor = supaBlue
        label.font = settingsFont
        label.isUserInteractionEnabled = true
        return label
    }()
    
    // handleNoAds()
    @objc func handleNoAds() {
        purchaseProduct(with: inAppPurchaseId)
        print("User clicked handleNoAds")
    }
    
    // ERASE DATA CONTAINER VIEW
    let eraseDataContainerView: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.backgroundColor = .white
        container.isUserInteractionEnabled = true
        return container
    }()
    
    // ERASE DATA LABEL
    let eraseDataLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = supaBlack
        label.font = settingsFont
        label.text = "Erase All Data"
        return label
    }()
    
    // handleEraseData()
    @objc func handleEraseData() {
        let alertController = UIAlertController.init(title: "Erase All Data", message: "Are you sure you want to erase all data and restart the App?", preferredStyle: .alert)
        let copy = UIAlertAction.init(title: "Yes", style: .default, handler: { action in
            
            isUserSetup = false
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let managedContext = appDelegate.persistentContainer.viewContext
            
            let userFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
            userFetch.fetchLimit = 1
            userFetch.predicate = NSPredicate(format: "userId = %@", "Nacho")
            userFetch.sortDescriptors = [NSSortDescriptor.init(key: "userId", ascending: true)]
            
            if let result = try? managedContext.fetch(userFetch) {
                for object in result {
                    managedContext.delete(object as! User)
                }
            }
            
            let introController = IntroController()
            appDelegate.window?.rootViewController = introController
            
        })
        let cancel = UIAlertAction.init(title: "No", style: .cancel, handler: { action in
        })
        alertController.addAction(copy)
        alertController.addAction(cancel)
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    // RESTORE PURCHASES VIEW
    let restorePurchasesView: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.backgroundColor = .white
        container.isUserInteractionEnabled = true
        return container
    }()
    
    // RESTORE PURCHASES LABEL
    let restorePurchasesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = supaBlack
        label.font = settingsFont
        label.text = "Restore all Purchases"
        return label
    }()
    
    // handleRestorePurchases()
    @objc func handleRestorePurchases() {
        let alertController = UIAlertController.init(title: "Restore Purchases", message: "Are you sure you want to restore all In-App Purchases?", preferredStyle: .alert)
        let copy = UIAlertAction.init(title: "Yes", style: .default, handler: { action in
            SwiftyStoreKit.restorePurchases(atomically: true) { results in
                if results.restoreFailedPurchases.count > 0 {
                    print("Restore Failed: \(results.restoreFailedPurchases)")
                }
                else if results.restoredPurchases.count > 0 {
                    print("Restore Success: \(results.restoredPurchases)")
                }
                else {
                    print("Nothing to Restore")
                }
            }
            
        })
        let cancel = UIAlertAction.init(title: "No", style: .cancel, handler: { action in
        })
        alertController.addAction(copy)
        alertController.addAction(cancel)
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    // FEEDBACK VIEW
    let feedbackView: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.backgroundColor = .white
        container.isUserInteractionEnabled = true
        return container
    }()
    
    // FEEDBACK LABEL
    let feedbackLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = supaBlack
        label.font = settingsFont
        label.text = "Feedback"
        return label
    }()
    
    // handleFeedback()
    @objc func handleFeedback() {
    
        let alertController = UIAlertController.init(title: "Give Feedback", message: "What can we do better?", preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "Name or Nickname"
            textField.textAlignment = .center
        }
        alertController.addTextField { textField2 in
            textField2.placeholder = "Feedback"
            textField2.textAlignment = .center
        }
        
        let send = UIAlertAction.init(title: "Send", style: .default, handler: { action in
            
            let name = alertController.textFields![0]
            let feedback = alertController.textFields![1]
            
            var ref: DatabaseReference!
            ref = Database.database().reference()
            
            ref.child("feedback").child("\(name.text ?? "")").setValue(["feedbacktext": feedback.text])
            
        })
        let cancel = UIAlertAction.init(title: "Cancel", style: .cancel, handler: { action in
        })
        alertController.addAction(send)
        alertController.addAction(cancel)
        present(alertController, animated: true, completion: nil)
        
    }
    
    
    // VERSION LABEL
    let versionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = supaBlack
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.baselineAdjustment = .alignCenters
        label.font = UIFont.systemFont(ofSize: 50, weight: .light)
        label.text = "Version 1.3"
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = supaYellow
        
        setupLayout()
    }
    
    
    // FUNCTION: setupLayout
    func setupLayout() {
        
        
        // setup returnButton
        self.view.addSubview(returnButton)
        returnButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 16).isActive = true
        returnButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        returnButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.14).isActive = true
        returnButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.03).isActive = true
        let returnTap = UITapGestureRecognizer(target: self, action: #selector(handleReturn))
        returnButton.addGestureRecognizer(returnTap)
        
        
        // setup settingsLabel
        view.addSubview(setttingsLabel)
        setttingsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        setttingsLabel.topAnchor.constraint(equalTo: returnButton.bottomAnchor, constant: 16).isActive = true
        setttingsLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3).isActive = true
        setttingsLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.055).isActive = true
        
        
        // setup aboutDevContainerView
        view.addSubview(aboutDevContainerView)
        aboutDevContainerView.topAnchor.constraint(equalTo: setttingsLabel.bottomAnchor, constant: 16).isActive = true
        aboutDevContainerView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        aboutDevContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.067).isActive = true
        let aboutDevTap = UITapGestureRecognizer(target: self, action: #selector(handleAboutDev))
        aboutDevContainerView.addGestureRecognizer(aboutDevTap)
        
        
        // setup aboutDevLabel
        aboutDevContainerView.addSubview(aboutDevLabel)
        aboutDevLabel.centerYAnchor.constraint(equalTo: aboutDevContainerView.centerYAnchor).isActive = true
        aboutDevLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        aboutDevLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true
        aboutDevLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.03).isActive = true
        
        
        // setup notificationsContainerView
        view.addSubview(notificationsContainerView)
        notificationsContainerView.topAnchor.constraint(equalTo: aboutDevContainerView.bottomAnchor).isActive = true
        notificationsContainerView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        notificationsContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.067).isActive = true
        
        
        // setup notificationsLabel
        notificationsContainerView.addSubview(notificationsLabel)
        notificationsLabel.centerYAnchor.constraint(equalTo: notificationsContainerView.centerYAnchor).isActive = true
        notificationsLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        notificationsLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true
        notificationsLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.03).isActive = true
        
        // setup notificationsSwitch
        notificationsContainerView.addSubview(notificationsSwitch)
        notificationsSwitch.centerYAnchor.constraint(equalTo: notificationsContainerView.centerYAnchor).isActive = true
        notificationsSwitch.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        
        
        // setup noAdsContainerView
        view.addSubview(noAdsContainerView)
        noAdsContainerView.topAnchor.constraint(equalTo: notificationsContainerView.bottomAnchor).isActive = true
        noAdsContainerView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        noAdsContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.067).isActive = true
        
        
        // setup noAdsLabel
        noAdsContainerView.addSubview(noAdsLabel)
        noAdsLabel.centerYAnchor.constraint(equalTo: noAdsContainerView.centerYAnchor).isActive = true
        noAdsLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        noAdsLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true
        noAdsLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.03).isActive = true
        
        
        // setup noAdsButton
        noAdsContainerView.addSubview(noAdsButton)
        noAdsButton.centerYAnchor.constraint(equalTo: noAdsContainerView.centerYAnchor).isActive = true
        noAdsButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        noAdsButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.2).isActive = true
        noAdsButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.03).isActive = true
        let noAdsTap = UITapGestureRecognizer(target: self, action: #selector(handleNoAds))
        noAdsButton.addGestureRecognizer(noAdsTap)
        
        // setup eraseDataContainerView
        view.addSubview(eraseDataContainerView)
        eraseDataContainerView.topAnchor.constraint(equalTo: noAdsContainerView.bottomAnchor).isActive = true
        eraseDataContainerView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        eraseDataContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.067).isActive = true
        let eraseDataTap = UITapGestureRecognizer(target: self, action: #selector(handleEraseData))
        eraseDataContainerView.addGestureRecognizer(eraseDataTap)
        
        // setup eraseDataLabel
        eraseDataContainerView.addSubview(eraseDataLabel)
        eraseDataLabel.centerYAnchor.constraint(equalTo: eraseDataContainerView.centerYAnchor).isActive = true
        eraseDataLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        eraseDataLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true
        eraseDataLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.03).isActive = true
        
        // setup restorePurchasesView
        view.addSubview(restorePurchasesView)
        restorePurchasesView.topAnchor.constraint(equalTo: eraseDataContainerView.bottomAnchor).isActive = true
        restorePurchasesView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        restorePurchasesView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.067).isActive = true
        let restorePurchasesTap = UITapGestureRecognizer(target: self, action: #selector(handleRestorePurchases))
        restorePurchasesView.addGestureRecognizer(restorePurchasesTap)
        
        // setup restorePurchasesLabel
        restorePurchasesView.addSubview(restorePurchasesLabel)
        restorePurchasesLabel.centerYAnchor.constraint(equalTo: restorePurchasesView.centerYAnchor).isActive = true
        restorePurchasesLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        restorePurchasesLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true
        restorePurchasesLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.03).isActive = true
        
        // setup feedbackView
        view.addSubview(feedbackView)
        feedbackView.topAnchor.constraint(equalTo: restorePurchasesView.bottomAnchor).isActive = true
        feedbackView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        feedbackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.067).isActive = true
        let feedbackTap = UITapGestureRecognizer(target: self, action: #selector(handleFeedback))
        feedbackView.addGestureRecognizer(feedbackTap)
        
        // setup feedbackLabel
        feedbackView.addSubview(feedbackLabel)
        feedbackLabel.centerYAnchor.constraint(equalTo: feedbackView.centerYAnchor).isActive = true
        feedbackLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        feedbackLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true
        feedbackLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.03).isActive = true
        
        // setup versionLabel
        view.addSubview(versionLabel)
        versionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        versionLabel.topAnchor.constraint(equalTo: feedbackView.bottomAnchor, constant: 10).isActive = true
        versionLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.18).isActive = true
        versionLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.018).isActive = true
        
        
        /*********************************************
         UGLY CODE
         (This is an ugly solution for a problem I
         still need to fix)
         **********************************************/
        
        //line1
        let separatorLineView1 = UIView()
        separatorLineView1.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        separatorLineView1.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(separatorLineView1)
        separatorLineView1.leftAnchor.constraint(equalTo: aboutDevContainerView.leftAnchor).isActive = true
        separatorLineView1.topAnchor.constraint(equalTo: aboutDevContainerView.topAnchor).isActive = true
        separatorLineView1.widthAnchor.constraint(equalTo: aboutDevContainerView.widthAnchor).isActive = true
        separatorLineView1.heightAnchor.constraint(equalToConstant: 1.5).isActive = true
        
        //line2
        let separatorLineView2 = UIView()
        separatorLineView2.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        separatorLineView2.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(separatorLineView2)
        separatorLineView2.leftAnchor.constraint(equalTo: notificationsContainerView.leftAnchor).isActive = true
        separatorLineView2.topAnchor.constraint(equalTo: notificationsContainerView.topAnchor).isActive = true
        separatorLineView2.widthAnchor.constraint(equalTo: notificationsContainerView.widthAnchor).isActive = true
        separatorLineView2.heightAnchor.constraint(equalToConstant: 1.5).isActive = true
        
        //line3
        let separatorLineView3 = UIView()
        separatorLineView3.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        separatorLineView3.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(separatorLineView3)
        separatorLineView3.leftAnchor.constraint(equalTo: noAdsContainerView.leftAnchor).isActive = true
        separatorLineView3.topAnchor.constraint(equalTo: noAdsContainerView.topAnchor).isActive = true
        separatorLineView3.widthAnchor.constraint(equalTo: noAdsContainerView.widthAnchor).isActive = true
        separatorLineView3.heightAnchor.constraint(equalToConstant: 1.5).isActive = true
        
        //line4
        let separatorLineView4 = UIView()
        separatorLineView4.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        separatorLineView4.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(separatorLineView4)
        separatorLineView4.leftAnchor.constraint(equalTo: eraseDataContainerView.leftAnchor).isActive = true
        separatorLineView4.topAnchor.constraint(equalTo: eraseDataContainerView.topAnchor).isActive = true
        separatorLineView4.widthAnchor.constraint(equalTo: eraseDataContainerView.widthAnchor).isActive = true
        separatorLineView4.heightAnchor.constraint(equalToConstant: 1.5).isActive = true
        
        //line5
        let separatorLineView5 = UIView()
        separatorLineView5.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        separatorLineView5.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(separatorLineView5)
        separatorLineView5.leftAnchor.constraint(equalTo: eraseDataContainerView.leftAnchor).isActive = true
        separatorLineView5.topAnchor.constraint(equalTo: eraseDataContainerView.bottomAnchor).isActive = true
        separatorLineView5.widthAnchor.constraint(equalTo: eraseDataContainerView.widthAnchor).isActive = true
        separatorLineView5.heightAnchor.constraint(equalToConstant: 1.5).isActive = true
        
        //line6
        let separatorLineView6 = UIView()
        separatorLineView6.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        separatorLineView6.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(separatorLineView6)
        separatorLineView6.leftAnchor.constraint(equalTo: restorePurchasesView.leftAnchor).isActive = true
        separatorLineView6.topAnchor.constraint(equalTo: restorePurchasesView.bottomAnchor).isActive = true
        separatorLineView6.widthAnchor.constraint(equalTo: restorePurchasesView.widthAnchor).isActive = true
        separatorLineView6.heightAnchor.constraint(equalToConstant: 1.5).isActive = true
        
        //line7
        let separatorLineView7 = UIView()
        separatorLineView7.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        separatorLineView7.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(separatorLineView7)
        separatorLineView7.leftAnchor.constraint(equalTo: feedbackView.leftAnchor).isActive = true
        separatorLineView7.topAnchor.constraint(equalTo: feedbackView.bottomAnchor).isActive = true
        separatorLineView7.widthAnchor.constraint(equalTo: feedbackView.widthAnchor).isActive = true
        separatorLineView7.heightAnchor.constraint(equalToConstant: 1.5).isActive = true
        
        /*********************************************
         END OF UGLY CODE
         **********************************************/
        
    }
    
}






