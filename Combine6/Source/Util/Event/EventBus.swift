//
//  EventBus.swift
//  AppTemplate
//
//  Created by 이병찬 on 24/08/2019.
//  Copyright © 2019 이병찬. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class EventBus {
    private init() {}
    
    static let shared: EventBus = EventBus()
    
    private let eventBus = PublishSubject<Event>()
    
    func getEvent(_ event: Event) -> Observable<Event> {
        return eventBus.filter { $0 == event }.asObservable()
    }
    
    func post(_ event: Event) {
        eventBus.onNext(event)
    }
}
