/*
 * \copyright Copyright (c) 2015-2022 Governikus GmbH & Co. KG, Germany
 */
import QtQml 2.2
import QtQuick 2.15
import QtQuick.Controls 2.15
import Governikus.Global 1.0
import Governikus.Style 1.0
import Governikus.Type.ApplicationModel 1.0

BusyIndicator {
	id: root

	property real factor: 1.1

	contentItem: Item {
		id: busyContent
		Behavior on rotation  {
			NumberAnimation {
				duration: timer.interval
				easing.type: Easing.Linear
			}
		}

		Rectangle {
			id: rect
			anchors.centerIn: parent
			color: Style.color.background
			height: parent.height * root.factor
			radius: width / 2
			width: height
		}
		Timer {
			id: timer
			interval: 1000
			repeat: true
			running: root.running
			triggeredOnStart: true

			onTriggered: {
				green.rotation += ApplicationModel.randomInt(0, 134);
				blue.rotation += ApplicationModel.randomInt(0, 194);
				busyContent.rotation += 100;
			}
		}
		GConicalGradient {
			id: green
			anchors.fill: rect
			source: rect

			gradient: Gradient {
				GradientStop {
					color: rect.color
					position: 0.0
				}
				GradientStop {
					color: Constants.green
					position: 0.50
				}
				GradientStop {
					color: Style.color.transparent
					position: 0.5000000000000001
				}
				GradientStop {
					color: Style.color.transparent
					position: 1.0
				}
			}
			Behavior on rotation  {
				NumberAnimation {
					duration: timer.interval
					easing.type: Easing.InOutQuad
				}
			}
		}
		GConicalGradient {
			id: blue
			anchors.fill: rect
			source: rect

			gradient: Gradient {
				GradientStop {
					color: Style.color.transparent
					position: 0.0
				}
				GradientStop {
					color: Style.color.transparent
					position: 0.50
				}
				GradientStop {
					color: rect.color
					position: 0.5000000000000001
				}
				GradientStop {
					color: Constants.blue
					position: 1.0
				}
			}
			Behavior on rotation  {
				NumberAnimation {
					duration: timer.interval
					easing.type: Easing.InOutQuad
				}
			}
		}
	}
}
