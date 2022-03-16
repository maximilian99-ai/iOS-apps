//
//  ViewController.swift
//  MaxTableView
//
//  Created by Max's MacBook Pro on 2021. 10. 23..
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var TableViewMain: UITableView!
    
    //1. http 통신방법 - urlsession
    //2. JSON 데이터 형태 {"키":"값"}, {[{"키1":"값1"}, {"키2":"값2"}, {"키3":"값3"}...]} - 뉴스
    //3. 테이블 뷰의 데이터 매칭 -> 통보!
    // ✰ background: network / ui: main
    
    
    var newsData: Array<Dictionary<String, Any>>?
    
    func getNews() {
        let task = URLSession.shared.dataTask(with: URL(string: "https://newsapi.org/v2/top-headlines?country=kr&apiKey=9af9f1c912784cd8b2c15856385b9e9a")!) { [self] (data, response, error) in
            
            if let dataJson = data {
                
                //json parsing
                do {
                    let json = try JSONSerialization.jsonObject(with: dataJson, options: []) as! Dictionary<String, Any>
                    
                    //Dictionary
                    let articles = json["articles"] as! Array<Dictionary<String, Any>>
                    print(articles)
                    self.newsData = articles
                    
                    DispatchQueue.main.async {
                        self.TableViewMain.reloadData()
                    }
                }
                catch {}
            }
        }
        
        task.resume()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 몇 개의 데이터?
        
        if let news = newsData {
            return news.count
        }
        else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 무엇에 관한 데이터? 10번 반복
        // 임의의 셀 생성
//        let cell = UITableViewCell.init(style: .default, reuseIdentifier: "TableCellType1")
        
//        cell.textLabel?.text = "\(indexPath.row)"
        
        // 스토리보드 + id를 이용. 자주 사용하는 방식
        let cell = TableViewMain.dequeueReusableCell(withIdentifier: "Type1", for: indexPath) as! Type1
        
            // as? as! - 부모 자식 클래스 관계 확인
        
        
        let idx = indexPath.row
        
        if let news = newsData {
            
            let row = news[idx]
            
            if let v = row as? Dictionary<String, Any> {
                
                if let title = v["title"] as? String {
                    cell.LabelText.text = title
                }
            }
        }
        
        return cell
    }
    
    // 클릭하고 이벤트 발생
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(" Clicked! \(indexPath.row)")
        
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "NewsDetailController") as! NewsDetailController
        
        if let news = newsData {
            let row = news[indexPath.row]
            
            if let v = row as? Dictionary<String, Any> {
                
                if let imageUrl = v["urlToImage"] as? String {
                    controller.imageUrl = imageUrl
                }
                
                if let desc = v["description"] as? String {
                    controller.desc = desc
                }
            }
        }
        // 수동 이동
        showDetailViewController(controller, sender: nil)
    }
    
    // 세그웨이: 메서드의 부모-자식 관계
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let id = segue.identifier, "NewsDetail" == id {
            if let controller = segue.destination as? NewsDetailController {
                
                if let news = newsData {
                    let indexPath = sender as! IndexPath
                    let row = news[indexPath.row]
                    
                    if let v = row as? Dictionary<String, Any> {
                        
                        if let imageUrl = v["urlToImage"] as? String {
                            controller.imageUrl = "urlToImage"
                        }
                        
                        if let desc = v["description"] as? String {
                            controller.desc = "description"
                        }
                    }
                }
            }
        }
        // 자동 이동
    }
    
    // 디테일(상세) 화면 만들기
    // 값 보내기 → 2가지 방법: tableview delegate vs storyboard (segue)
    // 화면 이동  !이동하기 전에 값을 미리 세팅해야함!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        TableViewMain.delegate = self
        TableViewMain.dataSource = self
        
        
        getNews()
        
    }
    
    // tableview: 테이블로 된 뷰 - 여러 개의 행이 모여있는 목록 화면
    // 테이블 뷰의 목적: 정갈하고 깔끔하게 보여주기 위해  ex) 전화번호부
    
    // 1. 데이터 무엇? - 전화번호부 목록
    // 2. 데이터 몇 개? - 100, 1000, 10000
    // 3. (옵션) 데이터 행 누름 - 클릭
    
}
