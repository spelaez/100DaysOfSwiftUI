//
//  DiceResult+CoreDataProperties.swift
//  RollDice
//
//  Created by Santiago Pelaez Rua on 19/04/21.
//
//

import Foundation
import CoreData


extension DiceResult {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DiceResult> {
        return NSFetchRequest<DiceResult>(entityName: "DiceResult")
    }

    @NSManaged public var dices: Int16
    @NSManaged public var id: UUID?
    @NSManaged public var sides: Int16
    @NSManaged public var result: NSSet
    
    var wrappedResult: [Result] {
        get {
            result.allObjects as? [Result] ?? []
        }
        set {
            result = NSSet(array: newValue)
        }
    }
    
    var total: Int16 {
        return wrappedResult.map{ $0.value }.reduce(0, +)
    }

}

// MARK: Generated accessors for result
extension DiceResult {

    @objc(addResultObject:)
    @NSManaged public func addToResult(_ value: Result)

    @objc(removeResultObject:)
    @NSManaged public func removeFromResult(_ value: Result)

    @objc(addResult:)
    @NSManaged public func addToResult(_ values: NSSet)

    @objc(removeResult:)
    @NSManaged public func removeFromResult(_ values: NSSet)

}

extension DiceResult : Identifiable {

}
