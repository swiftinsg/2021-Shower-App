import Foundation
import SwiftUI

class TimeData: ObservableObject {
    @Published var times: [Time] = []
    
    func getArchiveURL() -> URL {
        let plistName = "times.plist"
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        return documentsDirectory.appendingPathComponent(plistName)
    }
    
    func save() {
        let archiveURL = getArchiveURL()
        let propertyListEncoder = PropertyListEncoder()
        let encodedTimes = try? propertyListEncoder.encode(times)
        try? encodedTimes?.write(to: archiveURL, options: .noFileProtection)
    }
    
    func load() {
        let archiveURL = getArchiveURL()
        let propertyListDecoder = PropertyListDecoder()
        
        var finalTimes: [Time]!
        
        if let retrievedTimeData = try? Data(contentsOf: archiveURL),
            let decodedTimes = try? propertyListDecoder.decode([Time].self, from: retrievedTimeData) {
            finalTimes = decodedTimes
        } else {
            finalTimes = []
        }
        
        times = finalTimes
    }
}
