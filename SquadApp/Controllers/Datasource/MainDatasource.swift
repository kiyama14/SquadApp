//
//  MainDatasource.swift
//  SquadApp
//
//  Created by Mauricio Takashi Kiyama on 4/18/18.
//  Copyright © 2018 Marcio Kazuo Kiyama. All rights reserved.
//

import LBTAComponents
import CoreData
import GoogleMobileAds
import SwiftyStoreKit

// MAIN DATASOURCE
class MainDatasource: Datasource {
    
    override func footerClasses() -> [DatasourceCell.Type]? {
        return [MainFooter.self]
    }
    
    override func cellClasses() -> [DatasourceCell.Type] {
        return [MainCell.self]
    }
    
    override func item(_ indexPath: IndexPath) -> Any? {
        return userChallenges[indexPath.item].challengeNumber
    }
    
    override func numberOfItems(_ section: Int) -> Int {
        return userChallenges.count
    }
    
}

