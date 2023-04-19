//
//  ViewController.swift
//  facedetectissue
//
//  Created by petertao on 9/23/22.
//

import UIKit

class TestViewModel {
  var image: UIImage
  var text: String
  var faceFrame:CGRect
  
  init(image: UIImage, text: String, faceFrame:CGRect) {
    self.image = image
    self.text = text
    self.faceFrame = faceFrame
  }
}

class ViewController: UIViewController {
  
  var images:[UIImage] = []
  var vms:[TestViewModel] = []

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    
    let button = UIButton(type: .system)
    button.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(button)
    button.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
    button.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true
    button.widthAnchor.constraint(equalToConstant: 250).isActive = true
    button.heightAnchor.constraint(equalToConstant: 50).isActive = true
    button.setTitle("Run face detect 100 times", for: .normal)
    button.addTarget(self, action: #selector(runFaceDetect), for: .touchUpInside)
    
    let button2 = UIButton(type: .system)
    button2.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(button2)
    button2.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
    button2.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 12).isActive = true
    button2.widthAnchor.constraint(equalToConstant: 250).isActive = true
    button2.heightAnchor.constraint(equalToConstant: 50).isActive = true
    button2.setTitle("Print images", for: .normal)
    button2.addTarget(self, action: #selector(printImages), for: .touchUpInside)
    

    
    
    
  }
  
  @objc func printImages() {
    print(images[images.count-1], images.count)
  }
  
  @objc func runFaceDetect() {
    print("starting!")
    let serialQueue = DispatchQueue(label: "face_detect")

    let testImage = UIImage(named: "person")!.clone()!
    for i in 0..<100 {
      print(i)
      serialQueue.async {
        let faceRect = FaceFinder.findFace(inputImage: testImage)!  // We know there's a face in this one
        print(faceRect)
        let vm = TestViewModel(image: testImage, text: "too", faceFrame: faceRect)
        self.vms.append(vm)
        self.images.append(testImage.clone()!)
      }
    }
    serialQueue.async {
      print("Ran face detect 100 times!")
    }
  }
  
  func makeTestImage() -> UIImage {
    return UIImage(named: "person")!
//    let imageSize = view.frame.size
//    let color: UIColor = .black
//    UIGraphicsBeginImageContextWithOptions(imageSize, true, 0)
//    let context = UIGraphicsGetCurrentContext()!
//    color.setFill()
//    context.fill(CGRect(x: 0, y: 0, width: imageSize.width, height: imageSize.height))
//    let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
//    UIGraphicsEndImageContext()
//    return image
  }


}


extension UIImage {
    func clone() -> UIImage? {
        guard let originalCgImage = self.cgImage, let newCgImage = originalCgImage.copy() else {
            return nil
        }

        return UIImage(cgImage: newCgImage, scale: self.scale, orientation: self.imageOrientation)
    }
}
