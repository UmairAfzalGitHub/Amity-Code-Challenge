//
//  UITableView.swift
//  Todo-Demo
//
//  Created by Umair Afzal on 18/10/2020.
//  Copyright © 2020 iOS. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {

    func showEmptyView() {
        let noTasksView = NoTaskView.instanceFromNib()
        self.backgroundView = noTasksView
        self.separatorStyle = .none
    }
}
