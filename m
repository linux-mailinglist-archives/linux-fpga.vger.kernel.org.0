Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B63113B58F5
	for <lists+linux-fpga@lfdr.de>; Mon, 28 Jun 2021 08:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232278AbhF1GIH (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 28 Jun 2021 02:08:07 -0400
Received: from mga11.intel.com ([192.55.52.93]:53320 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232168AbhF1GIG (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 28 Jun 2021 02:08:06 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10028"; a="204886067"
X-IronPort-AV: E=Sophos;i="5.83,305,1616482800"; 
   d="scan'208";a="204886067"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2021 23:05:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,305,1616482800"; 
   d="scan'208";a="492207881"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.162])
  by fmsmga002.fm.intel.com with ESMTP; 27 Jun 2021 23:05:37 -0700
Date:   Mon, 28 Jun 2021 14:00:19 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Martin =?iso-8859-1?Q?Hundeb=F8ll?= <martin@geanix.com>
Cc:     Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Martin =?iso-8859-1?Q?Hundeb=F8ll?= <mhu@silicom.dk>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH v2 5/5] hwmon: intel-m10-bmc-hwmon: add n5010 sensors
Message-ID: <20210628060019.GE72330@yilunxu-OptiPlex-7050>
References: <20210625074213.654274-1-martin@geanix.com>
 <20210625074213.654274-6-martin@geanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210625074213.654274-6-martin@geanix.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

It is good to me.

