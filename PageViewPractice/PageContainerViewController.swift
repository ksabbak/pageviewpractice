//
//  PageContainerViewController.swift
//  PageViewPractice
//
//  Created by K Sabbak on 4/20/16.
//  Copyright © 2016 ksabbak. All rights reserved.
//

import UIKit

class PageContainerViewController: UIViewController, PageViewConrollerDotDelegate {

    @IBOutlet var containerView: UIView!
    @IBOutlet var pageControlDots: UIPageControl!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
    }
    
    
    
    func pageViewControllerDot(dotPageViewController: PageViewController, didUpdatePageIndex index: Int)
    {
        pageControlDots.currentPage = index
    }
    
    func pageViewControllerDot(dotPageViewController: PageViewController, didUpdatePageCount count: Int)
    {
        pageControlDots.numberOfPages = count
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if let pageViewController = segue.destinationViewController as? PageViewController
        {
            pageViewController.dotDelegate = self
        }
    }



}
