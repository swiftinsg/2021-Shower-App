import Foundation
import SwiftUI

struct Time: Identifiable, Equatable, Codable,Hashable {
    var id = UUID()
    var seconds : CGFloat
    var water: CGFloat
}
