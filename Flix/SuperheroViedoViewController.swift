//
//  SuperheroViedoViewController.swift
//  Flix
//
//  Created by 傅羽竹 on 2021/9/19.
//

import UIKit
import WebKit

class SuperheroViedoViewController: UIViewController {
    var id: String!
    var movie: [String: Any]!
    var result = [String: Any]()
    var key: String!
    var movieData : MovieData?
    
    @IBOutlet weak var webview: WKWebView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        getInfo()
        
        // Do any additional setup after loading the view.
    }
    
    func getInfo() {
        let url = "https://api.themoviedb.org/3/movie/\(id!)/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed"
        print(url)
        URLSession.shared.dataTask(with: URLRequest(url: URL(string: url)!), completionHandler: {data, response, error in
            guard let data = data, error == nil else {
                print("Error getting data")
                return
            }
            
            do {
                self.movieData = try JSONDecoder().decode(MovieData.self, from: data)
            } catch {
                print("Error decoding")
                return
            }
            
            DispatchQueue.main.async {
                let key = self.movieData?.results[0].key
                self.webview.load(URLRequest(url: URL(string: "https://www.youtube.com/watch?v=" + key!)!))
            }
            
            //print(self.movieData?.results[0].id)
        }).resume()
    }
    
    
    
    
}



struct MovieData: Codable {
    let results: [Video]
}

struct Video: Codable {
    let name: String
    let key: String
    let id: String
}
