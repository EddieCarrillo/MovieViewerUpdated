//
//  DetailViewController.swift
//  MovieViewer
//
//  Created by my mac on 2/4/17.
//  Copyright © 2017 Eduardo Carrillo. All rights reserved.
//

import UIKit
import AVKit
import MediaPlayer
import SVProgressHUD





class DetailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate,
UIWebViewDelegate{

   
    @IBOutlet weak var videoView: UIWebView!
    
//    var movie: NSDictionary!
    
    var movie: Movie!
   
    @IBOutlet var detailView: DetailMovieView!
    
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
     // videoView.isHidden = true
        
        detailView.scrollView.contentSize = CGSize(width: detailView.scrollView.frame.size.width, height: detailView.infoView.frame.origin.y + detailView.infoView.frame.size.height)
        
       detailView.movie = movie
        sendRequest()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func sendRequest(){
        let api = NetworkAPI.sharedInstance
    
        
        api.getMovie(by: "\(movie.id!)"  , successHandler: { (movieMap: NSDictionary) in
            
            //print("[NEWMAP: \(movieMap)]")
            self.movie = Movie(jsonMap: movieMap)
            
            
            self.detailView.movie = self.movie
            
        }) { (error: Error) in
            print("[ERROR] \(error)")
        }
        
//        api.get
        
        
    }
    
    public func webViewDidStartLoad(_ webView: UIWebView){
        print("Started video...")
    }
    
    
    

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
