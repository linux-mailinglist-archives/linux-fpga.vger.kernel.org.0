Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EFC031ACAC
	for <lists+linux-fpga@lfdr.de>; Sat, 13 Feb 2021 16:46:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbhBMPpr (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 13 Feb 2021 10:45:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22365 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229647AbhBMPpn (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Sat, 13 Feb 2021 10:45:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613231054;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YQi/EANdHWWU+K4S2hS9kqKruFURuTm780fwscRNIrs=;
        b=eJUcf1Bnf+qAHtOa05YaOF4uwqM2bkqJ8GEAf8ygxh0ENV3WdL3vfihFB+uIlH+jKrU6hL
        Gi4eCEdjQdFzJ3QGdTLckwba1FcqIoZRM49TQrSnjpS398eX1N61WFNtEtWUPWk6f5XiHT
        nMfw5/fnlhw7nI+xguqK/tGvtzvF+m4=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-300-h7x6Q58KN5WbR9gxAYJb_w-1; Sat, 13 Feb 2021 10:44:13 -0500
X-MC-Unique: h7x6Q58KN5WbR9gxAYJb_w-1
Received: by mail-qv1-f72.google.com with SMTP id q104so1722877qvq.20
        for <linux-fpga@vger.kernel.org>; Sat, 13 Feb 2021 07:44:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=YQi/EANdHWWU+K4S2hS9kqKruFURuTm780fwscRNIrs=;
        b=Z2ENDeQmkqjJ5s478XhNaTElpAPPlLYMFk8D7Q1Ds2fGxPYrFqAynHksWHHAXIZrSY
         AFnM3Y26bI3wRQuk4N+DAWvM3HULjR5I3vuVyQirkjPJdtErolrTqE6K+rA2xLL1h3cX
         BUc40jAkM2Hp8FNdmqkKtO85YWUjYgs+7o5lKYBLb5+doeKk8O1ygrEPiFLS5HqnOQTQ
         9+EDSu8XyzGX9lmLwMuk3+ucW0t2semfR2JXlbSz1T5qtr8ebry1oNfSzO80SMxOjAmz
         41xtdSWZYn8mjPcu1patjUJ1HGZ4Rbo4PKXQiz0fAgFLUuP72n4AzgI4mNhrbxsIdfvC
         3G9Q==
X-Gm-Message-State: AOAM530DYZ7IJZ79QGdFVlK7ZypLr0VGO2t7gKyPiDr7Baaunom4E+b3
        p9AYyZHrgbNsSqVdvIN73jzLutQYXDNtV8JAe4WgojgrCIWumqCLtQxIAFvXjIbTZg5M8KNfDpT
        0FwBxDsH0jM54W8h3F8X8Jg==
X-Received: by 2002:a05:620a:1322:: with SMTP id p2mr7551375qkj.260.1613231052744;
        Sat, 13 Feb 2021 07:44:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw7v+qM/tIcMmVl4Bc1iAXA7r88M/vfv1VkG7OMyRdrIIEV1A5BK6WWjqRQyk4g3LdRadBIsw==
X-Received: by 2002:a05:620a:1322:: with SMTP id p2mr7551361qkj.260.1613231052497;
        Sat, 13 Feb 2021 07:44:12 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id v5sm8510673qkg.47.2021.02.13.07.44.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Feb 2021 07:44:12 -0800 (PST)
Subject: Re: [PATCHv5 1/7] firmware: stratix10-svc: reset
 COMMAND_RECONFIG_FLAG_PARTIAL to 0
To:     richard.gong@linux.intel.com, mdf@kernel.org,
        gregkh@linuxfoundation.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Richard Gong <richard.gong@intel.com>
References: <1612909233-13867-1-git-send-email-richard.gong@linux.intel.com>
 <1612909233-13867-2-git-send-email-richard.gong@linux.intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <bc43e8ab-b8df-fd2f-31e4-02cdc48cadff@redhat.com>
Date:   Sat, 13 Feb 2021 07:44:10 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <1612909233-13867-2-git-send-email-richard.gong@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 2/9/21 2:20 PM, richard.gong@linux.intel.com wrote:
> From: Richard Gong <richard.gong@intel.com>
>
> Clean up COMMAND_RECONFIG_FLAG_PARTIAL flag by resetting it to 0, which
> aligns with the firmware settings.
>
> Fixes: 36847f9e3e56 ("firmware: stratix10-svc: correct reconfig flag and timeout values")
> Signed-off-by: Richard Gong <richard.gong@intel.com>
> ---
> v5: new add, add the missing standalone patch
> ---
>  include/linux/firmware/intel/stratix10-svc-client.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/firmware/intel/stratix10-svc-client.h b/include/linux/firmware/intel/stratix10-svc-client.h
> index a93d859..f843c6a 100644
> --- a/include/linux/firmware/intel/stratix10-svc-client.h
> +++ b/include/linux/firmware/intel/stratix10-svc-client.h
> @@ -56,7 +56,7 @@
>   * COMMAND_RECONFIG_FLAG_PARTIAL:
>   * Set to FPGA configuration type (full or partial).
>   */
> -#define COMMAND_RECONFIG_FLAG_PARTIAL	1
> +#define COMMAND_RECONFIG_FLAG_PARTIAL	0

Is this the stand alone fix split from v3's patch 1 ?

https://lore.kernel.org/linux-fpga/YBFW50LPP%2FyEbvEW@kroah.com/

Tom

>  
>  /**
>   * Timeout settings for service clients:

