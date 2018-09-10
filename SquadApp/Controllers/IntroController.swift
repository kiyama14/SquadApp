//
//  IntroController.swift
//  SquadApp
//
//  Created by Mauricio Takashi Kiyama on 4/12/18.
//  Copyright © 2018 Marcio Kazuo Kiyama. All rights reserved.
//


import UIKit
import CoreData

class IntroController: UIViewController {
    
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
    
    // SQUAD LABEL
    let squadLabel: UILabel = {
        let label = UILabel()
        label.text = "SQUAD"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.baselineAdjustment = .alignCenters
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 70, weight: .black)
        return label
    }()
    
    // SQUAD SUBTITLE
    let squadSubtitle: UILabel = {
        let label = UILabel()
        label.text = "Fun 4 Your Squad"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.baselineAdjustment = .alignCenters
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 70, weight: .heavy)
        label.textColor = supaBlue
        return label
    }()
    
    // START BUTTON
    let startButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Start", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.baselineAdjustment = .alignCenters
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont.systemFont(ofSize: 80, weight: .bold)
        button.backgroundColor = supaBlack
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(handleStartButton), for: .touchUpInside)
        return button
    }()
    
    // HANDLE START BUTTON ()
    @objc func handleStartButton() {
        let setupController = SetupController()
        present(setupController, animated: true, completion: nil)
    }
    
    // VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = supaYellow
        
        setupLayout()
    }
    
    // SETUP LAYOUT
    private func setupLayout() {
        
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
        
        // setup squadLabel
        bottomContainerView.addSubview(squadLabel)
        squadLabel.topAnchor.constraint(equalTo: bottomContainerView.topAnchor).isActive = true
        squadLabel.centerXAnchor.constraint(equalTo: bottomContainerView.centerXAnchor).isActive = true
        squadLabel.widthAnchor.constraint(equalTo: bottomContainerView.widthAnchor, multiplier: 0.7).isActive = true
        squadLabel.heightAnchor.constraint(equalTo: bottomContainerView.heightAnchor, multiplier: 0.22).isActive = true
        
        // setup squadSubtitle
        bottomContainerView.addSubview(squadSubtitle)
        squadSubtitle.topAnchor.constraint(equalTo: squadLabel.bottomAnchor, constant: -10).isActive = true
        squadSubtitle.centerXAnchor.constraint(equalTo: bottomContainerView.centerXAnchor).isActive = true
        squadSubtitle.widthAnchor.constraint(equalTo: bottomContainerView.widthAnchor, multiplier: 0.5).isActive = true
        squadSubtitle.heightAnchor.constraint(equalTo: bottomContainerView.heightAnchor, multiplier: 0.10).isActive = true
        
        // setup startButton
        bottomContainerView.addSubview(startButton)
        startButton.centerYAnchor.constraint(equalTo: bottomContainerView.centerYAnchor, constant: 80).isActive = true
        startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        startButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.38).isActive = true
        startButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.09).isActive = true
    }
    
    
}



