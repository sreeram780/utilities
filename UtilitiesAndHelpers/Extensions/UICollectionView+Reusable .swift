//
//  UICollectionView+Reusable .swift
//  UtilitiesAndHelpers
//
//  Created by HTS on 9/7/18.
//  Copyright © 2018 HTS. All rights reserved.
//

import Foundation
import  UIKit

extension UICollectionView
{
    func registerReusableCell<T: UICollectionViewCell>(_: T.Type) where T: Reusable
    {
        if let nib = T.nib
        {
            self.register(nib, forCellWithReuseIdentifier: T.reuseIdentifier)
        }
        else
        {
            self.register(T.self, forCellWithReuseIdentifier: T.reuseIdentifier)
        }
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(indexPath: NSIndexPath) -> T where T: Reusable
    {
        return self.dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath as IndexPath) as! T
    }
    
    func registerReusableSupplementaryView<T: Reusable>(elementKind: String, _: T.Type)
    {
        if let nib = T.nib
        {
            self.register(nib, forSupplementaryViewOfKind: elementKind, withReuseIdentifier: T.reuseIdentifier)
        }
        else
        {
            self.register(T.self, forSupplementaryViewOfKind: elementKind, withReuseIdentifier: T.reuseIdentifier)
        }
    }
    
    func dequeueReusableSupplementaryView<T: UICollectionViewCell>(elementKind: String, indexPath: IndexPath) -> T where T: Reusable
    {
        return self.dequeueReusableSupplementaryView(ofKind: elementKind, withReuseIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }
}
