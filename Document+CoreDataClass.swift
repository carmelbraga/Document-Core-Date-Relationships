//
//  Document+CoreDataClass.swift
//  Documents Core Data Relationships
//
//  Created by Carmel Braga on 9/26/19.
//  Copyright © 2019 Carmel Braga. All rights reserved.
//
//

import UIKit
import CoreData

@objc(Document)
public class Document: NSManagedObject {
    var date: Date?{
        get{
            return rawDate as Date?
        }
        set{
            rawDate = newValue as NSDate?
        }
    }
    
    convenience init?(name: String?, content: String?) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        guard let context = appDelegate?.persistentContainer.viewContext else{
            return nil
        }
        
        self.init(entity: Document.entity(), insertInto: context)
        self.name = name
        self.date = Date(timeIntervalSinceNow: 0)
        self.content = content
        if let size = content?.count {
            self.size = Int64(size)
        } else {
            self.size = 0
        }
    }
}
