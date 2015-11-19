/* gui/mainwindow.h
   Main window for GUI.

   Author: Fei Huang <felix.fei.huang@gmail.com>
 */
/* ====================================================================
 * Dissent: Accountable Group Anonymity
 * Copyright (c) 2010 Yale University.
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to
 *
 *   Free Software Foundation, Inc.,
 *   51 Franklin Street, Fifth Floor,
 *   Boston, MA  02110-1301  USA
 */

#ifndef _DISSENT_GUI_MAINWINDOW_H_
#define _DISSENT_GUI_MAINWINDOW_H_

#include <QDialog>
#include <QList>
#include <QString>
#include <QByteArray>
#include <QMutex>

#include "ui_mainwindow.h"

namespace Dissent {

class MessageTableModel;
class Node;

class MainWindow : public QMainWindow, public Ui::MainWindow {
  Q_OBJECT

 public:
  MainWindow(int node_id, Node *node, int interval, QWidget *parent = 0);
  void Start();

 signals:
  void finish();
  void feedData(const QByteArray &message);

 public slots:
  void ShuffledData(const QList<QByteArray> &messages);
  void FeedData();

 private slots:
  void on_inputLineEdit_textChanged();
  void on_inputLineEdit_returnPressed();
  void on_sendButton_clicked();
  void on_clearButton_clicked();
  void SubmitMessage(const QString &message);
  void PrintLine(const QString &message);

 private:
  int node_id_;
  Node *node_;
  int round_interval_;
  int round_;
  MessageTableModel *queued_message_model_;

  QMutex output_lock_;
};

}

#endif

