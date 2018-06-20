//
//  ArtworkCollectionViewController.swift
//  MVP Colors
//
//  Created by Zhenia Pasko on 6/19/18.
//  Copyright © 2018 Zhenia Pasko. All rights reserved.
//

import UIKit

class ArtworkCollectionViewController: UIViewController, Reloadble {
    
    let presenter: ArtworkCollectionPresenter!
    var collectionView: UICollectionView!
    
    init(with presenter: ArtworkCollectionPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = presenter.backgroundColor
        self.presenter.delegate = self
        setupCollectionView()
        
        presenter.updateArtwork { [weak self] in
            OperationQueue.main.addOperation {
                self?.collectionView.reloadData()
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupCollectionView() {
        collectionView = UICollectionView(frame: self.view.frame,
                                          collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = presenter
        collectionView.refreshControl = refreshControl
        presenter.registerCells(for: collectionView)
        self.view.addSubview(collectionView)
    }
    
    let layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        let insetLeft: CGFloat = 5.0
        let insetRight: CGFloat = 5.0
        layout.sectionInset = UIEdgeInsets(top: 10,
                                           left: insetLeft,
                                           bottom: 5.0,
                                           right: insetRight)
        let itemWidth = UIScreen.main.bounds.width / 2 - (insetLeft + insetRight)
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        return layout
    }()
    
    let refreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.addTarget(self,
                          action: #selector(ArtworkCollectionViewController.refreshArtworks),
                          for: .valueChanged)
        return refresh
    }()
    
    @objc func refreshArtworks() {
        presenter.updateArtwork {
            [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
                self?.refreshControl.endRefreshing()
            }
        }
    }
}

extension ArtworkCollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        presenter.updateArtworkIfNeedded(index: indexPath.row)
    }
}

