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

typealias ConfirmHandler = () -> Void
typealias CancelHandler = () -> Void

class AlertBuilder: NSObject {

    /// A function that presents an alert on the current screen
    /// - Parameter message: Message to be displayed in the alert
    public static func successAlertWithMessage(message: String?) {
        self.alertWithTitle(title: "Success", message: message, cancelButtonShow: false, confirmHandler: nil)
    }

    /// A function that presents an alert on the current screen
    /// - Parameter message: Message to be displayed in the alert
    public static func failureAlertWithMessage(message: String?) {
        self.alertWithTitle(title: "Error", message: message, cancelButtonShow: false, confirmHandler: nil)
    }

    /// A function that presents an alert on the current screen with custom actions
    /// - Parameters:
    ///   - title: Title for the alert
    ///   - message: Message to be displayed in the alert
    ///   - cancelButtonShow: A bool that represents that weather we want to show cancel button or not
    ///   - confirmHandler: Completion block called when user taps on okay
    public static func alertWithTitle(title: String?, message: String?, cancelButtonShow: Bool, confirmHandler: ConfirmHandler?) {
        let alert = prepareAlert(title: title, message: message)
        addAction(alert: alert, title: "Okay", style: .default, handler: confirmHandler)

        if(cancelButtonShow) {
            addAction(alert: alert, title: "Cancel", style: .cancel)
        }
        showAlert(alert: alert)
    }

    static func prepareAlert(title: String?, message: String?) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        return alertController
    }

    private static func showAlert(alert: UIAlertController) {
        DispatchQueue.main.async {
            self.topMostController().present(alert, animated: true, completion: nil)
        }
    }

    /// A function that gets currently visible view controller from the UIApplication Window
    /// - Returns: Returns the top most viewController in the current window
    static func topMostController() -> UIViewController {
        var topController: UIViewController? = UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController
        while ((topController?.presentedViewController) != nil) {
            topController = topController?.presentedViewController
        }
        return topController!
    }

    static func addAction(alert: UIAlertController, title: String?, style: UIAlertAction.Style, handler: ConfirmHandler? = nil) {
        alert.addAction(UIAlertAction(title: title, style: style, handler: { _ in
            if(handler != nil) {
                handler!()
            }
        }))
    }
}
