//
//  MetricsManager.swift
//  Runner
//
//  Created by Maciej Banaszyński on 21/11/2024.
//

import Foundation
import UIKit

class MetricsManager {
    static let shared = MetricsManager()
    
    func collectMetrics() -> [String: Any] {
        return [
            "batteryLevel": UIDevice.current.batteryLevel * 100, 
            "batteryState": batteryState(),
            "cpuUsage": getAppCPUUsage()
        ]
    }
    
    private func batteryState() -> String {
        switch UIDevice.current.batteryState {
            case .charging: return "Charging"
            case .full: return "Full"
            case .unplugged: return "Unplugged"
            case .unknown: return "Unknown"
            @unknown default: return "Unknown"
        }
    }
    
    private func getAppCPUUsage() -> Double {
        var threadsList: thread_act_array_t?
        var threadCount: mach_msg_type_number_t = 0
        
        guard task_threads(mach_task_self_, &threadsList, &threadCount) == KERN_SUCCESS,
              let threads = threadsList else { return -1 }
        
        var totalCPUUsage: Double = 0
        
        for i in 0..<Int(threadCount) {
            var threadInfo = thread_basic_info()
            var threadInfoCount = mach_msg_type_number_t(THREAD_INFO_MAX)
            
            let result = withUnsafeMutablePointer(to: &threadInfo) {
                $0.withMemoryRebound(to: integer_t.self, capacity: Int(threadInfoCount)) {
                    thread_info(threads[i], thread_flavor_t(THREAD_BASIC_INFO), $0, &threadInfoCount)
                }
            }
            
            guard result == KERN_SUCCESS else { continue }
            
            if threadInfo.flags & TH_FLAGS_IDLE == 0 {
                totalCPUUsage += Double(threadInfo.cpu_usage) / Double(TH_USAGE_SCALE) * 100
            }
        }
        
        vm_deallocate(mach_task_self_, vm_address_t(bitPattern: threads), vm_size_t(Int(threadCount) * MemoryLayout<thread_t>.stride))
        
        return totalCPUUsage
    }
}
