//
//  ViewController.swift
//  d03
//
//  Created by Liudmyla POHRIBNIAK on 4/04/19.
//  Copyright © 2019 Liudmyla POHRIBNIAK. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
 
    @IBOutlet weak var collectionView: UICollectionView!
    var flag: Int = 0
    var imageArray: [String] = ["https://www.clever-media.ru/getattachment/aaa5b3d4-f2ee-4366-94a3-394e891ed9af/book_attach_5519_78d6f62a-15fd-4977-9f59-8d88079777b6.jpg.aspx", "https://www.clever-media.ru/getattachment/d760ba2d-2628-4331-9dfb-91a094d0f2c5/book_attach_5519_b5df030f-ba49-4213-ab71-6e17dea36d5e.jpg.aspx", "https://www.clever-media.ru/getattachment/175c93cc-8088-4c9e-8599-d5e17fed6b81/book_attach_5505_3ac22aeb-d3c8-4c8e-82f4-758972228565.jpg.aspx", "https://www.clever-media.ru/getattachment/9e9d351c-80ca-4642-8c07-e61aa697234f/book_attach_5505_6c8c2715-361c-4f42-bb34-e7f62232b06c.jpg.aspx", "https://www.clever-media.ru/getattachment/9e9d351c-80ca-4642-8c07-e61aa697234f/book_attach_5505_6c8c2715-361c-4f42-bb34-e7f62232b06c.jpg.asp"]
    var arrayImage = [UIImage?](repeating: nil, count: 5)

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let DestViewController : Fullimage = segue.destination as! Fullimage
        if flag >= 0 && flag < 5 {
        DestViewController.image = arrayImage[flag]
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }
}

extension ViewController: UICollectionViewDataSource , UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        flag = indexPath.row
        performSegue(withIdentifier: "showImage", sender: "showImage")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width - 10) / 2 , height: (collectionView.frame.width - 10) / 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pictureCell", for: indexPath) as! PicturesCollectionCell
        cell.actIndicator.hidesWhenStopped = true
        cell.actIndicator.startAnimating()
        
        DispatchQueue.global().async {
            let url = URL(string: self.imageArray[indexPath.row])//check on null
            if let data = try? Data(contentsOf: url!) {
                DispatchQueue.main.async {
                    cell.image.image = UIImage(data: data)
                    self.arrayImage[indexPath.row] = cell.image.image!
                    cell.actIndicator.stopAnimating()
                }
            }
            else {
                DispatchQueue.main.async {
                    cell.image?.image = #imageLiteral(resourceName: "failed")
                    cell.actIndicator.stopAnimating()
                }
                let alertController = UIAlertController(title: "Error", message: "Cannot acces to \(url!)", preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(alertAction)
                self.present(alertController, animated: true, completion: nil)
            }
            
        }
        return cell
    }
}
