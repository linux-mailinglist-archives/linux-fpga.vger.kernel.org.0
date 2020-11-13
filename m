Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE1D22B2587
	for <lists+linux-fpga@lfdr.de>; Fri, 13 Nov 2020 21:31:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726088AbgKMUbP (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 13 Nov 2020 15:31:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50418 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725981AbgKMUbO (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 13 Nov 2020 15:31:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605299473;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wGTo69/0mWRMDWXMWSWzbSRGi0q3hDqTGf9uzqWEojg=;
        b=KB45rRZITOvf70psGz6q0HGnlC6kariGthdRz1mqLpK9VMv5knv9jrNzAQYMsN+EWDJhB5
        frnbO9v7vy66R+aotHuc0hISYmTwQprcoZMVL99/Wgvf+Udp1Q5Ip2OZN8aQRPaS0S/ZtC
        F9jzcB/UuSUyaY/ZvhSdCY4B8ZNK8JA=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-rUaLPWPHMsyue8wdxUubrQ-1; Fri, 13 Nov 2020 15:31:11 -0500
X-MC-Unique: rUaLPWPHMsyue8wdxUubrQ-1
Received: by mail-qv1-f72.google.com with SMTP id s3so6869789qve.13
        for <linux-fpga@vger.kernel.org>; Fri, 13 Nov 2020 12:31:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=wGTo69/0mWRMDWXMWSWzbSRGi0q3hDqTGf9uzqWEojg=;
        b=TrmiEmDniIA1ggcWVNhlKSDWEqtOEvFJ1ikOD0UKZbBGvSDXiFECSZGB4HxuJbcWJR
         xI1w4XC8lI1E0TeV686uIctTILnSuCR6SUfCEZSxHiCMyg8/LC42HQiVRah71cSL4ewD
         Wati6HZrGQ7fDPo3Md1TcqtwvE/Ww7hBhe+hF7f9kKGS25xlk7soYDkjudFPAwUIhBSL
         viW4GbSLMM6C6po2bo1qnl28JNkTo7DqMaMRcKwRop5/jFAgTXoYks2wILAzP/B+uKLl
         q3paUARJsF5oSJkVKc2Q2OoTEZIO2jp1i1A4T7Ea2yXoV4XBmqYskhI82bBxkNcaAR1d
         7/OQ==
X-Gm-Message-State: AOAM533XXWSOUdMU2cYJtJu/LthxqLPlOugIy74u42lc06Aeopas6xgC
        nIEJBDeflNvllREJ4bIYbCTeA2PoZba126KmG/dsv5OvjHdJrPAwP8TN0lAXu8yU5V6tqGlcT8L
        724ia4q4wRw+1u+EBUoQFtg==
X-Received: by 2002:a05:622a:28b:: with SMTP id z11mr3618410qtw.94.1605299470945;
        Fri, 13 Nov 2020 12:31:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwHktaMELEzOh9EV+QZwFcVtJpVhVcOYIuaHXM/+0JGc7AoYXCvSIy5WHD3KKq346ubgSIazQ==
X-Received: by 2002:a05:622a:28b:: with SMTP id z11mr3618317qtw.94.1605299469765;
        Fri, 13 Nov 2020 12:31:09 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id o125sm7363969qke.56.2020.11.13.12.31.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2020 12:31:09 -0800 (PST)
Subject: Re: [PATCHv1 4/4] fpga: stratix10-soc: entend driver for bitstream
 authentication
To:     richard.gong@linux.intel.com, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dinguyen@kernel.org, sridhar.rajagopal@intel.com,
        Richard Gong <richard.gong@intel.com>
References: <1605204403-6663-1-git-send-email-richard.gong@linux.intel.com>
 <1605204403-6663-5-git-send-email-richard.gong@linux.intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <9bb29416-65fe-85e8-b960-23abc49352f2@redhat.com>
Date:   Fri, 13 Nov 2020 12:31:07 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <1605204403-6663-5-git-send-email-richard.gong@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 11/12/20 10:06 AM, richard.gong@linux.intel.com wrote:
> From: Richard Gong <richard.gong@intel.com>
>
> Exten FPGA manager driver to support FPGA bitstream authentication on
> Intel SocFPGA platforms.
>
> Signed-off-by: Richard Gong <richard.gong@intel.com>
> ---
>  drivers/fpga/stratix10-soc.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
> index 657a70c..8a59365 100644
> --- a/drivers/fpga/stratix10-soc.c
> +++ b/drivers/fpga/stratix10-soc.c
> @@ -185,7 +185,10 @@ static int s10_ops_write_init(struct fpga_manager *mgr,
>  	ctype.flags = 0;
>  	if (info->flags & FPGA_MGR_PARTIAL_RECONFIG) {
>  		dev_dbg(dev, "Requesting partial reconfiguration.\n");
> -		ctype.flags |= BIT(COMMAND_RECONFIG_FLAG_PARTIAL);
> +		ctype.flags |= FPGA_MGR_PARTIAL_RECONFIG;

The change does not match the commit log.

Add some comment like..

'Cleanup setting of partial reconfig flag'

to cover the change.

Tom

> +	} else if (info->flags & FPGA_MGR_BITSTREM_AUTHENTICATION) {
> +		dev_dbg(dev, "Requesting bitstream authentication.\n");
> +		ctype.flags |= FPGA_MGR_BITSTREM_AUTHENTICATION;
>  	} else {
>  		dev_dbg(dev, "Requesting full reconfiguration.\n");
>  	}

