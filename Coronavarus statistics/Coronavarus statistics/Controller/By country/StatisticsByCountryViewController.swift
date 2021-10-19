//
//  ByCountryVC.swift
//  Coronavarus statistics
//
//  Created by David on 1/1/21.
//
import UIKit

final class StatisticsByCountryViewController: UIViewController {

    private let tableView = UITableView()

    private var countries: [Country] = [] {
        didSet {
            DispatchQueue.main.async {
                self.configureSections()
                self.tableView.reloadData()
                self.stopLoadingAnimation()
            }
        }
    }
    private var sortedFirstLettersOfCountries: [String] = []
    private var sections: [[Country]] = [[]]

    private let loadingOverlay: UIView = Utilities().loadingView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        prepare()
        fetchCountriesData()
    }

    @objc private func updateButtonPressed() {
        fetchCountriesData()
    }

    private func prepare() {
        confifureTableView()
        configureNavBar()
        configureUI()
        configureSubviews()
    }

    private func fetchCountriesData() {
        startLoadingAnimation()
        NetworkService.shared.getOverviewStatistics { [weak self] response in
            switch response.result {
            case .success(let response):
                self?.countries = response.countries
            case .failure(let error):
                print(error)
            }
        }
    }

    private func confifureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 55
        tableView.register(CountryCell.self, forCellReuseIdentifier: "CountryCell")
        tableView.sectionIndexColor = .black
    }
    
    private func configureNavBar() {
        let button = UIButton()
        button.setImageWithSize(size: 20, systemImgName: "arrow.triangle.2.circlepath")
        button.addTarget(self, action: #selector(updateButtonPressed), for: .touchUpInside)
        let barButton = UIBarButtonItem(customView: button)
        navigationItem.rightBarButtonItem = barButton
        navigationItem.title = "By country"
    }
    
    private func configureUI() {
        view.backgroundColor = .white
    }
    
    private func configureSubviews() {
        view.addSubview(tableView)
        tableView.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            left: view.leftAnchor,
            bottom: view.bottomAnchor,
            right: view.rightAnchor
        )
    }
    
    func configureSections() {
        let firstLetters = countries.map { $0.titleFirstLetter }
        let uniqueFirstLetters = Array(Set(firstLetters))

        sortedFirstLettersOfCountries = uniqueFirstLetters.sorted()
        sections = sortedFirstLettersOfCountries.map { firstLetter in
            return countries
                .filter { $0.titleFirstLetter == firstLetter }
                .sorted { $0.country < $1.country }
        }
    }
    
    private func startLoadingAnimation() {
        view.addSubview(loadingOverlay)
        loadingOverlay.pinTo(view)
    }
    
    private func stopLoadingAnimation() {
        loadingOverlay.removeFromSuperview()
    }
}

extension StatisticsByCountryViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard !sortedFirstLettersOfCountries.isEmpty else { return "Loading.." }
        return sortedFirstLettersOfCountries[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell") as! CountryCell
        let country = sections[indexPath.section][indexPath.row]
        cell.set(countryName: country.country)
        
        return cell
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return sortedFirstLettersOfCountries
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let countryDetailsVC = CountryDetailsViewController(country: sections[indexPath.section][indexPath.row])
        navigationController?.pushViewController(countryDetailsVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
