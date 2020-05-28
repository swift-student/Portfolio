//
//  ProjectDetailCollectionViewController.swift
//  Portfolio
//
//  Created by Shawn Gee on 5/27/20.
//  Copyright © 2020 Swift Student. All rights reserved.
//

import UIKit

private let cellID = "FeatureCell"
private let headerID = "ProjectDetailHeaderView"

class ProjectDetailCollectionViewController: UICollectionViewController {
    
    // MARK: - Public Properties
    
    var project: Project?
    
    // MARK: - Private Properties
    
    private var sizingCell = FeatureCollectionViewCell()

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView!.register(UINib(nibName: "FeatureCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: cellID)
        self.collectionView!.register(UINib(nibName: "ProjectDetailHeaderView", bundle: .main),
                                      forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                      withReuseIdentifier: headerID)
            
        sizingCell = Bundle.main.loadNibNamed("FeatureCollectionViewCell", owner: self, options: nil)?.first as! FeatureCollectionViewCell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        project?.featuresArray.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: cellID,
            for: indexPath) as? FeatureCollectionViewCell else {
                fatalError("Unable to cast cell as \(FeatureCollectionViewCell.self)")
        }
    
        cell.feature = project?.featuresArray[indexPath.row]
    
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: headerID,
            for: indexPath) as? ProjectDetailHeaderView else {
                fatalError("Unable to cast header as \(ProjectDetailHeaderView.self)")
        }
        
        header.project = project
        
        return header
    }

}

// MARK: - Flow Layout Delegate

extension ProjectDetailCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        sizingCell.feature = project?.featuresArray[indexPath.item]
        sizingCell.setNeedsLayout()
        sizingCell.layoutIfNeeded()
        var cellSize = sizingCell.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        cellSize.width = collectionView.frame.width
        print(cellSize)
        return cellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let width = collectionView.frame.width
        
        return CGSize(width: width, height: width * 1.1)
    }
}