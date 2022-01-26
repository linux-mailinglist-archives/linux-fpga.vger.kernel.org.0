Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADA8B49C081
	for <lists+linux-fpga@lfdr.de>; Wed, 26 Jan 2022 02:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235583AbiAZBPf (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 25 Jan 2022 20:15:35 -0500
Received: from mga06.intel.com ([134.134.136.31]:49993 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235581AbiAZBPf (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 25 Jan 2022 20:15:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643159735; x=1674695735;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=adSZiEP4q+sm1LMVy6D+9dph1lEFb/rZerQba2yPh1g=;
  b=EpRUmfYdXLkVnxHuBf4TJJv9Kgh7/VZolwlrAaMb4tz8RuDMK+y3xuRQ
   ld/jNF7nP43Vy2ViUOJMIRUXp0/qdeQ1wVxiuulMJsP1fXO3xn0ceT3xO
   i1gGykrpCOhN9kPjUKh6A5rgyRIMufkUGxkYPApZ/qz45V/wf+Z+L+iBQ
   LEqHq/zi9ytwTzg+e0MpTiPZhjD40u2jvyi1tCyao1abLyCh8iUD1w6h5
   isWq+rx4AE6vcZ4ZAqeguBbgxAeg0gWpSC4OFxTUAYugPnmQEum1zlazK
   xeShKci39drCbGx1FU06GFSfVfXv3jFFaVS49bPIJVbU3K3EbY0dWltBO
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="307171671"
X-IronPort-AV: E=Sophos;i="5.88,316,1635231600"; 
   d="scan'208";a="307171671"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 17:15:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,316,1635231600"; 
   d="scan'208";a="597318903"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.68])
  by fmsmga004.fm.intel.com with ESMTP; 25 Jan 2022 17:15:32 -0800
Date:   Wed, 26 Jan 2022 09:07:23 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     mdf@kernel.org, hao.wu@intel.com, trix@redhat.com,
        linux-fpga@vger.kernel.org, Richard Gong <richard.gong@intel.com>
Subject: Re: [PATCH] firmware: stratix10-svc: extend SVC driver to get the
 firmware version
Message-ID: <20220126010723.GA1139334@yilunxu-OptiPlex-7050>
References: <20220125192853.1956486-1-dinguyen@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220125192853.1956486-1-dinguyen@kernel.org>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Jan 25, 2022 at 01:28:53PM -0600, Dinh Nguyen wrote:
> From: Richard Gong <richard.gong@intel.com>
> 
> Extend Intel service layer driver to get the firmware version running at
> FPGA device. Therefore FPGA manager driver, one of Intel service layer
> driver's client, can decide whether to handle the newly added bitstream
> authentication function based on the retrieved firmware version.
> 
> Acked-by: Moritz Fischr <mdf@kernel.org>

This is already acked and no more change, is it? So please just ping in
the original mail or add the [RESEND PATCH] prefix.

The patch is good to me.

Acked-by: Xu Yilun <yilun.xu@intel.com>

> Signed-off-by: Richard Gong <richard.gong@intel.com>
> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
> ---
>  drivers/firmware/stratix10-svc.c              |  9 +++++++-
>  include/linux/firmware/intel/stratix10-smc.h  | 21 +++++++++++++++++--
>  .../firmware/intel/stratix10-svc-client.h     |  4 ++++
>  3 files changed, 31 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
> index 29c0a616b317..4bd57a908efe 100644
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
> @@ -491,7 +497,8 @@ static int svc_normal_to_secure_thread(void *data)
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
> index c3e5ab014caf..aad497a9ad8b 100644
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
> +        INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FIRMWARE_VERSION)
> +
> +#endif
> diff --git a/include/linux/firmware/intel/stratix10-svc-client.h b/include/linux/firmware/intel/stratix10-svc-client.h
> index 19781b0f6429..18c1841fdb1f 100644
> --- a/include/linux/firmware/intel/stratix10-svc-client.h
> +++ b/include/linux/firmware/intel/stratix10-svc-client.h
> @@ -104,6 +104,9 @@ struct stratix10_svc_chan;
>   *
>   * @COMMAND_RSU_DCMF_VERSION: query firmware for the DCMF version, return status
>   * is SVC_STATUS_OK or SVC_STATUS_ERROR
> + *
> + * @COMMAND_FIRMWARE_VERSION: query running firmware version, return status
> + * is SVC_STATUS_OK or SVC_STATUS_ERROR
>   */
>  enum stratix10_svc_command_code {
>  	COMMAND_NOOP = 0,
> @@ -117,6 +120,7 @@ enum stratix10_svc_command_code {
>  	COMMAND_RSU_RETRY,
>  	COMMAND_RSU_MAX_RETRY,
>  	COMMAND_RSU_DCMF_VERSION,
> +	COMMAND_FIRMWARE_VERSION,
>  };
>  
>  /**
> -- 
> 2.25.1
