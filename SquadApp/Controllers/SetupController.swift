//
//  SetupController.swift
//  SquadApp
//
//  Created by Mauricio Takashi Kiyama on 4/12/18.
//  Copyright © 2018 Marcio Kazuo Kiyama. All rights reserved.
//

import UIKit
import CoreData

class SetupController: UIViewController, UITextFieldDelegate {
    
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
    
    // SQUAD NAME LABEL
    let squadNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Squad name:"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.baselineAdjustment = .alignCenters
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 130, weight: .heavy)
        return label
    }()
    
    // INPUT FOR NAME LABEL
    let inputForNameField: UITextField = {
        let inputLabel = UITextField()
        inputLabel.translatesAutoresizingMaskIntoConstraints = false
        inputLabel.layer.cornerRadius = 10
        inputLabel.layer.masksToBounds = true
        inputLabel.layer.borderColor = supaGray.cgColor
        inputLabel.layer.borderWidth = 3
        inputLabel.backgroundColor = UIColor.white
        inputLabel.placeholder = "e.g. The Powerpuff Girls"
        inputLabel.tag = 0
        inputLabel.textAlignment = .center
        inputLabel.adjustsFontSizeToFitWidth = true
        inputLabel.font = UIFont.systemFont(ofSize: 18, weight: .heavy)
        inputLabel.returnKeyType = .next
        inputLabel.enablesReturnKeyAutomatically = true
        return inputLabel
    }()
    
    // DISCLAIMER CONT. VIEW
    let disclaimerContainerView: UIView = {
        let disView = UIView()
        disView.translatesAutoresizingMaskIntoConstraints = false
        disView.layer.cornerRadius = 10
        disView.layer.masksToBounds = true
        disView.layer.borderColor = supaGray.cgColor
        disView.layer.borderWidth = 3
        disView.backgroundColor = supaGray
        return disView
    }()
    
    // DISCLAMER TEXT FIELD
    let disclaimerTextView: UITextView = {
        let text = UITextView()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.backgroundColor = supaGray
        text.textColor = supaWhite
        text.textAlignment = .center
        text.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        text.isEditable = false
        text.isSelectable = false
        text.text = "Disclamer Below: \n \n The information contained on Squad mobile app is for general information purposes only. We assume no responsibility for any liability that the actions taken by using the app may cause. \n Use your best judgment when using the app. \n In no event shall be liable for any special, direct, indirect, consequential, or incidental damages or any damages whatsoever, whether in an action of contract, negligence or other tort, arising out of or in connection with the use of the Service or the contents of the Service. \n\n We reserve the right to make additions, deletions, or modifications to the contents on the Service at any time without prior notice. \n\n Thank you for using Squad!"
        return text
    }()
    
    // NEXT BUTTON
    let nextButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("I Agree", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.baselineAdjustment = .alignCenters
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont.systemFont(ofSize: 27, weight: .bold)
        button.backgroundColor = supaBlack
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(handleNextButton), for: .touchUpInside)
        return button
    }()
    
    // HANDLE NEXT BUTTON
    @objc func handleNextButton() {
        
        // numberOfChallenges
        var numberOfChallenges: Int = 0
        
        // JSON PARSING
        guard let path = Bundle.main.path(forResource: "challenges", ofType: "json") else { return }
        let url = URL(fileURLWithPath: path)
        do {
            let data = try Data(contentsOf: url)
            let challenges: [Challenges] = try JSONDecoder().decode([Challenges].self, from: data)
            numberOfChallenges = challenges.count
        } catch let jsonErr {
            print("Error serializing json:", jsonErr)
        }
        
        // CORE DATA
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let userEntity = NSEntityDescription.entity(forEntityName: "User", in: managedContext)!
        
        let newUser = NSManagedObject(entity: userEntity, insertInto: managedContext)
        
        newUser.setValue(true, forKey: "isUserSetup")
        newUser.setValue(inputForNameField.text, forKey: "squadName")
        newUser.setValue("Nacho", forKey: "userId")
        
        var arrayOfUserDidIt: [Int] = []
        
        for _ in 1...numberOfChallenges {
            arrayOfUserDidIt.append(0)
        }
        
        newUser.setValue(arrayOfUserDidIt, forKey: "arrayUserDidIt")
        
        
        let userPayedEntity = NSEntityDescription.entity(forEntityName: "UserPayed", in: managedContext)!
        
        let newUserPayed = NSManagedObject(entity: userPayedEntity, insertInto: managedContext)
        
        newUserPayed.setValue(false, forKey: "didUserPay")
        newUserPayed.setValue("Esqueleto", forKey: "didUserPayName")
        
    
        do {
            try managedContext.save()
        } catch {
            print("Failed saving")
        }
        
        // end of JSON parsing
        
        
        // check if the user is setup
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        request.returnsObjectsAsFaults = false
        do {
            let result = try managedContext.fetch(request)
            for data in result as! [NSManagedObject] {
                isUserSetup = (data.value(forKey: "isUserSetup") != nil)
            }
        } catch {
            print("Failed")
        }
        
        // present new controller
        let allSetController = AllSetController()
        present(allSetController, animated: true, completion: nil)
    }
    
    /**********************************************************
     VIEW DID LOAD, YO
     ***********************************************************/
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = supaYellow
        inputForNameField.delegate = self
        setupLayout()
    }
    
    // function textFieldShouldReturn
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        // Try to find next responder
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            // Not found, so remove keyboard.
            textField.resignFirstResponder()
        }
        // Do not add a line break
        return false
    }
    
    // SETUP LAYOUT FUNC
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
        
        // setup squadNameLabel
        topContainerView.addSubview(squadNameLabel)
        squadNameLabel.centerXAnchor.constraint(equalTo: topContainerView.centerXAnchor).isActive = true
        squadNameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        squadNameLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.72).isActive = true
        squadNameLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.08).isActive = true
        
        // setup inputForNameLabel
        topContainerView.addSubview(inputForNameField)
        inputForNameField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputForNameField.topAnchor.constraint(equalTo: squadNameLabel.bottomAnchor, constant: 20).isActive = true
        inputForNameField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.82).isActive = true
        inputForNameField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.12).isActive = true
        
        // setup disclaimerContainerView
        view.addSubview(disclaimerContainerView)
        disclaimerContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        disclaimerContainerView.topAnchor.constraint(equalTo: inputForNameField.bottomAnchor, constant: 20).isActive = true
        disclaimerContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.82).isActive = true
        disclaimerContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.46).isActive = true
        
        // setup disclaimerTextView
        disclaimerContainerView.addSubview(disclaimerTextView)
        disclaimerTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        disclaimerTextView.topAnchor.constraint(equalTo: inputForNameField.bottomAnchor, constant: 30).isActive = true
        disclaimerTextView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.78).isActive = true
        disclaimerTextView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.42).isActive = true
        
        // setup nextButton
        bottomContainerView.addSubview(nextButton)
        nextButton.centerYAnchor.constraint(equalTo: bottomContainerView.centerYAnchor, constant: 80).isActive = true
        nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nextButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.38).isActive = true
        nextButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.09).isActive = true
    }
    
    
    
}

