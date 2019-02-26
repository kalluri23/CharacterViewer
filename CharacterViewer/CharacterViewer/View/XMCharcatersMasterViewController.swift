//
//  XMCharcatersMasterViewController.swift
//  CharacterViewer
//
//  Created by Krishna teja Kalluri on 2/5/19.
//  Copyright © 2019 xfinity. All rights reserved.
//

import UIKit

protocol XMCharcaterSelectionDelegate: class {
    func characterSelected(_ character: XMCharacter)
}

class XMCharcatersMasterViewController: UIViewController {

    @IBOutlet weak var viewModel: XMCharactersListViewModel!
    
    @IBOutlet weak var charactersCollectionView: UICollectionView!
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var characterSearchBar: UISearchBar!
    
    
    @IBOutlet weak var layoutButton: UIButton!
    var isListLayout = true
    
    weak var delegate: XMCharcaterSelectionDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.activityIndicator.startAnimating()
        viewModelBinding()
        // Do any additional setup after loading the view.
    }
    
    private func viewModelBinding()  {
        viewModel.reloadData = { [unowned self] in
            DispatchQueue.main.async {
                self.charactersCollectionView.reloadData()
                self.activityIndicator.stopAnimating()
            }
        }
        
        viewModel.reloadDetailData = { [unowned self] in
            DispatchQueue.main.async {
                if let detailNavVC = self.splitViewController?.viewControllers.last as? UINavigationController, let detailVC = detailNavVC.topViewController as? XMCharacterDetailViewController {
                    detailVC.character = self.viewModel.characters?.first
                }
            }
        }
    }
    
    
    @IBAction func layoutButtonTapped(_ sender: UIButton) {
        if isListLayout {
            isListLayout = false
            UIView.animate(withDuration: 0.2, animations: {[unowned self] () -> Void in
                self.charactersCollectionView.collectionViewLayout.invalidateLayout()
                self.charactersCollectionView.reloadData()
                }, completion: {(completed) in
                    if completed {
                        sender.setImage(UIImage(named: "list"), for: .normal)
                    }
            })
        }else {
            isListLayout = true
            UIView.animate(withDuration: 0.2, animations: {[unowned self] () -> Void in
                self.charactersCollectionView.collectionViewLayout.invalidateLayout()
                self.charactersCollectionView.reloadData()
                }, completion: {(completed) in
                    if completed {
                        sender.setImage(UIImage(named: "grid"), for: .normal)
                    }
            })
        }
    }
    

}

extension XMCharcatersMasterViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numberOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if isListLayout {
            let characterCell = collectionView.dequeueReusableCell(withReuseIdentifier: "XMTitleCell", for: indexPath) as! XMTitleCell
            characterCell.configure(withTitle: viewModel.characterAtIndex(index: indexPath.item).title)
            return characterCell
        }else {
            let characterCell = collectionView.dequeueReusableCell(withReuseIdentifier: "XMImageCell", for: indexPath) as! XMImageCell
            characterCell.configure(withImageUrl: viewModel.characterAtIndex(index: indexPath.item).iconURL)
            return characterCell
        }
    }
}

extension XMCharcatersMasterViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let detailViewController =  delegate as? XMCharacterDetailViewController,
            let detailNavigationController = detailViewController.navigationController {
            delegate?.characterSelected(viewModel.characterAtIndex(index: indexPath.item))
            splitViewController?.showDetailViewController(detailNavigationController, sender: nil)
        }

        
    }
    
}

extension XMCharcatersMasterViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if isListLayout {
            let totalSpace = flowLayout.sectionInset.left
                + flowLayout.sectionInset.right
                + (flowLayout.minimumInteritemSpacing) + 1
            let cellHeight = viewModel.characterAtIndex(index: indexPath.item).title?.height(withConstrainedWidth: (collectionView.frame.size.width - totalSpace), font: UIFont.systemFont(ofSize: 20.0))
            return CGSize(width: collectionView.frame.size.width - totalSpace, height: (cellHeight  ?? 30) + 60)
        }else {
            return CGSize(width: 100, height: 100)
        }
    }
}

extension XMCharcatersMasterViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            searchBar.resignFirstResponder()
            self.viewModel.searchCharcters(matching: nil)
            return
        }
        self.viewModel.searchCharcters(matching: searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        self.viewModel.searchCharcters(matching: nil)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        self.viewModel.searchCharcters(matching: searchBar.text)
    }
    
}
