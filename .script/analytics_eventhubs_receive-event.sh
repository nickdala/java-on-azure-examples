#!/bin/bash
cd ..


if [[ -z $RESOURCE_GROUP ]]; then
export RESOURCE_GROUP=java-on-azure-$RANDOM
export REGION=westus2
fi

az group create --name $RESOURCE_GROUP --location $REGION

if [[ -z $RESOURCE_GROUP ]]; then
export RESOURCE_GROUP=java-on-azure-$RANDOM
export REGION=westus2
fi

az group create --name $RESOURCE_GROUP --location $REGION
export EVENTHUBS_NAMESPACE=eventhubs-$RANDOM

az eventhubs namespace create \
--name $EVENTHUBS_NAMESPACE \
--resource-group $RESOURCE_GROUP \
--location $REGION

if [[ -z $RESOURCE_GROUP ]]; then
export RESOURCE_GROUP=java-on-azure-$RANDOM
export REGION=westus2
fi

az group create --name $RESOURCE_GROUP --location $REGION

if [[ -z $RESOURCE_GROUP ]]; then
export RESOURCE_GROUP=java-on-azure-$RANDOM
export REGION=westus2
fi

az group create --name $RESOURCE_GROUP --location $REGION
export EVENTHUBS_NAMESPACE=eventhubs-$RANDOM

az eventhubs namespace create \
--name $EVENTHUBS_NAMESPACE \
--resource-group $RESOURCE_GROUP \
--location $REGION
export EVENTHUBS_EVENTHUB=eventhubs-hub-$RANDOM

az eventhubs eventhub create \
--name $EVENTHUBS_EVENTHUB \
--resource-group $RESOURCE_GROUP \
--namespace-name $EVENTHUBS_NAMESPACE

if [[ -z $RESOURCE_GROUP ]]; then
export RESOURCE_GROUP=java-on-azure-$RANDOM
export REGION=westus2
fi

az group create --name $RESOURCE_GROUP --location $REGION

if [[ -z $RESOURCE_GROUP ]]; then
export RESOURCE_GROUP=java-on-azure-$RANDOM
export REGION=westus2
fi

az group create --name $RESOURCE_GROUP --location $REGION
export EVENTHUBS_NAMESPACE=eventhubs-$RANDOM

az eventhubs namespace create \
--name $EVENTHUBS_NAMESPACE \
--resource-group $RESOURCE_GROUP \
--location $REGION

if [[ -z $RESOURCE_GROUP ]]; then
export RESOURCE_GROUP=java-on-azure-$RANDOM
export REGION=westus2
fi

az group create --name $RESOURCE_GROUP --location $REGION

if [[ -z $RESOURCE_GROUP ]]; then
export RESOURCE_GROUP=java-on-azure-$RANDOM
export REGION=westus2
fi

az group create --name $RESOURCE_GROUP --location $REGION
export EVENTHUBS_NAMESPACE=eventhubs-$RANDOM

az eventhubs namespace create \
--name $EVENTHUBS_NAMESPACE \
--resource-group $RESOURCE_GROUP \
--location $REGION
export EVENTHUBS_EVENTHUB=eventhubs-hub-$RANDOM

az eventhubs eventhub create \
--name $EVENTHUBS_EVENTHUB \
--resource-group $RESOURCE_GROUP \
--namespace-name $EVENTHUBS_NAMESPACE
export EVENTHUBS_EVENTHUB_CONNECTION_STRING=$(az eventhubs namespace authorization-rule keys list \
--resource-group $RESOURCE_GROUP \
--namespace-name $EVENTHUBS_NAMESPACE \
--name RootManageSharedAccessKey \
--query primaryConnectionString \
--output tsv)

cd analytics/eventhubs/send-event

mvn clean install

export RESULT=$(java -jar target/send-event.jar)
cd ../../..


cd analytics/eventhubs/receive-event

mvn clean install

export RESULT=$(java -jar target/receive-event.jar)
cd ../../..


az group delete --name $RESOURCE_GROUP --yes || true
if [[ "$RESULT" != 'Received: this is an event' ]]; then
echo "Error when receiving event to EventHub"
exit 1
fi