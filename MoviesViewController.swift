//
//  MoviesViewController.swift
//  MovieViewer
//
//  Created by my mac on 2/1/17.
//  Copyright © 2017 Eduardo Carrillo. All rights reserved.
//

import UIKit
import AFNetworking
import SVProgressHUD


class MoviesViewController: UIViewController, UICollectionViewDataSource, UISearchBarDelegate
    
{
   
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var navBar: UINavigationItem!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet var backgroundView: UIView!
    @IBOutlet weak var errorButton: UIButton!
    
    
    var movies : [NSDictionary]?
    var endpoint : String!
    var filteredData : [NSDictionary]!
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (endpoint == nil){
            endpoint = "now_playing"
        }
        //Initially data is unfiltered
        filteredData = movies
        
        errorButton.isUserInteractionEnabled = true
        
        //Let this controller be in charge of manipulating tableview
        collectionView.dataSource = self;
        //This class implements search bar functions
        searchBar.delegate = self
        
        
      
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        
        let cellsPerLine = 2
        
        let interItemSpacingTotal = layout.minimumInteritemSpacing * CGFloat((cellsPerLine - 1))
        print("interitem spacing: \(interItemSpacingTotal)")
        
        
        let width = (collectionView.frame.size.width - interItemSpacingTotal) / CGFloat(cellsPerLine)
        layout.itemSize = CGSize(width:(collectionView.frame.size.width - interItemSpacingTotal) / CGFloat(cellsPerLine), height: (3/2)*width)
     
        self.searchBar.barTintColor = UIColor.black
        self.searchBar.tintColor =  UIColor(red: 255/255.0, green: 215.0/255, blue: 0/255, alpha: 1.0)
        
        
        initUIRefreshControl()
        
        SVProgressHUD.show()
        SVProgressHUD.setOffsetFromCenter(UIOffsetMake(0.0, 0.0))
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let filteredData = filteredData {
            return filteredData.count
        }else if let movies = movies {
            return movies.count
        }
        
        return 0;
    }
    
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.reuseId, for: indexPath as IndexPath) as! MovieCell
      
        let movie = Movie(jsonMap: self.filteredData![indexPath.row])
          
        cell.movie = movie
        
        
        return cell
    }
 
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        filteredData = searchText.isEmpty ? movies : movies?.filter({(data: NSDictionary) -> Bool in
            // If dataItem matches the searchText, return true to include it
            if let text = data["title"] as? String{
                return text.range(of: searchText, options: .caseInsensitive) != nil ;
            }
            return false;
        })
        print("called")
        collectionView.reloadData()
    }
    
    func refreshControlAction(_ refreshControl: UIRefreshControl) {
        
        // ... Create the URLRequest `myRequest` ...
        print("\n\nrefresh control action called!\n\n")
        sendRequest()
        
        
    }
    
   
    @IBAction func onErrorButtonTouch(_ sender: Any) {
        sendRequest()
        
    }
    
    
    
    func loadMovieImage(posterPath: String, for cell: MovieCell){
        let baseUrl = "https://image.tmdb.org/t/p/w500"
        let imageUrl = URL(string: baseUrl + posterPath)
        
        let imageRequest = URLRequest(url: imageUrl!)
        cell.posterView.setImageWith(imageRequest, placeholderImage: nil, success: { (request: URLRequest, response:HTTPURLResponse?, image: UIImage) in
            //Image response will be nil if the image is cached.
            if response != nil {
                print("Image was not cached, so fade in image.")
                cell.posterView.alpha = 0.0
                cell.posterView.image = image
                
                UIView.animate(withDuration: 0.3, animations: {
                    cell.posterView.alpha = 1.0
                })
            }else { //Image came from the cache
                cell.posterView.image = image
            }
        }, failure: { (request: URLRequest, response: HTTPURLResponse?, error: Error) in
            print("[ERROR] \(error)")
        })
    }
    
    func sendRequest(){
        
        
        let api = NetworkAPI.sharedInstance
        
        api.getMovies(endpoint: self.endpoint, successHandler: { (movies: [NSDictionary]) in
            self.movies = movies
            //Success
            self.filteredData = self.movies
            //Update the collectionview with its new data
            self.collectionView.reloadData()
            self.refreshControl.endRefreshing()
            print("\n\nData is updated\n\n")
            SVProgressHUD.dismiss()
            self.errorButton.isHidden = true
        }) { (error: Error) in
            
            //Error
            self.errorButton.isHidden = false
            self.errorButton.isHighlighted = true
            
            self.backgroundView.bringSubview(toFront: self.errorButton)
            SVProgressHUD.show()
            self.refreshControl.endRefreshing()
            print("\n\nNetwork error has occurred\n\n")
        }
        
        
    }
    
    
    func initUIRefreshControl(){
        //Track the event when tableview is pulled.
        self.refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControlEvents.valueChanged)
        //Add the refresh control to the screen.
        self.collectionView.insertSubview(refreshControl, at: 0)
        //To indirectly trigger first network call to server
        refreshControlAction(refreshControl)

    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let cell = sender as! UICollectionViewCell
        let indexPath = collectionView.indexPath(for: cell)
        let movieDictionary = filteredData![indexPath!.row]
        let movie = Movie(jsonMap: movieDictionary)
        
        let detailViewController = segue.destination as! DetailViewController
        detailViewController.movie = movie
        
        print("prepare for seque called")
        
    }
    

}
