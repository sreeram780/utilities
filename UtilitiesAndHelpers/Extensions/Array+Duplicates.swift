//
//  ArrayExtension.swift
//  UtilitiesAndHelpers
//
//  Created by HTS on 5/10/18.
//  Copyright © 2018 HTS. All rights reserved.
//

import Foundation


extension Array
{
    // for Modeled array
//     self.array_SearchProducts = self.array_SearchProducts.filterDuplicates { $0.propertone == $1.propertone }
    func filterDuplicates(includeElement:(_ lhs:Element, _ rhs:Element) -> Bool) -> [Element]
    {
        var results = [Element]()
        
        forEach { (element) in
            let existingElements = results.filter
            {
                return includeElement(element, $0)
            }
            if existingElements.count == 0
            {
                results.append(element)
            }
        }
        return results
    }
}
