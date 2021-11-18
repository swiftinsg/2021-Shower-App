import Foundation
import SwiftUI

struct Time: Identifiable, Decodable, Encodable, Hashable {
    var id = UUID()
    var seconds : CGFloat
}
