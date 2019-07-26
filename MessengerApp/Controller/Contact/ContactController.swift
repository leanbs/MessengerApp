//
//  ContactController.swift
//  MessengerApp
//
//  Created by Davin on 23/07/19.
//  Copyright © 2019 Leanbs. All rights reserved.
//

import AsyncDisplayKit

class ContactController: ASViewController<ASTableNode> {
    fileprivate let cellId = "cellId"
    fileprivate let tableView = ASTableNode()
    
    public init() {
//        let rootNode = ASScrollNode()
        
        super.init(node: tableView)
//        rootNode.automaticallyManagesSubnodes = true
//        rootNode.automaticallyManagesContentSize = true
//        rootNode.scrollableDirections = [.up, .down]
//        rootNode.backgroundColor = .yellow
//
//        tableView.backgroundColor = .red
//
//        rootNode.layoutSpecBlock = { _, _ in
//            let vs = ASStackLayoutSpec.vertical()
//            vs.spacing = 16
//
//            vs.children = [
//                self.tableView
//            ]
//
//            return vs
//        }
    }
    
    override func viewDidLoad() {
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ContactController: ASTableDataSource {
    func numberOfSections(in tableNode: ASTableNode) -> Int {
        return 1
    }
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableNode(_ tableNode: ASTableNode, constrainedSizeForRowAt indexPath: IndexPath) -> ASSizeRange {
        return .init(min: CGSize(width: 0, height: 0), max: CGSize(width: UIScreen.main.bounds.width, height: 64))
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeForRowAt indexPath: IndexPath) -> ASCellNode {
        let cell = ASCellNode()
        cell.backgroundColor = .red
        return cell
    }
}

extension ContactController: ASTableDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = UIView()
        cell.backgroundColor = .blue
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
}
