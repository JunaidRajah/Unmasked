//
//  HeroInfoView.swift
//  Unmasked
//
//  Created by Junaid Rajah on 2021/11/19.
//

import UIKit

final class HeroInfoView: UIView {
    
    @IBOutlet private weak var infoStack: UIStackView!
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "HeroInfoView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }
    
    func setupBiography(biography: Biography) {
        addSegment(title: "Full Name", element: biography.fullName)
        addSegment(title: "Alter Egos", element: biography.alterEgos)
        
        addTitle(title: "Aliases")
        for alias in biography.aliases {
            addElement(element: alias)
        }
        
        addSegment(title: "Place of Birth", element: biography.placeOfBirth)
        addSegment(title: "First Appearance", element: biography.firstAppearance)
        addSegment(title: "Publisher", element: biography.publisher)
        addSegment(title: "Alignment", element: biography.alignment)
    }
    
    func setupWork(work: Work) {
        addSegment(title: "Base", element: work.base)
        addSegment(title: "Occupation", element: work.occupation)
    }
    
    func setupConnections(connections: Connections) {
        addSegment(title: "Group Affiliations", element: connections.groupAffiliation)
        addSegment(title: "Relatives", element: connections.relatives)
    }
    
    private func filterElements(element: String) {
        let separators = CharacterSet(charactersIn: ",;)")
        let elementArr = element.components(separatedBy: separators)

        for elements in elementArr {
            addElement(element: elements)
        }
    }
    
    private func addSegment(title: String, element: String) {
        addTitle(title: title)
        filterElements(element: element)
    }
    
    private func addTitle(title: String) {
        let titleView = InfoTitleView.instanceFromNib() as! InfoTitleView
        titleView.setup(title: title)
        infoStack.addArrangedSubview(titleView)
    }
    
    private func addElement(element: String) {
        let elementView = InfoElementView.instanceFromNib() as! InfoElementView
        elementView.setup(element: element)
        infoStack.addArrangedSubview(elementView)
    }
}
