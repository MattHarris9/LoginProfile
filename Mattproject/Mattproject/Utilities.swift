//
//  Utilities.swift
//  Mattproject
//
//  Created by Matthew Harris on 2/9/22.
//

import Foundation
import UIKit

class Utilities {
    
    class func itsNetworkAvailable() -> Bool

    {
        return (Reachability.init(hostname: BASE_URL)?.isReachable)!
    }
    
    class func downloadImageWithUrl(url: String) -> UIImage {
        let data = NSData(contentsOf: NSURL(string: url)! as URL)
        
        if(data != nil) {
            return UIImage(data: data! as Data)!
                
        } else {
            return UIImage(named: "camera")!
        }
    }
    

    
}

