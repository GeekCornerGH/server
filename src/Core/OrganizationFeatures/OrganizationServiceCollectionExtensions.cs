﻿using Bit.Core.Models.Business.Tokenables;
using Bit.Core.OrganizationFeatures.OrganizationApiKeys;
using Bit.Core.OrganizationFeatures.OrganizationApiKeys.Interfaces;
using Bit.Core.OrganizationFeatures.OrganizationConnections;
using Bit.Core.OrganizationFeatures.OrganizationConnections.Interfaces;
using Bit.Core.OrganizationFeatures.OrganizationDomains;
using Bit.Core.OrganizationFeatures.OrganizationDomains.Interfaces;
using Bit.Core.OrganizationFeatures.OrganizationSponsorships.FamiliesForEnterprise;
using Bit.Core.OrganizationFeatures.OrganizationSponsorships.FamiliesForEnterprise.Cloud;
using Bit.Core.OrganizationFeatures.OrganizationSponsorships.FamiliesForEnterprise.Interfaces;
using Bit.Core.OrganizationFeatures.OrganizationSponsorships.FamiliesForEnterprise.SelfHosted;
using Bit.Core.Services;
using Bit.Core.Settings;
using Bit.Core.Tokens;
using Microsoft.AspNetCore.DataProtection;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;

namespace Bit.Core.OrganizationFeatures;

public static class OrganizationServiceCollectionExtensions
{
    public static void AddOrganizationServices(this IServiceCollection services, IGlobalSettings globalSettings)
    {
        services.AddScoped<IOrganizationService, OrganizationService>();
        services.AddTokenizers();
        services.AddOrganizationConnectionCommands();
        services.AddOrganizationSponsorshipCommands(globalSettings);
        services.AddOrganizationApiKeyCommands();
        services.AddOrganizationDomainCommandsQueries();
    }

    private static void AddOrganizationConnectionCommands(this IServiceCollection services)
    {
        services.AddScoped<ICreateOrganizationConnectionCommand, CreateOrganizationConnectionCommand>();
        services.AddScoped<IDeleteOrganizationConnectionCommand, DeleteOrganizationConnectionCommand>();
        services.AddScoped<IUpdateOrganizationConnectionCommand, UpdateOrganizationConnectionCommand>();
    }

    private static void AddOrganizationSponsorshipCommands(this IServiceCollection services, IGlobalSettings globalSettings)
    {
        services.AddScoped<ICreateSponsorshipCommand, CreateSponsorshipCommand>();
        services.AddScoped<IRemoveSponsorshipCommand, RemoveSponsorshipCommand>();
        services.AddScoped<ISendSponsorshipOfferCommand, SendSponsorshipOfferCommand>();
        services.AddScoped<ISetUpSponsorshipCommand, SetUpSponsorshipCommand>();
        services.AddScoped<IValidateRedemptionTokenCommand, ValidateRedemptionTokenCommand>();
        services.AddScoped<IValidateSponsorshipCommand, ValidateSponsorshipCommand>();
        services.AddScoped<IValidateBillingSyncKeyCommand, ValidateBillingSyncKeyCommand>();
        services.AddScoped<IOrganizationSponsorshipRenewCommand, OrganizationSponsorshipRenewCommand>();
        services.AddScoped<ICloudSyncSponsorshipsCommand, CloudSyncSponsorshipsCommand>();
        services.AddScoped<ISelfHostedSyncSponsorshipsCommand, SelfHostedSyncSponsorshipsCommand>();
        services.AddScoped<ISelfHostedSyncSponsorshipsCommand, SelfHostedSyncSponsorshipsCommand>();
        services.AddScoped<ICloudSyncSponsorshipsCommand, CloudSyncSponsorshipsCommand>();
        services.AddScoped<IValidateBillingSyncKeyCommand, ValidateBillingSyncKeyCommand>();
        if (globalSettings.SelfHosted)
        {
            services.AddScoped<IRevokeSponsorshipCommand, SelfHostedRevokeSponsorshipCommand>();
        }
        else
        {
            services.AddScoped<IRevokeSponsorshipCommand, CloudRevokeSponsorshipCommand>();
        }
    }

    private static void AddOrganizationApiKeyCommands(this IServiceCollection services)
    {
        services.AddScoped<IGetOrganizationApiKeyCommand, GetOrganizationApiKeyCommand>();
        services.AddScoped<IRotateOrganizationApiKeyCommand, RotateOrganizationApiKeyCommand>();
    }

    private static void AddOrganizationDomainCommandsQueries(this IServiceCollection services)
    {
        services.AddScoped<ICreateOrganizationDomainCommand, CreateOrganizationDomainCommand>();
        services.AddScoped<IVerifyOrganizationDomainCommand, VerifyOrganizationDomainCommand>();
        services.AddScoped<IGetOrganizationDomainByIdQuery, GetOrganizationDomainByIdQuery>();
        services.AddScoped<IGetOrganizationDomainByOrganizationIdQuery, GetOrganizationDomainByOrganizationIdQuery>();
        services.AddScoped<IDeleteOrganizationDomainCommand, DeleteOrganizationDomainCommand>();
    }

    private static void AddTokenizers(this IServiceCollection services)
    {
        services.AddSingleton<IDataProtectorTokenFactory<OrganizationSponsorshipOfferTokenable>>(serviceProvider =>
            new DataProtectorTokenFactory<OrganizationSponsorshipOfferTokenable>(
                OrganizationSponsorshipOfferTokenable.ClearTextPrefix,
                OrganizationSponsorshipOfferTokenable.DataProtectorPurpose,
                serviceProvider.GetDataProtectionProvider(),
                serviceProvider.GetRequiredService<ILogger<DataProtectorTokenFactory<OrganizationSponsorshipOfferTokenable>>>())
        );
    }
}
