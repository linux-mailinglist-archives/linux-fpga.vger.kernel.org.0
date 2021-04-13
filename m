Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4124935E988
	for <lists+linux-fpga@lfdr.de>; Wed, 14 Apr 2021 01:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347820AbhDMXLw (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 13 Apr 2021 19:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232517AbhDMXLv (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 13 Apr 2021 19:11:51 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C45C061574;
        Tue, 13 Apr 2021 16:11:31 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id d3-20020a9d29030000b029027e8019067fso15768090otb.13;
        Tue, 13 Apr 2021 16:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=D/nsAOP6P3wyUX5B/9lLlJTqvWKWmrSRu43xTW8RyS0=;
        b=aeAWkYyAFe+etsxTV7kGg/Yh4JsEN6AvbNxT8v7t5DaabFe0hwozO/UPQmpp5mCi5l
         avAM8/beC1+KBuJHmZKc1BXT+I3INHgC8cylmSOUCLD+qeJ71j8/VGubEDKT4e6Kkx/Y
         d/uvx2gvGH+HFZ95M6SqdRMbeoOzGLsJp0KNDn8hsuVQl4Ozwx8Z2IWWcxnZ6WjAzxmf
         KckKMvIPnP1UqgjEirY/DVXeHw25tq09AOJcRmx5uUefROCBp1ZgJFbk/gVhse5L2mKn
         Qtut8dKXHRp5OBa2AAZ6k0NLac73hK1R6TMnDndC6tkqRKyVGFVUCspmis8Jxp+5yQ6W
         tqRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=D/nsAOP6P3wyUX5B/9lLlJTqvWKWmrSRu43xTW8RyS0=;
        b=jIaDWp/vWoGyw+n+wnMmhDOnEkDi1d6k/x6WgpvVASq7siwy986ctFgCOYF7qmQobW
         p5BKCarZhXFCEx9Q5zjoGlHGE9Py7HxcktH+s/mvCiJFhiT3u3I/ZBGclFTxZ48TxsnW
         92xlgfzpFZKaojIRX5+1Hd/EPERTqYjCFruv8JmlukErb57ufZK/6DSIzkSffrTtVsTO
         3Lnvd9KVj32BHbRGm+wE9f+gIy/LGpLiaw7xQuy/jvHKsgNh8STi1hYUF7onWS+SwPy0
         W3s977lLeZappbtQFOvfBVekj0dthNu4Lxn2xJtY6Jef1FtD3sIF2iQCd/U1rjhq9xFc
         io2g==
X-Gm-Message-State: AOAM531kDoIpJGduIXn+8L/iivmSDPuCuwYPajXe4JUA3nElkxkhhNJ2
        5aveWepuPUCvwU6Y5IraoJhyo2sRVMI=
X-Google-Smtp-Source: ABdhPJy8byrme0loYU0UXKYPvEQPv8Yu8ePmX12D72J8lEczsFC4566hO4frKalzKW0KCjQQYTRrAQ==
X-Received: by 2002:a9d:12e:: with SMTP id 43mr6873060otu.90.1618355490776;
        Tue, 13 Apr 2021 16:11:30 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w24sm1838149otj.33.2021.04.13.16.11.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Apr 2021 16:11:30 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 13 Apr 2021 16:11:29 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     matthew.gerlach@linux.intel.com
Cc:     hao.wu@intel.com, trix@redhat.com, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        yilun.xu@intel.com, jdelvare@suse.com, lee.jones@linaro.org,
        linux-hwmon@vger.kernel.org, russell.h.weight@intel.com,
        broonie@kernel.org, linux-spi@vger.kernel.org,
        Russ Weight <russell.h.weight@linux.intel.com>
Subject: Re: [PATCH v2 2/2] hwmon: intel-m10-bmc-hwmon: add sensor support of
 Intel D5005 card
Message-ID: <20210413231129.GA233651@roeck-us.net>
References: <20210413225835.459662-1-matthew.gerlach@linux.intel.com>
 <20210413225835.459662-3-matthew.gerlach@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210413225835.459662-3-matthew.gerlach@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Apr 13, 2021 at 03:58:35PM -0700, matthew.gerlach@linux.intel.com wrote:
> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> 
> Like the Intel N3000 card, the Intel D5005 has a MAX10 based
> BMC.  This commit adds support for the D5005 sensors that are
> monitored by the MAX10 BMC.
> 
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> Signed-off-by: Russ Weight <russell.h.weight@linux.intel.com>
> Acked-by: Lee Jones <lee.jones@linaro.org>

Applied to hwmon-next.

Thanks,
Guenter

> ---
> v2: change variable name from m10bmc_bmc_subdevs to m10bmc_d5005_subdevs
>     added Acked-by: Lee Jones
> ---
>  drivers/hwmon/intel-m10-bmc-hwmon.c | 122 ++++++++++++++++++++++++++++++++++++
>  drivers/mfd/intel-m10-bmc.c         |  10 +++
>  2 files changed, 132 insertions(+)
> 
> diff --git a/drivers/hwmon/intel-m10-bmc-hwmon.c b/drivers/hwmon/intel-m10-bmc-hwmon.c
> index 17d5e6b..bd7ed2e 100644
> --- a/drivers/hwmon/intel-m10-bmc-hwmon.c
> +++ b/drivers/hwmon/intel-m10-bmc-hwmon.c
> @@ -99,6 +99,50 @@ struct m10bmc_hwmon {
>  	NULL
>  };
>  
> +static const struct m10bmc_sdata d5005bmc_temp_tbl[] = {
> +	{ 0x100, 0x104, 0x108, 0x10c, 0x0, 500, "Board Inlet Air Temperature" },
> +	{ 0x110, 0x114, 0x118, 0x0, 0x0, 500, "FPGA Core Temperature" },
> +	{ 0x11c, 0x120, 0x124, 0x128, 0x0, 500, "Board Exhaust Air Temperature" },
> +	{ 0x12c, 0x130, 0x134, 0x0, 0x0, 500, "FPGA Transceiver Temperature" },
> +	{ 0x138, 0x13c, 0x140, 0x144, 0x0, 500, "RDIMM0 Temperature" },
> +	{ 0x148, 0x14c, 0x150, 0x154, 0x0, 500, "RDIMM1 Temperature" },
> +	{ 0x158, 0x15c, 0x160, 0x164, 0x0, 500, "RDIMM2 Temperature" },
> +	{ 0x168, 0x16c, 0x170, 0x174, 0x0, 500, "RDIMM3 Temperature" },
> +	{ 0x178, 0x17c, 0x180, 0x0, 0x0, 500, "QSFP0 Temperature" },
> +	{ 0x188, 0x18c, 0x190, 0x0, 0x0, 500, "QSFP1 Temperature" },
> +	{ 0x1a0, 0x1a4, 0x1a8, 0x0, 0x0, 500, "3.3v Temperature" },
> +	{ 0x1bc, 0x1c0, 0x1c4, 0x0, 0x0, 500, "VCCERAM Temperature" },
> +	{ 0x1d8, 0x1dc, 0x1e0, 0x0, 0x0, 500, "VCCR Temperature" },
> +	{ 0x1f4, 0x1f8, 0x1fc, 0x0, 0x0, 500, "VCCT Temperature" },
> +	{ 0x210, 0x214, 0x218, 0x0, 0x0, 500, "1.8v Temperature" },
> +	{ 0x22c, 0x230, 0x234, 0x0, 0x0, 500, "12v Backplane Temperature" },
> +	{ 0x248, 0x24c, 0x250, 0x0, 0x0, 500, "12v AUX Temperature" },
> +};
> +
> +static const struct m10bmc_sdata d5005bmc_in_tbl[] = {
> +	{ 0x184, 0x0, 0x0, 0x0, 0x0, 1, "QSFP0 Supply Voltage" },
> +	{ 0x194, 0x0, 0x0, 0x0, 0x0, 1, "QSFP1 Supply Voltage" },
> +	{ 0x198, 0x0, 0x0, 0x0, 0x0, 1, "FPGA Core Voltage" },
> +	{ 0x1ac, 0x1b0, 0x1b4, 0x0, 0x0, 1, "3.3v Voltage" },
> +	{ 0x1c8, 0x1cc, 0x1d0, 0x0, 0x0, 1, "VCCERAM Voltage" },
> +	{ 0x1e4, 0x1e8, 0x1ec, 0x0, 0x0, 1, "VCCR Voltage" },
> +	{ 0x200, 0x204, 0x208, 0x0, 0x0, 1, "VCCT Voltage" },
> +	{ 0x21c, 0x220, 0x224, 0x0, 0x0, 1, "1.8v Voltage" },
> +	{ 0x238, 0x0, 0x0, 0x0, 0x23c, 1, "12v Backplane Voltage" },
> +	{ 0x254, 0x0, 0x0, 0x0, 0x258, 1, "12v AUX Voltage" },
> +};
> +
> +static const struct m10bmc_sdata d5005bmc_curr_tbl[] = {
> +	{ 0x19c, 0x0, 0x0, 0x0, 0x0, 1, "FPGA Core Current" },
> +	{ 0x1b8, 0x0, 0x0, 0x0, 0x0, 1, "3.3v Current" },
> +	{ 0x1d4, 0x0, 0x0, 0x0, 0x0, 1, "VCCERAM Current" },
> +	{ 0x1f0, 0x0, 0x0, 0x0, 0x0, 1, "VCCR Current" },
> +	{ 0x20c, 0x0, 0x0, 0x0, 0x0, 1, "VCCT Current" },
> +	{ 0x228, 0x0, 0x0, 0x0, 0x0, 1, "1.8v Current" },
> +	{ 0x240, 0x244, 0x0, 0x0, 0x0, 1, "12v Backplane Current" },
> +	{ 0x25c, 0x260, 0x0, 0x0, 0x0, 1, "12v AUX Current" },
> +};
> +
>  static const struct m10bmc_hwmon_board_data n3000bmc_hwmon_bdata = {
>  	.tables = {
>  		[hwmon_temp] = n3000bmc_temp_tbl,
> @@ -110,6 +154,80 @@ struct m10bmc_hwmon {
>  	.hinfo = n3000bmc_hinfo,
>  };
>  
> +static const struct hwmon_channel_info *d5005bmc_hinfo[] = {
> +	HWMON_CHANNEL_INFO(temp,
> +			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_MAX_HYST |
> +			   HWMON_T_CRIT | HWMON_T_CRIT_HYST | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_CRIT |
> +			   HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_MAX_HYST |
> +			   HWMON_T_CRIT | HWMON_T_CRIT_HYST | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_CRIT |
> +			   HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_MAX_HYST |
> +			   HWMON_T_CRIT | HWMON_T_CRIT_HYST | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_MAX_HYST |
> +			   HWMON_T_CRIT | HWMON_T_CRIT_HYST | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_MAX_HYST |
> +			   HWMON_T_CRIT | HWMON_T_CRIT_HYST | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_MAX_HYST |
> +			   HWMON_T_CRIT | HWMON_T_CRIT_HYST | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_CRIT |
> +			   HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_CRIT |
> +			   HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_CRIT |
> +			   HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_CRIT |
> +			   HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_CRIT |
> +			   HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_CRIT |
> +			   HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_CRIT |
> +			   HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_CRIT |
> +			   HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_CRIT |
> +			   HWMON_T_LABEL),
> +	HWMON_CHANNEL_INFO(in,
> +			   HWMON_I_INPUT | HWMON_I_LABEL,
> +			   HWMON_I_INPUT | HWMON_I_LABEL,
> +			   HWMON_I_INPUT | HWMON_I_LABEL,
> +			   HWMON_I_INPUT | HWMON_I_MAX | HWMON_I_CRIT |
> +			   HWMON_I_LABEL,
> +			   HWMON_I_INPUT | HWMON_I_MAX | HWMON_I_CRIT |
> +			   HWMON_I_LABEL,
> +			   HWMON_I_INPUT | HWMON_I_MAX | HWMON_I_CRIT |
> +			   HWMON_I_LABEL,
> +			   HWMON_I_INPUT | HWMON_I_MAX | HWMON_I_CRIT |
> +			   HWMON_I_LABEL,
> +			   HWMON_I_INPUT | HWMON_I_MAX | HWMON_I_CRIT |
> +			   HWMON_I_LABEL,
> +			   HWMON_I_INPUT | HWMON_I_MIN | HWMON_I_LABEL,
> +			   HWMON_I_INPUT | HWMON_I_MIN | HWMON_I_LABEL),
> +	HWMON_CHANNEL_INFO(curr,
> +			   HWMON_C_INPUT | HWMON_C_LABEL,
> +			   HWMON_C_INPUT | HWMON_C_LABEL,
> +			   HWMON_C_INPUT | HWMON_C_LABEL,
> +			   HWMON_C_INPUT | HWMON_C_LABEL,
> +			   HWMON_C_INPUT | HWMON_C_LABEL,
> +			   HWMON_C_INPUT | HWMON_C_LABEL,
> +			   HWMON_C_INPUT | HWMON_C_MAX | HWMON_C_LABEL,
> +			   HWMON_C_INPUT | HWMON_C_MAX | HWMON_C_LABEL),
> +	NULL
> +};
> +
> +static const struct m10bmc_hwmon_board_data d5005bmc_hwmon_bdata = {
> +	.tables = {
> +		[hwmon_temp] = d5005bmc_temp_tbl,
> +		[hwmon_in] = d5005bmc_in_tbl,
> +		[hwmon_curr] = d5005bmc_curr_tbl,
> +	},
> +
> +	.hinfo = d5005bmc_hinfo,
> +};
> +
>  static umode_t
>  m10bmc_hwmon_is_visible(const void *data, enum hwmon_sensor_types type,
>  			u32 attr, int channel)
> @@ -316,6 +434,10 @@ static int m10bmc_hwmon_probe(struct platform_device *pdev)
>  		.name = "n3000bmc-hwmon",
>  		.driver_data = (unsigned long)&n3000bmc_hwmon_bdata,
>  	},
> +	{
> +		.name = "d5005bmc-hwmon",
> +		.driver_data = (unsigned long)&d5005bmc_hwmon_bdata,
> +	},
>  	{ }
>  };
>  
> diff --git a/drivers/mfd/intel-m10-bmc.c b/drivers/mfd/intel-m10-bmc.c
> index 1161933..1a9bfb7 100644
> --- a/drivers/mfd/intel-m10-bmc.c
> +++ b/drivers/mfd/intel-m10-bmc.c
> @@ -15,6 +15,11 @@
>  
>  enum m10bmc_type {
>  	M10_N3000,
> +	M10_D5005
> +};
> +
> +static struct mfd_cell m10bmc_d5005_subdevs[] = {
> +	{ .name = "d5005bmc-hwmon" },
>  };
>  
>  static struct mfd_cell m10bmc_pacn3000_subdevs[] = {
> @@ -183,6 +188,10 @@ static int intel_m10_bmc_spi_probe(struct spi_device *spi)
>  		cells = m10bmc_pacn3000_subdevs;
>  		n_cell = ARRAY_SIZE(m10bmc_pacn3000_subdevs);
>  		break;
> +	case M10_D5005:
> +		cells = m10bmc_d5005_subdevs;
> +		n_cell = ARRAY_SIZE(m10bmc_d5005_subdevs);
> +		break;
>  	default:
>  		return -ENODEV;
>  	}
> @@ -197,6 +206,7 @@ static int intel_m10_bmc_spi_probe(struct spi_device *spi)
>  
>  static const struct spi_device_id m10bmc_spi_id[] = {
>  	{ "m10-n3000", M10_N3000 },
> +	{ "m10-d5005", M10_D5005 },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(spi, m10bmc_spi_id);
