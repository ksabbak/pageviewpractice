//
//  ContentViewController.swift
//  PageViewPractice
//
//  Created by K Sabbak on 4/18/16.
//  Copyright © 2016 ksabbak. All rights reserved.
//
// This is the VC that handles the content displayed on the PageViewControllers Views.
//

import UIKit

class ContentViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    
    var imageName: String!
    var titleName: String!
    
    var orderNumber: Int!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        titleLabel.text = titleName
        imageView.image = UIImage(named: imageName)

    }



}
