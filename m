Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2B246594B8
	for <lists+linux-fpga@lfdr.de>; Fri, 30 Dec 2022 05:44:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbiL3Emc (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 29 Dec 2022 23:42:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiL3Ema (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 29 Dec 2022 23:42:30 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7951C15F31;
        Thu, 29 Dec 2022 20:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672375349; x=1703911349;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=PZiCmLeeMbq3pMzx8fofsCRedSWFTN74SC61n5l1MvQ=;
  b=PsO0OT4pZNzGEm65qLs4FmkihtMRBD3K9AlWDMCqy+AOmofLleP1BfzI
   B/Kkg9l0Erkp8MvMvqlb24jPViXaGP+sPRKKW3/OPYznAlAF7xenY7MsY
   6SSxJ2demEDqIRiQ4uTqXcCsKNraULrZ9yBHC4WFSOte9DJ3/zhl7jgzP
   Ns0dyL4LX5dGUMHRTkyRvo62U6LGqAivms7WWmk+5TJE92iz2lpP7xHEa
   /sL0LXmtCJFC6028hJ/CsfChIKKvsAobgQ80qcpLlx6FcHeTCeFyGNlX1
   UjP3O492MYRjJSU9I38jkzfSu8Jm9mzsw4hwWLHgaksaSkkjw7devZJws
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10575"; a="318852386"
X-IronPort-AV: E=Sophos;i="5.96,286,1665471600"; 
   d="scan'208";a="318852386"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2022 20:42:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10575"; a="777870625"
X-IronPort-AV: E=Sophos;i="5.96,286,1665471600"; 
   d="scan'208";a="777870625"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orsmga004.jf.intel.com with ESMTP; 29 Dec 2022 20:42:25 -0800
Date:   Fri, 30 Dec 2022 12:32:18 +0800
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
Subject: Re: [PATCH v5 08/10] fpga: m10bmc-sec: Differentiate rsu status from
 doorbell in csr map
Message-ID: <Y65p0kEZjyVt2pgr@yilunxu-OptiPlex-7050>
References: <20221226175849.13056-1-ilpo.jarvinen@linux.intel.com>
 <20221226175849.13056-9-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221226175849.13056-9-ilpo.jarvinen@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2022-12-26 at 19:58:47 +0200, Ilpo Järvinen wrote:
> The rsu_status field moves from the doorbell register to the auth
> result register in the PMCI implementation of the MAX10 BMC. Refactor
> the sec update driver code to handle two distinct registers (rsu_status
> field was added into csr map already when it was introduced but it was
> unused until now).
> 
> Co-developed-by: Tianfei zhang <tianfei.zhang@intel.com>
> Signed-off-by: Tianfei zhang <tianfei.zhang@intel.com>
> Co-developed-by: Russ Weight <russell.h.weight@intel.com>
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/fpga/intel-m10-bmc-sec-update.c | 68 ++++++++++++++++---------
>  include/linux/mfd/intel-m10-bmc.h       |  2 +-
>  2 files changed, 46 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/fpga/intel-m10-bmc-sec-update.c b/drivers/fpga/intel-m10-bmc-sec-update.c
> index 6e58a463619c..1fe8b7ff594c 100644
> --- a/drivers/fpga/intel-m10-bmc-sec-update.c
> +++ b/drivers/fpga/intel-m10-bmc-sec-update.c
> @@ -251,7 +251,7 @@ static void log_error_regs(struct m10bmc_sec *sec, u32 doorbell)
>  	const struct m10bmc_csr_map *csr_map = sec->m10bmc->info->csr_map;
>  	u32 auth_result;
>  
> -	dev_err(sec->dev, "RSU error status: 0x%08x\n", doorbell);
> +	dev_err(sec->dev, "Doorbell: 0x%08x\n", doorbell);
>  
>  	if (!m10bmc_sys_read(sec->m10bmc, csr_map->auth_result, &auth_result))
>  		dev_err(sec->dev, "RSU auth result: 0x%08x\n", auth_result);
> @@ -279,6 +279,30 @@ static bool rsu_progress_busy(u32 progress)
>  		progress == RSU_PROG_PROGRAM_KEY_HASH);
>  }
>  
> +static int m10bmc_sec_progress_status(struct m10bmc_sec *sec, u32 *doorbell,

Please try to rename the parameters, to indicate u32 *doorbell is the
raw value from doorbell register, and u32 *progress & status are
software managed info.

> +				      u32 *progress, u32 *status)
> +{
> +	const struct m10bmc_csr_map *csr_map = sec->m10bmc->info->csr_map;
> +	u32 status_reg;
> +	int ret;
> +
> +	ret = m10bmc_sys_read(sec->m10bmc, csr_map->doorbell, doorbell);
> +	if (ret)
> +		return ret;
> +
> +	if (csr_map->doorbell != csr_map->rsu_status) {

I prefer not to complicate the csr map filling in intel-m10-bmc, just invalid
the addr value if there is no such register for the board.

> +		ret = m10bmc_sys_read(sec->m10bmc, csr_map->rsu_status, &status_reg);
> +		if (ret)
> +			return ret;
> +		*status = rsu_stat(status_reg);
> +	} else {
> +		*status = rsu_stat(*doorbell);
> +	}
> +	*progress = rsu_prog(*doorbell);
> +
> +	return 0;
> +}
> +
>  static enum fw_upload_err rsu_check_idle(struct m10bmc_sec *sec)
>  {
>  	const struct m10bmc_csr_map *csr_map = sec->m10bmc->info->csr_map;
> @@ -297,18 +321,14 @@ static enum fw_upload_err rsu_check_idle(struct m10bmc_sec *sec)
>  	return FW_UPLOAD_ERR_NONE;
>  }
>  
> -static inline bool rsu_start_done(u32 doorbell)
> +static inline bool rsu_start_done(u32 doorbell, u32 progress, u32 status)

