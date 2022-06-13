//
//  IntroduceSubViewController.swift
//  SSCollection
//
//  Created by heyji on 2022/06/03.
//

import UIKit

class IntroduceSubViewController: UIViewController {

    @IBOutlet weak var introCollectionView: UICollectionView!
    @IBOutlet weak var listCollectionView: UICollectionView!
    
    enum Section {
        case main
    }
    typealias Item = Intro
    
    let introInfo: [Intro] = Intro.list
    var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
    
    enum Sectiontwo: CaseIterable {
        case ott
        case productivity
        
        var title: String {
            switch self {
            case .ott: return "OTT Service"
            case .productivity: return "Productivity Service"
            }
        }
    }
    
    typealias Itemtwo = Contents
    
    let ottList: [Contents] = Contents.ott
    let productivityList: [Contents] = Contents.productivity
    var dataSourcetwo: UICollectionViewDiffableDataSource<Sectiontwo, Itemtwo>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Apps"

        // First collectionView
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: introCollectionView, cellProvider: { collectionView, indexPath, item in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IntroCell", for: indexPath) as? IntroCell else {
                return nil
            }
            cell.configure(item)
            return cell
        })
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.main])
        snapshot.appendItems(introInfo, toSection: .main)
        dataSource.apply(snapshot)
        
        introCollectionView.collectionViewLayout = layout()
        
        // Second collectionView
        dataSourcetwo = UICollectionViewDiffableDataSource<Sectiontwo, Itemtwo>(collectionView: listCollectionView, cellProvider: { collectionView, indexPath, item in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ListCell", for: indexPath) as? ListCell else {
                return nil
            }
            cell.configure(item)
            return cell
        })
        
        dataSourcetwo.supplementaryViewProvider = { (collectionView, kind, indexPath) in
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "ListHeaderView", for: indexPath) as? ListHeaderView else {
                return nil
            }
            let allSection = Sectiontwo.allCases
            let section = allSection[indexPath.section]
            
            header.configure(section.title)
            return header
        }
        
        var listsnapshot = NSDiffableDataSourceSnapshot<Sectiontwo, Itemtwo>()
        listsnapshot.appendSections([.ott, .productivity])
        listsnapshot.appendItems(ottList, toSection: .ott)
        listsnapshot.appendItems(productivityList, toSection: .productivity)
        dataSourcetwo.apply(listsnapshot)
        
        listCollectionView.collectionViewLayout = layouttwo()
        
        listCollectionView.alwaysBounceVertical = false
        
        
    }
    
    // TODO: 마지막 그룹 안에 아이템이 1개거나 2개일 시 trailing 값이 적용되지 않음
    private func layouttwo() -> UICollectionViewCompositionalLayout {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.33))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.92), heightDimension: .absolute(250))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 3)
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
        group.interItemSpacing = .fixed(16)
        
        let section = NSCollectionLayoutSection(group: group)
        
        section.orthogonalScrollingBehavior = .groupPagingCentered
        
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(45))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        section.boundarySupplementaryItems = [header]
        header.contentInsets = .init(top: 0, leading: 20, bottom: 0, trailing: 20)
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 30
        let layout = UICollectionViewCompositionalLayout(section: section, configuration: config)
        return layout
    }
    
    private func layout() -> UICollectionViewCompositionalLayout {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.92), heightDimension: .absolute(400))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
