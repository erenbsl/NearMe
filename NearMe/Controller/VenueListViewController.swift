//
//  ViewController.swift
//  NearMe
//
//  Created by Eren Besel on 2019/08/21.
//  Copyright © 2019 Eren Besel. All rights reserved.
//

import UIKit
import CoreLocation

class VenueListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: VenueListViewModel!
    let locationManager = CLLocationManager()
    var isFirstBatch: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLocationManager()
        // initialize the view model asap
        viewModel = VenueListViewModel(dataProvider: VenuesDataProvider())
        setupTableView()
    }
    
    func setupLocationManager() {
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func setupTableView() {
        tableView.register(UINib(classType: VenuListCell.classForCoder()), forCellReuseIdentifier: VenuListCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        let refreshControl = UIRefreshControl(frame: .zero)
        refreshControl.addTarget(self, action: #selector(refreshTriggered), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    func loadVenues(isNextBatch: Bool) {
        guard let location = locationManager.location else { return }
        viewModel.loadVenues(near: location.coordinate, radius: 1000) { [weak self] (indexes, errorMessage) in
            guard let self = self else { return }
            
            self.tableView.refreshControl?.endRefreshing()
            if let indexes = indexes {
                if isNextBatch == false {
                    self.tableView.reloadData()
                    self.isFirstBatch = false
                } else {
                    let indexPaths = indexes.map { IndexPath(row: $0, section: 0) }
                    self.tableView.insertRows(at: indexPaths, with: .automatic)
                }
            }
        }
    }

    @objc func refreshTriggered() {
        viewModel.reset()
        loadVenues(isNextBatch: false)
    }
}

extension VenueListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfVenues
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: VenuListCell.identifier, for: indexPath)
        
        // check and load the next batch if needed
        if indexPath.row == viewModel.numberOfVenues - 1 {
            loadVenues(isNextBatch: true)
        }
        
        if let cell = cell as? VenuListCell, let cellModel = viewModel.cellModel(at: indexPath.row) {
            cell.configure(with: cellModel)
        }
        
        return cell
    }
}

extension VenueListViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        loadVenues(isNextBatch: false)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    }
}

