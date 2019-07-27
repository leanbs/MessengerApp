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
    
    private var dataRoomChat: Message
    
    private var rootNode: ASCollectionNode
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 16
        layout.scrollDirection = .vertical
        
        dataRoomChat = Message(dataUser: contactArray[1], messages: [])
        
        rootNode = ASCollectionNode(collectionViewLayout: layout)
        super.init(node: rootNode)
        
        dataRoomChat.messages = [
                ChatMessage(id: "1", isSender: false, date: Date(), text: "Testing1 Testing1Testing1 Testing1Testing1Testing1Testing1 Testing1Testing1Testing1Testing1Testing1Testing1Testing1Testing1Testing1Testing1Testing1Testing1Testing1Testing1 Testing1Testing1Testing1Testing1Testing1Testing1Testing1"),
                ChatMessage(id: "2", isSender: true, date: Date(), text: "Testing2"),
                ChatMessage(id: "3", isSender: true, date: Date(), text: "Testing3 Testing3 Testing3"),
                ChatMessage(id: "4", isSender: false, date: Date(), text: "Testing3 Testing3 Testing3"),
                ChatMessage(id: "5", isSender: false, date: Date(), text: "Testing3 Testing3 Testing3"),
                ChatMessage(id: "6", isSender: false, date: Date(), text: "Testing3 Testing3 Testing3"),
                ChatMessage(id: "7", isSender: false, date: Date(), text: "Testing3 Testing3 Testing3"),
                ChatMessage(id: "8", isSender: false, date: Date(), text: "Testing3 Testing3 Testing3"),
                ChatMessage(id: "9", isSender: false, date: Date(), text: "Testing3 Testing3 Testing3"),
                ChatMessage(id: "10", isSender: false, date: Date(), text: "Testing3 Testing3 Testing3"),
                ChatMessage(id: "11", isSender: false, date: Date(), text: "Testing3 Testing3 Testing3"),
                ChatMessage(id: "11", isSender: false, date: Date(), text: "Asd"),
            ]
        
        configureNodes()
    }

    private func configureNodes() {
        rootNode.automaticallyManagesSubnodes = true
        rootNode.dataSource = self
        rootNode.delegate = self
        
        rootNode.backgroundColor = .white
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
        return dataRoomChat.messages.count
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, nodeForItemAt indexPath: IndexPath) -> ASCellNode {
        let data = dataRoomChat.messages[indexPath.row]
        let cell = ChatCell(messageInfo: data, userData: dataRoomChat.dataUser)
        
        return cell
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, constrainedSizeForItemAt indexPath: IndexPath) -> ASSizeRange {
        
        let messageText = dataRoomChat.messages[indexPath.row].text
        let size = CGSize(width: 200, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        
        let estimatedFrame = NSString(string: messageText).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)], context: nil)
        
        return .init(min: CGSize(width: (UIScreen.main.bounds.width), height: 0), max: CGSize(width: (UIScreen.main.bounds.width), height: estimatedFrame.height + 16))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
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
    let isSender: Bool
    let date: Date
    let text: String
}

public struct Message {
    let dataUser: Contact
    var messages: [ChatMessage]
}

