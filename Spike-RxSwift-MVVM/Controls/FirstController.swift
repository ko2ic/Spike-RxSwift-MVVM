//
//  ViewController.swift
//  Spike-RxSwift-MVVM
//
//  Created by 石井幸次 on 2018/03/26.
//  Copyright © 2018年 ko2ic. All rights reserved.
//

import RxCocoa
import RxDataSources
import RxSwift
import UIKit
import ViewModels

class FirstController: UIViewController {
    @IBOutlet var searchbar: UISearchBar!
    @IBOutlet var tableview: UITableView!

    private var refreshControl = UIRefreshControl()

    let disposeBag = DisposeBag()
    let viewModel = FirstViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.transiton.subscribe { event in
            let type = event.element!
            switch type {
            case let .alertDialogType(message):
                self.alertDialog(message: message)
            }
        }

        configureTableView()
        bindViewModel()
    }

    private func configureTableView() {
        tableview.refreshControl = refreshControl
        tableview.estimatedRowHeight = 64
        tableview.rowHeight = UITableViewAutomaticDimension

        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }

    private func bindViewModel() {
        let dataSource = RxTableViewSectionedReloadDataSource<SectionOfCustomData>(configureCell: { (_, tableview, indexPath, item) -> UITableViewCell in
            let cell = tableview.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            cell.textLabel?.text = "Item \(item.id): \(item.fullName) - \(item.stars ?? 0)"
            return cell
        }, titleForHeaderInSection: { (datasource, index) -> String? in
            datasource.sectionModels[index].header
        })

        let viewWillAppear = rx.sentMessage(#selector(UIViewController.viewWillAppear(_:)))
            .take(1)
            .map { _ in }.asDriver(onErrorRecover: { _ in Driver.empty() })

        let pull = tableview.refreshControl!.rx
            .controlEvent(.valueChanged)
            .asDriver()

        let input = FirstViewModel.Input(trigger: Driver.merge(viewWillAppear, pull),
                                         freeword: searchbar.rx.text.orEmpty.changed
                                             .debounce(1, scheduler: MainScheduler.instance)
                                             .asDriver(onErrorJustReturn: ""))

        let output = viewModel.transform(input: input)

        output.items.asObservable()
            .bind(to: tableview.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)

        output.fetching
            .drive(tableview.refreshControl!.rx.isRefreshing)
            .disposed(by: disposeBag)
    }

    deinit {
        searchbar.removeFromSuperview()
        tableview.removeFromSuperview()
        searchbar = nil
        tableview = nil
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

// MARK: - UITableViewDelegate

extension FirstController: UITableViewDelegate {
    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
