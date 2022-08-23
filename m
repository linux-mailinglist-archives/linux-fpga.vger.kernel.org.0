Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4B659EC78
	for <lists+linux-fpga@lfdr.de>; Tue, 23 Aug 2022 21:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbiHWTdq (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 23 Aug 2022 15:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232137AbiHWTd3 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 23 Aug 2022 15:33:29 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E732810A14D
        for <linux-fpga@vger.kernel.org>; Tue, 23 Aug 2022 11:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661279183; x=1692815183;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=W4eRcX/hWiKxNYj6ht+v1A4K98tpxHBbPYbZPJ2H0+g=;
  b=gY1k7LMID68GR06oSJlO2ss70y8MM3DaWDSZ6qv6LI90h79UKW4KWnun
   GlUOJkrFppIhxd+Jy1DU44FHGC1cOm7CskaTaDSoKd/Y2IOyUh6xRwL1A
   UFTLeTf8RwNivG38A7T9oVYfIBw4kCxZsVsQ2jh3942Q9VMc7jTH14Rt7
   fpOOO1Ow/oUKQYtPNIKkplVfFl1Mba5EBrP4vMO/g4OsQPFXm99Uofo0Z
   x73i/3G50hr+Cp7qiRVZJr3QvSz8znDTIGBOUfSKm+EftKI2bXnTiPpBT
   jnR1Q07BgXp3brNZeirDjsMetz3/PfTAwrjZ1XqL/cJoWDxdQwINu63GB
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10448"; a="292509877"
X-IronPort-AV: E=Sophos;i="5.93,258,1654585200"; 
   d="scan'208";a="292509877"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 11:26:23 -0700
X-IronPort-AV: E=Sophos;i="5.93,258,1654585200"; 
   d="scan'208";a="937573763"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.43])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 11:26:22 -0700
Date:   Tue, 23 Aug 2022 11:26:35 -0700 (PDT)
From:   matthew.gerlach@linux.intel.com
X-X-Sender: mgerlach@rhweight-WRK1
To:     Tianfei Zhang <tianfei.zhang@intel.com>
cc:     mdf@kernel.org, yilun.xu@intel.com, linux-fpga@vger.kernel.org,
        lee.jones@linaro.org, russell.h.weight@intel.com, hao.wu@intel.com,
        trix@redhat.com
Subject: Re: [PATCH v4 2/2] fpga: m10bmc-sec: add m10bmc_sec_retimer_load
 callback
In-Reply-To: <20220815060715.37712-3-tianfei.zhang@intel.com>
Message-ID: <alpine.DEB.2.22.394.2208231124520.6273@rhweight-WRK1>
References: <20220815060715.37712-1-tianfei.zhang@intel.com> <20220815060715.37712-3-tianfei.zhang@intel.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On Mon, 15 Aug 2022, Tianfei Zhang wrote:

> From: Russ Weight <russell.h.weight@intel.com>
>
> Create m10bmc_sec_retimer_load() callback function
> to provide a trigger to update a new retimer (Intel
> C827 Ethernet transceiver) firmware on Intel PAC
> N3000 Card.
>
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>

Hi Tianfei,

You forgot to add Acked-by: Lee Jones <lee@kernel.org>.

Reviewed-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>

Looks good to me.
> ---
> v3:
> uses regmap_update_bits() API instead of m10bmc_sys_update_bits().
> ---
> drivers/fpga/intel-m10-bmc-sec-update.c | 148 ++++++++++++++++++++++++
> include/linux/mfd/intel-m10-bmc.h       |  31 +++++
> 2 files changed, 179 insertions(+)
>
> diff --git a/drivers/fpga/intel-m10-bmc-sec-update.c b/drivers/fpga/intel-m10-bmc-sec-update.c
> index 3a082911cf67..bef07e97c107 100644
> --- a/drivers/fpga/intel-m10-bmc-sec-update.c
> +++ b/drivers/fpga/intel-m10-bmc-sec-update.c
> @@ -300,6 +300,150 @@ static int m10bmc_sec_bmc_image_load_1(struct m10bmc_sec *sec)
> 	return m10bmc_sec_bmc_image_load(sec, 1);
> }
>
> +static int trigger_retimer_eeprom_load(struct m10bmc_sec *sec)
> +{
> +	struct intel_m10bmc *m10bmc = sec->m10bmc;
> +	unsigned int val;
> +	int ret;
> +
> +	ret = regmap_update_bits(m10bmc->regmap,
> +				 M10BMC_SYS_BASE + M10BMC_DOORBELL,
> +				 DRBL_PKVL_EEPROM_LOAD_SEC,
> +				 DRBL_PKVL_EEPROM_LOAD_SEC);
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
> +		regmap_update_bits(m10bmc->regmap,
> +				   M10BMC_SYS_BASE + M10BMC_DOORBELL,
> +				   DRBL_PKVL_EEPROM_LOAD_SEC, 0);
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
> static struct image_load m10bmc_image_load_hndlrs[] = {
> 	{
> 		.name = "bmc_factory",
> @@ -309,6 +453,10 @@ static struct image_load m10bmc_image_load_hndlrs[] = {
> 		.name = "bmc_user",
> 		.load_image = m10bmc_sec_bmc_image_load_0,
> 	},
> +	{
> +		.name = "retimer_fw",
> +		.load_image = m10bmc_sec_retimer_eeprom_load,
> +	},
> 	{}
> };
>
> diff --git a/include/linux/mfd/intel-m10-bmc.h b/include/linux/mfd/intel-m10-bmc.h
> index f0044b14136e..c06b9d3d1c5d 100644
> --- a/include/linux/mfd/intel-m10-bmc.h
> +++ b/include/linux/mfd/intel-m10-bmc.h
> @@ -36,6 +36,37 @@
> #define M10BMC_VER_PCB_INFO_MSK		GENMASK(31, 24)
> #define M10BMC_VER_LEGACY_INVALID	0xffffffff
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
> /* Secure update doorbell register, in system register region */
> #define M10BMC_DOORBELL			0x400
>
> -- 
> 2.26.2
>
>
