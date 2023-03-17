//
//  Delay.swift
//  Reminders
//
//  Created by ANDREY VORONTSOV on 15.03.2023.
//

import Foundation

class Delay {
    
    private var seconds: Double
    private var workItem: DispatchWorkItem?
    
    init(seconds: Double = 2.0) {
        self.seconds = seconds
    }
    
    func performWork(_ work: @escaping () -> Void) {
        workItem = DispatchWorkItem(block: {
            work()
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: workItem!)
    }
    
    func cancel() {
        workItem?.cancel()
    }
}
