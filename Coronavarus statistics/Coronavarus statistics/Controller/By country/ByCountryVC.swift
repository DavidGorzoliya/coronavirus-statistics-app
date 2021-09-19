//
//  ByCountryVC.swift
//  Coronavarus statistics
//
//  Created by David on 1/1/21.
//
import UIKit

class ByCountryVC: UIViewController {
    
    // MARK: - Properties
    
    var tableView = UITableView()
    var countries: [Country] = []
    var sortedFirstLetters: [String] = []
    var sections: [[Country]] = [[]]
    
    let loadingOverlay: UIView = {
        let loadingOverlay = Utilities().loadingView()
        
        return loadingOverlay
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchCountriesData()
        confifureTableView()
        configureNavBar()
        configureUI()
        configureSubviews()
    }
    
    // MARK: - Selectors
    
    @objc func updateButtonPressed() {
        fetchCountriesData()
    }

    // MARK: - Helpers
    func fetchCountriesData() {
        startLoadingAnimation()
        NetworkService.shared.getOverviewStatistics { [weak self] response in
            guard let res = response.value else { return }
            self?.countries = res.countries
            self?.configureSections()
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.stopLoadingAnimation()
            }
        }
    }
    
    func confifureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 55
        tableView.register(CountryCell.self, forCellReuseIdentifier: "CountryCell")
        tableView.sectionIndexColor = .black
    }
    
    func configureNavBar() {
        let button = UIButton()
        button.setImageWithSize(size: 20, systemImgName: "arrow.triangle.2.circlepath")
        button.addTarget(self, action: #selector(updateButtonPressed), for: .touchUpInside)
        let barButton = UIBarButtonItem(customView: button)
        navigationItem.rightBarButtonItem = barButton
        navigationItem.title = "By country"
    }
    
    func configureUI() {
        view.backgroundColor = .white
    }
    
    func configureSubviews() {
        view.addSubview(tableView)
        tableView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
    }
    
    func configureSections() {
        let firstLetters = countries.map { $0.titleFirstLetter }
        let uniqueFirstLetters = Array(Set(firstLetters))

        sortedFirstLetters = uniqueFirstLetters.sorted()
        sections = sortedFirstLetters.map { firstLetter in
            return countries
                .filter { $0.titleFirstLetter == firstLetter }
                .sorted { $0.country < $1.country }
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

extension ByCountryVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard !sortedFirstLetters.isEmpty else { return "Loading.." }
        return sortedFirstLetters[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell") as! CountryCell
        let country = sections[indexPath.section][indexPath.row]
        cell.set(countryName: country.country)
        
        return cell
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return sortedFirstLetters
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let countryDetailsVC = CountryDetailsVC(country: sections[indexPath.section][indexPath.row])
        navigationController?.pushViewController(countryDetailsVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
