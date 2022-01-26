//
//  MessageSection.swift
//  ChatterBox
//
//  Created by Jake Brown based on Falcon Messenger
//  Copyright © 2022 Jake Brown Media Productions. All rights reserved.
//

import RealmSwift

final class MessageSection: Object {

	@objc var title: String?
	var messages: Results<Message>!
	var notificationToken: NotificationToken?

	convenience init(messages: Results<Message>, title: String) {
		self.init()

		self.title = title
		self.messages = messages
	}
}
