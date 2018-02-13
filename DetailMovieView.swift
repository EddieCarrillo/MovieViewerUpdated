//
//  DetailMovieView.swift
//  MovieViewer
//
//  Created by my mac on 9/27/17.
//  Copyright © 2017 Eduardo Carrillo. All rights reserved.
//

import UIKit

class DetailMovieView: UIView {
    
    
    
    
    
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var infoView: UIView!
    
    @IBOutlet weak var taglineLabel: UILabel!
    @IBOutlet weak var revenueLabel: UILabel!
    
    @IBOutlet weak var ratingLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var posterView: UIImageView!
    
    @IBOutlet weak var backdropView: UIImageView!
    
    @IBOutlet weak var genresLabel: UILabel!
    
    @IBOutlet weak var budgetLabel: UILabel!
    
    @IBOutlet weak var runtimeLabel: UILabel!
    
    var movie: Movie? {
        
        
        didSet{
            if let movie = self.movie {
                let title = movie.title
                titleLabel.text =  title
                //Gold
                titleLabel.textColor = UIColor(red: 255/255.0, green: 215.0/255, blue: 0/255, alpha: 1.0)
                
                let overview = movie.overview
                overviewLabel.text = overview
                let baseUrl = NetworkAPI.sharedInstance.standardWidthImageBaseUrl
                
                if let backdrop = movie.backdropPath{
                    let imageUrl = URL(string: baseUrl + backdrop)
                    backdropView.setImageWith(imageUrl!)
                }
                
                if let posterPath = movie.posterPath {
                    let imageUrl = URL(string: baseUrl + posterPath )
                    posterView.setImageWith(imageUrl!)
                }
                
                if let tagline = movie.tagline {
                    print("[TAGLINE]: \(tagline)")
                    self.taglineLabel.text = tagline
                    
                }
                
                if let rating = movie.voteAverage {
                    //Round the corners.
                    ratingLabel.layer.cornerRadius = 5.0
                    ratingLabel.layer.masksToBounds =  true
                    ratingLabel.textAlignment = NSTextAlignment.center
                    
                    if rating >= 9.0 {
                        ratingLabel.backgroundColor = UIColor.blue
                    }else if rating >= 7.5 {
                        ratingLabel.backgroundColor = UIColor.green
                    }else if rating >= 5.0 {
                        //rgb(255,215,0)
                        ratingLabel.backgroundColor = UIColor(red: 255.0/255, green: 215.0/255, blue: 0, alpha: 1.0)
                    }else if rating >= 3.0 {
                        ratingLabel.backgroundColor = UIColor.orange
                    }else {
                        ratingLabel.backgroundColor = UIColor.red
                    }
                    
                    
                    
                    ratingLabel.textColor = UIColor.white
                    ratingLabel.text = "\(rating)/10"
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
                    
                    self.dateLabel.text = newFormatDateStr
                    
                }
                
                if let revenue = movie.revenue {
                    let currencyFormatter = NumberFormatter()
                    currencyFormatter.numberStyle = NumberFormatter.Style.currency
                    currencyFormatter.locale = Locale.current
                    self.revenueLabel.text = currencyFormatter.string(from: NSNumber(value: revenue))! + "Box Office Sales"
                }
                
                
                var genres: [String] = []
                
                if let genresMaps = movie.genreIdsLoaded{
                    for genreMap in genresMaps {
                        if let genre = genreMap["name"] as? String {
                            genres.append(genre)
                        }
                    }
                    let comma = ","
                    self.genresLabel.text = genres.joined(separator: ", ")
                }
                
                
                if let runtime = movie.runTime {
                   let numHours = runtime / 60
                    let numMinutes = runtime % 60
                    
                    self.runtimeLabel.text = "\(numHours) hrs \(numMinutes) min"
                
                    
            }
                
             if  let budget = movie.budget {
                let currencyFormatter = NumberFormatter()
                    currencyFormatter.numberStyle = NumberFormatter.Style.currency
                    currencyFormatter.locale = Locale.current
                    
//                    currencyFormatter.maximumFractionDigits = 0
                    self.budgetLabel.text = currencyFormatter.string(from: NSNumber(value: budget))! + "Movie Budget"
                    
                    
                }
                
            }
        }
        
    }

}
