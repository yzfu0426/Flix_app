//
//  SuperheroViedoViewController.swift
//  Flix
//
//  Created by 傅羽竹 on 2021/9/19.
//

import UIKit
import WebKit

class SuperheroViedoViewController: UIViewController {
    var id: Int64!
    var movie: [String: Any]!
    var result = [String: Any]()
    var key: String!
    
    @IBOutlet weak var webview: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*
        let video_url = movie["video"] as! String
        */
        
          let trailer_url = URL(string:"https://api.themoviedb.org/3/movie/" + String(id) + "/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        print(trailer_url)
        let request = URLRequest(url: trailer_url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { [self] (data, response, error) in
             // This will run when the network request returns
             if let error = error {
                    print(error.localizedDescription)
             } else if let data = data {
                    // Get the array of movies
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]

                self.result = dataDictionary["results"] as! [String:Any]
                   self.key = self.result["key"] as? String
                    //print(dataDictionary)
//                    // Reload your table view data
//
             }
        }
        task.resume()
        
        
        
        webview.load(URLRequest(url: URL(string: "https://www.youtube.com/watch?v=" + key)!))

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
