Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C07FC35498B
	for <lists+linux-fpga@lfdr.de>; Tue,  6 Apr 2021 02:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232686AbhDFADw (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 5 Apr 2021 20:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231544AbhDFADw (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 5 Apr 2021 20:03:52 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F945C06174A;
        Mon,  5 Apr 2021 17:03:45 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id w21-20020a9d63950000b02901ce7b8c45b4so12970520otk.5;
        Mon, 05 Apr 2021 17:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Mop3t/gayCivwWkXvjHrWHHgFOa0P9xBtC5TJrJX3fY=;
        b=HfAtcrFN20ha8/lC5u/lcFrjP2coZWKABboWUA/M32w+1G3aYvmPJbQ0WNERLSqW3V
         mPK8T5W5vIE6HAGuf0qkAsutyoe+s9BtWERkCHPdkbpM2dOKS2PbdS39R2fqK6tBHvZn
         dxm/z9JwJq1NkRDxOtD8TpV+hljSP967FeUaLt8fZJy1Ze3mFMs1B3abzo+hqd7fztRr
         nMEmbg5CLytSKWdX6N4jVk8ZRkZSDzwX/7nLXK26TxHkV4+55haczKDKDGAFidRiD5aO
         tqPDEuz2ggyGvBBucz+3bMkaHoSJxe4l7BTaswgbIyFM1Dor0VBYPxjRm4Lpz3neBGZ4
         J0AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Mop3t/gayCivwWkXvjHrWHHgFOa0P9xBtC5TJrJX3fY=;
        b=L76tMPoxyjjTloSw/DNLDK4KQBO1NWdkhoGqJ3OMYe8ZriyUAnLkSQ51pEGjq41dbW
         slQ3BX/zbTj8JtoTIWfpVqHExbWur91T3TkzaOH7ge0AojtlyzMg7utxA54DIbKhhoA9
         jd1SVl0K9IiKthYbEJXgQr1wLrnW/ZGYaWx3i7xJUz0CyiaR3waqPOWvMedETOBFCLDA
         /8bSpOrVjxCI2otXiepfG4dl474p3Vjf0iv09D3ndojRsZNJ+IF1P45ftfaIvwppBhTq
         X/zKBUzJp1YZLV4eDYOJCyHMMd1mjePqndA1oSgjvkRVC/Hg4Ef77QGxwoP7qmVeSeP+
         Pbqw==
X-Gm-Message-State: AOAM532AyVx6l3puVgnVkFOkMhW9wM3Z8Yt6eKuGEQ5EdCLzDP/TJohD
        Vm4BGEDGnddS/xtk4ujFnLA=
X-Google-Smtp-Source: ABdhPJzRK8WaNDNPhzfA3Eo08iVnh41hRM0P22PZQlft8ZdlaS0YGCYQWk/soPKb1AAOubcVnQgskw==
X-Received: by 2002:a9d:1c89:: with SMTP id l9mr24483896ota.25.1617667424724;
        Mon, 05 Apr 2021 17:03:44 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g61sm4272606otb.65.2021.04.05.17.03.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Apr 2021 17:03:43 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH 3/3] hwmon: intel-m10-bmc-hwmon: add sensor support of
 Intel D5005 card
To:     matthew.gerlach@linux.intel.com, hao.wu@intel.com, trix@redhat.com,
        mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, yilun.xu@intel.com,
        jdelvare@suse.com, lee.jones@linaro.org,
        linux-hwmon@vger.kernel.org, russell.h.weight@linux.intel.com
References: <20210405235301.187542-1-matthew.gerlach@linux.intel.com>
 <20210405235301.187542-4-matthew.gerlach@linux.intel.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <2bafe404-c708-a1eb-6584-2345225282dc@roeck-us.net>
Date:   Mon, 5 Apr 2021 17:03:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210405235301.187542-4-matthew.gerlach@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 4/5/21 4:53 PM, matthew.gerlach@linux.intel.com wrote:
> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> 
> Like the Intel N3000 card, the Intel D5005 has a MAX10 based
> BMC.  This commit adds support for the D5005 sensors that are
> monitored by the MAX10 BMC.
> 
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> Signed-off-by: Russ Weight <russell.h.weight@linux.intel.com>
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

It may be better to split this patch into two parts to simplify
its review and scope of responsibility.

Guenter

> index 1161933..dbb4975 100644
> --- a/drivers/mfd/intel-m10-bmc.c
> +++ b/drivers/mfd/intel-m10-bmc.c
> @@ -15,6 +15,11 @@
>  
>  enum m10bmc_type {
>  	M10_N3000,
> +	M10_D5005
> +};
> +
> +static struct mfd_cell m10bmc_bmc_subdevs[] = {
> +	{ .name = "d5005bmc-hwmon" },
>  };
>  
>  static struct mfd_cell m10bmc_pacn3000_subdevs[] = {
> @@ -183,6 +188,10 @@ static int intel_m10_bmc_spi_probe(struct spi_device *spi)
>  		cells = m10bmc_pacn3000_subdevs;
>  		n_cell = ARRAY_SIZE(m10bmc_pacn3000_subdevs);
>  		break;
> +	case M10_D5005:
> +		cells = m10bmc_bmc_subdevs;
> +		n_cell = ARRAY_SIZE(m10bmc_bmc_subdevs);
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
> 

