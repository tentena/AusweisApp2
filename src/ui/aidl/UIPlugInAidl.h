/*!
 * \brief UIPlugIn implementation of the AIDL UI.
 *
 * \copyright Copyright (c) 2016-2022 Governikus GmbH & Co. KG, Germany
 */

#pragma once

#include "UIPlugIn.h"
#include "UIPlugInJson.h"

#include <QAtomicPointer>
#include <QMutex>

namespace governikus
{

class UIPlugInAidl
	: public UIPlugIn
{
	Q_OBJECT
	Q_PLUGIN_METADATA(IID "governikus.UIPlugIn" FILE "metadata.json")
	Q_INTERFACES(governikus::UIPlugIn)

	private:
		QPointer<UIPlugInJson> mJson;
		QSharedPointer<WorkflowContext> mContext;
		QMutex mWorkflowIsActive;

		static QAtomicPointer<UIPlugInAidl> instance;

	public:
		UIPlugInAidl();
		~UIPlugInAidl() override = default;

		static UIPlugInAidl* getInstance(bool pBlock = true);
		[[nodiscard]] bool initialize() override;
		[[nodiscard]] bool isSuccessfullInitialized() const;
		Q_INVOKABLE void onReceived(const QByteArray& pMessage);
		bool waitForWorkflowToFinish();

	public Q_SLOTS:
		void reset();
		void startReaderManagerScans() const;

	private Q_SLOTS:
		void doShutdown() override;
		void onWorkflowStarted(QSharedPointer<WorkflowContext> pContext) override;
		void onWorkflowFinished(QSharedPointer<WorkflowContext> pContext) override;

		void onToSend(const QByteArray& pMessage);
};

} // namespace governikus
