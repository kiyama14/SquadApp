//
//  ExplanationController.swift
//  SquadApp
//
//  Created by Mauricio Takashi Kiyama on 4/12/18.
//  Copyright © 2018 Marcio Kazuo Kiyama. All rights reserved.
//


import UIKit
import CoreData
import GoogleMobileAds
import FirebaseDatabase

var indexNumber: Int = 0

class ExplanationController: UIViewController, GADInterstitialDelegate  {
    
    
    let gameTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Something went wrong :("
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.baselineAdjustment = .alignCenters
        label.textColor = supaWhite
        label.shadowColor = supaGray
        label.shadowOffset = CGSize(width: 2, height: 2)
        label.font = UIFont.systemFont(ofSize: 80, weight: .bold)
        return label
    }()
    
    // EXPLANATION VIEW
    let explanationView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = supaYellow
        view.layer.borderColor = supaGray.cgColor
        view.layer.borderWidth = 2.5
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        return view
    }()
    
    // EXPLANATION TEXT FIELD
    let explanationTextView: UITextView = {
        let text = UITextView()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.backgroundColor = .clear
        text.textColor = supaNewBlack
        text.textAlignment = .center
        text.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        text.isEditable = false
        text.isSelectable = false
        text.text = "Error loading your view!"
        return text
    }()
    
    // LATER BUTTON
    let laterButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Later", for: .normal)
        button.setTitleColor(supaNewBlack, for: .normal)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.baselineAdjustment = .alignCenters
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        button.backgroundColor = supaYellow
        button.layer.cornerRadius = 10
        button.layer.borderColor = supaGray.cgColor
        button.layer.borderWidth = 2.5
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(handleLaterButton), for: .touchUpInside)
        return button
    }()
    
    // handle later button ()
    @objc func handleLaterButton() {
        dismiss(animated: true, completion: nil)
    }
    
    // DID IT BUTTON
    let didItButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Did It!", for: .normal)
        button.setTitleColor(supaNewBlack, for: .normal)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.baselineAdjustment = .alignCenters
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        button.backgroundColor = supaYellow
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.layer.borderColor = supaGray.cgColor
        button.layer.borderWidth = 2.5
        button.addTarget(self, action: #selector(handleDidItButton), for: .touchUpInside)
        return button
    }()
    
    // HANDLE DID IT BUTTON ()
    @objc func handleDidItButton() {
        
        if userChallenges[indexNumber].userDidIt == 1 || userChallenges[indexNumber].userDidIt == 2 {
            userChallenges[indexNumber].userDidIt = 0
        } else {
            userChallenges[indexNumber].userDidIt = 1
        }
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let userFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        userFetch.fetchLimit = 1
        userFetch.predicate = NSPredicate(format: "userId = %@", "Nacho")
        userFetch.sortDescriptors = [NSSortDescriptor.init(key: "userId", ascending: true)]
        
        let users = try! managedContext.fetch(userFetch)
        
        let nacho: User = users.first as! User
        
        for index in 0...(userChallenges.count - 1) {
            nacho.arrayUserDidIt![index] = userChallenges[index].userDidIt
        }
        
        do {
            try managedContext.save()
        } catch {
            print("Failed saving")
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    // NEVER BUTTON
    let neverButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.attributedText = NSAttributedString(string: "Will never do it", attributes:
            [.underlineStyle: NSUnderlineStyle.styleSingle.rawValue])
        button.setTitle("Will never do it", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.baselineAdjustment = .alignCenters
        button.titleLabel?.textColor = .white
        button.titleLabel?.font = UIFont.systemFont(ofSize: 200, weight: .medium)
        button.addTarget(self, action: #selector(handleWillNeverDoIt), for: .touchUpInside)
        return button
    }()
    
    // HANDLE WILL NEVER DO IT ()
    @objc func handleWillNeverDoIt() {
        let alertController = UIAlertController.init(title: "Remove Game", message: "Please tell us the reason why you don't want to play this game", preferredStyle: .alert)
        let boring = UIAlertAction.init(title: "Boring", style: .default, handler: { action in
            
            let boringID = arc4random()
            
            var ref: DatabaseReference!
            ref = Database.database().reference()
            
            ref.child("challengeFeed").child("boring").child("\(boringID)").setValue(["boring": "\(self.gameTitleLabel.text ?? "Yes")"])
            
            self.makeChallengeRed()
            
            self.dismiss(animated: true, completion: nil)
        })
        let innapropriate = UIAlertAction.init(title: "Innapropriate", style: .default, handler: { action in
            
            let innapropriateID = arc4random()
            
            var ref: DatabaseReference!
            ref = Database.database().reference()
            
            ref.child("challengeFeed").child("innapropriate").child("\(innapropriateID)").setValue(["innapropriate": "yes"])
            
            
            self.makeChallengeRed()
            
            self.dismiss(animated: true, completion: nil)
        })
        let other = UIAlertAction.init(title: "Other", style: .default, handler: { action in
            
            let otherID = arc4random()
            
            var ref: DatabaseReference!
            ref = Database.database().reference()
            
            ref.child("challengeFeed").child("other").child("\(otherID)").setValue(["other": "yes"])
            
            self.makeChallengeRed()
            
            self.dismiss(animated: true, completion: nil)
        })
        let cancel = UIAlertAction.init(title: "Cancel", style: .cancel, handler: { action in
        })
        
        alertController.addAction(boring)
        alertController.addAction(innapropriate)
        alertController.addAction(other)
        alertController.addAction(cancel)
        self.present(alertController, animated: true, completion: nil)
    }
    
    // MAKE CHALLENGE RED ()
    func makeChallengeRed() {

        userChallenges[indexNumber].userDidIt = 2
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let userFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        userFetch.fetchLimit = 1
        userFetch.predicate = NSPredicate(format: "userId = %@", "Nacho")
        userFetch.sortDescriptors = [NSSortDescriptor.init(key: "userId", ascending: true)]
        
        let users = try! managedContext.fetch(userFetch)
        
        let nacho: User = users.first as! User
        
        for index in 0...(userChallenges.count - 1) {
            nacho.arrayUserDidIt![index] = userChallenges[index].userDidIt
        }
        
        do {
            try managedContext.save()
        } catch {
            print("Failed saving")
        }
        
    }
    
    // interstitial variable
    var interstitial: GADInterstitial!
    
    // VIEW WILL APPEAR
    override func viewWillAppear(_ animated: Bool) {
        
        if didUserPay == false {
            if adsViewedCount >= 3 {
                let alertController = UIAlertController.init(title: "Watch Advertisement", message: "For every couple of games we show you an Ad to help us with revenue. We are sorry but it pays our ramen noodles :) View the ad or buy the No-Ads version for only U$1.99", preferredStyle: .alert)
                
                let watchAd = UIAlertAction.init(title: "Watch Ad", style: .default, handler: { action in
                    print("watchad")
                    
                    // reset the adsViewedCount
                    adsViewedCount = 0
                    
                    if self.interstitial.isReady {
                        self.interstitial.present(fromRootViewController: self)
                    } else {
                        print("Ad wasn't ready")
                    }
                    
                    self.interstitial = self.createAndLoadInterstitial()
                })
                let noAds = UIAlertAction.init(title: "No-Ads", style: .default, handler: { action in
                    print("buy no ads")
                })
                let cancel = UIAlertAction.init(title: "Cancel", style: .cancel, handler: { action in
                    self.dismiss(animated: true, completion: nil)
                })
                
                alertController.addAction(watchAd)
                alertController.addAction(cancel)
                alertController.addAction(noAds)
                
                present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        interstitial = GADInterstitial(adUnitID: "ca-app-pub-3940256099942544/4411468910")
        
        let request = GADRequest()
        interstitial.load(request)
        
        if userChallenges[indexNumber].userDidIt == 0 {
            didItButton.setTitle("Did It!", for: .normal)
        }
        if userChallenges[indexNumber].userDidIt == 1 || userChallenges[indexNumber].userDidIt == 2 {
            didItButton.setTitle("Reset", for: .normal)
        }
        view.addSubview(gameTitleLabel)
        gameTitleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 19).isActive = true
        gameTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        gameTitleLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        gameTitleLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.09).isActive = true
        
        view.addSubview(explanationView)
        explanationView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        explanationView.topAnchor.constraint(equalTo: gameTitleLabel.bottomAnchor, constant: 12).isActive = true
        explanationView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.90).isActive = true
        explanationView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.63).isActive = true
        
        explanationView.addSubview(explanationTextView)
        explanationTextView.centerXAnchor.constraint(equalTo: explanationView.centerXAnchor).isActive = true
        explanationTextView.centerYAnchor.constraint(equalTo: explanationView.centerYAnchor).isActive = true
        explanationTextView.widthAnchor.constraint(equalTo: explanationView.widthAnchor, multiplier: 0.9).isActive = true
        explanationTextView.heightAnchor.constraint(equalTo: explanationView.heightAnchor, multiplier: 0.9).isActive = true
        
        view.addSubview(neverButton)
        neverButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32).isActive = true
        neverButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        neverButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3).isActive = true
        neverButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.026).isActive = true
        
        
        view.addSubview(laterButton)
        laterButton.bottomAnchor.constraint(equalTo: neverButton.topAnchor, constant: -10).isActive = true
        laterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -75).isActive = true
        laterButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3).isActive = true
        laterButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.09).isActive = true
        
        view.addSubview(didItButton)
        didItButton.bottomAnchor.constraint(equalTo: neverButton.topAnchor, constant: -10).isActive = true
        didItButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 75).isActive = true
        didItButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3).isActive = true
        didItButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.09).isActive = true
        
    }
    
    func createAndLoadInterstitial() -> GADInterstitial {
        let interstitial = GADInterstitial(adUnitID: "ca-app-pub-3940256099942544/4411468910")
        interstitial.delegate = self
        interstitial.load(GADRequest())
        return interstitial
    }
    
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        interstitial = createAndLoadInterstitial()
    }
    
    /// Tells the delegate an ad request succeeded.
    func interstitialDidReceiveAd(_ ad: GADInterstitial) {
        print("interstitialDidReceiveAd")
    }
    
    /// Tells the delegate an ad request failed.
    func interstitial(_ ad: GADInterstitial, didFailToReceiveAdWithError error: GADRequestError) {
        print("interstitial:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }
    
    /// Tells the delegate that an interstitial will be presented.
    func interstitialWillPresentScreen(_ ad: GADInterstitial) {
        print("interstitialWillPresentScreen")
    }
    
    /// Tells the delegate the interstitial is to be animated off the screen.
    func interstitialWillDismissScreen(_ ad: GADInterstitial) {
        print("interstitialWillDismissScreen")
    }
    
    /// Tells the delegate that a user click will open another app
    /// (such as the App Store), backgrounding the current app.
    func interstitialWillLeaveApplication(_ ad: GADInterstitial) {
        print("interstitialWillLeaveApplication")
    }

    
    convenience init(gameTitle: String, explanationText: String, userDidIt: Int, indexId: Int) {
        self.init(nibName: nil, bundle: nil)
        
        gameTitleLabel.text = gameTitle
        explanationTextView.text = explanationText
        indexNumber = indexId
        
        if userDidIt == 0 {
            view.backgroundColor = supaBlue
        } else if userDidIt == 1 {
            view.backgroundColor = supaGreen
            explanationView.backgroundColor = supaWhite
            laterButton.backgroundColor = supaWhite
            didItButton.backgroundColor = supaWhite
        } else {
            view.backgroundColor = supaRed
        }
        
    }
}

