/*
 * \copyright Copyright (c) 2020-2022 Governikus GmbH & Co. KG, Germany
 */
import QtQuick 2.15
import QtTest 1.15
import Governikus.Global 1.0

TestCase {
	id: testCase
	function createTestObject() {
		return createTemporaryQmlObject("import Governikus.Global 1.0; PaneTitle {}", testCase);
	}
	function test_load() {
		let testObject = createTestObject();
		verify(testObject, "Object loaded");
	}
	function test_visible() {
		let testObject = createTestObject();
		compare(testObject.text, "", "Initial text empty");
		verify(!testObject.visible, "Initial visible: false");
		testObject.text = "test";
		verify(testObject.visible, "visible: true");
		testObject.text = "";
		verify(!testObject.visible, "visible: false");
	}

	name: "test_PaneTitle"
	visible: true
	when: windowShown
}
