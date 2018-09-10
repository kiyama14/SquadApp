//
//  AboutController.swift
//  SquadApp
//
//  Created by Mauricio Takashi Kiyama on 4/12/18.
//  Copyright © 2018 Marcio Kazuo Kiyama. All rights reserved.
//


import UIKit

class AboutController: UIViewController {
    
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
    
    @objc func handleReturn() {
        dismiss(animated: true, completion: nil)
    }
    
    // MAURICIO IMAGE
    let mauricioImage: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "mauricioImage")
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.masksToBounds = true
        image.layer.borderWidth = 3
        image.layer.cornerRadius = 40
        image.layer.borderColor = supaGray.cgColor
        return image
    }()
    
    let setttingsLabel: UILabel = {
        let label = UILabel()
        label.text = "Mauricio Kiyama"
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.baselineAdjustment = .alignCenters
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 100, weight: .light)
        label.textColor = supaBlack
        return label
    }()
    
    // TEXT VIEW
    let textView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        return view
    }()
    
    // TEXT FIELD
    let textField: UILabel = {
        let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        let stringValue = "Mauricio is an aspiring software engineer from Sao Paulo, Brazil. After an unsuccesful boy-band career, he now wants to work for a big tech company to enjoy all the free food he keeps hearing about. Mauricio’s life goal is to help people to connect with each other and provide education for those that have no access to it. Mauricio loves to write in 3rd person. \n\n Buy the no-ads version of this app for true happiness!"
        let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: stringValue)
        attributedString.setColorForText(textForAttribute: "Sao Paulo", withColor: supaRed)
        attributedString.setColorForText(textForAttribute: "boy-band", withColor: supaBlue)
        attributedString.setColorForText(textForAttribute: "free food", withColor: supaPurple)
        attributedString.setColorForText(textForAttribute: "help", withColor: supaGreen)
        attributedString.setColorForText(textForAttribute: "education", withColor: supaDarkYellow)
        attributedString.setColorForText(textForAttribute: "Buy", withColor: supaPurple)
        text.attributedText = attributedString
        text.textAlignment = .center
        text.adjustsFontSizeToFitWidth = true
        text.baselineAdjustment = .alignCenters
        text.numberOfLines = 18
        text.font = UIFont.systemFont(ofSize: 200, weight: .light)
        return text
    }()
    
    let websiteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentMode = .scaleAspectFit
        button.setImage(#imageLiteral(resourceName: "interneticon"), for: .normal)
        button.addTarget(self, action: #selector(handleInternetButton), for: .touchUpInside)
        return button
    }()
    
    @objc func handleInternetButton() {
        if let url = URL(string: "https://mk.updog.co") {
            UIApplication.shared.open(url, options: [:]) {
                boolean in
            }
        }
    }
    
    let linkedInButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentMode = .scaleAspectFit
        button.setImage(#imageLiteral(resourceName: "linkedinicon"), for: .normal)
        button.addTarget(self, action: #selector(handleInternetButton), for: .touchUpInside)
        return button
    }()
    
    @objc func handleLinkedInButton() {
        if let url = URL(string: "https://www.linkedin.com/in/mauriciokiyama") {
            UIApplication.shared.open(url, options: [:]) {
                boolean in
            }
        }
    }
    
    let instagramButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentMode = .scaleAspectFit
        button.setImage(#imageLiteral(resourceName: "instagramicon"), for: .normal)
        button.addTarget(self, action: #selector(handleInternetButton), for: .touchUpInside)
        return button
    }()
    
    @objc func handleInstagramButton() {
        if let url = URL(string: "https://www.instagram.com/mauriciokiyama") {
            UIApplication.shared.open(url, options: [:]) {
                boolean in
            }
        }
    }
    
    let gitHubButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentMode = .scaleAspectFit
        button.setImage(#imageLiteral(resourceName: "githubicon"), for: .normal)
        button.addTarget(self, action: #selector(handleGitHubButton), for: .touchUpInside)
        return button
    }()
    
    @objc func handleGitHubButton() {
        if let url = URL(string: "https://github.com/kiyama14") {
            UIApplication.shared.open(url, options: [:]) {
                boolean in
            }
        }
    }
    
    let emailButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentMode = .scaleAspectFit
        button.setImage(#imageLiteral(resourceName: "mailicon"), for: .normal)
        button.addTarget(self, action: #selector(handleEmailButton), for: .touchUpInside)
        return button
    }()
    
    @objc func handleEmailButton() {
        let alertController = UIAlertController.init(title: "Mauricio's Email", message: "kiyama14@gmail.com", preferredStyle: .alert)
        let copy = UIAlertAction.init(title: "Copy", style: .default, handler: { action in
            let pasteboard = UIPasteboard.general
            pasteboard.string = "kiyama14@gmail.com"
        })
        let cancel = UIAlertAction.init(title: "Cancel", style: .cancel, handler: { action in
            
        })
        alertController.addAction(copy)
        alertController.addAction(cancel)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = supaWhite
        
        
        setupLayout()
    }
    
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
        
        
        // RETURN BUTTON setup
        
        topContainerView.addSubview(returnButton)
        returnButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 16).isActive = true
        returnButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        returnButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.14).isActive = true
        returnButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.03).isActive = true
        let returnTap = UITapGestureRecognizer(target: self, action: #selector(handleReturn))
        returnButton.addGestureRecognizer(returnTap)
        
        
        // MAURICIO IMAGE setup
        topContainerView.addSubview(mauricioImage)
        mauricioImage.centerXAnchor.constraint(equalTo: topContainerView.centerXAnchor).isActive = true
        mauricioImage.centerYAnchor.constraint(equalTo: topContainerView.centerYAnchor, constant: -15).isActive = true
        mauricioImage.widthAnchor.constraint(equalTo: topContainerView.widthAnchor, multiplier: 0.55).isActive = true
        mauricioImage.heightAnchor.constraint(equalTo: topContainerView.heightAnchor, multiplier: 0.6).isActive = true
        
        
        // SETTINGS LABEL setup
        self.view.addSubview(setttingsLabel)
        setttingsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        setttingsLabel.topAnchor.constraint(equalTo: mauricioImage.bottomAnchor, constant: 20).isActive = true
        setttingsLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6).isActive = true
        setttingsLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.06).isActive = true
        
        // setup textView
        view.addSubview(textView)
        textView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        textView.topAnchor.constraint(equalTo: setttingsLabel.bottomAnchor, constant: 10).isActive = true
        textView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9).isActive = true
        textView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4).isActive = true
        
        // setup textField
        textView.addSubview(textField)
        textField.centerXAnchor.constraint(equalTo: textView.centerXAnchor).isActive = true
        textField.centerYAnchor.constraint(equalTo: textView.centerYAnchor).isActive = true
        textField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        textField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.36).isActive = true
        
        // setup websiteButton
        bottomContainerView.addSubview(websiteButton)
        websiteButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        websiteButton.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 18).isActive = true
        websiteButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.08).isActive = true
        websiteButton.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.08).isActive = true
        
        // setup linkedInButton
        bottomContainerView.addSubview(linkedInButton)
        linkedInButton.centerYAnchor.constraint(equalTo: websiteButton.centerYAnchor).isActive = true
        linkedInButton.rightAnchor.constraint(equalTo: websiteButton.leftAnchor, constant: -16).isActive = true
        linkedInButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.08).isActive = true
        linkedInButton.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.08).isActive = true
        
        // setup instagramButton
        bottomContainerView.addSubview(instagramButton)
        instagramButton.centerYAnchor.constraint(equalTo: websiteButton.centerYAnchor).isActive = true
        instagramButton.leftAnchor.constraint(equalTo: websiteButton.rightAnchor, constant: 16).isActive = true
        instagramButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.08).isActive = true
        instagramButton.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.08).isActive = true
        
        // setup gitHubButton
        bottomContainerView.addSubview(gitHubButton)
        gitHubButton.centerYAnchor.constraint(equalTo: instagramButton.centerYAnchor).isActive = true
        gitHubButton.leftAnchor.constraint(equalTo: instagramButton.rightAnchor, constant: 16).isActive = true
        gitHubButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.08).isActive = true
        gitHubButton.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.08).isActive = true
        
        // setup emailButton
        bottomContainerView.addSubview(emailButton)
        emailButton.centerYAnchor.constraint(equalTo: linkedInButton.centerYAnchor).isActive = true
        emailButton.rightAnchor.constraint(equalTo: linkedInButton.leftAnchor, constant: -16).isActive = true
        emailButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.08).isActive = true
        emailButton.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.08).isActive = true
        
        
    }
    
    //internet    icon made by smash icon "Smashicons"
    //linkedin    icon made by Dave Gandy
    //instagram   icon made by Google
    //github      icon made by Dave Gandy
    //email       icon made by Chanut
    
    
    
}
