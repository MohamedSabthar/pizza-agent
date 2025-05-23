import ballerina/http;
import ballerinax/ai;

listener ai:Listener orderManagmentAgentListener = new (listenOn = check http:getDefaultListener());

service /orderManagmentAgent on orderManagmentAgentListener {
    resource function post chat(@http:Payload ai:ChatReqMessage request) returns ai:ChatRespMessage|error {

        string stringResult = check _orderManagmentAgentAgent->run(request.message, request.sessionId);
        return {message: stringResult};
    }
}
