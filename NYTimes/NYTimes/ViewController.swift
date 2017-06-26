//
//  ViewController.swift
//  NYTimes
//
//  Created by MDT002MBP on 6/21/17.
//  Copyright © 2017 MDT002MBP. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate, UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var searchBar: UISearchBar!
    
    var arrArticles: Array<ArticleSearchModel> = []
    var allArrArticles: Array<ArticleSearchModel> = []
    var currentPage = 0
    var arrRecentSearch: [String] = []
    var isSearching: Bool = false
    
    var tapGesture: UITapGestureRecognizer?
    
    // MARK: - UICollectionViewDataSource protocol
    // tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(isSearching && self.arrRecentSearch.count>0){
            return self.arrRecentSearch.count
        }
        return self.allArrArticles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if(isSearching && self.arrRecentSearch.count>0){
            return CGSize(width: collectionView.frame.width, height: 40)
        }else{
            return CGSize(width: collectionView.frame.width, height: 140)
        }
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(isSearching && self.arrRecentSearch.count>0){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HistoryCell", for: indexPath as IndexPath) as! HistoryCollectionViewCell
            
            // Use the outlet in our custom class to get a reference to the UILabel in the cell
            cell.lblText.text = self.arrRecentSearch.reversed()[indexPath.row]
            
            return cell
        }else{
            // get a reference to our storyboard cell
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NYCollectionViewCell", for: indexPath as IndexPath) as! NYCollectionViewCell
            
            // Use the outlet in our custom class to get a reference to the UILabel in the cell
            cell.lblTitle.text = self.allArrArticles[indexPath.row].title
            cell.lblSnippet.text = self.allArrArticles[indexPath.row].snippet
            if(self.allArrArticles[indexPath.row].date.characters.count>0){
                let date = Util.dateFromStringWithFormat(dateString: self.allArrArticles[indexPath.row].date, formatString: "yyyy-mm-dd'T'HH:mm:ss+0000")
                cell.lblDate.text = Util.stringFromDateWithFormat(date: date, formatString: "yyyy-mm-dd hh:mm:ssa")
            }else{
                cell.lblDate.text = ""
            }
            if(self.allArrArticles[indexPath.row].img.count>0){
                let dic = self.allArrArticles[indexPath.row].img[0] as! [String : Any]
                let url = URL(string: "\(Url.imgBase)\(dic["url"] as! String)")
                let data = try? Data(contentsOf: url!)
                let image = UIImage(data: data!)
                cell.img.image = image
                cell.toTrail.constant = 55
            }else{
                cell.img.image = nil
                cell.toTrail.constant = 0
            }

            cell.backgroundColor = UIColor(white: 0.0, alpha: 0.08) // make cell more visible in our example project
            
            return cell
        }
    }
    
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
        if(collectionView.visibleCells.first?.isKind(of: HistoryCollectionViewCell.self))!{
            print(self.arrRecentSearch[indexPath.row])
            currentPage = 0
            searchBar.text = self.arrRecentSearch.reversed()[indexPath.row]
            self.getArticles(query: self.arrRecentSearch.reversed()[indexPath.row], page: currentPage)
        }else{
            print(self.allArrArticles[indexPath.row].title)
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
            controller.selectedArticle = indexPath.row
            controller.arrArticles = allArrArticles
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    func getArticles(query: String, page: Int){
        ServiceManager.articleSearch (query: query, page: page,completion: { (success, responseData) in
            if success {
                let dic:NSMutableDictionary = responseData as! NSMutableDictionary
                let dicResponse:NSMutableDictionary = dic["response"] as! NSMutableDictionary
                let arrDocs:NSMutableArray = dicResponse["docs"] as! NSMutableArray
                for i in 0 ..< arrDocs.count {
                    let articleSearch =  ArticleSearchModel(JSON: arrDocs[i] as! [String : Any])
                    arrDocs.replaceObject(at: i, with: articleSearch)
                }
                self.arrArticles = NSArray(array:arrDocs) as! Array<ArticleSearchModel>
                if(page == 0){
                    self.allArrArticles = self.arrArticles
                }else{
                    self.allArrArticles.append(contentsOf: self.arrArticles)
                }
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        })
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        currentPage = 0
        self.getArticles(query: "",page: currentPage)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func tap(gesture: UITapGestureRecognizer) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.arrRecentSearch.append(searchBar.text!)
        if(self.arrRecentSearch.count>10){
            self.arrRecentSearch.removeFirst()
        }
        currentPage = 0
        self.getArticles(query: searchBar.text!,page: currentPage)
        searchBar.resignFirstResponder()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tap(gesture:)))
        view.addGestureRecognizer(tapGesture!)
        isSearching = true
        self.collectionView.reloadData()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        view.removeGestureRecognizer(tapGesture!)
        isSearching = false
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (scrollView.bounds.maxY == scrollView.contentSize.height) {
            currentPage = currentPage + 1
            self.getArticles(query: searchBar.text!, page: currentPage)
        }
    }
}

