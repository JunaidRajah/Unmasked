//
//  UnmaskedViewController.swift
//  Unmasked
//
//  Created by Junaid Rajah on 2021/11/19.
//

import UIKit
import UnmaskedEngine

class UnmaskedViewController: UIViewController {
    
    private var unmaskedViewModel: UnmaskedViewModel?
    public var heroGroup: Int = 0
    @IBOutlet private weak var heroNameLabel: UILabel!
    @IBOutlet private weak var heroImageView: UIImageView!
    @IBOutlet private weak var infoScreenTitleLable: UILabel!
    @IBOutlet private weak var heroInfoView: UIView!
    
    @IBOutlet private weak var menuImage: UIImageView!
    @IBOutlet private weak var menuOuterImage: UIImageView!
    @IBOutlet private weak var powerButton: UIButton!
    @IBOutlet private weak var appearanceButton: UIButton!
    @IBOutlet private weak var biographyButton: UIButton!
    @IBOutlet private weak var workButton: UIButton!
    @IBOutlet private weak var connectionButton: UIButton!
    @IBOutlet private weak var unmaskedMenuView: UIView!
    
    @IBOutlet private weak var biographyBorder: UIImageView!
    @IBOutlet private weak var connectionBorder: UIImageView!
    @IBOutlet private weak var workBorder: UIImageView!
    @IBOutlet private weak var appearanceBorder: UIImageView!
    @IBOutlet private weak var powerBorder: UIImageView!
    
    public var hero: SuperheroResponseModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "unmaskedToCollection" {
            super.prepare(for: segue, sender: sender)
            let destination = segue.destination as! HeroCollectionViewController
            destination.heroGroup = heroGroup
        }
    }
    
    private func initialSetup() {
        guard let chosenHero = self.hero else {
            return
        }
        unmaskedViewModel = UnmaskedViewModel(hero: chosenHero,
                                              heroInfoGroup: .powerstats,
                                              delegate: self)
        heroImageView.loadImage(with: chosenHero.image.url)
        heroNameLabel.text = chosenHero.name
        infoScreenTitleLable.text = unmaskedViewModel?.heroInfoGroup.rawValue
        setupInfoView()
        menuSetup()
    }
    
    private func menuSetup() {
        rotateMenuButtons()
        rotateMenuBorders()
        autoShrinkAllButtonText()
    }
    
    private func rotateMenuButtons() {
        appearanceButton.transform = CGAffineTransform(rotationAngle: CGFloat.pi/6)
        biographyButton.transform = CGAffineTransform(rotationAngle: -(CGFloat.pi/6))
        workButton.transform = CGAffineTransform(rotationAngle: CGFloat.pi/6)
        connectionButton.transform = CGAffineTransform(rotationAngle: -(CGFloat.pi/6))
    }
    
    private func rotateMenuBorders() {
        appearanceBorder.transform = CGAffineTransform(rotationAngle: CGFloat.pi/6)
        biographyBorder.transform = CGAffineTransform(rotationAngle: -(CGFloat.pi/6))
        workBorder.transform = CGAffineTransform(rotationAngle: CGFloat.pi/6)
        connectionBorder.transform = CGAffineTransform(rotationAngle: -(CGFloat.pi/6))
    }
    
    private func autoShrinkAllButtonText() {
        autoShrinkButtonText(btn: powerButton)
        autoShrinkButtonText(btn: biographyButton)
        autoShrinkButtonText(btn: appearanceButton)
        autoShrinkButtonText(btn: workButton)
        autoShrinkButtonText(btn: connectionButton)
    }
    
    private func autoShrinkButtonText(btn: UIButton) {
        btn.titleLabel?.adjustsFontSizeToFitWidth = true
        btn.titleLabel?.minimumScaleFactor = CGFloat(0.3)
        btn.titleLabel?.lineBreakMode = NSLineBreakMode.byClipping
    }
    
    private func setupInfoView() {
        if heroInfoView.subviews.count != 0 {
            heroInfoView.subviews[0].removeFromSuperview()
        }
        
        switch unmaskedViewModel?.currentInfoGroup {
        case .powerstats:
            let view = PowerstatsView.instanceFromNib() as! PowerstatsView
            view.setup(pStat: unmaskedViewModel!.chosenHero!.powerstats)
            addInfoSubview(subview: view)
            
        case .biography:
            let view = HeroInfoView.instanceFromNib() as! HeroInfoView
            view.setupBiography(biography: unmaskedViewModel!.chosenHero!.biography)
            addInfoSubview(subview: view)
            
        case .appearance:
            let view = AppearanceView.instanceFromNib() as! AppearanceView
            view.setup(appear: unmaskedViewModel!.chosenHero!.appearance)
            addInfoSubview(subview: view)
            
        case .work:
            let view = HeroInfoView.instanceFromNib() as! HeroInfoView
            view.setupWork(work: unmaskedViewModel!.chosenHero!.work)
            addInfoSubview(subview: view)
            
        case .connections:
            let view = HeroInfoView.instanceFromNib() as! HeroInfoView
            view.setupConnections(connections: unmaskedViewModel!.chosenHero!.connections)
            addInfoSubview(subview: view)
            
        default:
            let view = PowerstatsView.instanceFromNib() as! PowerstatsView
            view.setup(pStat: unmaskedViewModel!.chosenHero!.powerstats)
            addInfoSubview(subview: view)
        }
    }
    
    private func addInfoSubview(subview: UIView) {
        heroInfoView.addSubview(subview)
        heroInfoView.subviews.first?.translatesAutoresizingMaskIntoConstraints = false
        let sub = heroInfoView.subviews.first!
        let leadingConstraint = NSLayoutConstraint(item: sub, attribute: .leading, relatedBy: .equal,
                                                   toItem: heroInfoView, attribute: .leading,
                                                   multiplier: 1, constant: 0)
        let trailingConstraint = NSLayoutConstraint(item: sub, attribute: .trailing, relatedBy: .equal,
                                                    toItem: heroInfoView, attribute: .trailing,
                                                    multiplier: 1, constant: 0)
        let topConstraint = NSLayoutConstraint(item: sub, attribute: .top, relatedBy: .equal,
                                               toItem: heroInfoView, attribute: .top,
                                               multiplier: 1, constant: 0)
        let bottomConstraint = NSLayoutConstraint(item: sub, attribute: .bottom, relatedBy: .equal,
                                                  toItem: heroInfoView, attribute: .bottom,
                                                  multiplier: 1, constant: 0)
        heroInfoView.addConstraints([leadingConstraint, trailingConstraint, topConstraint, bottomConstraint])
    }
    
    @IBAction func returnButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "unmaskedToCollection", sender: self)
    }
    
    @IBAction func heroOptionButtonPressed(_ sender: UIButton) {
        self.unmaskedMenuView.isHidden = false
        self.menuOuterImage.rotateCounterClockwise()
        self.menuImage.rotate()
        UIView.animate(withDuration: 2, delay: 0, options: [], animations: {
            self.unmaskedMenuView.alpha = 1
        }, completion: { _ in })
    }
    
    @IBAction func nextOptionButtonPressed(_ sender: UIButton) {
        unmaskedViewModel!.nextGroup()
    }
    
    @IBAction func menuOptionButtonPressed(_ sender: UIButton) {
        SwitchInfoView(btnNo: sender.tag)
        UIView.animate(withDuration: 0.5, delay: 0, options: [], animations: {
            self.unmaskedMenuView.alpha = 0
        }, completion: { _ in
            self.unmaskedMenuView.isHidden = true
            self.stopImageRotation()
        })
    }
    
    
    @IBAction func menuOptionHeldDown(_ sender: UIButton) {
        stopImageRotation()
        menuImage.rotate(duration: 2)
        menuOuterImage.rotateCounterClockwise(duration: 2)
    }
    
    private func SwitchInfoView(btnNo: Int) {
        switch btnNo {
        case 1:
            self.unmaskedViewModel?.heroInfoGroup = .powerstats
        case 2:
            self.unmaskedViewModel?.heroInfoGroup = .biography
        case 3:
            self.unmaskedViewModel?.heroInfoGroup = .appearance
        case 4:
            self.unmaskedViewModel?.heroInfoGroup = .work
        case 5:
            self.unmaskedViewModel?.heroInfoGroup = .connections
        default:
            self.unmaskedViewModel?.heroInfoGroup = .powerstats
        }
        self.changeGroup()
    }
    
    private func stopImageRotation() {
        menuImage.stopRotating()
        menuOuterImage.stopRotating()
    }
    
}

