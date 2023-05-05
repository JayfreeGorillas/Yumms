//
//  ViewController.swift
//  Yumms
//
//  Created by Josfry Barillas on 4/28/23.
//

import UIKit

enum FetchError: Error {
    case statusCode(Int)
    case urlResponse
}
class DessertViewController: UIViewController {
    
    var networkManager = NetworkManager()
    var tableView = UITableView()
    
    var dessertList = [Dessert]()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemOrange
        
        configureTableView()
        networkManager.fetchDesserts { dessertResults in
            switch dessertResults {
            case let .success(desserts):
                // sort and return list
                
                DispatchQueue.main.async { [weak self] in
                    self?.dessertList = desserts.sorted(by: { lhs, rhs in
                        lhs.strMeal < rhs.strMeal
                    })
                    
                    self?.tableView.reloadData()
                }
                
            case let .failure(error):
                print("error fetching \(error)")
            }
        }
    }
    
    
    
    // MARK:  TableView setup
    func configureTableView() {
        view.addSubview(tableView)
        setTableViewProtocols()
        tableViewConstrainsts()
        tableView.register(DessertCell.self, forCellReuseIdentifier: "dessert")
        tableView.rowHeight = 120
    }
    
    func setTableViewProtocols() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
}

extension DessertViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dessertList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dessert") as! DessertCell

        cell.setupDessertCell(dessert: dessertList[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // MARK: pass over to detail VC
        let dessertDetailVC = DessertDetailsViewController()
        var currentDessert: DessertModel = DessertModel(name: "", area: "", instructions: "", ingredients: [Ingredients]())
        
        dessertDetailVC.title = dessertList[indexPath.row].strMeal
        print(dessertList[indexPath.row].strMeal, dessertList[indexPath.row].idMeal,
              dessertList[indexPath.row].strMealThumb)
        
        networkManager.fetchDessertDetails(id: dessertList[indexPath.row].idMeal) { dessertDetails in
            switch dessertDetails {
            case let .success(details):
                currentDessert = details
                let filteredIngredients = self.filterEmptyIngredients(from: currentDessert.ingredients)
                dessertDetailVC.instructions = currentDessert.instructions
                dessertDetailVC.dessertIngredients = filteredIngredients
                
                self.navigationController?.pushViewController(dessertDetailVC, animated: true)
                
            case let .failure(error):
                print("error: \(error.localizedDescription)")
            }
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableViewConstrainsts() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func filterEmptyIngredients(from dessert: [Ingredients]) -> [Ingredients] {
        let validIngredientList = dessert.filter { element in
            if element.ingredient.isEmpty && element.measureMent.isEmpty || element.ingredient == "" && element.measureMent == " "{
                return false
            }
            return true
        }
        return validIngredientList
    } 
}


// Extension on uiimageview to donwlown
extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFill) {
        self.contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
                
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFill) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
