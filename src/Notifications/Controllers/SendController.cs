﻿using System.Text;
using Bit.Core.Utilities;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.SignalR;

namespace Bit.Notifications;

[Authorize("Internal")]
public class SendController : Controller
{
    private readonly IHubContext<NotificationsHub> _hubContext;

    private readonly ILogger _logger;

    public SendController(IHubContext<NotificationsHub> hubContext, ILogger logger)
    {
        _hubContext = hubContext;
        _logger = logger;
    }

    [HttpPost("~/send")]
    [SelfHosted(SelfHostedOnly = true)]
    public async Task PostSend()
    {
        using (var reader = new StreamReader(Request.Body, Encoding.UTF8))
        {
            var notificationJson = await reader.ReadToEndAsync();
            if (!string.IsNullOrWhiteSpace(notificationJson))
            {
                await HubHelpers.SendNotificationToHubAsync(notificationJson, _hubContext, null, _logger);
            }
        }
    }
}
