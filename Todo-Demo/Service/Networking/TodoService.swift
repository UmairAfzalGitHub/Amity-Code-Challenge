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

class TodoService {

    func getTasks(completion: @escaping (String?, (Todo?)) -> Void) {
        

        // check if url with same file already exists
        if let url = UserDefaults.standard.string(forKey: "CurrentJsonUrl"),
            let jsonString = FileHandler().getDataFromFile(fileName: "Todo-Local-Data.json"),
            url == jsonFileUrl {
            // file is present, decode data
            completion(nil, parseData(jsonString: jsonString))

        } else {
            // a new url is provided, get the file content and store it in the document directory
            if let fileUrl = URL(string: jsonFileUrl) {
                NetworkClient().getFileContentFromUrl(url: fileUrl) { (error, result) in
                    if error == nil {
                        FileHandler().saveFile(url: jsonFileUrl, data: result)
                        completion(nil, self.parseData(jsonString: result ?? ""))
                    } else {
                        completion(error, nil)
                    }
                }
            }
        }
    }

    private func parseData(jsonString: String) -> Todo? {
        if let data = jsonString.data(using: .utf8) {
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .custom({ (decoder) -> Date in
                    // Parse the date using a custom `DateFormatter`
                    let container = try decoder.singleValueContainer()
                    let dateString = try container.decode(String.self)
                    if let date = AppDateFormatter.shared.longServer.date(from: dateString) {
                        return date
                    }
                    if let date = AppDateFormatter.shared.MMMDYYYY.date(from: dateString) {
                        return date
                    }
                    return Date()
                })

                return try decoder.decode(Todo.self, from: data)
            } catch let error {
                print("Error while parsing todoData: \(error)")
                return nil
            }
        }

        return nil
    }
}
