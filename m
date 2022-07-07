Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED7245697D6
	for <lists+linux-fpga@lfdr.de>; Thu,  7 Jul 2022 04:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbiGGCN5 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 6 Jul 2022 22:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbiGGCN5 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 6 Jul 2022 22:13:57 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DDE72F03F
        for <linux-fpga@vger.kernel.org>; Wed,  6 Jul 2022 19:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657160036; x=1688696036;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gLMLsMczUVRlQdRih4zwblJ854vu+MZ62WVlkjVZ1+s=;
  b=gQxhCEIy35kFoXCN36Y7TtlsGy766ZztbKpEKS5KhvufCo7Q/1dD+Xfd
   4DE1ed0dbG/wp+btDXK8JSVk9vkNZs1F3bhzLxIDC/0JNY0k/4e6FORcI
   3sBwOvRGEADp57ya+tYjZDmmY+tfVbIPo6H4+YfpsN007i3xnG26kiyJ4
   McE61xmAGkED4t4MxrjW1kAshSAz8fWEiE92PqlQOcgDVy2XXIWTQAnKr
   CQwYzGPIisru4PD0JK8Pz3g+MTu9zTrBZISu9mL8/d+1/92uHqW02Nbsj
   4lFashdNCaUQUEeacz2zMpGZcizByu7S0sNh48GQl4YDyASktzI1bbQjm
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10400"; a="284651211"
X-IronPort-AV: E=Sophos;i="5.92,251,1650956400"; 
   d="scan'208";a="284651211"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 19:13:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,251,1650956400"; 
   d="scan'208";a="650923668"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga008.fm.intel.com with ESMTP; 06 Jul 2022 19:13:53 -0700
Date:   Thu, 7 Jul 2022 10:05:30 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Tianfei Zhang <tianfei.zhang@intel.com>
Cc:     mdf@kernel.org, lee.jones@linaro.org, russell.h.weight@intel.com,
        hao.wu@intel.com, trix@redhat.com, linux-fpga@vger.kernel.org
Subject: Re: [PATCH v1 3/3] fpga: m10bmc-sec: add m10bmc_sec_retimer_load
 callback
Message-ID: <20220707020530.GA3659610@yilunxu-OptiPlex-7050>
References: <20220705080058.92532-1-tianfei.zhang@intel.com>
 <20220705080058.92532-4-tianfei.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220705080058.92532-4-tianfei.zhang@intel.com>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Jul 05, 2022 at 04:00:58AM -0400, Tianfei Zhang wrote:
> From: Russ Weight <russell.h.weight@intel.com>
> 
> Create m10bmc_sec_retimer_load() callback function
> to provide a trigger to update a new retimer (Intel
> C827 Ethernet transceiver) firmware on Intel PAC

A firmware loader framework is upstreamed recently, does that meet your
need?

Thanks,
Yilun

