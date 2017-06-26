//
//  DetailViewController.swift
//  NYTimes
//
//  Created by Adam on 26/6/17.
//  Copyright © 2017 MDT002MBP. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController{
    var arrArticles: Array<ArticleSearchModel> = []
    var selectedArticle:Int = 0
    @IBOutlet var webView: UIWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "The New York Times"
        self.goArticle(index: selectedArticle)
        //swipe left or right to go back or foward
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))
        
        leftSwipe.direction = .left
        rightSwipe.direction = .right
        
        view.addGestureRecognizer(leftSwipe)
        view.addGestureRecognizer(rightSwipe)
    }
    
    //swipe left to go forward
    func handleSwipes(sender:UISwipeGestureRecognizer) {
        if (sender.direction == .left) {
            print("left swipe")
            selectedArticle = selectedArticle + 1
        }
        //swipe right to go backward
        if (sender.direction == .right) {
            print("right swipe")
            selectedArticle = selectedArticle - 1
        }
        
        if(selectedArticle >= arrArticles.count){
            selectedArticle = 0
        }else if(selectedArticle < 0){
            selectedArticle = arrArticles.count - 1
        }
        
        self.goArticle(index: selectedArticle)
    }
    
    func goArticle(index: Int){
        let url = NSURL (string: "\(arrArticles[index].webUrl)")
        let requestObj = URLRequest(url: url! as URL);
        webView.loadRequest(requestObj)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
}
