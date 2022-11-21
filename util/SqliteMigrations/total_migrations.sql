CREATE TABLE IF NOT EXISTS "__EFMigrationsHistory" (
    "MigrationId" TEXT NOT NULL CONSTRAINT "PK___EFMigrationsHistory" PRIMARY KEY,
    "ProductVersion" TEXT NOT NULL
);

BEGIN TRANSACTION;

CREATE TABLE "Event" (
    "Id" TEXT NOT NULL CONSTRAINT "PK_Event" PRIMARY KEY,
    "Date" TEXT NOT NULL,
    "Type" INTEGER NOT NULL,
    "UserId" TEXT NULL,
    "OrganizationId" TEXT NULL,
    "InstallationId" TEXT NULL,
    "ProviderId" TEXT NULL,
    "CipherId" TEXT NULL,
    "CollectionId" TEXT NULL,
    "PolicyId" TEXT NULL,
    "GroupId" TEXT NULL,
    "OrganizationUserId" TEXT NULL,
    "ProviderUserId" TEXT NULL,
    "ProviderOrganizationId" TEXT NULL,
    "DeviceType" INTEGER NULL,
    "IpAddress" TEXT NULL,
    "ActingUserId" TEXT NULL,
    "SystemUser" INTEGER NULL
);

CREATE TABLE "Grant" (
    "Key" TEXT NOT NULL CONSTRAINT "PK_Grant" PRIMARY KEY,
    "Type" TEXT NULL,
    "SubjectId" TEXT NULL,
    "SessionId" TEXT NULL,
    "ClientId" TEXT NULL,
    "Description" TEXT NULL,
    "CreationDate" TEXT NOT NULL,
    "ExpirationDate" TEXT NULL,
    "ConsumedDate" TEXT NULL,
    "Data" TEXT NULL
);

CREATE TABLE "Installation" (
    "Id" TEXT NOT NULL CONSTRAINT "PK_Installation" PRIMARY KEY,
    "Email" TEXT NULL,
    "Key" TEXT NULL,
    "Enabled" INTEGER NOT NULL,
    "CreationDate" TEXT NOT NULL
);

CREATE TABLE "Organization" (
    "Id" TEXT NOT NULL CONSTRAINT "PK_Organization" PRIMARY KEY,
    "Identifier" TEXT NULL,
    "Name" TEXT NULL,
    "BusinessName" TEXT NULL,
    "BusinessAddress1" TEXT NULL,
    "BusinessAddress2" TEXT NULL,
    "BusinessAddress3" TEXT NULL,
    "BusinessCountry" TEXT NULL,
    "BusinessTaxNumber" TEXT NULL,
    "BillingEmail" TEXT NULL,
    "Plan" TEXT NULL,
    "PlanType" INTEGER NOT NULL,
    "Seats" INTEGER NULL,
    "MaxCollections" INTEGER NULL,
    "UsePolicies" INTEGER NOT NULL,
    "UseSso" INTEGER NOT NULL,
    "UseKeyConnector" INTEGER NOT NULL,
    "UseScim" INTEGER NOT NULL,
    "UseGroups" INTEGER NOT NULL,
    "UseDirectory" INTEGER NOT NULL,
    "UseEvents" INTEGER NOT NULL,
    "UseTotp" INTEGER NOT NULL,
    "Use2fa" INTEGER NOT NULL,
    "UseApi" INTEGER NOT NULL,
    "UseResetPassword" INTEGER NOT NULL,
    "SelfHost" INTEGER NOT NULL,
    "UsersGetPremium" INTEGER NOT NULL,
    "Storage" INTEGER NULL,
    "MaxStorageGb" INTEGER NULL,
    "Gateway" INTEGER NULL,
    "GatewayCustomerId" TEXT NULL,
    "GatewaySubscriptionId" TEXT NULL,
    "ReferenceData" TEXT NULL,
    "Enabled" INTEGER NOT NULL,
    "LicenseKey" TEXT NULL,
    "PublicKey" TEXT NULL,
    "PrivateKey" TEXT NULL,
    "TwoFactorProviders" TEXT NULL,
    "ExpirationDate" TEXT NULL,
    "CreationDate" TEXT NOT NULL,
    "RevisionDate" TEXT NOT NULL,
    "MaxAutoscaleSeats" INTEGER NULL,
    "OwnersNotifiedOfAutoscaling" TEXT NULL
);

