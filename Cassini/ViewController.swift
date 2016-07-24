//
//  ViewController.swift
//  Cassini
//
//  Created by Amin Amjadi on 7/18/16.
//  Copyright © 2016 MDJD. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UISplitViewControllerDelegate {
    
    private struct Storyboard { //this is nice to do for clean coding mechanism,
        //so we want to have a private struct to store our constants and are string in storyboard
        static let ShowImageSegue = "Show Image"
        //so this string and basically any string that we put anywhere in our storyboard, that's all colected here in our struct
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == Storyboard.ShowImageSegue {
            if let ivc = segue.destinationViewController.contentViewController as? ImageViewController {
                let imageName = (sender as? UIButton)?.currentTitle //(we can't send currentTitle to an optional)
                //so it is perfectly legal if we use optional chaining stuff on the end of some other expression that returns possible optional
                //so remember if this is nil then the whole thing just is gonna be ignored thats whats the ? means
                ivc.imageURL = DemoURL.NASAImageNamed(imageName: imageName)
                ivc.title = imageName
            }
        }
    }
// instead of using segue which always create the new MVC, we are going to use the target action which just reloads the ImageViewController each time
    
    @IBAction func ShowImage(_ sender: UIButton) { //so here we say if we are in SplitViewController do this otherwise use segue... 
        //and we are going to do the segue by code, instead of storyboard
        if let ivc = splitViewController?.viewControllers.last?.contentViewController as? ImageViewController {
            let imageName = sender.currentTitle
            ivc.imageURL = DemoURL.NASAImageNamed(imageName: imageName)
            ivc.title = imageName
        }
        else {
            performSegue(withIdentifier: Storyboard.ShowImageSegue, sender: sender)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        splitViewController?.delegate = self
    }
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        if primaryViewController.contentViewController == self {
            if let ivc = secondaryViewController.contentViewController as? ImageViewController , ivc.imageURL == nil {
                return true //it's us telling the system, yeah we took care of that. we put that detail on top of the master 
                //eventhough we didn't (and that's good cz that's what we want). so it's kinda lying to the system
            }
        }
        return false
    }
}

extension UIViewController {
    var contentViewController: UIViewController { //so now all UIViewControllers are responding to this contentViewController
        if let navCon = self as? UINavigationController {
            return navCon.visibleViewController ?? self
        }
        else {
            return self
        }
    }
    
}
