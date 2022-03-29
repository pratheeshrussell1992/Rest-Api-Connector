// This file contains your Data Connector logic
section REST_API_CONNECTOR;

[DataSource.Kind="REST_API_CONNECTOR", Publish="REST_API_CONNECTOR.Publish"]
shared REST_API_CONNECTOR.Contents = (url as text) =>
    let
        currentCredentials = Extension.CurrentCredential(),
        authenticationKind = currentCredentials[AuthenticationKind],
        access_token = currentCredentials[Key],

        headers = if authenticationKind = "Key" then
                    [#"Authorization" = "Bearer " & access_token, #"Content-Type" = "application/json"]
                else
                    [#"Content-Type" = "application/json"],
        
        Survey = Web.Contents(url, [ Headers = headers, ManualCredentials = true] ),
        Source = Json.Document(Survey)
    in
        Source;


// Data Source Kind description
REST_API_CONNECTOR = [
    Authentication = [
        // Key = [],
        // UsernamePassword = [],
        // Windows = [],
        Implicit = [],
        Key = [
            KeyLabel = "Auth Key",
            Label = "Bearer Token"
        ]
    ],
    Label = Extension.LoadString("DataSourceLabel")
];

// Data Source UI publishing description
REST_API_CONNECTOR.Publish = [
    Beta = false,
    Category = "Other",
    ButtonText = { Extension.LoadString("ButtonTitle"), Extension.LoadString("ButtonHelp") },
    LearnMoreUrl = "https://powerbi.microsoft.com/",
    SourceImage = REST_API_CONNECTOR.Icons,
    SourceTypeImage = REST_API_CONNECTOR.Icons
];

REST_API_CONNECTOR.Icons = [
    Icon16 = { Extension.Contents("REST_API_CONNECTOR16.png"), Extension.Contents("REST_API_CONNECTOR20.png"), Extension.Contents("REST_API_CONNECTOR24.png"), Extension.Contents("REST_API_CONNECTOR32.png") },
    Icon32 = { Extension.Contents("REST_API_CONNECTOR32.png"), Extension.Contents("REST_API_CONNECTOR40.png"), Extension.Contents("REST_API_CONNECTOR48.png"), Extension.Contents("REST_API_CONNECTOR64.png") }
];