CREATE TABLE "Provider" (
    "Id" TEXT NOT NULL CONSTRAINT "PK_Provider" PRIMARY KEY,
    "Name" TEXT NULL,
    "BusinessName" TEXT NULL,
    "BusinessAddress1" TEXT NULL,
    "BusinessAddress2" TEXT NULL,
    "BusinessAddress3" TEXT NULL,
    "BusinessCountry" TEXT NULL,
    "BusinessTaxNumber" TEXT NULL,
    "BillingEmail" TEXT NULL,
    "Status" INTEGER NOT NULL,
    "UseEvents" INTEGER NOT NULL,
    "Enabled" INTEGER NOT NULL,
    "CreationDate" TEXT NOT NULL,
    "RevisionDate" TEXT NOT NULL
);

CREATE TABLE "TaxRate" (
    "Id" TEXT NOT NULL CONSTRAINT "PK_TaxRate" PRIMARY KEY,
    "Country" TEXT NULL,
    "State" TEXT NULL,
    "PostalCode" TEXT NULL,
    "Rate" TEXT NOT NULL,
    "Active" INTEGER NOT NULL
);

CREATE TABLE "User" (
    "Id" TEXT NOT NULL CONSTRAINT "PK_User" PRIMARY KEY,
    "Name" TEXT NULL,
    "Email" TEXT NOT NULL,
    "EmailVerified" INTEGER NOT NULL,
    "MasterPassword" TEXT NULL,
    "MasterPasswordHint" TEXT NULL,
    "Culture" TEXT NULL,
    "SecurityStamp" TEXT NOT NULL,
    "TwoFactorProviders" TEXT NULL,
    "TwoFactorRecoveryCode" TEXT NULL,
    "EquivalentDomains" TEXT NULL,
    "ExcludedGlobalEquivalentDomains" TEXT NULL,
    "AccountRevisionDate" TEXT NOT NULL,
    "Key" TEXT NULL,
    "PublicKey" TEXT NULL,
    "PrivateKey" TEXT NULL,
    "Premium" INTEGER NOT NULL,
    "PremiumExpirationDate" TEXT NULL,
    "RenewalReminderDate" TEXT NULL,
    "Storage" INTEGER NULL,
    "MaxStorageGb" INTEGER NULL,
    "Gateway" INTEGER NULL,
    "GatewayCustomerId" TEXT NULL,
    "GatewaySubscriptionId" TEXT NULL,
    "ReferenceData" TEXT NULL,
    "LicenseKey" TEXT NULL,
    "ApiKey" TEXT NOT NULL,
    "Kdf" INTEGER NOT NULL,
    "KdfIterations" INTEGER NOT NULL,
    "CreationDate" TEXT NOT NULL,
    "RevisionDate" TEXT NOT NULL,
    "ForcePasswordReset" INTEGER NOT NULL,
    "UsesKeyConnector" INTEGER NOT NULL,
    "FailedLoginCount" INTEGER NOT NULL,
    "LastFailedLoginDate" TEXT NULL,
    "UnknownDeviceVerificationEnabled" INTEGER NOT NULL
);

CREATE TABLE "Collection" (
    "Id" TEXT NOT NULL CONSTRAINT "PK_Collection" PRIMARY KEY,
    "OrganizationId" TEXT NOT NULL,
    "Name" TEXT NULL,
    "ExternalId" TEXT NULL,
    "CreationDate" TEXT NOT NULL,
    "RevisionDate" TEXT NOT NULL,
    CONSTRAINT "FK_Collection_Organization_OrganizationId" FOREIGN KEY ("OrganizationId") REFERENCES "Organization" ("Id") ON DELETE CASCADE
);

