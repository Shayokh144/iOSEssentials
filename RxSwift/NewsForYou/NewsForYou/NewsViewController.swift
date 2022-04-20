//
//  NewsViewController.swift
//  NewsForYou
//
//  Created by Asif on 18/1/22.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

class NewsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let disposeBag = DisposeBag()
    private var articleList = [Article]()
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        populateNews()
    }

    private func configureTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        let cellNib = UINib(nibName: "NewsTableCell", bundle: nil)

        self.tableView.register(cellNib, forCellReuseIdentifier: "NewsTableCellId")
    }
    /*private func populateNews(){
        let jsonUrlString = "https://newsapi.org/v2/top-headlines?country=us&apiKey=db9c0877b39f45f79a193de49b136142"

            guard let url = URL(string: jsonUrlString) else{
                return
            }

            URLSession.shared.dataTask(with: url) { (data, res, err) in

                guard let data = data else {
                      return
                }

                do {
                    let json = try JSONDecoder().decode(ArticleList.self, from: data)

                } catch {
                    print("didnt work")
                }

            }.resume()
    }*/
    private func populateNews(){
        if let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=db9c0877b39f45f79a193de49b136142"){
            Observable.just(url).flatMap{url -> Observable<Data> in
                let request = URLRequest(url: url)
                return URLSession.shared.rx.data(request: request)
            }.map{ data -> [Article]? in
                return try? JSONDecoder().decode(ArticleList.self, from: data).articles
            }.subscribe(onNext:{[weak self] articles in
                if let articles = articles{
                    self?.articleList = articles
                    print(articles)
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                    }
                }
            }).disposed(by: disposeBag)
        }
    }

}

extension NewsViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articleList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableCellId") as? NewsTableCell {
            cell.titleLabel.text = self.articleList[indexPath.row].title
            cell.descriptionLabel.text = self.articleList[indexPath.row].description
            return cell
        }
        return UITableViewCell()
    }
    
    
}
