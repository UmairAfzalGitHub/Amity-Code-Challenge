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

class FileHandler {

    func saveFile(url: String, data: String?) {
        guard let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {return}
        do {
            let fileName = "Todo-Local-Data.json"
            let fileUrl = directory.appendingPathComponent(fileName)
            let value = data ?? ""
            try value.write(to: fileUrl, atomically: true, encoding: .utf8)
            //Save the location of your JSON file to UserDefaults
            UserDefaults.standard.set(url, forKey: "CurrentJsonUrl")
        } catch let error {
            print("Error while saving file to local directory \(error)")
        }
    }

    func getDataFromFile(fileName: String) -> String? {
        guard let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {return nil}
        let fileUrl = directory.appendingPathComponent(fileName)

        do {
            let data = try String(contentsOf: fileUrl)
            return data
        } catch let error{
            print("Error while getting file from local directory \(error)")
        }
        return nil
    }
}
