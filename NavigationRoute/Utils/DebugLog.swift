import Foundation

protocol Logger {
    func log(_ value: String)
}

class DebugLog: Logger {
    func log(_ value: String) {
        print(value)
    }
}
