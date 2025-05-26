import pizza_managment_agent.mg;
import ballerinax/googleapis.gmail;

final mg:Client mgClient = check new ({
    auth: {
        token: serviceToken
    }
});

final gmail:Client gmailClient = check new ({
    auth: {
        refreshToken: gmailRefreshToken,
        clientId: gmailClientId,
        clientSecret: gmailClientSecret
    }
});