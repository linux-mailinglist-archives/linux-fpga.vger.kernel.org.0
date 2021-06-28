Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A90D3B5FB2
	for <lists+linux-fpga@lfdr.de>; Mon, 28 Jun 2021 16:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232251AbhF1ONp (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 28 Jun 2021 10:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbhF1ONl (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 28 Jun 2021 10:13:41 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BDEFC061574;
        Mon, 28 Jun 2021 07:11:14 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id g19-20020a9d12930000b0290457fde18ad0so18880082otg.1;
        Mon, 28 Jun 2021 07:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NCy8SzHtVsTms8W2cCZWxIt9IklFt3RTVjERxFKBJRU=;
        b=QTI2Djox7MRIV5xmVdooXf1riXKjlPe55adOU+BbFPijCaVTewXZ5ie4xVJsUrdcBD
         cJlaDQ0G3jnRQLLI4ucg9LiqJXoFUL6UF2TdwnGnGtzNPK8lFvgToLswQ41VZ24yv2nQ
         APiWED5RrVS3FU+JaP99TaMMnWbx8swi1+T9I0Lzqyuw36K+MEEdXeqT+yN1Kbe+8u+q
         Nvw+TC7qW+mR340aPPwnhXKV/asgsrjefMugWibYblLQo+twZx0UsIDpXi6EuogG+xfL
         dTLM/fXncBQegCh1l/jxYY4BheYzmt3HHt6EhczL8on3MfoCQ1m6Yu56FxKx5ukPt4Fc
         1DyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NCy8SzHtVsTms8W2cCZWxIt9IklFt3RTVjERxFKBJRU=;
        b=WPjwoopFWCThGGc2zUtG1I+/X9nzblPj89TLdmFbB1c/j+4s1/Esb6SnTxRCbbaYgH
         dfgfQBHVNh/FRY66RogItNnKDrNPoAEM+gU+k3jiAhT3ZYOeLST27S1ok+Pekfs907ho
         IUp7mTNDmzjTeIHmkKquf1LezmUjtrDNK0h7TqVoDEZ46wQ5j+Ux21mt3pQguVBDST74
         DXQqDGtZfD5iMUM5Zeta2bYt6qDtsy19aeV2ob0YfG8DB2tlNJ1L4k7+r86coyYnItES
         J0cKlwFvtx5fgSptByg8hzWhxYcar2onSAi351RLoJjoBEW6ZrZKOwiFvVvTC2njaInR
         VOeA==
X-Gm-Message-State: AOAM532mZSzD+F47bE8Y71L7dmjX9GI9Yb6NCgUC+VLYVyn3TUlVK6u3
        jCDFCkKssggICvSK8d1LV2qDGRP14X0=
X-Google-Smtp-Source: ABdhPJz/RXKT8x97KI9wifUr08T/FRV419WzdifSJDubUxN/tao0sXxCDyEYw9FcL+YvC+iV0ip2Tw==
X-Received: by 2002:a9d:5c14:: with SMTP id o20mr20880765otk.328.1624889472363;
        Mon, 28 Jun 2021 07:11:12 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r204sm3120937oih.11.2021.06.28.07.11.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jun 2021 07:11:11 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v2 5/5] hwmon: intel-m10-bmc-hwmon: add n5010 sensors
To:     Xu Yilun <yilun.xu@intel.com>,
        =?UTF-8?Q?Martin_Hundeb=c3=b8ll?= <martin@geanix.com>
Cc:     Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        =?UTF-8?Q?Martin_Hundeb=c3=b8ll?= <mhu@silicom.dk>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-spi@vger.kernel.org
References: <20210625074213.654274-1-martin@geanix.com>
 <20210625074213.654274-6-martin@geanix.com>
 <20210628060019.GE72330@yilunxu-OptiPlex-7050>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <6cb3b8cb-35dc-7279-cda2-0a2300aa959a@roeck-us.net>
Date:   Mon, 28 Jun 2021 07:11:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210628060019.GE72330@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 6/27/21 11:00 PM, Xu Yilun wrote:
> It is good to me.
> 

As already pointed out, please don't top-post, and provide a
formal Reviewed-by: or Acked-by: tag.

Thanks,
Guenter

> On Fri, Jun 25, 2021 at 09:42:13AM +0200, Martin Hundebøll wrote:
>> From: Martin Hundebøll <mhu@silicom.dk>
>>
>> Add the list of sensors supported by the Silicom n5010 PAC, and enable
>> the drivers as a subtype of the intel-m10-bmc multi-function driver.
>>
>> Signed-off-by: Martin Hundebøll <mhu@silicom.dk>
>> ---
>>
>> Changes since v1:
>>   * Patch split out to separate hwmon changes
>>
>>   drivers/hwmon/intel-m10-bmc-hwmon.c | 116 ++++++++++++++++++++++++++++
>>   1 file changed, 116 insertions(+)
>>
>> diff --git a/drivers/hwmon/intel-m10-bmc-hwmon.c b/drivers/hwmon/intel-m10-bmc-hwmon.c
>> index bd7ed2ed3a1e..7a08e4c44a4b 100644
>> --- a/drivers/hwmon/intel-m10-bmc-hwmon.c
>> +++ b/drivers/hwmon/intel-m10-bmc-hwmon.c
>> @@ -228,6 +228,118 @@ static const struct m10bmc_hwmon_board_data d5005bmc_hwmon_bdata = {
>>   	.hinfo = d5005bmc_hinfo,
>>   };
>>   
>> +static const struct m10bmc_sdata n5010bmc_temp_tbl[] = {
>> +	{ 0x100, 0x0, 0x104, 0x0, 0x0, 1000, "Board Local Temperature" },
>> +	{ 0x108, 0x0, 0x10c, 0x0, 0x0, 1000, "FPGA 1 Temperature" },
>> +	{ 0x110, 0x0, 0x114, 0x0, 0x0, 1000, "FPGA 2 Temperature" },
>> +	{ 0x118, 0x0, 0x0, 0x0, 0x0, 1000, "Card Top Temperature" },
>> +	{ 0x11c, 0x0, 0x0, 0x0, 0x0, 1000, "Card Bottom Temperature" },
>> +	{ 0x128, 0x0, 0x0, 0x0, 0x0, 1000, "FPGA 1.2V Temperature" },
>> +	{ 0x134, 0x0, 0x0, 0x0, 0x0, 1000, "FPGA 5V Temperature" },
>> +	{ 0x140, 0x0, 0x0, 0x0, 0x0, 1000, "FPGA 0.9V Temperature" },
>> +	{ 0x14c, 0x0, 0x0, 0x0, 0x0, 1000, "FPGA 0.85V Temperature" },
>> +	{ 0x158, 0x0, 0x0, 0x0, 0x0, 1000, "AUX 12V Temperature" },
>> +	{ 0x164, 0x0, 0x0, 0x0, 0x0, 1000, "Backplane 12V Temperature" },
>> +	{ 0x1a8, 0x0, 0x0, 0x0, 0x0, 1000, "QSFP28-1 Temperature" },
>> +	{ 0x1ac, 0x0, 0x0, 0x0, 0x0, 1000, "QSFP28-2 Temperature" },
>> +	{ 0x1b0, 0x0, 0x0, 0x0, 0x0, 1000, "QSFP28-3 Temperature" },
>> +	{ 0x1b4, 0x0, 0x0, 0x0, 0x0, 1000, "QSFP28-4 Temperature" },
>> +	{ 0x1b8, 0x0, 0x0, 0x0, 0x0, 1000, "CVL1 Internal Temperature" },
>> +	{ 0x1bc, 0x0, 0x0, 0x0, 0x0, 1000, "CVL2 Internal Temperature" },
>> +};
>> +
>> +static const struct m10bmc_sdata n5010bmc_in_tbl[] = {
>> +	{ 0x120, 0x0, 0x0, 0x0, 0x0, 1, "FPGA 1.2V Voltage" },
>> +	{ 0x12c, 0x0, 0x0, 0x0, 0x0, 1, "FPGA 5V Voltage" },
>> +	{ 0x138, 0x0, 0x0, 0x0, 0x0, 1, "FPGA 0.9V Voltage" },
>> +	{ 0x144, 0x0, 0x0, 0x0, 0x0, 1, "FPGA 0.85V Voltage" },
>> +	{ 0x150, 0x0, 0x0, 0x0, 0x0, 1, "AUX 12V Voltage" },
>> +	{ 0x15c, 0x0, 0x0, 0x0, 0x0, 1, "Backplane 12V Voltage" },
>> +	{ 0x16c, 0x0, 0x0, 0x0, 0x0, 1, "DDR4 1.2V Voltage" },
>> +	{ 0x17c, 0x0, 0x0, 0x0, 0x0, 1, "FPGA 1.8V Voltage" },
>> +	{ 0x184, 0x0, 0x0, 0x0, 0x0, 1, "QDR 1.3V Voltage" },
>> +	{ 0x18c, 0x0, 0x0, 0x0, 0x0, 1, "CVL1 0.8V Voltage" },
>> +	{ 0x194, 0x0, 0x0, 0x0, 0x0, 1, "CVL1 1.05V Voltage" },
>> +	{ 0x19c, 0x0, 0x0, 0x0, 0x0, 1, "CVL2 1.05V Voltage" },
>> +	{ 0x1a4, 0x0, 0x0, 0x0, 0x0, 1, "CVL2 0.8V Voltage" },
>> +};
>> +
>> +static const struct m10bmc_sdata n5010bmc_curr_tbl[] = {
>> +	{ 0x124, 0x0, 0x0, 0x0, 0x0, 1, "FPGA 1.2V Current" },
>> +	{ 0x130, 0x0, 0x0, 0x0, 0x0, 1, "FPGA 5V Current" },
>> +	{ 0x13c, 0x0, 0x0, 0x0, 0x0, 1, "FPGA 0.9V Current" },
>> +	{ 0x148, 0x0, 0x0, 0x0, 0x0, 1, "FPGA 0.85V Current" },
>> +	{ 0x154, 0x0, 0x0, 0x0, 0x0, 1, "AUX 12V Current" },
>> +	{ 0x160, 0x0, 0x0, 0x0, 0x0, 1, "Backplane 12V Current" },
>> +	{ 0x168, 0x0, 0x0, 0x0, 0x0, 1, "DDR4 1.2V Current" },
>> +	{ 0x178, 0x0, 0x0, 0x0, 0x0, 1, "FPGA 1.8V Current" },
>> +	{ 0x180, 0x0, 0x0, 0x0, 0x0, 1, "QDR 1.3V Current" },
>> +	{ 0x188, 0x0, 0x0, 0x0, 0x0, 1, "CVL1 0.8V Current" },
>> +	{ 0x190, 0x0, 0x0, 0x0, 0x0, 1, "CVL1 1.05V Current" },
>> +	{ 0x198, 0x0, 0x0, 0x0, 0x0, 1, "CVL2 1.05V Current" },
>> +	{ 0x1a0, 0x0, 0x0, 0x0, 0x0, 1, "CVL2 0.8V Current" },
>> +};
>> +
>> +static const struct hwmon_channel_info *n5010bmc_hinfo[] = {
>> +	HWMON_CHANNEL_INFO(temp,
>> +			   HWMON_T_INPUT | HWMON_T_CRIT | HWMON_T_LABEL,
>> +			   HWMON_T_INPUT | HWMON_T_CRIT | HWMON_T_LABEL,
>> +			   HWMON_T_INPUT | HWMON_T_CRIT | HWMON_T_LABEL,
>> +			   HWMON_T_INPUT | HWMON_T_LABEL,
>> +			   HWMON_T_INPUT | HWMON_T_LABEL,
>> +			   HWMON_T_INPUT | HWMON_T_LABEL,
>> +			   HWMON_T_INPUT | HWMON_T_LABEL,
>> +			   HWMON_T_INPUT | HWMON_T_LABEL,
>> +			   HWMON_T_INPUT | HWMON_T_LABEL,
>> +			   HWMON_T_INPUT | HWMON_T_LABEL,
>> +			   HWMON_T_INPUT | HWMON_T_LABEL,
>> +			   HWMON_T_INPUT | HWMON_T_LABEL,
>> +			   HWMON_T_INPUT | HWMON_T_LABEL,
>> +			   HWMON_T_INPUT | HWMON_T_LABEL,
>> +			   HWMON_T_INPUT | HWMON_T_LABEL,
>> +			   HWMON_T_INPUT | HWMON_T_LABEL,
>> +			   HWMON_T_INPUT | HWMON_T_LABEL),
>> +	HWMON_CHANNEL_INFO(in,
>> +			   HWMON_I_INPUT | HWMON_I_LABEL,
>> +			   HWMON_I_INPUT | HWMON_I_LABEL,
>> +			   HWMON_I_INPUT | HWMON_I_LABEL,
>> +			   HWMON_I_INPUT | HWMON_I_LABEL,
>> +			   HWMON_I_INPUT | HWMON_I_LABEL,
>> +			   HWMON_I_INPUT | HWMON_I_LABEL,
>> +			   HWMON_I_INPUT | HWMON_I_LABEL,
>> +			   HWMON_I_INPUT | HWMON_I_LABEL,
>> +			   HWMON_I_INPUT | HWMON_I_LABEL,
>> +			   HWMON_I_INPUT | HWMON_I_LABEL,
>> +			   HWMON_I_INPUT | HWMON_I_LABEL,
>> +			   HWMON_I_INPUT | HWMON_I_LABEL,
>> +			   HWMON_I_INPUT | HWMON_I_LABEL),
>> +	HWMON_CHANNEL_INFO(curr,
>> +			   HWMON_C_INPUT | HWMON_C_LABEL,
>> +			   HWMON_C_INPUT | HWMON_C_LABEL,
>> +			   HWMON_C_INPUT | HWMON_C_LABEL,
>> +			   HWMON_C_INPUT | HWMON_C_LABEL,
>> +			   HWMON_C_INPUT | HWMON_C_LABEL,
>> +			   HWMON_C_INPUT | HWMON_C_LABEL,
>> +			   HWMON_C_INPUT | HWMON_C_LABEL,
>> +			   HWMON_C_INPUT | HWMON_C_LABEL,
>> +			   HWMON_C_INPUT | HWMON_C_LABEL,
>> +			   HWMON_C_INPUT | HWMON_C_LABEL,
>> +			   HWMON_C_INPUT | HWMON_C_LABEL,
>> +			   HWMON_C_INPUT | HWMON_C_LABEL,
>> +			   HWMON_C_INPUT | HWMON_C_LABEL),
>> +	NULL
>> +};
>> +
>> +static const struct m10bmc_hwmon_board_data n5010bmc_hwmon_bdata = {
>> +	.tables = {
>> +		[hwmon_temp] = n5010bmc_temp_tbl,
>> +		[hwmon_in] = n5010bmc_in_tbl,
>> +		[hwmon_curr] = n5010bmc_curr_tbl,
>> +	},
>> +
>> +	.hinfo = n5010bmc_hinfo,
>> +};
>> +
>>   static umode_t
>>   m10bmc_hwmon_is_visible(const void *data, enum hwmon_sensor_types type,
>>   			u32 attr, int channel)
>> @@ -438,6 +550,10 @@ static const struct platform_device_id intel_m10bmc_hwmon_ids[] = {
>>   		.name = "d5005bmc-hwmon",
>>   		.driver_data = (unsigned long)&d5005bmc_hwmon_bdata,
>>   	},
>> +	{
>> +		.name = "n5010bmc-hwmon",
>> +		.driver_data = (unsigned long)&n5010bmc_hwmon_bdata,
>> +	},
>>   	{ }
>>   };
>>   
>> -- 
>> 2.31.0

