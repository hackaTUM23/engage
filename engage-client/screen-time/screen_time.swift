//
//  screen_time.swift
//  screen-time
//
//  Created by Vincent Picking on 23.11.24.
//

import DeviceActivity
import SwiftUI

@main
struct screen_time: DeviceActivityReportExtension {
    var body: some DeviceActivityReportScene {
        // Create a report for each DeviceActivityReport.Context that your app supports.
        TotalActivityReport { totalActivity in
            TotalActivityView(totalActivity: totalActivity)
        }
        // Add more reports here...
    }
}
