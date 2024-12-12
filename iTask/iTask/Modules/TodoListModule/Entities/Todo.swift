//
//  Todo.swift
//  iTask
//
//  Created by Адам Мирзаканов on 12.12.2024.
//

typealias Todos = [Todo]

struct Todo: Decodable, Hashable {
  var id: String
  var title: String
  var body: String
  var date: String
  var completed: Bool
  
  // MARK: CodingKeys
  private enum CodingKeys: String, CodingKey {
    case id
    case title
    case body = "todo"
    case date
    case completed
  }
}
