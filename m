Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6967A35F7EF
	for <lists+linux-fpga@lfdr.de>; Wed, 14 Apr 2021 17:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236853AbhDNPgd (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 14 Apr 2021 11:36:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29996 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233194AbhDNPgc (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 14 Apr 2021 11:36:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618414571;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Qx3/iLYPrCC/uAPin88FDvO6p98LMRUdvHQ9Rn3q//E=;
        b=TZFKkG+N90DBIehrGjQy5lGMVDe3/hUS8YISq/O3Nw9v9yeYvF79Qws1zRnqaFuhSJ53ff
        vXa/q6aqi/dW5V6zDFUUCqeq6fnsOzai4s6xHIK6p86tW/VkodIc9z5aDYmkC0d6sCXSsS
        Sbw4ndAaZV/JmSbwIOQWYJGZkpUgFBU=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-549-5T0NeIpRMlmFHlqJjYKWCA-1; Wed, 14 Apr 2021 11:36:09 -0400
X-MC-Unique: 5T0NeIpRMlmFHlqJjYKWCA-1
Received: by mail-qk1-f200.google.com with SMTP id c9so6598399qkm.11
        for <linux-fpga@vger.kernel.org>; Wed, 14 Apr 2021 08:36:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Qx3/iLYPrCC/uAPin88FDvO6p98LMRUdvHQ9Rn3q//E=;
        b=tTCtk8W65BsMrKgxzbubPKvolNNSIHeUoAUAUCzkNTuzjkBcE8wgHOcQHyZckERQho
         42iXBczxrSPyCBrWzm6HJUmOgvQdENllBqB95oXKah5jMXqGA0maS5+iFnI/rosakpvy
         8ozKf7TNuO5uVYXzIYzTZrplIZHSKfm00wnrkJkYTsr98I4T1CwcIsZBvJa4zS34QCpa
         kvTWaBUQifCzjJwmyqCqRgI+QzPKiYyilTR6V7AIiClDF8UB27fn7zSJxRQ9NC8tfEOu
         K8NOpphE+ZjXnblB3sUrgTKrvv9DyuseZGe8+jnDrL3cW2/L+np3G/tpopwY7+mDLN2N
         hmyg==
X-Gm-Message-State: AOAM533WEIRqCySqHJW2dk67hYkAIPSJ9dsw5Y2gh71bKHAh3ZdhLNqa
        kvMWbscQA3PvD0kDo755kNC1yOLoAypLVMHj6fCC2LgNvwJKSAr1cSuV1Kp/DOX9vh8K6gsCfj3
        AuLQgMyouK2vPyw8huLKkiw==
X-Received: by 2002:ac8:4802:: with SMTP id g2mr5361833qtq.210.1618414568976;
        Wed, 14 Apr 2021 08:36:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyVQwQDicZSgbLuYxjpagAqgn3QoywjmdVPa0hzhR27d7BS25kP7uXoSWCKwrKfVVF3ZEzWdg==
X-Received: by 2002:ac8:4802:: with SMTP id g2mr5361816qtq.210.1618414568756;
        Wed, 14 Apr 2021 08:36:08 -0700 (PDT)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id x82sm9743300qkb.0.2021.04.14.08.36.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Apr 2021 08:36:08 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] hwmon: intel-m10-bmc-hwmon: add sensor support of
 Intel D5005 card
To:     matthew.gerlach@linux.intel.com, hao.wu@intel.com, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        yilun.xu@intel.com, jdelvare@suse.com, linux@roeck-us.net,
        lee.jones@linaro.org, linux-hwmon@vger.kernel.org,
        russell.h.weight@intel.com, broonie@kernel.org,
        linux-spi@vger.kernel.org
Cc:     Russ Weight <russell.h.weight@linux.intel.com>
References: <20210413225835.459662-1-matthew.gerlach@linux.intel.com>
 <20210413225835.459662-3-matthew.gerlach@linux.intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <b2d402b9-0f48-b945-c47d-3fdb45a3cd45@redhat.com>
Date:   Wed, 14 Apr 2021 08:36:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210413225835.459662-3-matthew.gerlach@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 4/13/21 3:58 PM, matthew.gerlach@linux.intel.com wrote:
> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>
> Like the Intel N3000 card, the Intel D5005 has a MAX10 based
> BMC.  This commit adds support for the D5005 sensors that are
> monitored by the MAX10 BMC.
>
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> Signed-off-by: Russ Weight <russell.h.weight@linux.intel.com>
> Acked-by: Lee Jones <lee.jones@linaro.org>

lgtm

Reviewed-by: Tom Rix <trix@redhat.com>

> ---
> v2: change variable name from m10bmc_bmc_subdevs to m10bmc_d5005_subdevs
>      added Acked-by: Lee Jones
> ---
>   drivers/hwmon/intel-m10-bmc-hwmon.c | 122 ++++++++++++++++++++++++++++++++++++
>   drivers/mfd/intel-m10-bmc.c         |  10 +++
>   2 files changed, 132 insertions(+)
>
> diff --git a/drivers/hwmon/intel-m10-bmc-hwmon.c b/drivers/hwmon/intel-m10-bmc-hwmon.c
> index 17d5e6b..bd7ed2e 100644
> --- a/drivers/hwmon/intel-m10-bmc-hwmon.c
> +++ b/drivers/hwmon/intel-m10-bmc-hwmon.c
> @@ -99,6 +99,50 @@ struct m10bmc_hwmon {
>   	NULL
>   };
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
>   static const struct m10bmc_hwmon_board_data n3000bmc_hwmon_bdata = {
>   	.tables = {
>   		[hwmon_temp] = n3000bmc_temp_tbl,
> @@ -110,6 +154,80 @@ struct m10bmc_hwmon {
>   	.hinfo = n3000bmc_hinfo,
>   };
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
>   static umode_t
>   m10bmc_hwmon_is_visible(const void *data, enum hwmon_sensor_types type,
>   			u32 attr, int channel)
> @@ -316,6 +434,10 @@ static int m10bmc_hwmon_probe(struct platform_device *pdev)
>   		.name = "n3000bmc-hwmon",
>   		.driver_data = (unsigned long)&n3000bmc_hwmon_bdata,
>   	},
> +	{
> +		.name = "d5005bmc-hwmon",
> +		.driver_data = (unsigned long)&d5005bmc_hwmon_bdata,
> +	},
>   	{ }
>   };
>   
> diff --git a/drivers/mfd/intel-m10-bmc.c b/drivers/mfd/intel-m10-bmc.c
> index 1161933..1a9bfb7 100644
> --- a/drivers/mfd/intel-m10-bmc.c
> +++ b/drivers/mfd/intel-m10-bmc.c
> @@ -15,6 +15,11 @@
>   
>   enum m10bmc_type {
>   	M10_N3000,
> +	M10_D5005
> +};
> +
> +static struct mfd_cell m10bmc_d5005_subdevs[] = {
> +	{ .name = "d5005bmc-hwmon" },
>   };
>   
>   static struct mfd_cell m10bmc_pacn3000_subdevs[] = {
> @@ -183,6 +188,10 @@ static int intel_m10_bmc_spi_probe(struct spi_device *spi)
>   		cells = m10bmc_pacn3000_subdevs;
>   		n_cell = ARRAY_SIZE(m10bmc_pacn3000_subdevs);
>   		break;
> +	case M10_D5005:
> +		cells = m10bmc_d5005_subdevs;
> +		n_cell = ARRAY_SIZE(m10bmc_d5005_subdevs);
> +		break;
>   	default:
>   		return -ENODEV;
>   	}
> @@ -197,6 +206,7 @@ static int intel_m10_bmc_spi_probe(struct spi_device *spi)
>   
>   static const struct spi_device_id m10bmc_spi_id[] = {
>   	{ "m10-n3000", M10_N3000 },
> +	{ "m10-d5005", M10_D5005 },
>   	{ }
>   };
>   MODULE_DEVICE_TABLE(spi, m10bmc_spi_id);

