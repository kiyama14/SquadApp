//
//  AllSetController.swift
//  SquadApp
//
//  Created by Mauricio Takashi Kiyama on 4/12/18.
//  Copyright © 2018 Marcio Kazuo Kiyama. All rights reserved.
//


import UIKit

class AllSetController: UIViewController {
    
    // TOP CONT. VIEW
    let topContainerView: UIView = {
        let topView = UIView()
        topView.translatesAutoresizingMaskIntoConstraints = false
        return topView
    }()
    
    // BOTTOM CONT. VIEW
    let bottomContainerView: UIView = {
        let bottomView = UIView()
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        return bottomView
    }()
    
    // SQUAD LOGO
    let squadLogo: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "Icon_800px")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    // ALL SET LABEL
    let allSetLabel: UILabel = {
        let label = UILabel()
        label.text = "All Set!"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.baselineAdjustment = .alignCenters
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 50, weight: .bold)
        return label
    }()
    
    
    // VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = supaYellow
        
        self.perform(#selector(nextViewController), with: Any?.self, afterDelay: 2)
        
        setupLayout()
    }
    
    // NEXT VIEW CONTROLLER ()
    @objc func nextViewController() {
        let mainDatasourceController = UINavigationController(rootViewController: MainDatasourceController())
        let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
        appDelegate.window?.rootViewController = mainDatasourceController
        
        
    }
    
    // SETUP LAYOUT ()
    func setupLayout() {
        
        // setup topContainerView
        view.addSubview(topContainerView)
        topContainerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        topContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        topContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
        
        // setup bottomContainerView
        view.addSubview(bottomContainerView)
        bottomContainerView.topAnchor.constraint(equalTo: topContainerView.bottomAnchor).isActive = true
        bottomContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        bottomContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        bottomContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
        
        // setup squadLogo
        topContainerView.addSubview(squadLogo)
        squadLogo.centerXAnchor.constraint(equalTo: topContainerView.centerXAnchor).isActive = true
        squadLogo.centerYAnchor.constraint(equalTo: topContainerView.centerYAnchor).isActive = true
        squadLogo.widthAnchor.constraint(equalTo: topContainerView.widthAnchor, multiplier: 0.8).isActive = true
        squadLogo.heightAnchor.constraint(equalTo: topContainerView.heightAnchor, multiplier: 0.8).isActive = true
        
        // setup allSetLabel
        bottomContainerView.addSubview(allSetLabel)
        allSetLabel.topAnchor.constraint(equalTo: bottomContainerView.topAnchor).isActive = true
        allSetLabel.centerXAnchor.constraint(equalTo: bottomContainerView.centerXAnchor).isActive = true
        allSetLabel.widthAnchor.constraint(equalTo: bottomContainerView.widthAnchor, multiplier: 0.7).isActive = true
        allSetLabel.heightAnchor.constraint(equalTo: bottomContainerView.heightAnchor, multiplier: 0.15).isActive = true
    }
}
