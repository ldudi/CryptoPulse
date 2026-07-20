import Foundation

enum ChartTimeRange: String, CaseIterable {
    case day1 = "1"
    case day7 = "7"
    case day30 = "30"
    case day90 = "90"
    case year1 = "365"
    case max = "max"
    
    var title: String {
        switch self {
        case .day1:
            return "1D"
        case .day7:
            return "7D"
        case .day30:
            return "30D"
        case .day90:
            return "90D"
        case .year1:
            return "1Y"
        case .max:
            return "MAX"
        }
    }
}
