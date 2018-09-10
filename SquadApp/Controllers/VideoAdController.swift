//
//  VideoAdController.swift
//  SquadApp
//
//  Created by Mauricio Takashi Kiyama on 4/16/18.
//  Copyright © 2018 Marcio Kazuo Kiyama. All rights reserved.
//

import UIKit
import GoogleMobileAds

class VideoAdController: UIViewController, GADInterstitialDelegate {
    
    var interstitial: GADInterstitial!
    
    var loadappbutton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("click here", for: .normal)
        button.addTarget(self, action: #selector(handleButtonPress), for: .touchUpInside)
        return button
    }()
    
    @objc func handleButtonPress() {
        if interstitial.isReady {
            interstitial.present(fromRootViewController: self)
        } else {
            print("Problem loading your ad")
        }
        
        interstitial = createAndLoadInterstitial()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // interstitial ID
        interstitial = GADInterstitial(adUnitID: "ca-app-pub-5947866396824097/5721726746")
        
        let request = GADRequest()
        interstitial.load(request)
        
        
        view.addSubview(loadappbutton)
        loadappbutton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loadappbutton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        loadappbutton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        loadappbutton.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        
    }
    
    func createAndLoadInterstitial() -> GADInterstitial {
        let interstitial = GADInterstitial(adUnitID: "ca-app-pub-5947866396824097/5721726746")
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
}
