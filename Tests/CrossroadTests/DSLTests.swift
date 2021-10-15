import Foundation
import XCTest
import Crossroad

let pokedex: LinkSource = .urlScheme("pokedex")
let pokedexWeb: LinkSource = .universalLink(URL(string: "https://my-awesome-pokedex.com")!)

final class DSLTests: XCTestCase {
    func testDSL() throws {
        typealias Route = SimpleRouter.Route
        let router = try SimpleRouter(accepts: [pokedex, pokedexWeb]) {
            Route("/pokemons/:id") { context in
                let pokedexID: Int? = context.id
                return true
            }

            Route("/pokemons/search", accepts: .onlyFor([pokedex])) { context in
                let pokedexID: Int? = context.id
                return true
            }
        }
        router.responds(to: URL(string: "pokedex://pokemon/42")!)
    }
}
