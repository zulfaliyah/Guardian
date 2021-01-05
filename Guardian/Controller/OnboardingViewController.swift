//
//  OnboardingViewController.swift
//  Guardian
//
//  Created by Zulfa Aliyah on 05/01/21.
//

import UIKit

struct Slide {
    let title: String
    let imageName: String
    
    static let collection: [Slide] = [
        .init(title: "Selamatkan bumi dari sampah dengan menabung", imageName: "OnboardingBG1"),
        .init(title: "Sampah yang disetor akan didaur ulang kembali", imageName: "OnboardingBG2"),
        .init(title: "Cairkan saldo dan rasakan manfaatnya", imageName: "OnboardingBG3"),
    ]
}

class OnboardingViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var masukBtn: UIButton!
    @IBOutlet weak var daftarBtn: UIButton!
    
    private let slides = Slide.collection
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupPageControl()
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = layout
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = .clear
    }
    
    private func setupPageControl() {
        pageControl.numberOfPages = slides.count
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = Int(collectionView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = index

    }
    
    @IBAction func donePressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }


}

extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! OnboardingCollectionViewCell
        let slide = slides[indexPath.item]
        cell.configure(with: slide)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = collectionView.bounds.width
        let itemHeight = collectionView.bounds.height
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

class OnboardingCollectionViewCell: UICollectionViewCell {
   
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    func configure(with slide: Slide) {
        titleLabel.text = slide.title
        
        let image = UIImage(named: slide.imageName)
        imageView.image = image
    }
    
}

