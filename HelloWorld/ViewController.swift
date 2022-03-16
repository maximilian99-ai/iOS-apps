//
//  ViewController.swift
//  HelloWorld
//
//  Created by Max's MacBook Pro on 2021. 09. 26..
//

import UIKit

class ViewController: UIViewController {

    //click event
    @IBAction func Click_moveBtn1(_ sender: Any) {
        print("Clicked Move")
    }
    
    @IBAction func Click_moveBtn2(_ sender: Any) {
        //storyboard find controller: DetailController
        
        //옵셔널 바인딩
        if let controller = self.storyboard?.instantiateViewController(withIdentifier: "DetailController") {
            //push, add(?) controller = navi
            self.navigationController?.pushViewController(controller, animated: true)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

}