CREATE TABLE "Group" (
    "Id" TEXT NOT NULL CONSTRAINT "PK_Group" PRIMARY KEY,
    "OrganizationId" TEXT NOT NULL,
    "Name" TEXT NULL,
    "AccessAll" INTEGER NOT NULL,
    "ExternalId" TEXT NULL,
    "CreationDate" TEXT NOT NULL,
    "RevisionDate" TEXT NOT NULL,
    CONSTRAINT "FK_Group_Organization_OrganizationId" FOREIGN KEY ("OrganizationId") REFERENCES "Organization" ("Id") ON DELETE CASCADE
);

CREATE TABLE "OrganizationApiKey" (
    "Id" TEXT NOT NULL CONSTRAINT "PK_OrganizationApiKey" PRIMARY KEY,
    "OrganizationId" TEXT NOT NULL,
    "Type" INTEGER NOT NULL,
    "ApiKey" TEXT NULL,
    "RevisionDate" TEXT NOT NULL,
    CONSTRAINT "FK_OrganizationApiKey_Organization_OrganizationId" FOREIGN KEY ("OrganizationId") REFERENCES "Organization" ("Id") ON DELETE CASCADE
);

CREATE TABLE "OrganizationConnection" (
    "Id" TEXT NOT NULL CONSTRAINT "PK_OrganizationConnection" PRIMARY KEY,
    "Type" INTEGER NOT NULL,
    "OrganizationId" TEXT NOT NULL,
    "Enabled" INTEGER NOT NULL,
    "Config" TEXT NULL,
    CONSTRAINT "FK_OrganizationConnection_Organization_OrganizationId" FOREIGN KEY ("OrganizationId") REFERENCES "Organization" ("Id") ON DELETE CASCADE
);

CREATE TABLE "OrganizationSponsorship" (
    "Id" TEXT NOT NULL CONSTRAINT "PK_OrganizationSponsorship" PRIMARY KEY,
    "SponsoringOrganizationId" TEXT NULL,
    "SponsoringOrganizationUserId" TEXT NOT NULL,
    "SponsoredOrganizationId" TEXT NULL,
    "FriendlyName" TEXT NULL,
    "OfferedToEmail" TEXT NULL,
    "PlanSponsorshipType" INTEGER NULL,
    "LastSyncDate" TEXT NULL,
    "ValidUntil" TEXT NULL,
    "ToDelete" INTEGER NOT NULL,
    CONSTRAINT "FK_OrganizationSponsorship_Organization_SponsoredOrganizationId" FOREIGN KEY ("SponsoredOrganizationId") REFERENCES "Organization" ("Id"),
    CONSTRAINT "FK_OrganizationSponsorship_Organization_SponsoringOrganizationId" FOREIGN KEY ("SponsoringOrganizationId") REFERENCES "Organization" ("Id")
);

CREATE TABLE "Policy" (
    "Id" TEXT NOT NULL CONSTRAINT "PK_Policy" PRIMARY KEY,
    "OrganizationId" TEXT NOT NULL,
    "Type" INTEGER NOT NULL,
    "Data" TEXT NULL,
    "Enabled" INTEGER NOT NULL,
    "CreationDate" TEXT NOT NULL,
    "RevisionDate" TEXT NOT NULL,
    CONSTRAINT "FK_Policy_Organization_OrganizationId" FOREIGN KEY ("OrganizationId") REFERENCES "Organization" ("Id") ON DELETE CASCADE
);

CREATE TABLE "SsoConfig" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_SsoConfig" PRIMARY KEY AUTOINCREMENT,
    "Enabled" INTEGER NOT NULL,
    "OrganizationId" TEXT NOT NULL,
    "Data" TEXT NULL,
    "CreationDate" TEXT NOT NULL,
    "RevisionDate" TEXT NOT NULL,
    CONSTRAINT "FK_SsoConfig_Organization_OrganizationId" FOREIGN KEY ("OrganizationId") REFERENCES "Organization" ("Id") ON DELETE CASCADE
);

