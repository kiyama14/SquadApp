//
//  MainFooter.swift
//  SquadApp
//
//  Created by Mauricio Takashi Kiyama on 4/18/18.
//  Copyright © 2018 Marcio Kazuo Kiyama. All rights reserved.
//

import LBTAComponents
import CoreData
import GoogleMobileAds
import SwiftyStoreKit

// MAIN FOOTER
class MainFooter: DatasourceCell, GADBannerViewDelegate {
    
    // GOOGLE AD MOB VAR
    var bannerView: GADBannerView!
    
    // SETUP VIEWS ()
    override func setupViews() {
        super.setupViews()
        backgroundColor = .black
        
        bannerView = GADBannerView(adSize: kGADAdSizeSmartBannerPortrait)
        bannerView.adUnitID = "ca-app-pub-5947866396824097/7693283966"
        bannerView.rootViewController = UIApplication.shared.keyWindow?.rootViewController
        bannerView.load(GADRequest())
        bannerView.delegate = self
        
        addBannerViewToView(bannerView)
    }
    
    // addBannerViewToView ()
    func addBannerViewToView(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(bannerView)
        bannerView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    /// Tells the delegate an ad request loaded an ad.
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        print("adViewDidReceiveAd")
    }
    
    /// Tells the delegate an ad request failed.
    func adView(_ bannerView: GADBannerView,
                didFailToReceiveAdWithError error: GADRequestError) {
        print("adView:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }
    
    /// Tells the delegate that a full-screen view will be presented in response
    /// to the user clicking on an ad.
    func adViewWillPresentScreen(_ bannerView: GADBannerView) {
        print("adViewWillPresentScreen")
    }
    
    /// Tells the delegate that the full-screen view will be dismissed.
    func adViewWillDismissScreen(_ bannerView: GADBannerView) {
        print("adViewWillDismissScreen")
    }
    
    /// Tells the delegate that the full-screen view has been dismissed.
    func adViewDidDismissScreen(_ bannerView: GADBannerView) {
        print("adViewDidDismissScreen")
    }
    
    /// Tells the delegate that a user click will open another app (such as
    /// the App Store), backgrounding the current app.
    func adViewWillLeaveApplication(_ bannerView: GADBannerView) {
        print("adViewWillLeaveApplication")
    }
}
