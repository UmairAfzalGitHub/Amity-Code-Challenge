//  Created by Umair Afzal
//  Copyright © 202 Amity.co. All rights reserved.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

import Foundation
import UIKit
import AlamofireImage

extension UIImageView {

    /// A function that downloads the image from the given url
    /// - Parameter path: url string of the image
    func setImageFromUrl(path: String) {
        guard let url = URL(string: path) else {return}
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 64, height: 64)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        self.addSubview(activityIndicator)
        activityIndicator.center = self.center

        self.af.setImage(withURL:url, placeholderImage: nil, filter: nil,  imageTransition: .crossDissolve(0.2), runImageTransitionIfCached: false, completion: {response in
            activityIndicator.stopAnimating()
        })
    }
}