CREATE TABLE "ProviderOrganization" (
    "Id" TEXT NOT NULL CONSTRAINT "PK_ProviderOrganization" PRIMARY KEY,
    "ProviderId" TEXT NOT NULL,
    "OrganizationId" TEXT NOT NULL,
    "Key" TEXT NULL,
    "Settings" TEXT NULL,
    "CreationDate" TEXT NOT NULL,
    "RevisionDate" TEXT NOT NULL,
    CONSTRAINT "FK_ProviderOrganization_Organization_OrganizationId" FOREIGN KEY ("OrganizationId") REFERENCES "Organization" ("Id") ON DELETE CASCADE,
    CONSTRAINT "FK_ProviderOrganization_Provider_ProviderId" FOREIGN KEY ("ProviderId") REFERENCES "Provider" ("Id") ON DELETE CASCADE
);

CREATE TABLE "Cipher" (
    "Id" TEXT NOT NULL CONSTRAINT "PK_Cipher" PRIMARY KEY,
    "UserId" TEXT NULL,
    "OrganizationId" TEXT NULL,
    "Type" INTEGER NOT NULL,
    "Data" TEXT NULL,
    "Favorites" TEXT NULL,
    "Folders" TEXT NULL,
    "Attachments" TEXT NULL,
    "CreationDate" TEXT NOT NULL,
    "RevisionDate" TEXT NOT NULL,
    "DeletedDate" TEXT NULL,
    "Reprompt" INTEGER NULL,
    CONSTRAINT "FK_Cipher_Organization_OrganizationId" FOREIGN KEY ("OrganizationId") REFERENCES "Organization" ("Id"),
    CONSTRAINT "FK_Cipher_User_UserId" FOREIGN KEY ("UserId") REFERENCES "User" ("Id")
);

CREATE TABLE "Device" (
    "Id" TEXT NOT NULL CONSTRAINT "PK_Device" PRIMARY KEY,
    "UserId" TEXT NOT NULL,
    "Name" TEXT NULL,
    "Type" INTEGER NOT NULL,
    "Identifier" TEXT NULL,
    "PushToken" TEXT NULL,
    "CreationDate" TEXT NOT NULL,
    "RevisionDate" TEXT NOT NULL,
    CONSTRAINT "FK_Device_User_UserId" FOREIGN KEY ("UserId") REFERENCES "User" ("Id") ON DELETE CASCADE
);

CREATE TABLE "EmergencyAccess" (
    "Id" TEXT NOT NULL CONSTRAINT "PK_EmergencyAccess" PRIMARY KEY,
    "GrantorId" TEXT NOT NULL,
    "GranteeId" TEXT NULL,
    "Email" TEXT NULL,
    "KeyEncrypted" TEXT NULL,
    "Type" INTEGER NOT NULL,
    "Status" INTEGER NOT NULL,
    "WaitTimeDays" INTEGER NOT NULL,
    "RecoveryInitiatedDate" TEXT NULL,
    "LastNotificationDate" TEXT NULL,
    "CreationDate" TEXT NOT NULL,
    "RevisionDate" TEXT NOT NULL,
    CONSTRAINT "FK_EmergencyAccess_User_GranteeId" FOREIGN KEY ("GranteeId") REFERENCES "User" ("Id"),
    CONSTRAINT "FK_EmergencyAccess_User_GrantorId" FOREIGN KEY ("GrantorId") REFERENCES "User" ("Id") ON DELETE CASCADE
);

CREATE TABLE "Folder" (
    "Id" TEXT NOT NULL CONSTRAINT "PK_Folder" PRIMARY KEY,
    "UserId" TEXT NOT NULL,
    "Name" TEXT NULL,
    "CreationDate" TEXT NOT NULL,
    "RevisionDate" TEXT NOT NULL,
    CONSTRAINT "FK_Folder_User_UserId" FOREIGN KEY ("UserId") REFERENCES "User" ("Id") ON DELETE CASCADE
);

CREATE TABLE "OrganizationUser" (
    "Id" TEXT NOT NULL CONSTRAINT "PK_OrganizationUser" PRIMARY KEY,
    "OrganizationId" TEXT NOT NULL,
    "UserId" TEXT NULL,
    "Email" TEXT NULL,
    "Key" TEXT NULL,
    "ResetPasswordKey" TEXT NULL,
    "Status" INTEGER NOT NULL,
    "Type" INTEGER NOT NULL,
    "AccessAll" INTEGER NOT NULL,
    "ExternalId" TEXT NULL,
    "CreationDate" TEXT NOT NULL,
    "RevisionDate" TEXT NOT NULL,
    "Permissions" TEXT NULL,
    CONSTRAINT "FK_OrganizationUser_Organization_OrganizationId" FOREIGN KEY ("OrganizationId") REFERENCES "Organization" ("Id") ON DELETE CASCADE,
    CONSTRAINT "FK_OrganizationUser_User_UserId" FOREIGN KEY ("UserId") REFERENCES "User" ("Id")
);

