Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F280659462
	for <lists+linux-fpga@lfdr.de>; Fri, 30 Dec 2022 04:28:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234418AbiL3D0j (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 29 Dec 2022 22:26:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiL3D0i (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 29 Dec 2022 22:26:38 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D422E15FE9;
        Thu, 29 Dec 2022 19:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672370796; x=1703906796;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=rAvklqB8sv5ccKib0MLWukqTw2dPH21DjHyVfepgTFY=;
  b=KXPt/i/DIJtdYME4I9pGC7U2/G9mAfL1WmGyjcVoYKZdrOH56GkXyNLQ
   o1bWcWX0LScky0omSw37tpuiUdIvkwgOEU78w9tfn5436si0cls35Dcsj
   YHfiRmjdgYN3jyuo29QGDhwQ23Iut8l7iXj1buHdzLb1jDM+C7K1v1s1p
   oACJYNcDc/kwk6lvYExOsgyUKpVJmzDQGVUN7fA3napjEePdG3hAKxb5+
   Kh3vaWyVt1lye9/+PDJSwCuEHjXfB+qWOXlclILxFFIW9HsjR6/04P48l
   xzbM6AuZQsngTDJ0rYXB/M9rAYEtvRj/Ao9xM8wJHF0cCZDS+h3ztBtlZ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10575"; a="322389165"
X-IronPort-AV: E=Sophos;i="5.96,286,1665471600"; 
   d="scan'208";a="322389165"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2022 19:26:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10575"; a="742470373"
X-IronPort-AV: E=Sophos;i="5.96,286,1665471600"; 
   d="scan'208";a="742470373"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by FMSMGA003.fm.intel.com with ESMTP; 29 Dec 2022 19:26:32 -0800
Date:   Fri, 30 Dec 2022 11:16:25 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-fpga@vger.kernel.org, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>,
        Lee Jones <lee@kernel.org>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Russ Weight <russell.h.weight@intel.com>,
        Tianfei zhang <tianfei.zhang@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Marco Pagani <marpagan@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 07/10] fpga: m10bmc-sec: Create helpers for rsu
 status/progress checks
Message-ID: <Y65YCV19NSyhUx2D@yilunxu-OptiPlex-7050>
References: <20221226175849.13056-1-ilpo.jarvinen@linux.intel.com>
 <20221226175849.13056-8-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221226175849.13056-8-ilpo.jarvinen@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2022-12-26 at 19:58:46 +0200, Ilpo Järvinen wrote:
> RSU_STAT_* and RSU_PROG_* checks are done in more than one place in the sec
> update code. Move the checks into new helper functions.
> 
> No function changes intended.
> 
> Co-developed-by: Tianfei zhang <tianfei.zhang@intel.com>
> Signed-off-by: Tianfei zhang <tianfei.zhang@intel.com>
> Co-developed-by: Russ Weight <russell.h.weight@intel.com>
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Acked-by: Xu Yilun <yilun.xu@intel.com>

> ---
>  drivers/fpga/intel-m10-bmc-sec-update.c | 59 +++++++++++++------------
>  1 file changed, 31 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/fpga/intel-m10-bmc-sec-update.c b/drivers/fpga/intel-m10-bmc-sec-update.c
> index 9922027856a4..6e58a463619c 100644
> --- a/drivers/fpga/intel-m10-bmc-sec-update.c
> +++ b/drivers/fpga/intel-m10-bmc-sec-update.c
> @@ -257,6 +257,28 @@ static void log_error_regs(struct m10bmc_sec *sec, u32 doorbell)
>  		dev_err(sec->dev, "RSU auth result: 0x%08x\n", auth_result);
>  }
>  
> +static bool rsu_status_ok(u32 status)
> +{
> +	return (status == RSU_STAT_NORMAL ||
> +		status == RSU_STAT_NIOS_OK ||
> +		status == RSU_STAT_USER_OK ||
> +		status == RSU_STAT_FACTORY_OK);
> +}
> +
> +static bool rsu_progress_done(u32 progress)
> +{
> +	return (progress == RSU_PROG_IDLE ||
> +		progress == RSU_PROG_RSU_DONE);
> +}
> +
> +static bool rsu_progress_busy(u32 progress)
> +{
> +	return (progress == RSU_PROG_AUTHENTICATING ||
> +		progress == RSU_PROG_COPYING ||
> +		progress == RSU_PROG_UPDATE_CANCEL ||
> +		progress == RSU_PROG_PROGRAM_KEY_HASH);
> +}
> +
>  static enum fw_upload_err rsu_check_idle(struct m10bmc_sec *sec)
>  {
>  	const struct m10bmc_csr_map *csr_map = sec->m10bmc->info->csr_map;
> @@ -267,8 +289,7 @@ static enum fw_upload_err rsu_check_idle(struct m10bmc_sec *sec)
>  	if (ret)
>  		return FW_UPLOAD_ERR_RW_ERROR;
>  
> -	if (rsu_prog(doorbell) != RSU_PROG_IDLE &&
> -	    rsu_prog(doorbell) != RSU_PROG_RSU_DONE) {
> +	if (!rsu_progress_done(rsu_prog(doorbell))) {
>  		log_error_regs(sec, doorbell);
>  		return FW_UPLOAD_ERR_BUSY;
>  	}
> @@ -288,7 +309,7 @@ static inline bool rsu_start_done(u32 doorbell)
>  		return true;
>  
>  	progress = rsu_prog(doorbell);
> -	if (progress != RSU_PROG_IDLE && progress != RSU_PROG_RSU_DONE)
> +	if (!rsu_progress_done(progress))
>  		return true;
>  
>  	return false;
> @@ -397,13 +418,7 @@ static enum fw_upload_err rsu_send_data(struct m10bmc_sec *sec)
>  		return FW_UPLOAD_ERR_RW_ERROR;
>  	}
>  
> -	switch (rsu_stat(doorbell)) {
> -	case RSU_STAT_NORMAL:
> -	case RSU_STAT_NIOS_OK:
> -	case RSU_STAT_USER_OK:
> -	case RSU_STAT_FACTORY_OK:
> -		break;
> -	default:
> +	if (!rsu_status_ok(rsu_stat(doorbell))) {
>  		log_error_regs(sec, doorbell);
>  		return FW_UPLOAD_ERR_HW_ERROR;
>  	}
> @@ -418,28 +433,16 @@ static int rsu_check_complete(struct m10bmc_sec *sec, u32 *doorbell)
>  	if (m10bmc_sys_read(sec->m10bmc, csr_map->doorbell, doorbell))
>  		return -EIO;
>  
> -	switch (rsu_stat(*doorbell)) {
> -	case RSU_STAT_NORMAL:
> -	case RSU_STAT_NIOS_OK:
> -	case RSU_STAT_USER_OK:
> -	case RSU_STAT_FACTORY_OK:
> -		break;
> -	default:
> +	if (!rsu_status_ok(rsu_stat(*doorbell)))
>  		return -EINVAL;
> -	}
>  
> -	switch (rsu_prog(*doorbell)) {
> -	case RSU_PROG_IDLE:
> -	case RSU_PROG_RSU_DONE:
> +	if (rsu_progress_done(rsu_prog(*doorbell)))
>  		return 0;
> -	case RSU_PROG_AUTHENTICATING:
> -	case RSU_PROG_COPYING:
> -	case RSU_PROG_UPDATE_CANCEL:
> -	case RSU_PROG_PROGRAM_KEY_HASH:
> +
> +	if (rsu_progress_busy(rsu_prog(*doorbell)))
>  		return -EAGAIN;
> -	default:
> -		return -EINVAL;
> -	}
> +
> +	return -EINVAL;
>  }
>  
>  static enum fw_upload_err rsu_cancel(struct m10bmc_sec *sec)
> -- 
> 2.30.2
> 
