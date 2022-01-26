//
//  RealmUIImage.swift
//  ChatterBox
//
//  Created by Jake Brown based on Falcon Messenger
//  Copyright © 2022 Jake Brown Media Productions. All rights reserved.
//

import RealmSwift

final class RealmImage: Object {
	@objc dynamic var id: String?
	@objc dynamic var imageData: Data?

	func uiImage() -> UIImage? {
		guard let data = imageData else { return blurredPlaceholder }
		return UIImage(data: data)
	}

	override static func primaryKey() -> String? {
		return "id"
	}

	convenience init(_ image: UIImage, quality: CGFloat, id: String) {
		self.init()
		self.id = id

		if quality < 1.0 {
			imageData = image.jpegData(compressionQuality: quality)
		} else {
			imageData = image.pngData()
		}
	}
}