CREATE TABLE "ProviderUser" (
    "Id" TEXT NOT NULL CONSTRAINT "PK_ProviderUser" PRIMARY KEY,
    "ProviderId" TEXT NOT NULL,
    "UserId" TEXT NULL,
    "Email" TEXT NULL,
    "Key" TEXT NULL,
    "Status" INTEGER NOT NULL,
    "Type" INTEGER NOT NULL,
    "Permissions" TEXT NULL,
    "CreationDate" TEXT NOT NULL,
    "RevisionDate" TEXT NOT NULL,
    CONSTRAINT "FK_ProviderUser_Provider_ProviderId" FOREIGN KEY ("ProviderId") REFERENCES "Provider" ("Id") ON DELETE CASCADE,
    CONSTRAINT "FK_ProviderUser_User_UserId" FOREIGN KEY ("UserId") REFERENCES "User" ("Id")
);

CREATE TABLE "Send" (
    "Id" TEXT NOT NULL CONSTRAINT "PK_Send" PRIMARY KEY,
    "UserId" TEXT NULL,
    "OrganizationId" TEXT NULL,
    "Type" INTEGER NOT NULL,
    "Data" TEXT NULL,
    "Key" TEXT NULL,
    "Password" TEXT NULL,
    "MaxAccessCount" INTEGER NULL,
    "AccessCount" INTEGER NOT NULL,
    "CreationDate" TEXT NOT NULL,
    "RevisionDate" TEXT NOT NULL,
    "ExpirationDate" TEXT NULL,
    "DeletionDate" TEXT NOT NULL,
    "Disabled" INTEGER NOT NULL,
    "HideEmail" INTEGER NULL,
    CONSTRAINT "FK_Send_Organization_OrganizationId" FOREIGN KEY ("OrganizationId") REFERENCES "Organization" ("Id"),
    CONSTRAINT "FK_Send_User_UserId" FOREIGN KEY ("UserId") REFERENCES "User" ("Id")
);

CREATE TABLE "SsoUser" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_SsoUser" PRIMARY KEY AUTOINCREMENT,
    "UserId" TEXT NOT NULL,
    "OrganizationId" TEXT NULL,
    "ExternalId" TEXT NULL,
    "CreationDate" TEXT NOT NULL,
    CONSTRAINT "FK_SsoUser_Organization_OrganizationId" FOREIGN KEY ("OrganizationId") REFERENCES "Organization" ("Id"),
    CONSTRAINT "FK_SsoUser_User_UserId" FOREIGN KEY ("UserId") REFERENCES "User" ("Id") ON DELETE CASCADE
);

CREATE TABLE "Transaction" (
    "Id" TEXT NOT NULL CONSTRAINT "PK_Transaction" PRIMARY KEY,
    "UserId" TEXT NULL,
    "OrganizationId" TEXT NULL,
    "Type" INTEGER NOT NULL,
    "Amount" TEXT NOT NULL,
    "Refunded" INTEGER NULL,
    "RefundedAmount" TEXT NULL,
    "Details" TEXT NULL,
    "PaymentMethodType" INTEGER NULL,
    "Gateway" INTEGER NULL,
    "GatewayId" TEXT NULL,
    "CreationDate" TEXT NOT NULL,
    CONSTRAINT "FK_Transaction_Organization_OrganizationId" FOREIGN KEY ("OrganizationId") REFERENCES "Organization" ("Id"),
    CONSTRAINT "FK_Transaction_User_UserId" FOREIGN KEY ("UserId") REFERENCES "User" ("Id")
);

