/*
 * \copyright Copyright (c) 2016-2022 Governikus GmbH & Co. KG, Germany
 */
import QtQuick 2.15
import QtQuick.Layouts 1.15
import Governikus.Global 1.0
import Governikus.Style 1.0
import Governikus.Type.ChangePinModel 1.0
import Governikus.Type.NumberModel 1.0
import Governikus.Type.ApplicationModel 1.0

GFlickableColumnLayout {
	id: root

	readonly property var maxIconHeight: Style.dimens.header_icon_size
	readonly property var minIconHeight: Style.dimens.medium_icon_size

	signal moreInformationRequested
	signal noPinAvailable

	minimumContentHeight: implicitContentHeight - (maxIconHeight - minIconHeight)
	spacing: 0

	TintableIcon {
		id: pinIcon
		Layout.alignment: Qt.AlignHCenter
		Layout.fillHeight: true
		Layout.maximumHeight: root.maxIconHeight
		Layout.minimumHeight: root.minIconHeight
		Layout.preferredHeight: root.maxIconHeight
		source: "qrc:///images/material_lock.svg"
		sourceSize.height: root.maxIconHeight
		tintColor: Style.color.accent
	}
	GText {
		id: pinDescWhatType
		Layout.alignment: Qt.AlignCenter
		Layout.fillWidth: true
		Layout.maximumWidth: Style.dimens.max_text_width
		Layout.topMargin: Constants.component_spacing
		horizontalAlignment: Text.AlignHCenter

		//: LABEL ANDROID IOS
		text: qsTr("What kind of PIN do you have?")
		textStyle: Style.text.header_accent
		wrapMode: Text.WordWrap
	}
	GText {
		id: pinDesc
		Layout.alignment: Qt.AlignCenter
		Layout.fillWidth: true
		Layout.maximumWidth: Style.dimens.max_text_width
		Layout.topMargin: Constants.text_spacing
		horizontalAlignment: Text.AlignHCenter

		//: LABEL ANDROID IOS
		text: qsTr("Please make a choice to set or change your PIN.")
		textStyle: Style.text.normal_secondary
		wrapMode: Text.WordWrap
	}
	MoreInformationLink {
		Layout.alignment: Qt.AlignCenter
		Layout.fillWidth: true
		Layout.maximumWidth: Style.dimens.max_text_width
		Layout.topMargin: Constants.component_spacing
		horizontalAlignment: Text.AlignHCenter

		onClicked: root.moreInformationRequested()
	}
	GSpacer {
		Layout.fillHeight: true
	}
	DynamicLayout {
		id: buttonLayout

		readonly property double buttonWidth: Math.max(sixDigitButton.implicitWidth, fiveDigitButton.implicitWidth, dontKnowButton.implicitWidth)

		Layout.alignment: Qt.AlignCenter
		Layout.topMargin: Constants.component_spacing
		spacing: Constants.component_spacing

		GButton {
			id: sixDigitButton
			Layout.minimumWidth: buttonLayout.buttonWidth
			icon.source: "qrc:///images/mobile/material_six.svg"

			//: LABEL ANDROID_TABLET IOS_TABLET
			text: qsTr("Six-digit PIN")

			onClicked: ChangePinModel.startWorkflow(false)
		}
		GButton {
			id: fiveDigitButton
			Layout.minimumWidth: buttonLayout.buttonWidth
			icon.source: "qrc:///images/mobile/material_five.svg"

			//: LABEL ANDROID_TABLET IOS_TABLET
			text: qsTr("Five-digit Transport PIN")

			onClicked: ChangePinModel.startWorkflow(true)
		}
		GButton {
			id: dontKnowButton
			Layout.minimumWidth: buttonLayout.buttonWidth
			icon.source: "qrc:///images/material_help.svg"

			//: LABEL ANDROID_TABLET IOS_TABLET
			text: qsTr("PIN unknown")

			onClicked: root.noPinAvailable()
		}
	}
}
