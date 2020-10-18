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
import AlamofireImage

class TaskListingTableViewCell: UITableViewCell {

    // MARK: - IBOutlets and variables
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    
    // MARK: - Override Methods

    class func cellForTableView(tableView: UITableView, atIndexPath indexPath: IndexPath) -> TaskListingTableViewCell {
        let kTaskListingTableViewCellIdentifier = "kTaskListingTableViewCellIdentifier"
        tableView.register(UINib(nibName: "TaskListingTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: kTaskListingTableViewCellIdentifier)
        let cell = tableView.dequeueReusableCell(withIdentifier: kTaskListingTableViewCellIdentifier, for: indexPath) as! TaskListingTableViewCell
        return cell
    }
    
    func configureCell(task: Task) {
        titleLabel.text = task.title
        nameLabel.text = "By: \(task.user?.name ?? "")"
        dateLabel.text = "At: \(AppDateFormatter.shared.getReadableDate(date: task.createdAt ?? Date()))"
        avatarImageView.setImageFromUrl(path: task.user?.avatar ?? "")
    }
}
