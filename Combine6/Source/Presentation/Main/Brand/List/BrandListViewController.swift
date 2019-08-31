//
//  BrandListViewController.swift
//  Combine6
//
//  Created by 이병찬 on 31/08/2019.
//  Copyright © 2019 이병찬. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Then
import SnapKit

protocol BrandListViewBindable {
    var viewDidLoad: PublishRelay<Void> { get }
    var searchKeyword: PublishRelay<String> { get }
    var brands: Driver<[Brand]> { get }
    var addButtonTapped: PublishRelay<Void> { get }
    
    var push: Driver<Pushable> { get }
}

class BrandListViewController: ViewController<BrandListViewBindable> {
    let headerView = BrandHeaderView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 100))
    let tableView = UITableView()
    let footerView = BrandFooterView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 100))
    let closeButton = UIBarButtonItem(title: "닫기", style: .plain, target: nil, action: nil)
    
    override func bind(_ viewModel: BrandListViewBindable) {
        self.disposeBag = DisposeBag()
        
        viewModel.brands
            .drive(tableView.rx.items) { tv, row, item in
                let cell = tv.dequeueReusableCell(withIdentifier: "BrandTableCell", for: IndexPath(row: row, section: 0)) as! BrandTableCell
                cell.setData(brand: item)
                return cell
            }
            .disposed(by: disposeBag)
        
        viewModel.push
            .drive(self.rx.push)
            .disposed(by: disposeBag)
        
        headerView.textField.rx.text
            .filterNil { $0 }
            .debounce(2, scheduler: MainScheduler.instance)
            .bind(to: viewModel.searchKeyword)
            .disposed(by: disposeBag)
        
        footerView.actionButton.rx.tap
            .bind(to: viewModel.addButtonTapped)
            .disposed(by: disposeBag)
        
        self.rx.viewDidLoad
            .bind(to: viewModel.viewDidLoad)
            .disposed(by: disposeBag)
        
        closeButton.rx.tap
            .bind(onNext: { [weak self] _ in
                self?.dismiss(animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
    }
    
    override func attribute() {
        self.do {
            $0.setLargeNavigationSetting()
            $0.navigationItem.title = "브랜드 리스트"
            $0.navigationItem.rightBarButtonItem = closeButton
        }
        
        tableView.do {
            $0.register(BrandTableCell.self, forCellReuseIdentifier: "BrandTableCell")
            $0.tableHeaderView = headerView
            $0.tableFooterView = footerView
            $0.rowHeight = UITableView.automaticDimension
            $0.keyboardDismissMode = .onDrag
        }
        
        headerView.do {
            $0.setData(description: "해당 보이콧 대상인 브랜드입니다.")
        }
        
        footerView.do {
            $0.setData(title: "찾으시는 브랜드가 없나요? 직접 추가해주세요!", actionTitle: "추가하기")
        }
    }
    
    override func layout() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