CREATE TABLE "CollectionGroups" (
    "CollectionId" TEXT NOT NULL,
    "GroupId" TEXT NOT NULL,
    "ReadOnly" INTEGER NOT NULL,
    "HidePasswords" INTEGER NOT NULL,
    CONSTRAINT "PK_CollectionGroups" PRIMARY KEY ("CollectionId", "GroupId"),
    CONSTRAINT "FK_CollectionGroups_Collection_CollectionId" FOREIGN KEY ("CollectionId") REFERENCES "Collection" ("Id") ON DELETE CASCADE,
    CONSTRAINT "FK_CollectionGroups_Group_GroupId" FOREIGN KEY ("GroupId") REFERENCES "Group" ("Id") ON DELETE CASCADE
);

CREATE TABLE "CollectionCipher" (
    "CollectionId" TEXT NOT NULL,
    "CipherId" TEXT NOT NULL,
    CONSTRAINT "PK_CollectionCipher" PRIMARY KEY ("CollectionId", "CipherId"),
    CONSTRAINT "FK_CollectionCipher_Cipher_CipherId" FOREIGN KEY ("CipherId") REFERENCES "Cipher" ("Id") ON DELETE CASCADE,
    CONSTRAINT "FK_CollectionCipher_Collection_CollectionId" FOREIGN KEY ("CollectionId") REFERENCES "Collection" ("Id") ON DELETE CASCADE
);

CREATE TABLE "AuthRequest" (
    "Id" TEXT NOT NULL CONSTRAINT "PK_AuthRequest" PRIMARY KEY,
    "UserId" TEXT NOT NULL,
    "Type" INTEGER NOT NULL,
    "RequestDeviceIdentifier" TEXT NULL,
    "RequestDeviceType" INTEGER NOT NULL,
    "RequestIpAddress" TEXT NULL,
    "RequestFingerprint" TEXT NULL,
    "ResponseDeviceId" TEXT NULL,
    "AccessCode" TEXT NULL,
    "PublicKey" TEXT NULL,
    "Key" TEXT NULL,
    "MasterPasswordHash" TEXT NULL,
    "Approved" INTEGER NULL,
    "CreationDate" TEXT NOT NULL,
    "ResponseDate" TEXT NULL,
    "AuthenticationDate" TEXT NULL,
    CONSTRAINT "FK_AuthRequest_Device_ResponseDeviceId" FOREIGN KEY ("ResponseDeviceId") REFERENCES "Device" ("Id"),
    CONSTRAINT "FK_AuthRequest_User_UserId" FOREIGN KEY ("UserId") REFERENCES "User" ("Id") ON DELETE CASCADE
);

CREATE TABLE "CollectionUsers" (
    "CollectionId" TEXT NOT NULL,
    "OrganizationUserId" TEXT NOT NULL,
    "UserId" TEXT NULL,
    "ReadOnly" INTEGER NOT NULL,
    "HidePasswords" INTEGER NOT NULL,
    CONSTRAINT "PK_CollectionUsers" PRIMARY KEY ("CollectionId", "OrganizationUserId"),
    CONSTRAINT "FK_CollectionUsers_Collection_CollectionId" FOREIGN KEY ("CollectionId") REFERENCES "Collection" ("Id") ON DELETE CASCADE,
    CONSTRAINT "FK_CollectionUsers_OrganizationUser_OrganizationUserId" FOREIGN KEY ("OrganizationUserId") REFERENCES "OrganizationUser" ("Id") ON DELETE CASCADE,
    CONSTRAINT "FK_CollectionUsers_User_UserId" FOREIGN KEY ("UserId") REFERENCES "User" ("Id")
);

CREATE TABLE "GroupUser" (
    "GroupId" TEXT NOT NULL,
    "OrganizationUserId" TEXT NOT NULL,
    "UserId" TEXT NULL,
    CONSTRAINT "PK_GroupUser" PRIMARY KEY ("GroupId", "OrganizationUserId"),
    CONSTRAINT "FK_GroupUser_Group_GroupId" FOREIGN KEY ("GroupId") REFERENCES "Group" ("Id") ON DELETE CASCADE,
    CONSTRAINT "FK_GroupUser_OrganizationUser_OrganizationUserId" FOREIGN KEY ("OrganizationUserId") REFERENCES "OrganizationUser" ("Id") ON DELETE CASCADE,
    CONSTRAINT "FK_GroupUser_User_UserId" FOREIGN KEY ("UserId") REFERENCES "User" ("Id")
);

