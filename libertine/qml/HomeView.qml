/**
 * @file HomeView.qml
 * @brief Libertine container apps view
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
import QtQuick 2.4
import Ubuntu.Components 1.2
import Ubuntu.Components.ListItems 1.0 as ListItem
import Ubuntu.Components.Popups 1.0


Page {
    id: homeView
    title: i18n.tr("Classic Apps")

    head.actions: [
        Action {
	    iconName: "add"
	    onTriggered: mainView.state = "ADD_APPS"
	},
        Action {
	    id: settingsButton
	    iconName: "settings"
	    onTriggered: PopupUtils.open(settingsMenu, homeView)
	}
    ]

    Component {
	id: settingsMenu
	ActionSelectionPopover {
	    actions: ActionList {
		Action {
		    text: "App Sources"
		    onTriggered: print(text)
		}
		Action {
		    text: "Switch Container"
		    onTriggered: mainView.state = "CONTAINERS_VIEW"
		}
	    }
	}
    }

    ContainerApps {
        id: containerApps
    }

    ListView {
        model: containerApps.appsForContainer
        delegate: Text {
            text: mainView.currentContainerId
        }
    }
}
