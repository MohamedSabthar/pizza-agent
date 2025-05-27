import ballerinax/ai;
import ballerinax/googleapis.gmail;

import admin/pizza_managment_agent.mg;

final ai:OpenAiProvider _orderManagmentAgentModel = check new (openAiApiKey, "gpt-4o", openAiGatewayUrl, secureSocket = {enable: false});
final ai:Agent _orderManagmentAgentAgent = check new (
    systemPrompt = {role: "Order Management Assistant", instructions: string `You are a pizza order management assistant, designed to guide Customer Service Representative through each step of the order management process, asking relevant questions to ensure orders are handled accurately and efficiently. Always show the order id when possible. Always send an email when an order is placed, ask the customer email when needed.`}, model = _orderManagmentAgentModel, tools = [getPizzas, createOrder, getOrder, updateOrder, sendEmailTool], verbose = true
);

# Retrieves all available pizzas.
# + return - Array of pizza responses or an error if retrieval fails
@ai:AgentTool
@display {label: "", iconPath: "https://bcentral-packageicons.azureedge.net/images/admin_pizza_managment_agent.mg_0.1.0.png"}
isolated function getPizzas() returns mg:PizzaResponse[]|error {
    mg:PizzaResponse[] mgPizzaresponse = check mgClient->/pizzas.get();
    return mgPizzaresponse;
}

# Creates a new order.
# + payload - The order request containing order details
# + return - Order response containing the created order details or an error if creation fails
@ai:AgentTool
@display {label: "", iconPath: "https://bcentral-packageicons.azureedge.net/images/admin_pizza_managment_agent.mg_0.1.0.png"}
isolated function createOrder(mg:OrderRequest payload) returns mg:OrderResponse|error {
    mg:OrderResponse mgOrder = check mgClient->/orders.post(payload);
    return mgOrder;
}

# Retrieves a specific order by ID.
# + orderId - The unique identifier of the order
# + return - Order response containing the order details or an error if retrieval fails
@ai:AgentTool
@display {label: "", iconPath: "https://bcentral-packageicons.azureedge.net/images/admin_pizza_managment_agent.mg_0.1.0.png"}
isolated function getOrder(string orderId) returns mg:OrderResponse|error {
    mg:OrderResponse mgOrder = check mgClient->/orders/[orderId].get();
    return mgOrder;
}

# Updates the status of an order.
# + orderId - The unique identifier of the order to update
# + payload - The order update containing the new status
# + return - Updated order response or an error if update fails
@ai:AgentTool
@display {label: "", iconPath: "https://bcentral-packageicons.azureedge.net/images/admin_pizza_managment_agent.mg_0.1.0.png"}
isolated function updateOrder(string orderId, mg:OrderUpdate payload) returns mg:OrderResponse|error {
    mg:OrderResponse mgOrder = check mgClient->/orders/[orderId].patch(payload);
    return mgOrder;
}

# Send an email to a specific email address.
# + toEmail - Email address of the recipient
# + subject - Subject of the email
# + body - Content of the email
# + return - Gmail message response or an error if sending fails
@ai:AgentTool
@display {label: "", iconPath: ""}
isolated function sendEmailTool(string toEmail, string subject, string body) returns error|gmail:Message {
    return sendEmail(toEmail, subject, body);
}