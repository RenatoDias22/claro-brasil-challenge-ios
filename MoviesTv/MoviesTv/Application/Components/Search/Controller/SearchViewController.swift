//
//  SearchMoviesViewController.swift
//  MoviesTv
//
//  Created by Renato Dias on 04/08/2018.
//  Copyright © 2018 Renato Dias. All rights reserved.
//

import UIKit
import JSONJoy
import SwiftHTTP
import SVProgressHUD
import Alamofire

class SearchViewController: RootViewController {

    var searchTimer: Timer?
    
    var httpManager = HttpManager()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var search: UISearchController!
    
    var movies: [Movies] = [Movies]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setSearchbar()
        self.setTitle()
        self.collectionView.register(cellType: MovieCollectionViewCell.self)
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self,
                                       selector: #selector(SearchViewController.setMovie),
                                       name: .setMovieObjectkey,
                                       object: nil)
        
//        NotificationCenter.default.addObserver(self, selector: #selector(SearchViewController.setMovie), name: NSNotification.Name(rawValue: setMovieObjectkey), object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.searchTimer?.invalidate()
    }
    
    private func setTitle() {
        if #available(iOS 11.0, *) {
            self.navigationItem.searchController = search
            self.navigationItem.largeTitleDisplayMode = .never
            self.navigationItem.hidesSearchBarWhenScrolling = false
        } else{
            self.navigationItem.titleView = search.searchBar
        }
    }

    private func setSearchbar() {
        search = UISearchController(searchResultsController: nil)
        search.delegate = self
        search.searchBar.delegate = self
        search.searchResultsUpdater = self
        search.dimsBackgroundDuringPresentation = false
        search.searchBar.sizeToFit()
        search.searchBar.tintColor = .white
        search.isActive = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if self.isMovingToParentViewController {
            search.isActive = true
        }
    }
    
    @objc func setMovie(notfication: NSNotification) {
        if let dict = notfication.object as! [Movies]? {
            if let moveisObj = dict as? [Movies] {
                self.movies = moveisObj
            }
        }
        self.collectionView.reloadData()
    }
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.movies.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let movie = self.movies[indexPath.row]
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: MovieCollectionViewCell.self)
        cell.setImageView(movie)

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 8+2, bottom: 8, right: 8+2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfItemsInRow: CGFloat = CGFloat(Int(UIScreen.main.bounds.width/(342.0/UIScreen.main.scale)))
        let width = (UIScreen.main.bounds.width/numberOfItemsInRow) - (2 * 8)
        let height = width/0.667
        return CGSize(width: width, height: height)
    }
    
}

extension SearchViewController: UISearchControllerDelegate, UISearchBarDelegate, UISearchResultsUpdating {
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        self.searchTimer?.invalidate()
        self.clearResult()
        self.dismiss(animated: true, completion: nil)
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchString = searchController.searchBar.text {
            if !searchString.isEmpty && searchString.count > 2 {
                self.searchTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(SearchViewController.searchTimer(_:)), userInfo: searchString, repeats: false)
            }
        }
    }
    
    @objc func searchTimer(_ timer: Timer) {
        if let text = timer.userInfo as? String {
//            self.startLoading()
            self.movies.removeAll()
            self.httpManager.getFavoritos(query: text)

        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.text = nil
        self.dismiss(animated: true, completion: nil)
        self.searchTimer?.invalidate()
    }
    
    func presentSearchController(_ searchController: UISearchController) {
        self.search.searchBar.becomeFirstResponder()
        self.searchTimer?.invalidate()
    }
    
    func didDismissSearchController(_ searchController: UISearchController) {
        self.searchTimer?.invalidate()
    }
    
    private func clearResult() {
        self.movies = []
        self.collectionView.reloadData()
//        self.endLoading()
    }
    
}

