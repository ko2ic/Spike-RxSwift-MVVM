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

class FirstController: UIViewController {
    @IBOutlet var searchbar: UISearchBar!
    @IBOutlet var tableview: UITableView!

    let disposeBag = DisposeBag()
    let viewModel = FirstViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")

        let dataSource = RxTableViewSectionedReloadDataSource<SectionOfCustomData>(configureCell: { (_, tableview, indexPath, item) -> UITableViewCell in
            let cell = tableview.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            cell.textLabel?.text = "Item \(item.id): \(item.fullName) - \(item.stars)"
            return cell
        }, titleForHeaderInSection: { (datasource, index) -> String? in
            datasource.sectionModels[index].header
        })

        viewModel.fetchList()
            .asObservable()
            .bind(to: tableview.rx.items(dataSource: dataSource))
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
