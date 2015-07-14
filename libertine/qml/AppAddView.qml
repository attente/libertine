/**
 * @file AppAddView.qml
 * @brief Libertine app add view
 */
/*
 * Copyright 2015 Canonical Ltd
 *
 * Libertine is free software: you can redistribute it and/or modify it under
 * the terms of the GNU General Public License, version 3, as published by the
 * Free Software Foundation.
 *
 * Libertine is distributed in the hope that it will be useful, but WITHOUT ANY
 * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
 * A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */
import Libertine 1.0
import QtQuick 2.4
import QtQuick.Layouts 1.0
import Ubuntu.Components 1.2


Page {
    id: appAddView
    title: i18n.tr("Install Apps")

    Label {
        id: enterPackageMessage

        visible: false

        Layout.fillWidth: true
        wrapMode: Text.Wrap
        horizontalAlignment: Text.AlignHCenter

        text: "Please enter the exact package name of the app to install:"
    }

    TextField {
        id: appName

        visible: false

        anchors {
            top: enterPackageMessage.bottom
            horizontalCenter: parent.horizontalCenter
            margins: units.gu(1)
        }
        height: units.gu(4.5)
        width: parent.width - anchors.margins * 2

        onAccepted: {
            if (containerAppsList.addNewApp(mainView.currentContainer, text)) {
                installPackage()
                appName.text = ""
                pageStack.pop()
            }
            else {
                appAlreadyInstalledMessage.text = i18n.tr("Package ") + text + i18n.tr(" already installed. Please try a different package name.")
                appAlreadyInstalledMessage.visible = true
                appName.text = ""
            }  
        }
    }

    Label {
        id: appAlreadyInstalledMessage

        visible: false

        anchors {
            top: appName.bottom
            margins: units.gu(3)
        }
        height: units.gu(4.5)
     }

    head.actions: [
        Action {
	    iconName: "search"
	    onTriggered: {
              if (enterPackageMessage.visible) {
                  enterPackageMessage.visible = false;
                  appName.visible = false;
                  appName.text = ""
              }
              print("search")
            }
	},
        Action {
           iconName: "settings"
           onTriggered: {
               enterPackageMessage.visible = true
               appName.visible = true
               appName.forceActiveFocus()
           }
        }
    ]

    function installPackage() {
        var comp = Qt.createComponent("ContainerManager.qml")
        var worker = comp.createObject()
        worker.containerAction = ContainerManagerWorker.Install
        worker.containerId = mainView.currentContainer
        worker.data = appName.text
        worker.start()
    }
}
