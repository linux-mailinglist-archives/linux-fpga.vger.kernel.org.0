Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91FFC3B7A48
	for <lists+linux-fpga@lfdr.de>; Wed, 30 Jun 2021 00:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235348AbhF2WKj (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 29 Jun 2021 18:10:39 -0400
Received: from mga14.intel.com ([192.55.52.115]:31494 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235291AbhF2WKi (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 29 Jun 2021 18:10:38 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10030"; a="208069120"
X-IronPort-AV: E=Sophos;i="5.83,310,1616482800"; 
   d="scan'208";a="208069120"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2021 15:08:10 -0700
X-IronPort-AV: E=Sophos;i="5.83,310,1616482800"; 
   d="scan'208";a="408336090"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.42])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2021 15:08:10 -0700
Date:   Tue, 29 Jun 2021 15:09:48 -0700 (PDT)
From:   matthew.gerlach@linux.intel.com
X-X-Sender: mgerlach@rhweight-WRK1
To:     =?ISO-8859-15?Q?Martin_Hundeb=F8ll?= <martin@geanix.com>
cc:     Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        =?ISO-8859-15?Q?Martin_Hundeb=F8ll?= <mhu@silicom.dk>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH v3 4/4] hwmon: intel-m10-bmc-hwmon: add n5010 sensors
In-Reply-To: <20210629121214.988036-5-martin@geanix.com>
Message-ID: <alpine.DEB.2.22.394.2106291509350.1279832@rhweight-WRK1>
References: <20210629121214.988036-1-martin@geanix.com> <20210629121214.988036-5-martin@geanix.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1872359212-1625004588=:1279832"
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1872359212-1625004588=:1279832
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT



On Tue, 29 Jun 2021, Martin Hundebøll wrote:

> From: Martin Hundebøll <mhu@silicom.dk>
>
> Add the list of sensors supported by the Silicom n5010 PAC, and enable
> the drivers as a subtype of the intel-m10-bmc multi-function driver.
>
> Signed-off-by: Martin Hundebøll <mhu@silicom.dk>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> Reviewed-by: Moritz Fischer <mdf@kernel.org>
> Reviewed-by: Xu Yilun <yilun.xu@intel.com>
Acked-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> ---
>
> Changes since v2:
> * Added Yilun's Reviewed-by
> * Added Moritz' Reviewed-by
> * Added Guenter's Reviewed-by
>
> Changes since v1:
> * Patch split out to separate hwmon changes
>
> drivers/hwmon/intel-m10-bmc-hwmon.c | 116 ++++++++++++++++++++++++++++
> 1 file changed, 116 insertions(+)
>
> diff --git a/drivers/hwmon/intel-m10-bmc-hwmon.c b/drivers/hwmon/intel-m10-bmc-hwmon.c
> index bd7ed2ed3a1e..7a08e4c44a4b 100644
> --- a/drivers/hwmon/intel-m10-bmc-hwmon.c
> +++ b/drivers/hwmon/intel-m10-bmc-hwmon.c
> @@ -228,6 +228,118 @@ static const struct m10bmc_hwmon_board_data d5005bmc_hwmon_bdata = {
> 	.hinfo = d5005bmc_hinfo,
> };
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
> static umode_t
> m10bmc_hwmon_is_visible(const void *data, enum hwmon_sensor_types type,
> 			u32 attr, int channel)
> @@ -438,6 +550,10 @@ static const struct platform_device_id intel_m10bmc_hwmon_ids[] = {
> 		.name = "d5005bmc-hwmon",
> 		.driver_data = (unsigned long)&d5005bmc_hwmon_bdata,
> 	},
> +	{
> +		.name = "n5010bmc-hwmon",
> +		.driver_data = (unsigned long)&n5010bmc_hwmon_bdata,
> +	},
> 	{ }
> };
>
> -- 
> 2.31.0
>
>
--8323328-1872359212-1625004588=:1279832--
