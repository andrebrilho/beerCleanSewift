//
//  BeerTableViewCell.swift
//  ApiBeerCleanSwift
//
//  Created by André Brilho on 05/05/20.
//  Copyright © 2020 André Brilho. All rights reserved.
//

import UIKit
import AlamofireImage

class BeerTableViewCell: UITableViewCell {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lbl: UILabel!
    
    var beer:MainBeer.Beer?{
        didSet{
            configureCell()
        }
    }
    
    func configureCell(){
        lbl.text = beer?.name
        img.image = nil
        img.af_cancelImageRequest()
        img.af_setImage(withURL: URL(string:((beer?.image_url)!))!, filter: AspectScaledToFitSizeFilter(size: CGSize(width: self.img.frame.width, height: self.img.frame.height)), imageTransition: .crossDissolve(0.3), runImageTransitionIfCached: true, completion: { (_) in
        })
    }
}
