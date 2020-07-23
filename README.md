# README

This demo application showcases the use of the `kuyio/omniauth-microsoft-graph` gem.

To start the application you will need:

- Ruby 2.7.1+
- Bundler 2.1+
- a Postgresql database
- an Azure AD account

First, you will need to create an Azure AD App Registration for this demo and configure the callback URL.

1. Open a browser and navigate to the Azure Active Directory admin center. Login using a personal account (aka: Microsoft Account) or Work or School Account.

2. Select Azure Active Directory in the left-hand navigation, then select App registrations under Manage.

3. Select New registration. On the Register an application page, set the values as follows.

   - Set Name to your application name.
   - Set Supported account types to Accounts in any organizational directory and personal Microsoft accounts.
   - Under Redirect URI, set the first drop-down to Web and set the value to http://localhost:5000/users/auth/microsoft_graph/callback.

4. Select Register. On the Application info page, copy the value of the Application (client) ID and save it, you will need it in the next step.

5. Select Certificates & secrets under Manage. Select the New client secret button. Enter a value in Description and select one of the options for Expires and select Add.

6. Copy the client secret value before you leave this page. You will need it in the next step. **Important:** This client secret is never shown again, so make sure you copy it now.

Next, we need to set the application configuration via environment variables, this can be done in a `.env` files which is automatically loaded by `foreman`:

| Variable           | Description                                                                                                                                      |
| ------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------ |
| `AZURE_APP_ID`     | The Application Client ID obtained from the above process                                                                                        |
| `AZURE_APP_SECRET` | The Application Secret obtained from the above process                                                                                           |
| `AZURE_TENANT`     | Your Azure AD Tenant ID, if not set, will use `common` - but then your Application will need to be set as a multi-tenant application in Azure AD |
| `AZURE_SCOPES`     | The requested Graph API scopes, e.g., openid profile email offline_access user.read                                                              |
| `DB_USERNAME`      | Your database username, default: `postgres`                                                                                                      |
| `DB_PASSWORD`      | Your database password, default: `postgres`                                                                                                      |
| `DB_HOST`          | Your database host, default: `localhost`                                                                                                         |
| `DB_PORT`          | Your database port, default: `5432`                                                                                                              |

After that, we need to install the application dependencies:

```sh
bundle install
yarn install --check-files
```

Then, we need to configure and migrate the database:

```sh
rails db:create
rails db:migrate
```

Finally, we can start the application:

```sh
foreman start -f Procfile.dev
```

Navigate to http://localhost:5000, click on `Sign in with Microsoft`, enter your credentials and consent to the requested scope.