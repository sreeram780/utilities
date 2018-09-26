//
//  NSManagedObjectExt.swift
//  UtilitiesAndHelpers
//
//  Created by HTS on 4/11/18.
//  Copyright © 2018 HTS. All rights reserved.
//

import Foundation
import CoreData

// Convert from NSManagedObject  to [String: AnyObject]
extension NSManagedObject{
    
    // The method copies NSManageObject into a Dictionary. the method initially goes through NSManageObject's attributes, copying each attribute then it goes through its relations. By recurisve calls relation objects are transformed into dictionary, which are then placed into the parent Dictionary. In order to avaid circular relations, the Objects that have already been traversed are placed in to a set  and if they are visited again they are ignored
    private func toDictionaryWithTraversal(traversalHistory: NSMutableSet? = nil)->[String: AnyObject]{
        
        let attributes = self.entity.attributesByName
        let relationships = self.entity.relationshipsByName
        let capacity = self.entity.attributesByName.count + self.entity.relationshipsByName.count + 1
        var dict = [String: AnyObject]()
        
        let localTraversalHistory = traversalHistory ?? NSMutableSet(capacity: capacity)
        localTraversalHistory.add(self)
        dict["class"] = self.entity.name! as AnyObject
        
        //println("Going through Object attributes...")
        for (attr, _) in attributes{
            let value: AnyObject? = self.value(forKey: attr as String) as AnyObject
            if value != nil {
                if (value as? NSCoding) != nil{
                    dict[attr as String]  = value!
                }else{
                    print("Attribute is not NSCoding complient")
                }
            }
        }
        //println("attributes copied")
        //println("Going through Object relationships...")
        for (rel, _) in relationships{
            let value: AnyObject? = self.value(forKey: rel as String) as AnyObject as AnyObject
            switch value {
            // To-many relationship
            case let relatedObjects as NSSet:
                // Our set holds a collection of dictionaries
                var dictSet = [[String: AnyObject]]()
                
                for object in relatedObjects {
                    if !localTraversalHistory.contains(object){
                        dictSet.append(
                            (object as! NSManagedObject).toDictionaryWithTraversal(traversalHistory: localTraversalHistory))
                    }
                }
                dict[rel as String] =  dictSet as AnyObject
            // To-one relationship
            case let object as NSManagedObject where !localTraversalHistory.contains(object) :
                // Call toDictionary on the referenced object and put the result back into our dictionary.
                dict[rel as String] =  object.toDictionaryWithTraversal(traversalHistory: localTraversalHistory) as AnyObject
            default:
                // there are two types of nil
                //1. non initialised/set attribtues/objects
                //2. inverse relationships
                print("inverse reached")
                
                
            }
        }
        //println("\(self.entity.name!) Relationships copied")
        
        if traversalHistory == nil {
            localTraversalHistory.removeAllObjects()
        }
        return dict
    }
    
    
    //Public method
    func toDictionary()->[String: AnyObject]{
        return self.toDictionaryWithTraversal()
    }
    
    // The method goes through every Dictionary elemet and populates its NSManaged object attributes and relations with values
    func populateFromDictionary(dict: [String: AnyObject]) -> NSManagedObject?{
        
        for (key, value) in dict{
            
            if key == "class" {
                continue
            }
            switch value {
            // This is a to-one relationship
            case let object as [String: AnyObject]:
                let relatedObject = NSManagedObject.fromDictionary(dict: object, context: self.managedObjectContext!)
                self.setValue(relatedObject, forKey: key)
                
            // This is a to-many relationship
            case let relatedObjectDictionaries as [[String: AnyObject]]:
                // Get a proxy set that represents the relationship, and add related objects to it.
                let relatedObjects = self.mutableSetValue(forKey: key)
                for relatedObjectDict in relatedObjectDictionaries{
                    let relatedObject = NSManagedObject.fromDictionary(dict: relatedObjectDict,context: self.managedObjectContext!)
                    relatedObjects.add(relatedObject)
                }
            default:
                self.setValue(value, forKey: key)
                // println("PUT NSDATE FROM DICT TO NSMANAGE OBJECT ATTR")
            }
        }
        return self
    }
    
    // Class method that transforms NSObjects from Dictionaries into NSManagedObjects. the method creates an NSObject which is then populated
    class func fromDictionary(dict: [String: AnyObject], context: NSManagedObjectContext)->NSManagedObject{
        
        let name = dict["class"]! as! String
        let newObject =  NSEntityDescription.insertNewObject(forEntityName: name, into: context) as NSManagedObject
        return newObject.populateFromDictionary(dict: dict)!
    }
}
