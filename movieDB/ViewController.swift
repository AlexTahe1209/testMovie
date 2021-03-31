//
//  ViewController.swift
//  movieDB
//
//  Created by Alex Rivera BBVA on 31/03/21.
//

import UIKit

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, RequestManagerDelegate {
   
    //Le indico al arreglo que es de tal tipo para despues poder acceder a sus atributos
    var arr_info : [MoviesModel] = NSMutableArray() as! [MoviesModel]
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        let requestManager = RequetsManager()
        requestManager.delegate = self;
        requestManager.sendRequest()
    }
    
    // MARK : UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        return self.arr_info.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        
        cell.titleCell.text = arr_info[indexPath.row].original_title
        cell.descriptionCell.text = arr_info[indexPath.row].overview
    
        //aquí se busca la imagen
        let url = URL(string: arr_info[indexPath.row].url_image)
        let data = try? Data(contentsOf: url!)
        cell.imageCell?.image = UIImage(data: data!)
        
        return TableViewCell()
    }
    
    // MARK : UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 150
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        _ = tableView.indexPathForSelectedRow
        if let _ = tableView.cellForRow(at: indexPath as IndexPath)
        {
            performSegue(withIdentifier: "segueInfo", sender: nil)
        }
    }
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "segueInfo"
        {
            if let indexPath = self.tableView.indexPathForSelectedRow
            {
                let destination = segue.destination as! ProductDetailViewController
                
                destination.originalTitle = arr_info[indexPath.row].original_title
                destination.picture = arr_info[indexPath.row].url_image
                destination.overview = arr_info[indexPath.row].overview
            }
        }
    }
    
    //interface de request manager
    func didGetResponseModel(response: [MoviesModel])
    {
        arr_info = response;
        //regreso al hilo principal
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    
}



