
import Foundation
struct companyInfo : Codable {
	let headquarters : Headquarters?
	let links : CompanyInfoLinks?
	let name : String?
	let founder : String?
	let founded : Int?
	let employees : Int?
	let vehicles : Int?
	let launch_sites : Int?
	let test_sites : Int?
	let ceo : String?
	let cto : String?
	let coo : String?
	let cto_propulsion : String?
	let valuation : Int?
	let summary : String?
	let id : String?

	enum CodingKeys: String, CodingKey {

		case headquarters = "headquarters"
		case links = "links"
		case name = "name"
		case founder = "founder"
		case founded = "founded"
		case employees = "employees"
		case vehicles = "vehicles"
		case launch_sites = "launch_sites"
		case test_sites = "test_sites"
		case ceo = "ceo"
		case cto = "cto"
		case coo = "coo"
		case cto_propulsion = "cto_propulsion"
		case valuation = "valuation"
		case summary = "summary"
		case id = "id"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		headquarters = try values.decodeIfPresent(Headquarters.self, forKey: .headquarters)
		links = try values.decodeIfPresent(CompanyInfoLinks.self, forKey: .links)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		founder = try values.decodeIfPresent(String.self, forKey: .founder)
		founded = try values.decodeIfPresent(Int.self, forKey: .founded)
		employees = try values.decodeIfPresent(Int.self, forKey: .employees)
		vehicles = try values.decodeIfPresent(Int.self, forKey: .vehicles)
		launch_sites = try values.decodeIfPresent(Int.self, forKey: .launch_sites)
		test_sites = try values.decodeIfPresent(Int.self, forKey: .test_sites)
		ceo = try values.decodeIfPresent(String.self, forKey: .ceo)
		cto = try values.decodeIfPresent(String.self, forKey: .cto)
		coo = try values.decodeIfPresent(String.self, forKey: .coo)
		cto_propulsion = try values.decodeIfPresent(String.self, forKey: .cto_propulsion)
		valuation = try values.decodeIfPresent(Int.self, forKey: .valuation)
		summary = try values.decodeIfPresent(String.self, forKey: .summary)
		id = try values.decodeIfPresent(String.self, forKey: .id)
	}

}
