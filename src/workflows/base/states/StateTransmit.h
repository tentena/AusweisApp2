/*!
 * \brief Process received transmits. Send it to the card and create a response.
 *
 * \copyright Copyright (c) 2014-2022 Governikus GmbH & Co. KG, Germany
 */

#pragma once

#include "AbstractState.h"
#include "GenericContextContainer.h"
#include "command/TransmitCommand.h"
#include "context/AuthContext.h"

class test_StateTransmit;

namespace governikus
{

class StateTransmit
	: public AbstractState
	, public GenericContextContainer<AuthContext>
{
	Q_OBJECT
	friend class StateBuilder;
	friend class ::test_StateTransmit;

	private:
		explicit StateTransmit(const QSharedPointer<WorkflowContext>& pContext);
		void run() override;

	private Q_SLOTS:
		void onCardCommandDone(QSharedPointer<BaseCardCommand> pCommand);

	public:
		void onEntry(QEvent* pEvent) override;
};

} // namespace governikus
