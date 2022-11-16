//
//  NotesViewController.swift
//  akshubnikovPW2
//
//  Created by Андрей Шубников on 16.11.2022.
//

import UIKit

final class NotesViewController: UIViewController {
    public let tableView = UITableView(frame: .zero, style: .insetGrouped)
    public var dataSource = [ShortNote]()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        setupView()
    }

    private func setupView() {
        setupTableView()
        setupNavBar()
    }

    private func setupTableView() {
        tableView.register(NoteCell.self, forCellReuseIdentifier: NoteCell.reuseIdentifier)
        tableView.register(AddNoteCell.self, forCellReuseIdentifier: AddNoteCell.reuseIdentifier)

        view.addSubview(tableView)

        tableView.backgroundColor = .clear
        tableView.keyboardDismissMode = .onDrag
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)

        tableView.pin(to: self.view, [.bottom, .top, .right, .left], 0)
    }

    private func setupNavBar() {
        self.title = "Notes"

//        let closeButton = UIButton(type: .close)
//        closeButton.addTarget(self,
//                action: #selector(dismissViewController),
//                for: .touchUpInside)
    
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: closeButton)
    }

    public func handleDelete(indexPath: IndexPath) {
        dataSource.remove(at: indexPath.row)
        tableView.reloadData()
    }

    @objc
    private func dismissViewController() {
        dismiss(animated: true)
    }
}
