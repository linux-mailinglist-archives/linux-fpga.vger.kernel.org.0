Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA26305160
	for <lists+linux-fpga@lfdr.de>; Wed, 27 Jan 2021 05:49:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234001AbhA0Ep0 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 26 Jan 2021 23:45:26 -0500
Received: from mail-pf1-f180.google.com ([209.85.210.180]:46013 "EHLO
        mail-pf1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727162AbhAZFC1 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 26 Jan 2021 00:02:27 -0500
Received: by mail-pf1-f180.google.com with SMTP id j12so9788443pfj.12;
        Mon, 25 Jan 2021 21:02:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5sPaQ9hxkwyZ8/SMdBWsfsk9BJ2xUder9O8LP6uJOsg=;
        b=to+4vOmdrJ0RTW0/XAnAbZVEC9dBeVtPBCKU5MMTsVFcoF/fqXtSVmo+Edi8VCUYjD
         oluSOr4fQFzA108fMAJA2YoL9T2cq/RIwnGX9Z8Zv1jAZ3NgfaObdfcAGrxSj0JAfGSd
         3mpzfA097oSrdqnoVNKapUCJe5tibyFeCIPc/4Fv7fV4chCZuFusLrTKqlgfOwCT9X7x
         de4/NswH7uvbsvtYwQY+/PBPA+xR+fKhfCT4ys/LBXokNCK1qgfKkLTpmBfrLtzr+kfM
         r5u2K/xoYFnWWhVIWCR0lC5fjJhO3KbN3ZNngSa01j/b7pFD6lCH3Wi9j5xZn/9zT8P1
         q6hA==
X-Gm-Message-State: AOAM533Zw6S9T1y3mHxmIIO5wWkjYLJJFiR4Xyu6sUbXMc/XHMYmTal+
        Zyfe7cxItsf4lM6s1bLpF5jzP+50Qsc=
X-Google-Smtp-Source: ABdhPJxlLcvjc++VLFUFQyYSB6lgmgpqyeqbYSYX8zDuAFLDQsRCTV84AGDbI8jZEegBwKCzSxfeaw==
X-Received: by 2002:a62:d5:0:b029:1b4:144c:f217 with SMTP id 204-20020a6200d50000b02901b4144cf217mr3487246pfa.13.1611637307273;
        Mon, 25 Jan 2021 21:01:47 -0800 (PST)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id i4sm9537864pfo.40.2021.01.25.21.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 21:01:46 -0800 (PST)
Date:   Mon, 25 Jan 2021 21:01:45 -0800
From:   Moritz Fischer <mdf@kernel.org>
To:     richard.gong@linux.intel.com
Cc:     mdf@kernel.org, trix@redhat.com, gregkh@linuxfoundation.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        dinguyen@kernel.org, sridhar.rajagopal@intel.com,
        Richard Gong <richard.gong@intel.com>
Subject: Re: [PATCHv3 2/6] firmware: stratix10-svc: extend SVC driver to get
 the firmware version
Message-ID: <YA+iOW079Pq6L6yH@epycbox.lan>
References: <1611608188-25621-1-git-send-email-richard.gong@linux.intel.com>
 <1611608188-25621-3-git-send-email-richard.gong@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1611608188-25621-3-git-send-email-richard.gong@linux.intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Richard,

On Mon, Jan 25, 2021 at 02:56:24PM -0600, richard.gong@linux.intel.com wrote:
> From: Richard Gong <richard.gong@intel.com>
> 
> Extend Intel service layer driver to get the firmware version running at
> FPGA device. Therefore FPGA manager driver, one of Intel service layer
> driver's client, can decide whether to handle the newly added bitstream
> authentication function based on the retrieved firmware version.
> 
> Signed-off-by: Richard Gong <richard.gong@intel.com>
> ---
> v3: new added, changes for getting firmware version
Thanks for doing that.
> ---
>  drivers/firmware/stratix10-svc.c                    | 12 ++++++++++--
>  include/linux/firmware/intel/stratix10-smc.h        | 21 +++++++++++++++++++--
>  include/linux/firmware/intel/stratix10-svc-client.h |  4 ++++
>  3 files changed, 33 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
> index 3aa489d..1443bbd 100644
> --- a/drivers/firmware/stratix10-svc.c
> +++ b/drivers/firmware/stratix10-svc.c
> @@ -306,6 +306,7 @@ static void svc_thread_recv_status_ok(struct stratix10_svc_data *p_data,
>  		break;
>  	case COMMAND_RSU_RETRY:
>  	case COMMAND_RSU_MAX_RETRY:
> +	case COMMAND_FIRMWARE_VERSION:
>  		cb_data->status = BIT(SVC_STATUS_OK);
>  		cb_data->kaddr1 = &res.a1;
>  		break;
> @@ -422,6 +423,11 @@ static int svc_normal_to_secure_thread(void *data)
>  			a1 = 0;
>  			a2 = 0;
>  			break;
> +		case COMMAND_FIRMWARE_VERSION:
> +			a0 = INTEL_SIP_SMC_FIRMWARE_VERSION;
> +			a1 = 0;
> +			a2 = 0;
> +			break;
>  		default:
>  			pr_warn("it shouldn't happen\n");
>  			break;
> @@ -487,11 +493,13 @@ static int svc_normal_to_secure_thread(void *data)
>  
>  			/*
>  			 * be compatible with older version firmware which
> -			 * doesn't support RSU notify or retry
> +			 * doesn't support RSU notify, retry or bitstream
> +			 * authentication.
>  			 */
>  			if ((pdata->command == COMMAND_RSU_RETRY) ||
>  			    (pdata->command == COMMAND_RSU_MAX_RETRY) ||
> -				(pdata->command == COMMAND_RSU_NOTIFY)) {
> +			    (pdata->command == COMMAND_RSU_NOTIFY) ||
> +			    (pdata->command == COMMAND_FIRMWARE_VERSION)) {
>  				cbdata->status =
>  					BIT(SVC_STATUS_NO_SUPPORT);
>  				cbdata->kaddr1 = NULL;
> diff --git a/include/linux/firmware/intel/stratix10-smc.h b/include/linux/firmware/intel/stratix10-smc.h
> index c3e5ab0..505fcca 100644
> --- a/include/linux/firmware/intel/stratix10-smc.h
> +++ b/include/linux/firmware/intel/stratix10-smc.h
> @@ -321,8 +321,6 @@ INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FPGA_CONFIG_COMPLETED_WRITE)
>  #define INTEL_SIP_SMC_ECC_DBE \
>  	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_ECC_DBE)
>  
> -#endif
> -
>  /**
>   * Request INTEL_SIP_SMC_RSU_NOTIFY
>   *
> @@ -404,3 +402,22 @@ INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FPGA_CONFIG_COMPLETED_WRITE)
>  #define INTEL_SIP_SMC_FUNCID_RSU_MAX_RETRY 18
>  #define INTEL_SIP_SMC_RSU_MAX_RETRY \
>  	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_RSU_MAX_RETRY)
> +
> +/**
> + * Request INTEL_SIP_SMC_FIRMWARE_VERSION
> + *
> + * Sync call used to query the version of running firmware
> + *
> + * Call register usage:
> + * a0 INTEL_SIP_SMC_FIRMWARE_VERSION
> + * a1-a7 not used
> + *
> + * Return status:
> + * a0 INTEL_SIP_SMC_STATUS_OK or INTEL_SIP_SMC_STATUS_ERROR
> + * a1 running firmware version
> + */
> +#define INTEL_SIP_SMC_FUNCID_FIRMWARE_VERSION 31
> +#define INTEL_SIP_SMC_FIRMWARE_VERSION \
> +	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FIRMWARE_VERSION)
> +
> +#endif
> diff --git a/include/linux/firmware/intel/stratix10-svc-client.h b/include/linux/firmware/intel/stratix10-svc-client.h
> index 7ada1f2..15e5477 100644
> --- a/include/linux/firmware/intel/stratix10-svc-client.h
> +++ b/include/linux/firmware/intel/stratix10-svc-client.h
> @@ -109,6 +109,9 @@ struct stratix10_svc_chan;
>   *
>   * @COMMAND_RSU_DCMF_VERSION: query firmware for the DCMF version, return status
>   * is SVC_STATUS_OK or SVC_STATUS_ERROR
Is DCMF explaines somewhere? Maybe I missed it.
> + *
> + * @COMMAND_FIRMWARE_VERSION: query running firmware version, return status
> + * is SVC_STATUS_OK or SVC_STATUS_ERROR
>   */
>  enum stratix10_svc_command_code {
>  	COMMAND_NOOP = 0,
> @@ -122,6 +125,7 @@ enum stratix10_svc_command_code {
>  	COMMAND_RSU_RETRY,
>  	COMMAND_RSU_MAX_RETRY,
>  	COMMAND_RSU_DCMF_VERSION,
> +	COMMAND_FIRMWARE_VERSION,
>  };
>  
>  /**
> -- 
> 2.7.4
> 
Thanks,
Moritz
