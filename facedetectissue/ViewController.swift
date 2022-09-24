//
//  ViewController.swift
//  facedetectissue
//
//  Created by petertao on 9/23/22.
//

import UIKit

class ViewController: UIViewController {

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
//    button.setTitleColor(.black, for: .normal)
    button.addTarget(self, action: #selector(runFaceDetect), for: .touchUpInside)
    
    
    
  }
  
  @objc func runFaceDetect() {
    print("starting!")
    let serialQueue = DispatchQueue(label: "face_detect")

    let testImage = makeTestImage()
    for i in 0..<100 {
      print(i)
      serialQueue.async {
        print(FaceFinder.findFace(inputImage: testImage))
      }
    }
    serialQueue.sync {
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

