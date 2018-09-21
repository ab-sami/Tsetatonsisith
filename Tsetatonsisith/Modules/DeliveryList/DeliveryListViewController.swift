//
//  DeliveryListViewController.swift
//  Tsetatonsisith
//
//  Created by Abdul Sami on 20/09/2018.
//  Copyright © 2018 Abdul Sami. All rights reserved.
//

import UIKit

let kRowHeight: CGFloat = 80.0

class DeliveryListViewController: UITableViewController, BaseViewModelDelegate {
    
    let cellId = "cellId"
    
    public var viewModel: DeliveryListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = DeliveryListViewModel()
        viewModel.delegate = self
        tableView.register(DeliverTableViewCell.self, forCellReuseIdentifier: cellId)
        setUpView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        LoadingView.shared.show(self)
        viewModel.load()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
         self.refreshControl = createRefreshControl()
    }
    
    private func setUpView() {
        navigationItem.title = "Deliverables"
        navigationController?.navigationBar.tintColor = UIColor.white
        let textAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.barTintColor = UIColor.red
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationController?.navigationBar.largeTitleTextAttributes = textAttributes
        }
        tableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
    }
    
    @objc func forceRefresh() {
        viewModel.load()
    }
    
    private func createRefreshControl() -> UIRefreshControl {
        let refresher = UIRefreshControl()
        refresher.addTarget(self, action: #selector(forceRefresh), for: .valueChanged)
        return refresher
    }
    
    //MARK:- Table view delegate methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getDeliveriesCount()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! DeliverTableViewCell
        cell.deliveryDescriptionNameLabel.text = viewModel.getDeliveryDescription(at: indexPath.row) + " at " + viewModel.getDeliveryLocationAddress(at: indexPath.row)
        cell.deliveryImage.loadImageUsingUrlString(viewModel.getDeliveryImageUrl(at: indexPath.row))
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showDeliveryDetailView(idx: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return kRowHeight
    }
    
    //MARK:- Present Detail View
    
    func showDeliveryDetailView(idx: IndexPath) {
        let detailVC = DeliveryDetailsViewController(delivery: viewModel.getSelectedDelivery(index: idx.row))
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    //MARK:- View Model Delegate Methods
    
    func onViewModelReady(_ viewModel: BaseViewModel) {
        if (self.refreshControl?.isRefreshing)! {
            self.refreshControl?.endRefreshing()
        }
        
        LoadingView.shared.hide()
        tableView.reloadData()
    }
    
    func onViewModelError(_ viewModel: BaseViewModel, error: Error) {
        if (self.refreshControl?.isRefreshing)! {
            self.refreshControl?.endRefreshing()
        }
        
        LoadingView.shared.hide()
        self.handleError(error: error)
    }
    
    func handleError(error: Error) {
        let alertView = UIAlertController(title: "Error!!", message: "OOPS! An error occured. Pull down to refresh again.", preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            alertView.dismiss(animated: true, completion: nil)
        }))
        self.present(alertView, animated: true, completion: nil)
    }
}

