//
//  Fullimage.swift
//  d03
//
//  Created by Liudmyla POHRIBNIAK on 4/04/19.
//  Copyright © 2019 Liudmyla POHRIBNIAK. All rights reserved.
//

import UIKit

class Fullimage: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrolling: UIScrollView!
    var image: UIImage!
    var imageFullsize: UIImageView!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        scrolling.delegate = self
        imageFullsize = UIImageView(image: image)
        scrolling.addSubview(imageFullsize!)
        scrolling.contentSize = imageFullsize.frame.size
        scrolling.clipsToBounds = true
//        imageFullsize.contentMode = UIViewContentMode.scaleAspectFit
        scrolling.minimumZoomScale = 0.05
        scrolling.maximumZoomScale = 200
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageFullsize
    }
}

