﻿#nullable enable

using System.Text.Json;
using Bit.Core.Entities;
using Bit.Core.Models.Business;
using Bit.Core.OrganizationFeatures.OrganizationLicenses.Interfaces;
using Bit.Core.Services;
using Bit.Core.Settings;
using Bit.Core.Utilities;
using AutoMapper;

namespace Bit.Core.OrganizationFeatures.OrganizationLicenses;

public class UpdateOrganizationLicenseCommand : IUpdateOrganizationLicenseCommand
{
    private readonly ILicensingService _licensingService;
    private readonly IGlobalSettings _globalSettings;
    private readonly IOrganizationService _organizationService;
    private readonly IMapper _mapper;

    public UpdateOrganizationLicenseCommand(
        ILicensingService licensingService,
        IGlobalSettings globalSettings,
        IOrganizationService organizationService,
        IMapper mapper)
    {
        _licensingService = licensingService;
        _globalSettings = globalSettings;
        _organizationService = organizationService;
        _mapper = mapper;
    }

    public async Task UpdateLicenseAsync(SelfHostedOrganizationDetails selfHostedOrganization,
        OrganizationLicense license, Organization? existingOrganization)
    {
        license.CanUse(_globalSettings, _licensingService);
        selfHostedOrganization.CanUseLicense(license, existingOrganization);
        
        await WriteLicenseFileAsync(selfHostedOrganization, license);
        await UpdateOrganizationAsync(selfHostedOrganization, license);
    }

    private async Task WriteLicenseFileAsync(Organization organization, OrganizationLicense license)
    {
        var dir = $"{_globalSettings.LicenseDirectory}/organization";
        Directory.CreateDirectory(dir);
        await using var fs = new FileStream(Path.Combine(dir, $"{organization.Id}.json"), FileMode.Create);
        await JsonSerializer.SerializeAsync(fs, license, JsonHelpers.Indented);
    }

    private async Task UpdateOrganizationAsync(SelfHostedOrganizationDetails selfHostedOrganizationDetails, OrganizationLicense license)
    {
        var organization = _mapper.Map<Organization>(selfHostedOrganizationDetails);
        organization.UpdateFromLicense(license);
        await _organizationService.ReplaceAndUpdateCacheAsync(organization);
    }
}
