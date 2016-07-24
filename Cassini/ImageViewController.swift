//
//  ImageViewController.swift
//  Cassini
//
//  Created by Amin Amjadi on 7/18/16.
//  Copyright © 2016 MDJD. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController, UIScrollViewDelegate {
    
    var imageURL: URL? {
        didSet {
            image = nil
            if view.window != nil { //people might not have good internet... they might be using cellular and it is cost money
                //so we are going to fetch this image unless we are currently in the screen
                
                fetchImage()
            }
        }
    }
    
    private func fetchImage() {
        if let url = imageURL {
            spinner?.startAnimating() //we put ? just in case we are fatching our image like as the reasult of prepare for segue 
            //cz there our outlets aren't set
            if let imageData = try? Data(contentsOf: url) {
                image = UIImage(data: imageData)
            }
            else {
                image = nil
                spinner.stopAnimating()
            }
            //we are gonna work and use these line of codes here in fetch func but these are really bad lines of code...
            //cz it would be so slow... cz we might be in cellular, this might take 10 sec or min or even just fail....
            //we might even not connected to internet so we will correct it later
        }
    }
    
    
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView.contentSize = imageView.frame.size //here we don't need to make it optional cz it just gets set
            scrollView.delegate = self
            scrollView.minimumZoomScale = 0.03
            scrollView.maximumZoomScale = 1.0
        }

    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    private var imageView = UIImageView()
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    private var image: UIImage? {
        get { return imageView.image }
        set {
            imageView.image = newValue
            imageView.sizeToFit()
            scrollView?.contentSize = imageView.frame.size //we are making it optional just to protect it in the case that scrollView for example gets set before imageVeiw or...
            spinner?.stopAnimating() //in case we don't even start animating
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.addSubview(imageView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if image == nil {
            fetchImage()
        }
    }
}

