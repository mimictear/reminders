//
//  UIColorTransformer.swift
//  Reminders
//
//  Created by ANDREY VORONTSOV on 14.03.2023.
//

import UIKit

class UIColorTransformer: ValueTransformer {
    
    override func transformedValue(_ value: Any?) -> Any? {
        guard
            let color = value as? UIColor,
            let data = try? NSKeyedArchiver.archivedData(withRootObject: color, requiringSecureCoding: true)
        else {
            return nil
        }
        return data
    }
    
    override func reverseTransformedValue(_ value: Any?) -> Any? {
        guard
            let data = value as? Data,
            let color = try? NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: data)
        else {
            return nil
        }
        return color
    }
}
