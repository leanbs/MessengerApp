//
//  ChatRoomViewController.swift
//  MessengerApp
//
//  Created by dikasetiadi on 23/07/19.
//  Copyright © 2019 Leanbs. All rights reserved.
//

import AsyncDisplayKit
import UIKit

class ChatRoomViewController: ASViewController<ASCollectionNode> {
    private var contactArray: [Contact] = [
        Contact(fullname: "Davin Iskandar", idName: "leanbs", profilePicture: #imageLiteral(resourceName: "PP1")),
        Contact(fullname: "Zunio Benarivo", idName: "Niobenarivo", profilePicture: #imageLiteral(resourceName: "PP2")),
        Contact(fullname: "Mas Boy", idName: "Penguinqu", profilePicture: #imageLiteral(resourceName: "PP3"))
    ]
    
    private var messageArr: [Message] = [Message]()
    
    private var rootNode: ASCollectionNode
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        layout.scrollDirection = .vertical
        
        rootNode = ASCollectionNode(collectionViewLayout: layout)
        
        super.init(node: rootNode)
        
        configureNodes()
        
        messageArr = [
            Message(fromUser: contactArray[0], messages: ChatMessage(id: "1", date: Date(), text: "Testing1Testing1Testing1Testing1Testing1Testing1Testing1 Testing1Testing1Testing1Testing1Testing1Testing1Testing1Testing1Testing1Testing1Testing1Testing1Testing1Testing1 Testing1Testing1Testing1Testing1Testing1Testing1Testing1")),
            Message(fromUser: contactArray[0], messages: ChatMessage(id: "2", date: Date(), text: "Testing2")),
            Message(fromUser: contactArray[0], messages: ChatMessage(id: "3", date: Date(), text: "Testing3Testing3Testing3")),
        ]
    }

    private func configureNodes() {
        rootNode.automaticallyManagesSubnodes = true
        rootNode.dataSource = self
        rootNode.delegate = self
        
        rootNode.backgroundColor = .yellow
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ChatRoomViewController: ASCollectionDelegate {
    func numberOfSections(in collectionNode: ASCollectionNode) -> Int {
        return 1
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        return messageArr.count
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, nodeForItemAt indexPath: IndexPath) -> ASCellNode {
        let data = messageArr[indexPath.row].messages
        
        let cell = ChatCell(messageInfo: data)
        return cell
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, constrainedSizeForItemAt indexPath: IndexPath) -> ASSizeRange {
        
        let messageText = messageArr[indexPath.row].messages.text
        let size = CGSize(width: view.frame.width, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        
        let estimatedFrame = NSString(string: messageText).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)], context: nil)
        print("estimate: \(estimatedFrame)")
        return .init(min: CGSize(width: UIScreen.main.bounds.width, height: 0), max: CGSize(width: (UIScreen.main.bounds.width), height: estimatedFrame.height))
    }
}

extension ChatRoomViewController: ASCollectionDataSource {
    
}

extension ChatRoomViewController: ASCollectionDelegateFlowLayout {
    
}

struct Contact {
    let fullname: String
    let idName: String
    let profilePicture: UIImage
}

struct ChatMessage {
    let id: String
    let date: Date
    let text: String
}

public struct Message {
    let fromUser: Contact
    let messages: ChatMessage
}

