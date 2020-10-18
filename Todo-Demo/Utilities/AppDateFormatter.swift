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

class AppDateFormatter {

    static let shared = AppDateFormatter()

    private init () {
    }

    let longServer = formatter(format: "yyyy-MM-dd'T'HH:mm:ss.SSSZ")
    let MMMDYYYY = formatter(format: "MMM d, yyyy")

    private static func formatter(format: String) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }

    func getReadableDate(date: Date) -> String {
        return self.MMMDYYYY.string(from: date)
    }
}
