//
//  OldCode.swift
//  SquadApp
//
//  Created by Mauricio Takashi Kiyama on 4/12/18.
//  Copyright © 2018 Marcio Kazuo Kiyama. All rights reserved.
//


//UIColor(r: 220, g: 220, b: 220)



//    // NUMBER IN SQUAD LABEL
//    let numberInSquadLabel: UILabel = {
//        let label = UILabel()
//        label.text = "# of people:"
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.adjustsFontSizeToFitWidth = true
//        label.baselineAdjustment = .alignCenters
//        label.textAlignment = .center
//        label.font = UIFont.systemFont(ofSize: 130, weight: .heavy)
//        return label
//    }()
//
//    // INPUT FOR NUMBER FIELD
//    let inputForNumberField: UITextField = {
//        let inputLabel = UITextField()
//        inputLabel.translatesAutoresizingMaskIntoConstraints = false
//        inputLabel.layer.cornerRadius = 10
//        inputLabel.layer.masksToBounds = true
//        inputLabel.layer.borderColor = supaGray.cgColor
//        inputLabel.layer.borderWidth = 3
//        inputLabel.backgroundColor = UIColor.white
//        inputLabel.adjustsFontSizeToFitWidth = true
//        inputLabel.font = UIFont.systemFont(ofSize: 18, weight: .heavy)
//        inputLabel.textAlignment = .center
//        inputLabel.placeholder = "2"
//        inputLabel.tag = 1
//        return inputLabel
//    }()

//        // setup numberInSquadLabel
//        topContainerView.addSubview(numberInSquadLabel)
//        numberInSquadLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        numberInSquadLabel.topAnchor.constraint(equalTo: topContainerView.bottomAnchor, constant: -15).isActive = true
//        numberInSquadLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.65).isActive = true
//        numberInSquadLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.08).isActive = true
//
//        // setup inputForNumberView
//        topContainerView.addSubview(inputForNumberField)
//        inputForNumberField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        inputForNumberField.topAnchor.constraint(equalTo: numberInSquadLabel.bottomAnchor, constant: 10).isActive = true
//        inputForNumberField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.25).isActive = true
//        inputForNumberField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.12).isActive = true

//private let cellId = "cellId"
//private let headerId = "headerId"
//private let footerId = "footerId"
//
//class MainCell: UICollectionViewCell {
//    // this gets called when a cell is dequeued
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupViews()
//    }
//
//    let wordLabel: UILabel = {
//        let label = UILabel()
//        label.text = "TEST TEST TEST"
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//
//    func setupViews() {
//        backgroundColor = .yellow
//
//        addSubview(wordLabel)
//        wordLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
//        wordLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
//        wordLabel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
//        wordLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
//
//class MainController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        collectionView?.backgroundColor = supaYellow
//
//
//        self.collectionView!.register(MainCell.self, forCellWithReuseIdentifier: cellId)
//        self.collectionView?.register(UICollectionViewCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
//        self.collectionView?.register(UICollectionViewCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: footerId)
//
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//
//    // MARK: UICollectionViewDataSource
//
//    override func numberOfSections(in collectionView: UICollectionView) -> Int {
//
//        return 1
//    }
//
//    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//
//        return 2
//    }
//
//    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
//        cell.backgroundColor = supaBlue
//        cell.layer.masksToBounds = true
//        cell.layer.cornerRadius = 20
//
//        return cell
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: view.frame.width * 0.42, height: view.frame.width * 0.42)
//    }
//
//    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//
//        if kind == UICollectionElementKindSectionHeader {
//            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath)
//            header.backgroundColor = .orange
//            return header
//        } else {
//            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: footerId, for: indexPath)
//            footer.backgroundColor = .red
//            return footer
//        }
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        return CGSize(width: view.frame.width, height: 60)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
//        return CGSize(width: view.frame.width, height: 60)
//    }
//
//
//    // MARK: UICollectionViewDelegate
//
//    /*
//    // Uncomment this method to specify if the specified item should be highlighted during tracking
//    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
//        return true
//    }
//    */
//
//    /*
//    // Uncomment this method to specify if the specified item should be selected
//    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
//        return true
//    }
//    */
//
//    /*
//    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
//    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
//        return false
//    }
//
//    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
//        return false
//    }
//
//    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
//
//    }
//    */
//
//}

//     newChallenge[0].setValue(userChallenges[0].challengeName, forKey: "challengeName")
//newChallenge[0].setValue(userChallenges[0].challengeDescription, forKey: "challengeDescription")
//newChallenge[0].setValue(userChallenges[0].challengeNumber, forKey: "challengeNumber")
//newChallenge[0].setValue(userChallenges[0].numberOfPlayers, forKey: "numberOfPlayers")
//newChallenge[0].setValue(userChallenges[0].userDidIt, forKey: "userDidIt")


