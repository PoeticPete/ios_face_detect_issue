//
//  FaceFinder.swift
//  testscrollviewpinch
//
//  Created by Peter Tao on 9/20/22.
//

import UIKit

class FaceFinder {
  
  private init() {}

  static func findFace(inputImage: UIImage) -> CGRect? {
    let ciImage = CIImage(cgImage: inputImage.cgImage!)
    
    var ret:CGRect? = nil
      let options = [CIDetectorAccuracy: CIDetectorAccuracyLow] as [String : Any]
      var faceDetector = CIDetector(ofType: CIDetectorTypeFace, context: nil, options: options)
      
      let faces = faceDetector?.features(in: ciImage, options: nil)
      print(faces)
      if let face = faces!.first as? CIFaceFeature {
        
        if face.hasLeftEyePosition {
        }
        
        if face.hasRightEyePosition {
        }
        
        if face.hasMouthPosition {
        }

        let actualHeight = inputImage.size.height * inputImage.scale
        let actualWidth = inputImage.size.width * inputImage.scale
        let translatedMinY = actualHeight - face.bounds.maxY // CIImage to UIKit coordinates
        let boundingBox = CGRect(x: face.bounds.minX/actualWidth, y: translatedMinY/actualHeight, width: face.bounds.width/actualWidth, height: face.bounds.height/actualHeight)
        
        ret = boundingBox
        faceDetector = nil
      }

    return ret
  }
}
