//
//  ProductDetailViewController.swift
//  movieDB
//
//  Created by Alex Rivera BBVA on 31/03/21.
//

import Foundation
import UIKit

class ProductDetailViewController: UIViewController {
    
    
    var picture       = ""
    var originalTitle = ""
    var overview      = ""
    
    @IBOutlet weak var lblTitle    : UILabel!
    @IBOutlet weak var poster      : UIImageView!
    @IBOutlet weak var movieDetail : UITextView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        lblTitle.text = originalTitle as String
        movieDetail.text = overview as String

        let url = URL(string: picture)
        let data = try? Data(contentsOf: url!)
        poster.image = UIImage(data: data!)
    }
}