On Fri, Jun 25, 2021 at 09:42:13AM +0200, Martin Hundebøll wrote:
> From: Martin Hundebøll <mhu@silicom.dk>
> 
> Add the list of sensors supported by the Silicom n5010 PAC, and enable
> the drivers as a subtype of the intel-m10-bmc multi-function driver.
> 
> Signed-off-by: Martin Hundebøll <mhu@silicom.dk>
> ---
> 
> Changes since v1:
>  * Patch split out to separate hwmon changes
> 
>  drivers/hwmon/intel-m10-bmc-hwmon.c | 116 ++++++++++++++++++++++++++++
>  1 file changed, 116 insertions(+)
> 
> diff --git a/drivers/hwmon/intel-m10-bmc-hwmon.c b/drivers/hwmon/intel-m10-bmc-hwmon.c
> index bd7ed2ed3a1e..7a08e4c44a4b 100644
> --- a/drivers/hwmon/intel-m10-bmc-hwmon.c
> +++ b/drivers/hwmon/intel-m10-bmc-hwmon.c
> @@ -228,6 +228,118 @@ static const struct m10bmc_hwmon_board_data d5005bmc_hwmon_bdata = {
>  	.hinfo = d5005bmc_hinfo,
>  };
>  
> +static const struct m10bmc_sdata n5010bmc_temp_tbl[] = {
> +	{ 0x100, 0x0, 0x104, 0x0, 0x0, 1000, "Board Local Temperature" },
> +	{ 0x108, 0x0, 0x10c, 0x0, 0x0, 1000, "FPGA 1 Temperature" },
> +	{ 0x110, 0x0, 0x114, 0x0, 0x0, 1000, "FPGA 2 Temperature" },
> +	{ 0x118, 0x0, 0x0, 0x0, 0x0, 1000, "Card Top Temperature" },
> +	{ 0x11c, 0x0, 0x0, 0x0, 0x0, 1000, "Card Bottom Temperature" },
> +	{ 0x128, 0x0, 0x0, 0x0, 0x0, 1000, "FPGA 1.2V Temperature" },
> +	{ 0x134, 0x0, 0x0, 0x0, 0x0, 1000, "FPGA 5V Temperature" },
> +	{ 0x140, 0x0, 0x0, 0x0, 0x0, 1000, "FPGA 0.9V Temperature" },
> +	{ 0x14c, 0x0, 0x0, 0x0, 0x0, 1000, "FPGA 0.85V Temperature" },
> +	{ 0x158, 0x0, 0x0, 0x0, 0x0, 1000, "AUX 12V Temperature" },
> +	{ 0x164, 0x0, 0x0, 0x0, 0x0, 1000, "Backplane 12V Temperature" },
> +	{ 0x1a8, 0x0, 0x0, 0x0, 0x0, 1000, "QSFP28-1 Temperature" },
> +	{ 0x1ac, 0x0, 0x0, 0x0, 0x0, 1000, "QSFP28-2 Temperature" },
> +	{ 0x1b0, 0x0, 0x0, 0x0, 0x0, 1000, "QSFP28-3 Temperature" },
> +	{ 0x1b4, 0x0, 0x0, 0x0, 0x0, 1000, "QSFP28-4 Temperature" },
> +	{ 0x1b8, 0x0, 0x0, 0x0, 0x0, 1000, "CVL1 Internal Temperature" },
> +	{ 0x1bc, 0x0, 0x0, 0x0, 0x0, 1000, "CVL2 Internal Temperature" },
> +};
> +
> +static const struct m10bmc_sdata n5010bmc_in_tbl[] = {
> +	{ 0x120, 0x0, 0x0, 0x0, 0x0, 1, "FPGA 1.2V Voltage" },
> +	{ 0x12c, 0x0, 0x0, 0x0, 0x0, 1, "FPGA 5V Voltage" },
> +	{ 0x138, 0x0, 0x0, 0x0, 0x0, 1, "FPGA 0.9V Voltage" },
> +	{ 0x144, 0x0, 0x0, 0x0, 0x0, 1, "FPGA 0.85V Voltage" },
> +	{ 0x150, 0x0, 0x0, 0x0, 0x0, 1, "AUX 12V Voltage" },
> +	{ 0x15c, 0x0, 0x0, 0x0, 0x0, 1, "Backplane 12V Voltage" },
> +	{ 0x16c, 0x0, 0x0, 0x0, 0x0, 1, "DDR4 1.2V Voltage" },
> +	{ 0x17c, 0x0, 0x0, 0x0, 0x0, 1, "FPGA 1.8V Voltage" },
> +	{ 0x184, 0x0, 0x0, 0x0, 0x0, 1, "QDR 1.3V Voltage" },
> +	{ 0x18c, 0x0, 0x0, 0x0, 0x0, 1, "CVL1 0.8V Voltage" },
> +	{ 0x194, 0x0, 0x0, 0x0, 0x0, 1, "CVL1 1.05V Voltage" },
> +	{ 0x19c, 0x0, 0x0, 0x0, 0x0, 1, "CVL2 1.05V Voltage" },
> +	{ 0x1a4, 0x0, 0x0, 0x0, 0x0, 1, "CVL2 0.8V Voltage" },
> +};
> +
> +static const struct m10bmc_sdata n5010bmc_curr_tbl[] = {
> +	{ 0x124, 0x0, 0x0, 0x0, 0x0, 1, "FPGA 1.2V Current" },
> +	{ 0x130, 0x0, 0x0, 0x0, 0x0, 1, "FPGA 5V Current" },
> +	{ 0x13c, 0x0, 0x0, 0x0, 0x0, 1, "FPGA 0.9V Current" },
> +	{ 0x148, 0x0, 0x0, 0x0, 0x0, 1, "FPGA 0.85V Current" },
> +	{ 0x154, 0x0, 0x0, 0x0, 0x0, 1, "AUX 12V Current" },
> +	{ 0x160, 0x0, 0x0, 0x0, 0x0, 1, "Backplane 12V Current" },
> +	{ 0x168, 0x0, 0x0, 0x0, 0x0, 1, "DDR4 1.2V Current" },
> +	{ 0x178, 0x0, 0x0, 0x0, 0x0, 1, "FPGA 1.8V Current" },
> +	{ 0x180, 0x0, 0x0, 0x0, 0x0, 1, "QDR 1.3V Current" },
> +	{ 0x188, 0x0, 0x0, 0x0, 0x0, 1, "CVL1 0.8V Current" },
> +	{ 0x190, 0x0, 0x0, 0x0, 0x0, 1, "CVL1 1.05V Current" },
> +	{ 0x198, 0x0, 0x0, 0x0, 0x0, 1, "CVL2 1.05V Current" },
> +	{ 0x1a0, 0x0, 0x0, 0x0, 0x0, 1, "CVL2 0.8V Current" },
> +};
> +
> +static const struct hwmon_channel_info *n5010bmc_hinfo[] = {
> +	HWMON_CHANNEL_INFO(temp,
> +			   HWMON_T_INPUT | HWMON_T_CRIT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_CRIT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_CRIT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL),
> +	HWMON_CHANNEL_INFO(in,
> +			   HWMON_I_INPUT | HWMON_I_LABEL,
> +			   HWMON_I_INPUT | HWMON_I_LABEL,
> +			   HWMON_I_INPUT | HWMON_I_LABEL,
> +			   HWMON_I_INPUT | HWMON_I_LABEL,
> +			   HWMON_I_INPUT | HWMON_I_LABEL,
> +			   HWMON_I_INPUT | HWMON_I_LABEL,
> +			   HWMON_I_INPUT | HWMON_I_LABEL,
> +			   HWMON_I_INPUT | HWMON_I_LABEL,
> +			   HWMON_I_INPUT | HWMON_I_LABEL,
> +			   HWMON_I_INPUT | HWMON_I_LABEL,
> +			   HWMON_I_INPUT | HWMON_I_LABEL,
> +			   HWMON_I_INPUT | HWMON_I_LABEL,
> +			   HWMON_I_INPUT | HWMON_I_LABEL),
> +	HWMON_CHANNEL_INFO(curr,
> +			   HWMON_C_INPUT | HWMON_C_LABEL,
> +			   HWMON_C_INPUT | HWMON_C_LABEL,
> +			   HWMON_C_INPUT | HWMON_C_LABEL,
> +			   HWMON_C_INPUT | HWMON_C_LABEL,
> +			   HWMON_C_INPUT | HWMON_C_LABEL,
> +			   HWMON_C_INPUT | HWMON_C_LABEL,
> +			   HWMON_C_INPUT | HWMON_C_LABEL,
> +			   HWMON_C_INPUT | HWMON_C_LABEL,
> +			   HWMON_C_INPUT | HWMON_C_LABEL,
> +			   HWMON_C_INPUT | HWMON_C_LABEL,
> +			   HWMON_C_INPUT | HWMON_C_LABEL,
> +			   HWMON_C_INPUT | HWMON_C_LABEL,
> +			   HWMON_C_INPUT | HWMON_C_LABEL),
> +	NULL
> +};
> +
> +static const struct m10bmc_hwmon_board_data n5010bmc_hwmon_bdata = {
> +	.tables = {
> +		[hwmon_temp] = n5010bmc_temp_tbl,
> +		[hwmon_in] = n5010bmc_in_tbl,
> +		[hwmon_curr] = n5010bmc_curr_tbl,
> +	},
> +
> +	.hinfo = n5010bmc_hinfo,
> +};
> +
>  static umode_t
>  m10bmc_hwmon_is_visible(const void *data, enum hwmon_sensor_types type,
>  			u32 attr, int channel)
> @@ -438,6 +550,10 @@ static const struct platform_device_id intel_m10bmc_hwmon_ids[] = {
>  		.name = "d5005bmc-hwmon",
>  		.driver_data = (unsigned long)&d5005bmc_hwmon_bdata,
>  	},
> +	{
> +		.name = "n5010bmc-hwmon",
> +		.driver_data = (unsigned long)&n5010bmc_hwmon_bdata,
> +	},
>  	{ }
>  };
>  
> -- 
> 2.31.0