Same concern for the naming, some more below I didn't list.

>  {
> -	u32 status, progress;
> -
>  	if (doorbell & DRBL_RSU_REQUEST)
>  		return false;
>  
> -	status = rsu_stat(doorbell);
>  	if (status == RSU_STAT_ERASE_FAIL || status == RSU_STAT_WEAROUT)
>  		return true;
>  
> -	progress = rsu_prog(doorbell);
>  	if (!rsu_progress_done(progress))
>  		return true;
>  
> @@ -318,8 +338,8 @@ static inline bool rsu_start_done(u32 doorbell)
>  static enum fw_upload_err rsu_update_init(struct m10bmc_sec *sec)
>  {
>  	const struct m10bmc_csr_map *csr_map = sec->m10bmc->info->csr_map;
> -	u32 doorbell, status;
> -	int ret;
> +	u32 doorbell, progress, status;
> +	int ret, err;
>  
>  	ret = regmap_update_bits(sec->m10bmc->regmap,
>  				 csr_map->base + csr_map->doorbell,
> @@ -330,21 +350,20 @@ static enum fw_upload_err rsu_update_init(struct m10bmc_sec *sec)
>  	if (ret)
>  		return FW_UPLOAD_ERR_RW_ERROR;
>  
> -	ret = regmap_read_poll_timeout(sec->m10bmc->regmap,
> -				       csr_map->base + csr_map->doorbell,
> -				       doorbell,
> -				       rsu_start_done(doorbell),
> -				       NIOS_HANDSHAKE_INTERVAL_US,
> -				       NIOS_HANDSHAKE_TIMEOUT_US);
> +	ret = read_poll_timeout(m10bmc_sec_progress_status, err,
> +				err < 0 || rsu_start_done(doorbell, progress, status),
> +				NIOS_HANDSHAKE_INTERVAL_US,
> +				NIOS_HANDSHAKE_TIMEOUT_US,
> +				false,
> +				sec, &doorbell, &progress, &status);
>  
>  	if (ret == -ETIMEDOUT) {
>  		log_error_regs(sec, doorbell);
>  		return FW_UPLOAD_ERR_TIMEOUT;
> -	} else if (ret) {
> +	} else if (err) {
>  		return FW_UPLOAD_ERR_RW_ERROR;
>  	}
>  
> -	status = rsu_stat(doorbell);
>  	if (status == RSU_STAT_WEAROUT) {
>  		dev_warn(sec->dev, "Excessive flash update count detected\n");
>  		return FW_UPLOAD_ERR_WEAROUT;
> @@ -393,7 +412,7 @@ static enum fw_upload_err rsu_prog_ready(struct m10bmc_sec *sec)
>  static enum fw_upload_err rsu_send_data(struct m10bmc_sec *sec)
>  {
>  	const struct m10bmc_csr_map *csr_map = sec->m10bmc->info->csr_map;
> -	u32 doorbell;
> +	u32 doorbell, status;
>  	int ret;
>  
>  	ret = regmap_update_bits(sec->m10bmc->regmap,
> @@ -418,7 +437,10 @@ static enum fw_upload_err rsu_send_data(struct m10bmc_sec *sec)
>  		return FW_UPLOAD_ERR_RW_ERROR;
>  	}
>  
> -	if (!rsu_status_ok(rsu_stat(doorbell))) {
> +	ret = m10bmc_sys_read(sec->m10bmc, csr_map->rsu_status, &status);

Same as above, please just handle the detailed register definition differences
in this driver, not in csr map.

Thanks,
Yilun

> +	if (ret)
> +		return ret;
> +	if (!rsu_status_ok(rsu_stat(status))) {
>  		log_error_regs(sec, doorbell);
>  		return FW_UPLOAD_ERR_HW_ERROR;
>  	}
> @@ -428,18 +450,18 @@ static enum fw_upload_err rsu_send_data(struct m10bmc_sec *sec)
>  
>  static int rsu_check_complete(struct m10bmc_sec *sec, u32 *doorbell)
>  {
> -	const struct m10bmc_csr_map *csr_map = sec->m10bmc->info->csr_map;
> +	u32 progress, status;
>  
> -	if (m10bmc_sys_read(sec->m10bmc, csr_map->doorbell, doorbell))
> +	if (m10bmc_sec_progress_status(sec, doorbell, &progress, &status))
>  		return -EIO;
>  
> -	if (!rsu_status_ok(rsu_stat(*doorbell)))
> +	if (!rsu_status_ok(status))
>  		return -EINVAL;
>  
> -	if (rsu_progress_done(rsu_prog(*doorbell)))
> +	if (rsu_progress_done(progress))
>  		return 0;
>  
> -	if (rsu_progress_busy(rsu_prog(*doorbell)))
> +	if (rsu_progress_busy(progress))
>  		return -EAGAIN;
>  
>  	return -EINVAL;
> diff --git a/include/linux/mfd/intel-m10-bmc.h b/include/linux/mfd/intel-m10-bmc.h
> index 42e2ce7fe439..cc2d9eb597b0 100644
> --- a/include/linux/mfd/intel-m10-bmc.h
> +++ b/include/linux/mfd/intel-m10-bmc.h
> @@ -58,7 +58,7 @@
>  #define HOST_STATUS_ABORT_RSU		0x2
>  
>  #define rsu_prog(doorbell)	FIELD_GET(DRBL_RSU_PROGRESS, doorbell)
> -#define rsu_stat(doorbell)	FIELD_GET(DRBL_RSU_STATUS, doorbell)
> +#define rsu_stat(status_reg)	FIELD_GET(DRBL_RSU_STATUS, status_reg)
>  
>  /* interval 100ms and timeout 5s */
>  #define NIOS_HANDSHAKE_INTERVAL_US	(100 * 1000)
> -- 
> 2.30.2
> 
