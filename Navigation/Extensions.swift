//
//  Extensions.swift
//  Navigation
//
//  Created by Aleksey on 27.09.2022.
//

import UIKit

extension UITextField {
    func setPaddingPoints(_ amount: CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return ProfileHeaderView()
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        publications.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as? PostTableViewCell else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
            return cell
        }
        
        let post = publications[indexPath.row]
        
        let postViewModel = PostTableViewCell.Post(
            author: post.author,
            image: post.image,
            description: post.description,
            likes: "Likes: \(post.likes)",
            views: "Views: \(post.views)"
        )
        cell.setup(with: postViewModel)
        return cell
        }
        
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 250
        }
        return UITableView.automaticDimension
    }

}
