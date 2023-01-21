
import Foundation
struct Headquarters : Codable {
	let address : String?
	let city : String?
	let state : String?

	enum CodingKeys: String, CodingKey {

		case address = "address"
		case city = "city"
		case state = "state"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		address = try values.decodeIfPresent(String.self, forKey: .address)
		city = try values.decodeIfPresent(String.self, forKey: .city)
		state = try values.decodeIfPresent(String.self, forKey: .state)
	}

}
