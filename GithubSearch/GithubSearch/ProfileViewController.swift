//
//  ProfileViewController.swift
//  GithubSearch
//
//  Created by heyji on 2022/06/30.
//

import UIKit
import Combine

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var followers: UILabel!
    @IBOutlet weak var following: UILabel!
    
    @Published private(set) var user: UserProfile?
    var subscriptions = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        embedSearchControl()
        bind()
    }
    
    private func setupUI() {
        profileImageView.layer.cornerRadius = 40
    }
    
    private func embedSearchControl() {
        self.navigationItem.title = "Search"
        let searchController = UISearchController(searchResultsController: nil)
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "UserName"
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        self.navigationItem.searchController = searchController
    }
    
    private func bind() {
        $user
            .receive(on: RunLoop.main)
            .sink { [unowned self] result in
                self.update(result)
            }.store(in: &subscriptions)
    }
    
    private func update(_ user: UserProfile?) {
        guard let user = user else {
            profileImageView.image = nil
            nameLabel.text = "n/a"
            idLabel.text = "n/a"
            bioLabel.text = ""
            followers.text = "0 followers"
            following.text = "0 following"
            return
        }
        let profileURL = "\(user.avatarUrl)"
        guard let imageURL = URL(string: profileURL),
              let imageData = try? Data(contentsOf: imageURL)
        else { return }
        profileImageView.image = UIImage(data: imageData)
        nameLabel.text = user.name
        idLabel.text = user.login
        bioLabel.text = user.bio
        followers.text = "\(user.followers) followers"
        following.text = "\(user.following) following"
    }
}

extension ProfileViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let keyword = searchController.searchBar.text
        print(keyword)
    }
}

extension ProfileViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let keyword = searchBar.text,
                !keyword.isEmpty else { return }
        
        let base = "https://api.github.com/"
        let path = "users/\(keyword)"
        let params: [String: String] = [:]
        let header: [String: String] = ["Content-Type": "application/json"]
        
        guard var urlComponents = URLComponents(string: base + path) else { return }
        let queryItem = params.map { (key: String, value: String) in
            return URLQueryItem(name: key, value: value)
        }
        urlComponents.queryItems = queryItem
        
        var request = URLRequest(url: urlComponents.url!)
        header.forEach { (key: String, value: String) in
            request.addValue(value, forHTTPHeaderField: key)
        }
        
        URLSession.shared
            .dataTaskPublisher(for: request)
            .tryMap { result -> Data in
                guard let response = result.response as? HTTPURLResponse,
                (200..<300).contains(response.statusCode) else {
                    let response = result.response as? HTTPURLResponse
                    let statusCode = response?.statusCode ?? -1
                    throw NetworkError.responseError(statusCode: statusCode)
                }
                return result.data
            }
            .decode(type: UserProfile.self, decoder: JSONDecoder())
//            .print() -> 어느 부분에서 에러가 뜨는지 알 수 있음
            .receive(on: RunLoop.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    self.user = nil
                case .finished: break
                }
            } receiveValue: { user in
                self.user = user
            }.store(in: &subscriptions)
    }
}
