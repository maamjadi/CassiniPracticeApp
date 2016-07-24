//
//  File.swift
//  Cassini
//
//  Created by Amin Amjadi on 7/17/16.
//  Copyright © 2016 MDJD. All rights reserved.
//

import Foundation

struct DemoURL {
    static let Standford = "http://comm.stanford.edu/wp-content/uploads/2013//01/stanford-campus.png"
    
    static let NASA = [
    "Cassini" : "http://www.jpl.nasa.gov/images/cassini/20090202/pia03883-full.jpg",
    "Earth" : "http://www.nasa.gov/sites/default/files/wave_earth_mosaic_3.jpg",
    "Saturn" : "http://www.nasa.gov/sites/default/files/saturn_collage.jpg"
    ]
    
    static func NASAImageNamed(imageName: String?) -> URL? {
        if let urlString = NASA[imageName ?? ""] {
            return URL(fileURLWithPath: urlString)
        }
        else {
            return nil
        }
    }
}
