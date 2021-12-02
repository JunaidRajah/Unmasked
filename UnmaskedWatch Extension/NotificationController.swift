//
//  NotificationController.swift
//  UnmaskedWatch Extension
//
//  Created by Junaid Rajah on 2021/11/30.
//

import WatchKit
import Foundation
import UserNotifications

class NotificationController: WKUserNotificationInterfaceController {

    override init() {
        super.init()
    }

    override func willActivate() {}

    override func didDeactivate() {}

    override func didReceive(_ notification: UNNotification) {}
}
