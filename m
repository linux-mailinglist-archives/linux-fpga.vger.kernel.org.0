Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9C4F3B66DC
	for <lists+linux-fpga@lfdr.de>; Mon, 28 Jun 2021 18:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231743AbhF1Qi0 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 28 Jun 2021 12:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231734AbhF1Qi0 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 28 Jun 2021 12:38:26 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C927EC061574;
        Mon, 28 Jun 2021 09:35:58 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id i12-20020a05683033ecb02903346fa0f74dso19392916otu.10;
        Mon, 28 Jun 2021 09:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=SEFrvB4lNK1uv+L1kEqbUttA63rPtg4SqRdsqRkNxR0=;
        b=SdmAj+8M50qeuooFOqBSiKTI1eYBIJPgAhjnfwbpuqPuFq5Aks86ciFrQK67jZtbD7
         nneH2PwWNovGHUdLEOgFczgS0DHmV8m1hbSz1tH45NUnphYeomGI9raMXI8LMXPGEJSX
         Y2z41RHn48YgXwtnAm+Uwf9SyT1pZoVkkuXiWKyCDFpzFpb3RofMM50vsliFgSzI2Fdz
         YnD8E34WGqRKSO9Wl5Ua1kR1lZmC4oW1IdoFA/nRHo+c9W2WnVBm6zmrjO+kMV6Tm9D3
         kJYLaciASuahlp6gHaN90sAu4nAbVf064GPRL23uAQb+GukZPhy89ehFJ6DvX8YZLfCw
         eHMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=SEFrvB4lNK1uv+L1kEqbUttA63rPtg4SqRdsqRkNxR0=;
        b=e0Yo/Gh6e1TY6T/ltBSrBs7sq8/heSfPtLhKtiRLRvJtXwVKPoE+UC4BShuK3KJ9ta
         FVZuprG1Xv8tC5GQGhsA06Hk9gkQ8pSMAap0REa7STxJfqcKf+UTCzxMieWBNoxKDMm9
         zKS5JGbQzI7M7vHOdJjVPNWRJJgnqhaeCYodiizd3tFqFadzJtAPJhjjbxy/I5KuE6xT
         3YdZX23yTF/TwrMMkiKujRPFF+6seSsEmoG+RBc4fFJdz884kiTPOYW2eWdZ8y0yVuQ2
         fgFPUaitDYhXkTZXvhVN/FaSkxqIRHXiS3SfF0JsO7SM/lfzwFg1hjYhD2Ke6qdb9UOL
         0snQ==
X-Gm-Message-State: AOAM533em9X0ZL4Bq1LHB/dhLAQAK8J6FOWXxfHZulqanhGvjyGyBzOn
        0Az4ck9ea7/X0g6Z8E0c37Y=
X-Google-Smtp-Source: ABdhPJzTf47pyLSaDZ0ridJ7KaIluoX+RDqtU2UZQG0HsSj/bcq4OHSWmLx5p/vnCB5AC/gY54uvrQ==
X-Received: by 2002:a9d:554a:: with SMTP id h10mr381131oti.177.1624898157994;
        Mon, 28 Jun 2021 09:35:57 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d3sm1436778otl.57.2021.06.28.09.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 09:35:57 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 28 Jun 2021 09:35:56 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Martin =?iso-8859-1?Q?Hundeb=F8ll?= <martin@geanix.com>
Cc:     Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
        Jean Delvare <jdelvare@suse.com>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Martin =?iso-8859-1?Q?Hundeb=F8ll?= <mhu@silicom.dk>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH v2 5/5] hwmon: intel-m10-bmc-hwmon: add n5010 sensors
Message-ID: <20210628163556.GB445250@roeck-us.net>
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

On Fri, Jun 25, 2021 at 09:42:13AM +0200, Martin Hundebøll wrote:
> From: Martin Hundebøll <mhu@silicom.dk>
> 
> Add the list of sensors supported by the Silicom n5010 PAC, and enable
> the drivers as a subtype of the intel-m10-bmc multi-function driver.
> 
> Signed-off-by: Martin Hundebøll <mhu@silicom.dk>

For my reference:

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Not sure if I can apply this patch as-is to hwmon, or if it needs
to wait for the other patches in the series. Any thoughts / comments ?

Guenter

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
> 
