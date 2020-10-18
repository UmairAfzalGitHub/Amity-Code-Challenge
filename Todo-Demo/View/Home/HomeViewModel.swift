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

protocol HomeViewModelDelegate: BaseViewModelDelegate {
    func didLoadTasks()
}

class HomeViewModel: BaseViewModel {

    var dataSource = [Task]()
    var filteredDataSource = [Task]()
    var isLoading = false

    var delegate: HomeViewModelDelegate?

    func getTasks() {
        self.delegate?.showPorgress()
        isLoading = true
        
        TodoService().getTasks() { [weak self] (error, result) in
            guard let self = self else { return }
            self.delegate?.hideProgress()
            self.isLoading = false

            DispatchQueue.main.async {
                if error == nil, let data = result {
                    self.dataSource = self.mapUserWithTask(data: data)
                    self.filteredDataSource = self.dataSource
                    self.delegate?.didLoadTasks()
                } else {
                    self.delegate?.showErrorAlert(message: error.orDash)
                }
            }
        }
    }

    func mapUserWithTask(data: Todo) -> [Task] {

        for user in data.user {
            for task in data.todo {
                if user.id ==  task.userId {
                    task.user = user
                }
            }
        }

        // sort by date
        data.todo.sort(by: {($0.createdAt?.timeIntervalSince1970 ?? 0) < ($1.createdAt?.timeIntervalSince1970 ?? 0)})
        return data.todo
    }
}
