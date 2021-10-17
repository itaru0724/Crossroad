import Foundation

public struct Route<UserInfo> {
    public typealias Handler = (Context<UserInfo>) throws -> Bool
    var path: Path
    var acceptPolicy: AcceptPolicy
    var handler: Handler

    public enum AcceptPolicy: Equatable {
        case any
        case only(for: LinkSource)
    }

    init(patternString: String, acceptPolicy: AcceptPolicy, handler: @escaping Handler) throws {
        let pattern = try Pattern(patternString: patternString)
        self.path = pattern.path
        self.acceptPolicy = acceptPolicy
        self.handler = handler
    }

    func executeHandler(context: Context<UserInfo>) throws -> Bool {
        try handler(context)
    }
}
