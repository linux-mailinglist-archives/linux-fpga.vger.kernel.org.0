Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69F6D34BF02
	for <lists+linux-fpga@lfdr.de>; Sun, 28 Mar 2021 22:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbhC1UxE (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 28 Mar 2021 16:53:04 -0400
Received: from mail-pg1-f178.google.com ([209.85.215.178]:37678 "EHLO
        mail-pg1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbhC1Uwm (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 28 Mar 2021 16:52:42 -0400
Received: by mail-pg1-f178.google.com with SMTP id 33so2264905pgy.4;
        Sun, 28 Mar 2021 13:52:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7C6je9CRkl7USBYPCN2QHdfoxDl2CIHBPIaFK+t0uow=;
        b=C4vfRclZv467Ret/xZnLidwXLNO7PmBUv4icUzCIv/QMrN4Bf6cuGsZLo9odmaqsNO
         q+FRMKVkuyODLKkU85RBjTFmMJFSOfgKWztR/D8DaZXb1Y8jAarJXN27fAA67X2n0YYl
         BFEM45+1WzDBkqvvleuh4jZnc+UfKp4Z9nilQteJKvT2GF1fBSusFJ9j7vNf1b/fzJbx
         nVDCkHaIFzlZ/A3D9cMb9xN3wdp+GmkaP2735dlDAaXCrzkUSRzYTXY+AzQFB0CEElUb
         jEaaoVbIqwOh4ocQuWG3dhqWumkeJvL9dvK0RJvVqLR77jy2Dn+Sh6gOMCsipdbQHfS2
         SyUA==
X-Gm-Message-State: AOAM533a2LMiiTkMenN1NUBY3QzWZ7xNgY5rSJ6rpS3eFthppQ2B8Hyb
        50NUVLR5MPAeb5wDhADEKHY=
X-Google-Smtp-Source: ABdhPJy4/029yakqf15+k6YieVoY+FAOZSCZUUOAFqUSyf17lzqcLfDwcMfhqLjnL23FY78Fm5ZLaw==
X-Received: by 2002:a62:7708:0:b029:1ee:f656:51d5 with SMTP id s8-20020a6277080000b02901eef65651d5mr22915107pfc.59.1616964761882;
        Sun, 28 Mar 2021 13:52:41 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id g7sm14273683pgb.10.2021.03.28.13.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 13:52:41 -0700 (PDT)
Date:   Sun, 28 Mar 2021 13:52:39 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     richard.gong@linux.intel.com
Cc:     mdf@kernel.org, trix@redhat.com, gregkh@linuxfoundation.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        Richard Gong <richard.gong@intel.com>
Subject: Re: [PATCHv5 3/7] firmware: stratix10-svc: extend SVC driver to get
 the firmware version
Message-ID: <YGDsl3VlIAnyJDzd@epycbox.lan>
References: <1612909233-13867-1-git-send-email-richard.gong@linux.intel.com>
 <1612909233-13867-4-git-send-email-richard.gong@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1612909233-13867-4-git-send-email-richard.gong@linux.intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Feb 09, 2021 at 04:20:29PM -0600, richard.gong@linux.intel.com wrote:
> From: Richard Gong <richard.gong@intel.com>
> 
> Extend Intel service layer driver to get the firmware version running at
> FPGA device. Therefore FPGA manager driver, one of Intel service layer
> driver's client, can decide whether to handle the newly added bitstream
> authentication function based on the retrieved firmware version.
> 
> Signed-off-by: Richard Gong <richard.gong@intel.com>
Acked-by: Moritz Fischr <mdf@kernel.org>
> ---
> v5: no change
> v4: no change
> v3: new added, changes for getting firmware version
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
> index fa9581d..193a2cf 100644
> --- a/include/linux/firmware/intel/stratix10-svc-client.h
> +++ b/include/linux/firmware/intel/stratix10-svc-client.h
> @@ -109,6 +109,9 @@ struct stratix10_svc_chan;
>   *
>   * @COMMAND_RSU_DCMF_VERSION: query firmware for the DCMF version, return status
>   * is SVC_STATUS_OK or SVC_STATUS_ERROR
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
