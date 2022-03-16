//
//  ViewController.swift
//  SampleWebView
//
//  Created by Max's MacBook Pro on 2021. 10. 11..
//

import UIKit
import WebKit

class ViewController: UIViewController {

    @IBOutlet weak var WebViewMain: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // 1. URL을 string으로 대입
        // 2. 이 URL을 request로 변환
        // 3. 변환한 URL을 Load
        
        let urlString = "https://google.com"
        if let url = URL(string: urlString) { //unwrapping (혹은) → 옵셔널 바인딩 라고 표현
            let urlReq = URLRequest(url: url)
            WebViewMain.load(urlReq)
        }
        
//        let abc = "1"
//        let abc1: String? = nil
//
//        let aaa = abc1!
//
//        let abc2 = "2"
    }

}
