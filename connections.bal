import pizza_managment_agent.mg;

final mg:Client mgClient = check new ({
    auth: {
        token: serviceToken
    }
});
