
import Foundation
struct CompanyInfoLinks : Codable {
	let website : String?
	let flickr : String?
	let twitter : String?
	let elon_twitter : String?

	enum CodingKeys: String, CodingKey {

		case website = "website"
		case flickr = "flickr"
		case twitter = "twitter"
		case elon_twitter = "elon_twitter"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		website = try values.decodeIfPresent(String.self, forKey: .website)
		flickr = try values.decodeIfPresent(String.self, forKey: .flickr)
		twitter = try values.decodeIfPresent(String.self, forKey: .twitter)
		elon_twitter = try values.decodeIfPresent(String.self, forKey: .elon_twitter)
	}

}