> N3000 Card.
> 
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
> ---
>  drivers/fpga/intel-m10-bmc-sec-update.c | 146 ++++++++++++++++++++++++
>  include/linux/mfd/intel-m10-bmc.h       |  31 +++++
>  2 files changed, 177 insertions(+)
> 
> diff --git a/drivers/fpga/intel-m10-bmc-sec-update.c b/drivers/fpga/intel-m10-bmc-sec-update.c
> index 640690e6c131..707dfd8a1931 100644
> --- a/drivers/fpga/intel-m10-bmc-sec-update.c
> +++ b/drivers/fpga/intel-m10-bmc-sec-update.c
> @@ -299,6 +299,148 @@ static int m10bmc_sec_bmc_image_load_1(struct m10bmc_sec *sec)
>  	return m10bmc_sec_bmc_image_load(sec, 1);
>  }
>  
> +static int trigger_retimer_eeprom_load(struct m10bmc_sec *sec)
> +{
> +	struct intel_m10bmc *m10bmc = sec->m10bmc;
> +	unsigned int val;
> +	int ret;
> +
> +	ret = m10bmc_sys_update_bits(m10bmc, M10BMC_DOORBELL,
> +				     DRBL_PKVL_EEPROM_LOAD_SEC,
> +				     DRBL_PKVL_EEPROM_LOAD_SEC);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * If the current NIOS FW supports this retimer update feature, then
> +	 * it will clear the same PKVL_EEPROM_LOAD bit in 2 seconds. Otherwise
> +	 * the driver needs to clear the PKVL_EEPROM_LOAD bit manually and
> +	 * return an error code.
> +	 */
> +	ret = regmap_read_poll_timeout(m10bmc->regmap,
> +				       M10BMC_SYS_BASE + M10BMC_DOORBELL, val,
> +				       (!(val & DRBL_PKVL_EEPROM_LOAD_SEC)),
> +				       M10BMC_PKVL_LOAD_INTERVAL_US,
> +				       M10BMC_PKVL_LOAD_TIMEOUT_US);
> +	if (ret == -ETIMEDOUT) {
> +		dev_err(sec->dev, "PKVL_EEPROM_LOAD clear timedout\n");
> +		m10bmc_sys_update_bits(m10bmc, M10BMC_DOORBELL,
> +				       DRBL_PKVL_EEPROM_LOAD_SEC, 0);
> +		ret = -ENODEV;
> +	} else if (ret) {
> +		dev_err(sec->dev, "poll EEPROM_LOAD error %d\n", ret);
> +	}
> +
> +	return ret;
> +}
> +
> +static int poll_retimer_eeprom_load_done(struct m10bmc_sec *sec)
> +{
> +	struct intel_m10bmc *m10bmc = sec->m10bmc;
> +	unsigned int doorbell;
> +	int ret;
> +
> +	/*
> +	 * RSU_STAT_PKVL_REJECT indicates that the current image is
> +	 * already programmed. RSU_PROG_PKVL_PROM_DONE that the firmware
> +	 * update process has finished, but does not necessarily indicate
> +	 * a successful update.
> +	 */
> +	ret = regmap_read_poll_timeout(m10bmc->regmap,
> +				       M10BMC_SYS_BASE + M10BMC_DOORBELL,
> +				       doorbell,
> +				       ((rsu_prog(doorbell) ==
> +					 RSU_PROG_PKVL_PROM_DONE) ||
> +					(rsu_stat(doorbell) ==
> +					 RSU_STAT_PKVL_REJECT)),
> +				       M10BMC_PKVL_PRELOAD_INTERVAL_US,
> +				       M10BMC_PKVL_PRELOAD_TIMEOUT_US);
> +	if (ret) {
> +		if (ret == -ETIMEDOUT)
> +			dev_err(sec->dev,
> +				"Doorbell check timedout: 0x%08x\n", doorbell);
> +		else
> +			dev_err(sec->dev, "poll Doorbell error\n");
> +		return ret;
> +	}
> +
> +	if (rsu_stat(doorbell) == RSU_STAT_PKVL_REJECT) {
> +		dev_err(sec->dev, "duplicate image rejected\n");
> +		return -ECANCELED;
> +	}
> +
> +	return 0;
> +}
> +
> +static int poll_retimer_preload_done(struct m10bmc_sec *sec)
> +{
> +	struct intel_m10bmc *m10bmc = sec->m10bmc;
> +	unsigned int val;
> +	int ret;
> +
> +	/*
> +	 * Wait for the updated firmware to be loaded by the PKVL device
> +	 * and confirm that the updated firmware is operational
> +	 */
> +	ret = regmap_read_poll_timeout(m10bmc->regmap,
> +				       M10BMC_SYS_BASE + M10BMC_PKVL_POLL_CTRL, val,
> +				       ((val & M10BMC_PKVL_PRELOAD) == M10BMC_PKVL_PRELOAD),
> +				       M10BMC_PKVL_PRELOAD_INTERVAL_US,
> +				       M10BMC_PKVL_PRELOAD_TIMEOUT_US);
> +	if (ret) {
> +		dev_err(sec->dev, "poll M10BMC_PKVL_PRELOAD error %d\n", ret);
> +		return ret;
> +	}
> +
> +	if ((val & M10BMC_PKVL_UPG_STATUS_MASK) != M10BMC_PKVL_UPG_STATUS_GOOD) {
> +		dev_err(sec->dev, "error detected during upgrade\n");
> +		return -EIO;
> +	}
> +
> +	return 0;
> +}
> +
> +static int retimer_check_idle(struct m10bmc_sec *sec)
> +{
> +	u32 doorbell;
> +	int ret;
> +
> +	ret = m10bmc_sys_read(sec->m10bmc, M10BMC_DOORBELL, &doorbell);
> +	if (ret)
> +		return -EIO;
> +
> +	if (rsu_prog(doorbell) != RSU_PROG_IDLE &&
> +	    rsu_prog(doorbell) != RSU_PROG_RSU_DONE &&
> +	    rsu_prog(doorbell) != RSU_PROG_PKVL_PROM_DONE) {
> +		log_error_regs(sec, doorbell);
> +		return -EBUSY;
> +	}
> +
> +	return 0;
> +}
> +
> +static int m10bmc_sec_retimer_eeprom_load(struct m10bmc_sec *sec)
> +{
> +	int ret;
> +
> +	ret = retimer_check_idle(sec);
> +	if (ret)
> +		goto exit;
> +
> +	ret = trigger_retimer_eeprom_load(sec);
> +	if (ret)
> +		goto exit;
> +
> +	ret = poll_retimer_eeprom_load_done(sec);
> +	if (ret)
> +		goto exit;
> +
> +	ret = poll_retimer_preload_done(sec);
> +
> +exit:
> +	return ret;
> +}
> +
>  static struct image_load m10bmc_image_load_hndlrs[] = {
>  	{
>  		.name = "bmc_factory",
> @@ -308,6 +450,10 @@ static struct image_load m10bmc_image_load_hndlrs[] = {
>  		.name = "bmc_user",
>  		.load_image = m10bmc_sec_bmc_image_load_0,
>  	},
> +	{
> +		.name = "retimer_fw",
> +		.load_image = m10bmc_sec_retimer_eeprom_load,
> +	},
>  	{}
>  };
>  
> diff --git a/include/linux/mfd/intel-m10-bmc.h b/include/linux/mfd/intel-m10-bmc.h
> index 8e434886a5a1..23025e4d2779 100644
> --- a/include/linux/mfd/intel-m10-bmc.h
> +++ b/include/linux/mfd/intel-m10-bmc.h
> @@ -36,6 +36,37 @@
>  #define M10BMC_VER_PCB_INFO_MSK		GENMASK(31, 24)
>  #define M10BMC_VER_LEGACY_INVALID	0xffffffff
>  
> +/* Retimer related registers, in system register region */
> +#define M10BMC_PKVL_POLL_CTRL		0x80
> +#define M10BMC_PKVL_A_PRELOAD		BIT(16)
> +#define M10BMC_PKVL_A_PRELOAD_TO	BIT(17)
> +#define M10BMC_PKVL_A_DATA_TOO_BIG	BIT(18)
> +#define M10BMC_PKVL_A_HDR_CKSUM	BIT(20)
> +#define M10BMC_PKVL_B_PRELOAD		BIT(24)
> +#define M10BMC_PKVL_B_PRELOAD_TO	BIT(25)
> +#define M10BMC_PKVL_B_DATA_TOO_BIG	BIT(26)
> +#define M10BMC_PKVL_B_HDR_CKSUM	BIT(28)
> +
> +#define M10BMC_PKVL_PRELOAD		(M10BMC_PKVL_A_PRELOAD | M10BMC_PKVL_B_PRELOAD)
> +#define M10BMC_PKVL_PRELOAD_TIMEOUT	(M10BMC_PKVL_A_PRELOAD_TO | \
> +					 M10BMC_PKVL_B_PRELOAD_TO)
> +#define M10BMC_PKVL_DATA_TOO_BIG	(M10BMC_PKVL_A_DATA_TOO_BIG | \
> +					 M10BMC_PKVL_B_DATA_TOO_BIG)
> +#define M10BMC_PKVL_HDR_CHECKSUM	(M10BMC_PKVL_A_HDR_CKSUM | \
> +					 M10BMC_PKVL_B_HDR_CKSUM)
> +
> +#define M10BMC_PKVL_UPG_STATUS_MASK	(M10BMC_PKVL_PRELOAD | M10BMC_PKVL_PRELOAD_TIMEOUT |\
> +					 M10BMC_PKVL_DATA_TOO_BIG | M10BMC_PKVL_HDR_CHECKSUM)
> +#define M10BMC_PKVL_UPG_STATUS_GOOD	(M10BMC_PKVL_PRELOAD | M10BMC_PKVL_HDR_CHECKSUM)
> +
> +/* interval 100ms and timeout 2s */
> +#define M10BMC_PKVL_LOAD_INTERVAL_US	(100 * 1000)
> +#define M10BMC_PKVL_LOAD_TIMEOUT_US	(2 * 1000 * 1000)
> +
> +/* interval 100ms and timeout 30s */
> +#define M10BMC_PKVL_PRELOAD_INTERVAL_US	(100 * 1000)
> +#define M10BMC_PKVL_PRELOAD_TIMEOUT_US	(30 * 1000 * 1000)
> +
>  /* Secure update doorbell register, in system register region */
>  #define M10BMC_DOORBELL			0x400
>  
> -- 
> 2.26.2
