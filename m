Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35CDB2B8085
	for <lists+linux-fpga@lfdr.de>; Wed, 18 Nov 2020 16:30:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727362AbgKRPaQ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 18 Nov 2020 10:30:16 -0500
Received: from mail-pl1-f174.google.com ([209.85.214.174]:33879 "EHLO
        mail-pl1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727347AbgKRPaQ (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 18 Nov 2020 10:30:16 -0500
Received: by mail-pl1-f174.google.com with SMTP id l11so1175997plt.1;
        Wed, 18 Nov 2020 07:30:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=y9/7rMp8wYJx+lOeR+5/3aIIgQ12D6SIhl1zOm1jjJ0=;
        b=rpy3By+UD1kOxgi7hiWPd1IFVJwCY/eQS5UbtpYpnSMzFyTSRh8mkSEgcHISzVTPHo
         416W1U1wcY1mwtr0wCsS46i/7VBNUh1dR14s7wBCrktxQtVfe1MSvxPu9fwBByl80HBf
         IaXW1VacHS2br/OpcSCCpXf0gnZ05Hdh/u19xEW8lUaS45l5oo1jXYIW8ays/xyamSsl
         UyhzH4WF3TvOnDE2cOCJi6CVVArTak6N1RJBKmbHR3rtq4YqXpAUo3dRMv/RKKQFL0c2
         D0DMxfHM2LGgrYIDr+1K49aIH+/6Aemtiet08fdh42P7pSraCw2jUhAzmjRql9VwWX97
         pZUw==
X-Gm-Message-State: AOAM533u2qIJLVSGcP8Adc2FHA5W889J2KUPfN5NYcF/J2TGPMi74w0U
        VpZK9QMmVuU7Sos1AvZK3Jrj1jP02b0=
X-Google-Smtp-Source: ABdhPJwJFBs6Nk8Bw3Ghq2T5oxuDczRjEoiWucpLmYTAwZjel0ru4uJvCaUP26EwILyj2Kha+EgzHw==
X-Received: by 2002:a17:90b:3508:: with SMTP id ls8mr450885pjb.61.1605713415458;
        Wed, 18 Nov 2020 07:30:15 -0800 (PST)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id w127sm25641571pfc.172.2020.11.18.07.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 07:30:14 -0800 (PST)
Date:   Wed, 18 Nov 2020 07:30:13 -0800
From:   Moritz Fischer <mdf@kernel.org>
To:     richard.gong@linux.intel.com
Cc:     gregkh@linuxfoundation.org, mdf@kernel.org, trix@redhat.com,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        dinguyen@kernel.org, sridhar.rajagopal@intel.com,
        richard.gong@intel.com
Subject: Re: [PATCHv2 1/5] firmware: stratix10-svc: add
 COMMAND_AUTHENTICATE_BITSTREAM flag
Message-ID: <X7U+BTkW7ZmsMByV@epycbox.lan>
References: <1605709753-7800-1-git-send-email-richard.gong@linux.intel.com>
 <1605709753-7800-2-git-send-email-richard.gong@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1605709753-7800-2-git-send-email-richard.gong@linux.intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Wed, Nov 18, 2020 at 08:29:09AM -0600, richard.gong@linux.intel.com wrote:
> From: Richard Gong <richard.gong@intel.com>
> 
> Add COMMAND_AUTHENTICATE_BITSTREAM command flag for new added bitstream
> authentication feature. Authenticating a bistream is to make sure a signed
> bitstream has the valid signatures.
> 
> Except for the actual configuration of the device, the bitstream
> authentication works the same way as FPGA configuration does. If the
> authentication passes, the signed bitstream will be programmed into QSPI
> flash memory and will be expected to boot without issues.
> 
> Clean up COMMAND_RECONFIG_FLAG_PARTIAL flag by resetting it to 0, which
> aligns with the firmware settings.

Should this be down with the v2: ?
> 
> Signed-off-by: Richard Gong <richard.gong@intel.com>
> ---
> v2: new added
> ---
>  include/linux/firmware/intel/stratix10-svc-client.h | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/firmware/intel/stratix10-svc-client.h b/include/linux/firmware/intel/stratix10-svc-client.h
> index a93d859..85463c8 100644
> --- a/include/linux/firmware/intel/stratix10-svc-client.h
> +++ b/include/linux/firmware/intel/stratix10-svc-client.h
> @@ -51,12 +51,17 @@
>  #define SVC_STATUS_NO_SUPPORT		6
>  
>  /**
> - * Flag bit for COMMAND_RECONFIG
> + * Flag bit for COMMAND_RECONFIG, in bit number
>   *
>   * COMMAND_RECONFIG_FLAG_PARTIAL:
> - * Set to FPGA configuration type (full or partial).
> + * Set for partial FPGA configuration.
> + *
> + * COMMAND_AUTHENTICATE_BITSTREAM:
> + * Set for bitstream authentication, which makes sure a signed bitstream
> + * has valid signatures before committing it to QSPI flash memory.
>   */
> -#define COMMAND_RECONFIG_FLAG_PARTIAL	1
> +#define COMMAND_RECONFIG_FLAG_PARTIAL	0
> +#define COMMAND_AUTHENTICATE_BITSTREAM	1

Can you explain how this commit by itself doesn't break things?

Before this change firmware expected BIT(0) to be set for partial
reconfiguration, now BIT(0) suddenly means authentication? How doest his
work? :)

Was there a firmware version change? Did this never work before?

If this is version depenedent for firmware, then this might need a
different compatible string / id / some form of probing?

Entirely possible that I'm missing something, but it doesn't *seem*
right.
>  
>  /**
>   * Timeout settings for service clients:
> -- 
> 2.7.4
> 

Cheers,
Moritz
