//
//  EmptyViewBindable.swift
//  AppTemplate
//
//  Created by 이병찬 on 24/08/2019.
//  Copyright © 2019 이병찬. All rights reserved.
//

import Foundation

protocol EmptyViewBindable {}

typealias EmptyView = View<EmptyViewBindable>

typealias EmptyViewController = ViewController<EmptyViewBindable>

/*
Template 작성을 위해 임시로 적용되는 ViewController 입니다.
 */
typealias TempViewController = EmptyViewController
