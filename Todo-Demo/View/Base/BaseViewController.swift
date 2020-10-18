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

class BaseViewController: UIViewController {

    var activityView = UIActivityIndicatorView(style: .large)

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension BaseViewController: BaseViewModelDelegate {

    func showErrorAlert(message: String) {
        AlertBuilder.failureAlertWithMessage(message: message)
    }

    func showSuccessAlert(message: String) {
        AlertBuilder.successAlertWithMessage(message: message)
    }

    func showPorgress() {
        DispatchQueue.main.async {
            self.activityView.center = self.view.center
            self.activityView.hidesWhenStopped = true
            self.view.addSubview(self.activityView)
            self.activityView.startAnimating()
        }
    }

    func hideProgress() {
        DispatchQueue.main.async {
            self.activityView.stopAnimating()
        }
    }
}
