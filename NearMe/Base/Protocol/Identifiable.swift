//
//  Identifiable.swift
//  NearMe
//
//  Created by Eren Besel on 2019/08/21.
//  Copyright © 2019 Eren Besel. All rights reserved.
//

import UIKit

/// `Identifiable` defines a simple interface for objects to easily have a unique string identifier.
protocol Identifiable {
    static var identifier: String { get }
}

extension Identifiable where Self: NSObject {
    static var identifier: String {
        return (NSStringFromClass(classForCoder()).components(separatedBy: ".").last ?? "") + "Identifier"
    }
}

extension UITableViewCell: Identifiable {}
extension UICollectionViewCell: Identifiable {}

extension UINib {
    convenience init(classType: AnyClass, bundle: Bundle? = nil) {
        self.init(nibName: NSStringFromClass(classType).components(separatedBy: ".").last ?? "", bundle: bundle)
    }
}
