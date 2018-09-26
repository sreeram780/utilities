//
//  UIImage+PHAsset.swift
//  UtilitiesAndHelpers
//
//  Created by HTS on 9/10/18.
//  Copyright © 2018 HTS. All rights reserved.
//

import Foundation
import UIKit
import Photos

func getAssetThumbnail(asset: PHAsset, size: CGFloat) -> UIImage
{
    let retinaScale = UIScreen.main.scale
    let retinaSquare = CGSize(width: size * retinaScale, height: size * retinaScale)//(size * retinaScale, size * retinaScale)
    let cropSizeLength = min(asset.pixelWidth, asset.pixelHeight)
    let square = CGRect(x:0, y: 0,width: CGFloat(cropSizeLength),height: CGFloat(cropSizeLength))
    let cropRect = square.applying(CGAffineTransform(scaleX: 1.0/CGFloat(asset.pixelWidth), y: 1.0/CGFloat(asset.pixelHeight)))
    let manager = PHImageManager.default()
    let options = PHImageRequestOptions()
    var thumbnail = UIImage()
    options.isSynchronous = true
    options.deliveryMode = .highQualityFormat
    options.resizeMode = .exact
    options.normalizedCropRect = cropRect
    manager.requestImage(for: asset, targetSize: retinaSquare, contentMode: .aspectFit, options: options, resultHandler: {(result, info)->Void in
        thumbnail = result!
    })
    return thumbnail
}