CREATE INDEX "IX_AuthRequest_ResponseDeviceId" ON "AuthRequest" ("ResponseDeviceId");

CREATE INDEX "IX_AuthRequest_UserId" ON "AuthRequest" ("UserId");

CREATE INDEX "IX_Cipher_OrganizationId" ON "Cipher" ("OrganizationId");

CREATE INDEX "IX_Cipher_UserId" ON "Cipher" ("UserId");

CREATE INDEX "IX_Collection_OrganizationId" ON "Collection" ("OrganizationId");

CREATE INDEX "IX_CollectionCipher_CipherId" ON "CollectionCipher" ("CipherId");

CREATE INDEX "IX_CollectionGroups_GroupId" ON "CollectionGroups" ("GroupId");

CREATE INDEX "IX_CollectionUsers_OrganizationUserId" ON "CollectionUsers" ("OrganizationUserId");

CREATE INDEX "IX_CollectionUsers_UserId" ON "CollectionUsers" ("UserId");

CREATE INDEX "IX_Device_UserId" ON "Device" ("UserId");

CREATE INDEX "IX_EmergencyAccess_GranteeId" ON "EmergencyAccess" ("GranteeId");

CREATE INDEX "IX_EmergencyAccess_GrantorId" ON "EmergencyAccess" ("GrantorId");

CREATE INDEX "IX_Folder_UserId" ON "Folder" ("UserId");

CREATE INDEX "IX_Group_OrganizationId" ON "Group" ("OrganizationId");

CREATE INDEX "IX_GroupUser_OrganizationUserId" ON "GroupUser" ("OrganizationUserId");

CREATE INDEX "IX_GroupUser_UserId" ON "GroupUser" ("UserId");

CREATE INDEX "IX_OrganizationApiKey_OrganizationId" ON "OrganizationApiKey" ("OrganizationId");

CREATE INDEX "IX_OrganizationConnection_OrganizationId" ON "OrganizationConnection" ("OrganizationId");

CREATE INDEX "IX_OrganizationSponsorship_SponsoredOrganizationId" ON "OrganizationSponsorship" ("SponsoredOrganizationId");

CREATE INDEX "IX_OrganizationSponsorship_SponsoringOrganizationId" ON "OrganizationSponsorship" ("SponsoringOrganizationId");

CREATE INDEX "IX_OrganizationUser_OrganizationId" ON "OrganizationUser" ("OrganizationId");

CREATE INDEX "IX_OrganizationUser_UserId" ON "OrganizationUser" ("UserId");

CREATE INDEX "IX_Policy_OrganizationId" ON "Policy" ("OrganizationId");

CREATE INDEX "IX_ProviderOrganization_OrganizationId" ON "ProviderOrganization" ("OrganizationId");

CREATE INDEX "IX_ProviderOrganization_ProviderId" ON "ProviderOrganization" ("ProviderId");

CREATE INDEX "IX_ProviderUser_ProviderId" ON "ProviderUser" ("ProviderId");

CREATE INDEX "IX_ProviderUser_UserId" ON "ProviderUser" ("UserId");

CREATE INDEX "IX_Send_OrganizationId" ON "Send" ("OrganizationId");

CREATE INDEX "IX_Send_UserId" ON "Send" ("UserId");

CREATE INDEX "IX_SsoConfig_OrganizationId" ON "SsoConfig" ("OrganizationId");

CREATE INDEX "IX_SsoUser_OrganizationId" ON "SsoUser" ("OrganizationId");

CREATE INDEX "IX_SsoUser_UserId" ON "SsoUser" ("UserId");

CREATE INDEX "IX_Transaction_OrganizationId" ON "Transaction" ("OrganizationId");

CREATE INDEX "IX_Transaction_UserId" ON "Transaction" ("UserId");

INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
VALUES ('20221121223935_Initial', '6.0.4');

COMMIT;


