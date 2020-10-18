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

import UIKit

class TaskDetailsViewController: BaseViewController {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    var viewModel = TaskDetailsViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupCustomPropertiesOnView()
    }

    func setupCustomPropertiesOnView() {
        self.title = "Task Details"

        titleLabel.text = viewModel.dataSource.title
        nameLabel.text = "By: \(viewModel.dataSource.user?.name ?? "")"
        dateLabel.text = "At: \(AppDateFormatter.shared.getReadableDate(date: viewModel.dataSource.createdAt ?? Date()))"
        descriptionLabel.text = viewModel.dataSource.description
        avatarImageView.setImageFromUrl(path: viewModel.dataSource.user?.avatar ?? "")
    }
}
