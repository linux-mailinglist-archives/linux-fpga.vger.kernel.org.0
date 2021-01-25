Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D98A302F9B
	for <lists+linux-fpga@lfdr.de>; Mon, 25 Jan 2021 23:59:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732118AbhAYW6W (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 25 Jan 2021 17:58:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42212 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732748AbhAYW6N (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 25 Jan 2021 17:58:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611615400;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D+br43BWYs8uxBdvKqN099cMR5CRAOYUfWqj6wzB+qg=;
        b=e+EEzKClcMGJvXofl5lJ4fLPzA1+f6/WkJA4tWukCVYRCY9dGIW18I05NHIm43PoIXooG/
        JaNDButtrEb/LqFqGajGAiEHi2mXCOFSkoCTAVf8n0Evescw/lpuMxgpv4uyq3hcEwEyHB
        oXr4TXdv4MHZ4JP05WMzV7JV+VCT17Q=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-G3wVivK-OSewAFbi7g2lAg-1; Mon, 25 Jan 2021 17:56:37 -0500
X-MC-Unique: G3wVivK-OSewAFbi7g2lAg-1
Received: by mail-qk1-f200.google.com with SMTP id f27so11079880qkh.0
        for <linux-fpga@vger.kernel.org>; Mon, 25 Jan 2021 14:56:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=D+br43BWYs8uxBdvKqN099cMR5CRAOYUfWqj6wzB+qg=;
        b=BbsecEdrUXn/LZBuFOEErvRoYARUbNSWb4ghDLOlkNWOvF4o74ndNO/8f79ZtYbPI3
         VlVdMh7XJeGFxhk45b5UV11Zm+iHk9t6hFL2m2GRx83MDTxjiG4OnAY3mchPnNTkK+1D
         pK7O80ODOcXwB8OhhrkH3/uRUigqlM6Ik7wD7zB346/cDN14O5vVFQS4Tm9GtpWXixbr
         wvDcuLrP89gAKUVva+80chXPXxnwA7RX84V4yMRN8x3PJcYIfNYP0ut0kTTWjAITKPxS
         g00cslInBMAebmuc4TEnlDv4i8QKLOVIWisfjIPExbblzplYqtKp861sw6dC3WVN2rGC
         gHOA==
X-Gm-Message-State: AOAM530SrHV3khpPQSPbojmj2o9Ijh2kmEOxDYkwzRCuwkngc4rsrssD
        MiPsXyeR/eLwrXe5+18VURpZHGKB00kTJuEVKcwNbrsqmJPgtV1aEMDASFs+aBxsTy/pCOd+Do1
        4DmmFrbGwYL+RSjqp/kTFWQ==
X-Received: by 2002:a37:d202:: with SMTP id f2mr3082599qkj.81.1611615396603;
        Mon, 25 Jan 2021 14:56:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw0CDpDdzmMTKfL+eejHQpDS9fn/OYZvcxiwollZ5JcIM5XBoJVFbzIxVegmL/lHSuTJYRx2A==
X-Received: by 2002:a37:d202:: with SMTP id f2mr3082590qkj.81.1611615396362;
        Mon, 25 Jan 2021 14:56:36 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id r64sm3941406qkf.121.2021.01.25.14.56.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jan 2021 14:56:35 -0800 (PST)
Subject: Re: [PATCHv3 1/6] firmware: stratix10-svc: add
 COMMAND_AUTHENTICATE_BITSTREAM flag
To:     richard.gong@linux.intel.com, mdf@kernel.org,
        gregkh@linuxfoundation.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     dinguyen@kernel.org, sridhar.rajagopal@intel.com,
        Richard Gong <richard.gong@intel.com>
References: <1611608188-25621-1-git-send-email-richard.gong@linux.intel.com>
 <1611608188-25621-2-git-send-email-richard.gong@linux.intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <4e1c60e6-8e6e-d0c6-970f-674958ffe91d@redhat.com>
Date:   Mon, 25 Jan 2021 14:56:33 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <1611608188-25621-2-git-send-email-richard.gong@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 1/25/21 12:56 PM, richard.gong@linux.intel.com wrote:
> From: Richard Gong <richard.gong@intel.com>
>
> Add COMMAND_AUTHENTICATE_BITSTREAM command flag for new added bitstream
> authentication feature. Authenticating a bitstream is to make sure a signed
> bitstream has the valid signatures.
>
> Except for the actual configuration of the device, the bitstream
> authentication works the same way as FPGA configuration does. If the
> authentication passes, the signed bitstream will be programmed into QSPI
> flash memory and will be expected to boot without issues.
>
> Clean up COMMAND_RECONFIG_FLAG_PARTIAL flag by resetting it to 0, which
> aligns with the firmware settings.
>
> Signed-off-by: Richard Gong <richard.gong@intel.com>
> ---
> v3: no change
> v2: new added
> ---
>  include/linux/firmware/intel/stratix10-svc-client.h | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/firmware/intel/stratix10-svc-client.h b/include/linux/firmware/intel/stratix10-svc-client.h
> index ebc2956..7ada1f2 100644
> --- a/include/linux/firmware/intel/stratix10-svc-client.h
> +++ b/include/linux/firmware/intel/stratix10-svc-client.h
> @@ -51,12 +51,17 @@
>  #define SVC_STATUS_NO_SUPPORT		6
>  
>  /*

This patch fails to apply, i believe the conflict is because in mainline this is '/**' not '/*'

Please check or point me at the branch/tag you are using.

I am using char-misc-next.

Tom

Tom

