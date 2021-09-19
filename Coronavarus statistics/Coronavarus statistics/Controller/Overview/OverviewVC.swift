//
//  ViewController.swift
//  Coronavarus statistics
//
//  Created by David on 1/1/21.
//

import UIKit

class OverviewVC: UIViewController {
    
    private let scrollView = UIScrollView()
    private let scrollContentView = UIView()
    
    private let loadingOverlay = Utilities().loadingView()

    private var overviewData: Global? {
        didSet {
            guard let overviewData = overviewData else { return }
            newConfirmedInfoView.textLabel.text = String(overviewData.newConfirmed)
            totalConfirmedInfoView.textLabel.text = String(overviewData.totalConfirmed)
            newDeathsInfoView.textLabel.text = String(overviewData.newDeaths)
            totalDeathsInfoView.textLabel.text = String(overviewData.totalDeaths)
            newRecoveredInfoView.textLabel.text = String(overviewData.newRecovered)
            totalRecoveredInfoView.textLabel.text = String(overviewData.totalRecovered)
        }
    }

    private let newConfirmedInfoView = InfoView(caption: "New confirmed")
    private let totalConfirmedInfoView = InfoView(caption: "Total confirmed")
    private let newDeathsInfoView = InfoView(caption: "New deaths")
    private let totalDeathsInfoView = InfoView(caption: "Total deaths")
    private let newRecoveredInfoView = InfoView(caption: "New recovered")
    private let totalRecoveredInfoView = InfoView(caption: "Total recovered")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout()
        configureSubviews()
        configureNavBar()
        configureUI()
        fetchOverviewData()
    }

    @objc func updateButtonPressed() {
        fetchOverviewData()
    }
    
    func layout() {
        
        view.addSubview(scrollView)
        scrollView.pinToSafeAreaSuperview()
        
        scrollView.addSubview(scrollContentView)
        scrollContentView.pinToSuperview()
        scrollContentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
    }

    func configureSubviews() {
        let vStackView = UIStackView(
            arrangedSubviews: [
                newConfirmedInfoView,
                totalConfirmedInfoView,
                newDeathsInfoView,
                totalDeathsInfoView,
                newRecoveredInfoView,
                totalRecoveredInfoView,
            ]
        )

        vStackView.axis = .vertical
        vStackView.distribution = .fillEqually
        vStackView.spacing = 10
        
        scrollContentView.addSubview(vStackView)
        vStackView.anchor(top: scrollContentView.topAnchor,
                          left: scrollContentView.leftAnchor,
                          bottom: scrollContentView.bottomAnchor,
                          right: scrollContentView.rightAnchor)
    }
    
    func configureNavBar() {
        let button = UIButton()
        button.setImageWithSize(size: 20, systemImgName: "arrow.triangle.2.circlepath")
        button.addTarget(self, action: #selector(updateButtonPressed), for: .touchUpInside)
        let barButton = UIBarButtonItem(customView: button)
        navigationItem.rightBarButtonItem = barButton
        navigationItem.title = "Worldwide"
    }
    
    func configureUI() {
        view.backgroundColor = .white
    }
    
    func fetchOverviewData() {

        startLoadingAnimation()
        NetworkService.shared.getOverviewStatistics { [weak self] response in
            switch response.result {
            case .success(let response):
                self?.overviewData = response.global
                self?.stopLoadingAnimation()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func startLoadingAnimation() {
        view.addSubview(loadingOverlay)
        loadingOverlay.pinTo(view)
    }
    
    func stopLoadingAnimation() {
        loadingOverlay.removeFromSuperview()
    }
}

