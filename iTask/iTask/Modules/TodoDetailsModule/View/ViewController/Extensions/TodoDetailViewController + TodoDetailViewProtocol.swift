//
//  TodoDetailViewController + TodoDetailViewProtocol.swift
//  iTask
//
//  Created by Адам Мирзаканов on 13.12.2024.
//

extension TodoDetailViewController: TodoDetailsViewProtocol {
  func showTodoContent(
    _ taskTitle: String,
    _ taskBody: String,
    _ taskDate: String
  ) {
    rootView.taskTitleTextView.text = taskTitle
    rootView.taskBodyTextView.text = taskBody
    rootView.dateLabel.text = taskDate.toLongDate(style: .long)
  }
}
