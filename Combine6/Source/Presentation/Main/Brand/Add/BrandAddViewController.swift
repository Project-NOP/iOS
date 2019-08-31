//
//  BrandAddViewController.swift
//  Combine6
//
//  Created by 이병찬 on 31/08/2019.
//  Copyright © 2019 이병찬. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol BrandAddViewBindable {
    var viewDidLoad: PublishRelay<Void> { get }
    var searchKeyword: PublishRelay<String> { get }
    var brands: Driver<[Brand]> { get }
    var dismiss: Signal<Void> { get }
    
    var selectedBrands: PublishRelay<[Brand]> { get }
}

class BrandAddViewController: ViewController<BrandAddViewBindable> {
    let headerView = BrandHeaderView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 100))
    let tableView = UITableView()
    let footerView = BrandFooterView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 100))
    let confirmButton = UIBarButtonItem(barButtonSystemItem: .save, target: nil, action: nil)
    
    override func bind(_ viewModel: BrandAddViewBindable) {
        self.disposeBag = DisposeBag()
        
        viewModel.brands
            .drive(tableView.rx.items) { tv, row, item in
                let cell = tv.dequeueReusableCell(withIdentifier: "BrandSelectableTableCell", for: IndexPath(row: row, section: 0)) as! BrandSelectableTableCell
                cell.setData(brand: item)
                return cell
            }
            .disposed(by: disposeBag)
        
        viewModel.dismiss
            .emit(onNext: { [weak self] _ in
                self?.back()
            })
            .disposed(by: disposeBag)
        
        headerView.textField.rx.text
            .filterNil { $0 }
            .debounce(2, scheduler: MainScheduler.instance)
            .bind(to: viewModel.searchKeyword)
            .disposed(by: disposeBag)
        
        self.rx.viewDidLoad
            .bind(to: viewModel.viewDidLoad)
            .disposed(by: disposeBag)
        
        confirmButton.rx.tap
            .map { [weak tableView] _ in
                let cells = tableView?.visibleCells as! [BrandSelectableTableCell]
                let selectedBrands = cells.filter { $0.selectButton.isSelected }.compactMap { $0.brand }
                return selectedBrands
            }
            .bind(to: viewModel.selectedBrands)
            .disposed(by: disposeBag)
    }
    
    override func attribute() {
        self.do {
            $0.setLargeNavigationSetting()
            $0.navigationItem.title = "브랜드 추가"
            $0.navigationItem.rightBarButtonItem = confirmButton
        }
        
        tableView.do {
            $0.register(BrandSelectableTableCell.self, forCellReuseIdentifier: "BrandSelectableTableCell")
            $0.tableHeaderView = headerView
            $0.tableFooterView = footerView
        }
        
        headerView.do {
            $0.setData(description: "해당 보이콧과 관련된 브랜드를 추가하세요")
        }
        
        footerView.do {
            $0.setData(title: "악의적인 브랜드 추가는 제제 대상입니다.", actionTitle: nil)
        }
    }
    
    override func layout() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
