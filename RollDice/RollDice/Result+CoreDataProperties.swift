//
//  Result+CoreDataProperties.swift
//  RollDice
//
//  Created by Santiago Pelaez Rua on 19/04/21.
//
//

import Foundation
import CoreData


extension Result {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Result> {
        return NSFetchRequest<Result>(entityName: "Result")
    }

    @NSManaged public var value: Int16
    @NSManaged public var dice: DiceResult?
}

extension Result : Identifiable {

}
