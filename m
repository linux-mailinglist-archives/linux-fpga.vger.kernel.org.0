Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 052713CC3B6
	for <lists+linux-fpga@lfdr.de>; Sat, 17 Jul 2021 16:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233925AbhGQOF3 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 17 Jul 2021 10:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232893AbhGQOFZ (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 17 Jul 2021 10:05:25 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6963EC06175F;
        Sat, 17 Jul 2021 07:02:27 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id t185so11764908qkd.3;
        Sat, 17 Jul 2021 07:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=6s0Eow+aaYWdgpdvAHa4CJ4vuVpO05X1fAzq4YRaOOY=;
        b=ZckhdPBhyubz4pTINULryx44zhRVBHjJ1x8SW2X2Pf08aavUp0L1C5oH/m60+YUBj5
         SJSgvVgDhCawL5LMlo+ztNjACvXHwxtKAx3IFcu+LzjRGJMg9j96d3AjyWv581t7URt6
         L1RfVczg1MbpmsCk1SJr7C34NNw+kVZvC8fn931LbJAsgFzy1Qa4bp6Q/U/ASE7p4nUp
         WYiiVsxd5ZUaFwSx6P2w6wqnYoYUq3Ibg23NZhS4o8T0aclzJAEPbv3nAbFNDy/1wPbm
         lUa8IALnIWliOyfPSfR9cFOycU9OVw1Kyax3Wx/hz/9XsAPDySYNdbEpcY7+diHYlFFC
         qZgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=6s0Eow+aaYWdgpdvAHa4CJ4vuVpO05X1fAzq4YRaOOY=;
        b=P2rqz9a2HNRlstBiB/u1g3wslp/tB4HThJDGljX4G27nsd1nmDaOn3Ucvr39XeqNzD
         ASiwqgbm+DbRy3rGv7Khkuh4ARQWW0R0e02C+ke/On+lk9TnPHVIgmLCVGTX5pEItYcC
         Kkd6bunvCe8mjku3PuH1P4ze/IR5r7b2Olf45zkPfACDMc3oxvd7OOfV0nTWXp8pIGrO
         qJCAuCJvAtiP9s83v8+vxSVOxxD3nPkKJChfE90fri6R9jPJSxSVa0cs4DZrNT1PRRSv
         De+R0XBv7rkoaw1YaAEnmcVdcwRB1+x4IDY8EWEONOTLltR7uWnFAfTpopZxg03cp0mw
         vDEQ==
X-Gm-Message-State: AOAM531xyJewLFfspt3VXu27/uyL6dBfKmOhBwFt4KGtFbDCg7b7MLLB
        YQAthqC0NUU5cygXPLROR5Y=
X-Google-Smtp-Source: ABdhPJxKURP+LxKbFTc/K/60oCWUWTQ98v/H+SQJMCWME1fv0fMn3XzTsb4LcR87AkAMB+IDmLfAcw==
X-Received: by 2002:a37:40ca:: with SMTP id n193mr15396910qka.208.1626530547017;
        Sat, 17 Jul 2021 07:02:27 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p10sm5275610qkp.48.2021.07.17.07.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jul 2021 07:02:26 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 17 Jul 2021 07:02:24 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Martin =?iso-8859-1?Q?Hundeb=F8ll?= <martin@geanix.com>
Cc:     Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
        Jean Delvare <jdelvare@suse.com>,
        Mark Brown <broonie@kernel.org>,
        Martin =?iso-8859-1?Q?Hundeb=F8ll?= <mhu@silicom.dk>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH v5 3/3] hwmon: intel-m10-bmc-hwmon: add n5010 sensors
Message-ID: <20210717140224.GA800550@roeck-us.net>
References: <20210716135441.3235863-1-martin@geanix.com>
 <20210716135441.3235863-4-martin@geanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210716135441.3235863-4-martin@geanix.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Fri, Jul 16, 2021 at 03:54:41PM +0200, Martin Hundebøll wrote:
> From: Martin Hundebøll <mhu@silicom.dk>
> 
> Add the list of sensors supported by the Silicom n5010 PAC, and enable
> the drivers as a subtype of the intel-m10-bmc multi-function driver.
> 
> Signed-off-by: Martin Hundebøll <mhu@silicom.dk>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> Reviewed-by: Moritz Fischer <mdf@kernel.org>
> Reviewed-by: Xu Yilun <yilun.xu@intel.com>

The context patches have been applied, so I applied this patch as well
to hwmon-next.

Guenter

> ---
> 
> Changes since v4:
>  * None
> 
> Changes since v3:
>  * None
> 
> Changes since v2:
>  * Added Yilun's Reviewed-by
>  * Added Moritz' Reviewed-by
>  * Added Guenter's Reviewed-by
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
