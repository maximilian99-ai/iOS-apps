//
//  NewsDetailController.swift
//  MaxTableView
//
//  Created by Max's MacBook Pro on 2021. 10. 31..
//

import UIKit

class NewsDetailController : UIViewController {
    
    @IBOutlet weak var ImageMain: UIImageView!
    
    @IBOutlet weak var LabelMain: UILabel!
    
    // image url
    // description
    
    var imageUrl: String?
    var desc: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //값이 있으면
        if let img = imageUrl {
            //이미지 가져와서 뿌림
            if let data = try? Data(contentsOf: URL(string: img)!) {
                //Main thread
                DispatchQueue.main.async {
                    self.ImageMain.image = UIImage(data: data)
                }
            }
        }
        
        if let d = desc {
            //본문을 보여줌
            self.LabelMain.text = d
        }
    }
}
