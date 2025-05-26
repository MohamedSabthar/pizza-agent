import ballerinax/ai;

import admin/pizza_managment_agent.mg;

final ai:OpenAiProvider _orderManagmentAgentModel = check new (openAiApiKey, "gpt-4o", "https://4.194.24.252:8243/openai/1.0.0", secureSocket = {cert: "./resources/gw-cert.crt", verifyHostName: false});
final ai:Agent _orderManagmentAgentAgent = check new (
    systemPrompt = {role: "Order Management Assistant", instructions: string `You are a pizza order management assistant, designed to guide cashiers through each step of the order management process, asking relevant questions to ensure orders are handled accurately and efficiently. Always show the order id when possible.`}, model = _orderManagmentAgentModel, tools = [getPizzas, createOrder, getOrder, updateOrder], verbose = true
);

# Retrieves all available pizzas.

@ai:AgentTool
@display {label: "", iconPath: "https://bcentral-packageicons.azureedge.net/images/admin_pizza_managment_agent.mg_0.1.0.png"}
isolated function getPizzas() returns mg:PizzaResponse[]|error {
    mg:PizzaResponse[] mgPizzaresponse = check mgClient->/pizzas.get();
    return mgPizzaresponse;
}

# Creates a new order.
@ai:AgentTool
@display {label: "", iconPath: "https://bcentral-packageicons.azureedge.net/images/admin_pizza_managment_agent.mg_0.1.0.png"}
isolated function createOrder(mg:OrderRequest payload) returns mg:OrderResponse|error {
    mg:OrderResponse mgOrder = check mgClient->/orders.post(payload);
    return mgOrder;
}

# Retrieves a specific order by ID
@ai:AgentTool
@display {label: "", iconPath: "https://bcentral-packageicons.azureedge.net/images/admin_pizza_managment_agent.mg_0.1.0.png"}
isolated function getOrder(string orderId) returns mg:OrderResponse|error {
    mg:OrderResponse mgOrder = check mgClient->/orders/[orderId].get();
    return mgOrder;
}

# Updates the status of an order
@ai:AgentTool
@display {label: "", iconPath: "https://bcentral-packageicons.azureedge.net/images/admin_pizza_managment_agent.mg_0.1.0.png"}
isolated function updateOrder(string orderId, mg:OrderUpdate payload) returns mg:OrderResponse|error {
    mg:OrderResponse mgOrder = check mgClient->/orders/[orderId].patch(payload);
    return mgOrder;
}