extension UnmaskedViewController: UnmaskedViewModelDelegate {
    func showErrorMessage(error: Error) {
        Alert.showCollectionHeroSelectFailAlert(on: self)
    }
    
    func changeGroup() {
        setupInfoView()
        infoScreenTitleLable.text = unmaskedViewModel?.currentInfoGroup.rawValue
    }
}

extension UIView {
    private static let kRotationAnimationKey = "rotationanimationkey"
    
    func rotate(duration: Double = 10) {
        if layer.animation(forKey: UIView.kRotationAnimationKey) == nil {
            let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
            
            rotationAnimation.fromValue = 0.0
            rotationAnimation.toValue = Float.pi * 2.0
            rotationAnimation.duration = duration
            rotationAnimation.repeatCount = Float.infinity
            
            layer.add(rotationAnimation, forKey: UIView.kRotationAnimationKey)
        }
    }
    
    func rotateCounterClockwise(duration: Double = 10) {
        if layer.animation(forKey: UIView.kRotationAnimationKey) == nil {
            let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
            
            rotationAnimation.fromValue = 0.0
            rotationAnimation.toValue = -(Float.pi * 2.0)
            rotationAnimation.duration = duration
            rotationAnimation.repeatCount = Float.infinity
            
            layer.add(rotationAnimation, forKey: UIView.kRotationAnimationKey)
        }
    }
    
    func stopRotating() {
        if layer.animation(forKey: UIView.kRotationAnimationKey) != nil {
            layer.removeAnimation(forKey: UIView.kRotationAnimationKey)
        }
    }
}