//// MAIN HEADER
//class MainHeader: DatasourceCell {
//
//    // SQUAD NAME LABEL
//    let squadNameLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.adjustsFontSizeToFitWidth = true
//        label.baselineAdjustment = .alignCenters
//        label.textAlignment = .center
//        label.font = UIFont.systemFont(ofSize: 50, weight: .heavy)
//        label.text = "Problem Here :("
//        label.isUserInteractionEnabled = true
//        return label
//    }()
//
//    @objc func handleNameChange() {
//        let alertController = UIAlertController.init(title: "Change Squad Name", message: "What will it be son?", preferredStyle: .alert)
//        alertController.addTextField { textField in
//            textField.placeholder = "e.g. Nacho & Esqueleto"
//            textField.textAlignment = .center
//        }
//
//        let copy = UIAlertAction.init(title: "Change", style: .default, handler: { action in
//
//            let textField = alertController.textFields![0]
//
//            //do the name change
//            let appDelegate = UIApplication.shared.delegate as! AppDelegate
//            let managedContext = appDelegate.persistentContainer.viewContext
//
//            let userFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
//            userFetch.fetchLimit = 1
//            userFetch.predicate = NSPredicate(format: "userId = %@", "Nacho")
//            userFetch.sortDescriptors = [NSSortDescriptor.init(key: "userId", ascending: true)]
//
//            let users = try! managedContext.fetch(userFetch)
//
//            let nacho: User = users.first as! User
//
//            nacho.squadName = textField.text
//            self.squadNameLabel.text = textField.text
//
//            do {
//                try managedContext.save()
//            } catch {
//                print("Failed saving")
//            }
//
//
//            print("Name Changed!")
//        })
//        let cancel = UIAlertAction.init(title: "Cancel", style: .cancel, handler: { action in
//        })
//        alertController.addAction(copy)
//        alertController.addAction(cancel)
//        self.window?.rootViewController?.present(alertController, animated: true, completion: nil)
//    }
//
//    // NO ADS BUTTON
//    let noAdsButton: UIImageView = {
//        let image = UIImageView()
//        image.translatesAutoresizingMaskIntoConstraints = false
//        image.contentMode = .scaleAspectFit
//        image.isUserInteractionEnabled = true
//        image.image = #imageLiteral(resourceName: "noadsicon")
//        return image
//    }()
//
//    // handleNoAdsTap()
//    @objc func handleNoAdsTap() {
//        print("Pay $0.99")
//    }
//
//    // SETTINGS BUTTON
//    let settingsButton: UIImageView = {
//        let image = UIImageView()
//        image.translatesAutoresizingMaskIntoConstraints = false
//        image.contentMode = .scaleAspectFit
//        image.isUserInteractionEnabled = true
//        image.image = #imageLiteral(resourceName: "settingsicon")
//        return image
//    }()
//
//    // handleSettingsTap()
//    @objc func handleSettingsTap() {
//        let settingsController = SettingsController()
//        self.window?.rootViewController?.present(settingsController, animated: true, completion: nil)
//    }
//
//    override func setupViews() {
//        super.setupViews()
//
//
//        backgroundColor = supaWhite
//        addBorder(side: .bottom, thickness: 3, color: supaGray)
//
//        loadSquadName()
//
////        addSubview(whiteBackgroundView)
////        whiteBackgroundView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
////        whiteBackgroundView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
////        whiteBackgroundView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
////        whiteBackgroundView.topAnchor.constraint(equalTo: (window?.topAnchor)!).isActive = true
//
//        addSubview(squadNameLabel)
//        squadNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
//        squadNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
//        squadNameLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7).isActive = true
//        squadNameLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.64).isActive = true
//        let squadtap = UITapGestureRecognizer(target: self, action: #selector(handleNameChange))
//        squadNameLabel.addGestureRecognizer(squadtap)
//
//        addSubview(noAdsButton)
//        noAdsButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
//        noAdsButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
//        noAdsButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.07).isActive = true
//        noAdsButton.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.07).isActive = true
//        let noAdsTap = UITapGestureRecognizer(target: self, action: #selector(handleNoAdsTap))
//        noAdsButton.addGestureRecognizer(noAdsTap)
//
//        addSubview(settingsButton)
//        settingsButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
//        settingsButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true
//        settingsButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.07).isActive = true
//        settingsButton.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.07).isActive = true
//        let settingsTap = UITapGestureRecognizer(target: self, action: #selector(handleSettingsTap))
//        settingsButton.addGestureRecognizer(settingsTap)
//    }
//
//    func loadSquadName() {
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        let context = appDelegate.persistentContainer.viewContext
//        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
//        request.returnsObjectsAsFaults = false
//
//        do {
//            let result = try context.fetch(request)
//            for data in result as! [NSManagedObject] {
//                squadNameLabel.text = (data.value(forKey: "squadName") as! String)
//            }
//        } catch {
//            print("Failed")
//        }
//    }
//
//}

//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        return CGSize(width: view.frame.width, height: view.frame.height * 0.128)
//    }
