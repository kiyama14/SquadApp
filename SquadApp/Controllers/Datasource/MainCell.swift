//
//  MainCell.swift
//  SquadApp
//
//  Created by Mauricio Takashi Kiyama on 4/18/18.
//  Copyright © 2018 Marcio Kazuo Kiyama. All rights reserved.
//

import LBTAComponents
import CoreData
import GoogleMobileAds
import SwiftyStoreKit


// MAIN CELL
class MainCell: DatasourceCell {
    
    // setup the cell labels
    override var datasourceItem: Any? {
        didSet {
            let index = datasourceItem as! Int - 1
            if index < userChallenges.count {
                gameNameLabel.text = userChallenges[index].challengeName
                gameNameLabel.textColor = supaBlack
                if (gameNameLabel.text?.count)! > 10 {
                    gameNameLabel.numberOfLines = 2
                } else {
                    gameNameLabel.numberOfLines = 1
                }
                gameDescription = userChallenges[index].challengeDescription
                gameNumberLabel.text = "Game " + String(index + 1)
                gameNumberLabel.textColor = supaGray
            }
            
            // change color depending on json
            if userChallenges[index].userDidIt == 0 {
                backgroundColor = supaBlue
            } else if userChallenges[index].userDidIt == 1 {
                backgroundColor = supaGreen
            } else {
                backgroundColor = supaGray
            }
        }
        
    }
    
    // GAME DESCRIPTION
    var gameDescription: String = ""
    
    // GAME NUMBER LABEL
    let gameNumberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Game Yo"
        label.textAlignment = .center
        label.textColor = supaDarkerGray
        label.adjustsFontSizeToFitWidth = true
        label.baselineAdjustment = .alignCenters
        label.font = UIFont.systemFont(ofSize: 130, weight: .semibold)
        return label
    }()
    
    // GAME NAME LABEL
    let gameNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Somethin"
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.baselineAdjustment = .alignCenters
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        return label
    }()
    
    // SETUP VIEWS
    override func setupViews() {
        super.setupViews()
        
        layer.masksToBounds = true
        layer.cornerRadius = 15
        layer.borderWidth = 3
        layer.borderColor = supaGray.cgColor
        
        addSubview(gameNumberLabel)
        gameNumberLabel.topAnchor.constraint(equalTo: topAnchor, constant: 4).isActive = true
        gameNumberLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        gameNumberLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.36).isActive = true
        gameNumberLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.15).isActive = true
        
        addSubview(gameNameLabel)
        gameNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        gameNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        gameNameLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.81).isActive = true
        gameNameLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.61).isActive = true
    }
}
