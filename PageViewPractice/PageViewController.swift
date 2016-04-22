//
//  PageViewController.swift
//  PageViewPractice
//
//  Created by K Sabbak on 4/18/16.
//  Copyright © 2016 ksabbak. All rights reserved.
//
//  This is all the code that needs to be handled by the UIPageViewController
//

import UIKit


//Pulled from THIS TUTORIAL: https://spin.atomicobject.com/2016/02/11/move-uipageviewcontroller-dots/
protocol PageViewConrollerDotDelegate: class {
    
    /**
     Called when the number of pages is updated.
     
     - parameter tutorialPageViewController: the TutorialPageViewController instance
     - parameter count: the total number of pages.
     
     Apparently you need this no matter what, even if you aren't like, changing anything once the shit loads
     */
    func pageViewControllerDot(dotPageViewController: PageViewController,
                                    didUpdatePageCount count: Int)
    
    /**
     Called when the current index is updated.
     
     - parameter tutorialPageViewController: the TutorialPageViewController instance
     - parameter index: the index of the currently visible page.
     */
    func pageViewControllerDot(dotPageViewController: PageViewController,
                                    didUpdatePageIndex index: Int)
    
}


class PageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    let titleLabels = ["Football", "Car", "Baseball", "Zoe", "Watch"]
    let imageNames = ["1", "2", "3", "4", "5"]
    var totalViewControllers: Int {return imageNames.count}
    //var index = 0
    
    var dotDelegate: PageViewConrollerDotDelegate?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        dataSource = self
        delegate = self
        
        if let viewController = showContentViewController(0)
        {
            let viewControllers = [viewController]
            setViewControllers(
                viewControllers,
                direction: .Forward,
                animated: false,
                completion: nil
            )
        }
        
        dotDelegate?.pageViewControllerDot(self, didUpdatePageCount: totalViewControllers)
    }
    
    func showContentViewController(index: Int) -> ContentViewController?
    {
        if let storyboard = storyboard,
            contentVC = storyboard.instantiateViewControllerWithIdentifier("ContentViewController") as? ContentViewController
        {
            contentVC.imageName = imageNames[index]
            contentVC.titleName = titleLabels[index]
            contentVC.orderNumber = index
            return contentVC
        }
        
        print("showContentViewController broke somehow")
        return nil
    }

    //MARK - PageViewControllerDataSource
    
    //Because this PVC is self-contained (aka, no external elements?) the datasource is in the PVC code
    //This code could be written in an external VC
    
    //Required
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController?
    {
        
        if let viewController = viewController as? ContentViewController
        {
            var index = viewController.orderNumber
            guard index != NSNotFound && index != 0 else { return nil }
            index = index - 1
            return showContentViewController(index)
            
        }
        return nil
    }
    
    //Required
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController?
    {
        if let viewController = viewController as? ContentViewController
        {
            var index = viewController.orderNumber
            guard index != NSNotFound && index != totalViewControllers - 1 else { return nil }
            index = index + 1
            return showContentViewController(index)
            
        }
        return nil
    }
    
    //Implimenting the dotDelegate methods using a delegate method
    func pageViewController(pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool)
    {
        if let firstViewController = viewControllers?.first as? ContentViewController,
           let index = firstViewController.orderNumber
        {
            dotDelegate!.pageViewControllerDot(self, didUpdatePageIndex: index)
        }
    }

}


