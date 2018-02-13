//
//  MovieCell.swift
//  MovieViewer
//
//  Created by my mac on 2/4/17.
//  Copyright © 2017 Eduardo Carrillo. All rights reserved.
//

import UIKit

class MovieCell: UICollectionViewCell {
    
    static let reuseId = "MovieCell"
    
    @IBOutlet weak var posterView: UIImageView!
    
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var averageRatingLabel: UILabel!
    
    
    var movie: Movie? {
        didSet {
            guard let movie = self.movie, let posterPath = movie.posterPath else {
                return;
            }
            
            if let dateString = movie.releaseDate {
                //                    self.dateLabel.text = date
                
                
                let oldDateFormatStr = "yyyy-MM-dd"
                var oldDateFormat = DateFormatter()
                oldDateFormat.dateFormat = oldDateFormatStr
                
                let dateWithOldFormat = oldDateFormat.date(from: dateString)
                let newDateFormat = DateFormatter()
                newDateFormat.dateFormat = "MMM d, yyyy"
                let newFormatDateStr = newDateFormat.string(from: dateWithOldFormat!)
                
                self.releaseDateLabel.text = newFormatDateStr
                
            }
            
            
            if let rating = movie.voteAverage {
                //Round the corners.
                averageRatingLabel.layer.cornerRadius = 5.0
                averageRatingLabel.layer.masksToBounds =  true
                averageRatingLabel.textAlignment = NSTextAlignment.center
                
                if rating >= 9.0 {
                   averageRatingLabel.backgroundColor = UIColor.blue
                }else if rating >= 7.5 {
                    averageRatingLabel.backgroundColor = UIColor.green
                }else if rating >= 5.0 {
                  averageRatingLabel.backgroundColor = UIColor(red: 255.0/255, green: 215.0/255, blue: 0, alpha: 1.0)
                }else if rating >= 3.0 {
                    averageRatingLabel.backgroundColor = UIColor.orange
                }else {
                    averageRatingLabel.backgroundColor = UIColor.red
                }
                
                
                
                averageRatingLabel.textColor = UIColor.white
                averageRatingLabel.text = "\(rating)/10"
            }
            let urlImageStr = NetworkAPI.sharedInstance.standardWidthImageBaseUrl
            posterView.setImageWith(URL(string: "\(urlImageStr)/\(posterPath)")!)
        }
    
    }
    
    
}
