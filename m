Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C63E462116D
	for <lists+linux-fpga@lfdr.de>; Tue,  8 Nov 2022 13:51:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234152AbiKHMtr (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 8 Nov 2022 07:49:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233970AbiKHMtq (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 8 Nov 2022 07:49:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91DDC53ED1
        for <linux-fpga@vger.kernel.org>; Tue,  8 Nov 2022 04:48:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667911709;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QAiHLCB1b9Tp2kmiKlrL3PjLUEp05CS+ZW+ASsM00nw=;
        b=Z0s3eJ9YooEyhZtsvjgVjsUY4kiYWz4mZEiKulmsqJHQsF5ncXS1hEMbpgDG4uKR+6Rg6E
        lCZlK0/XKkeXVmmygoihVGX7GbS766Yp1eW5CkORNlUdY/RQdrhJ3EEtHN58EIkRAdZzj/
        KPg2hqP/DNDiEnlz+CjQla9lZo3d2Mk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-353-ew7rYKSRNhOlCJ0kOjb5yw-1; Tue, 08 Nov 2022 07:48:27 -0500
X-MC-Unique: ew7rYKSRNhOlCJ0kOjb5yw-1
Received: by mail-wr1-f71.google.com with SMTP id h18-20020adfa4d2000000b00236584fc8c7so3896302wrb.7
        for <linux-fpga@vger.kernel.org>; Tue, 08 Nov 2022 04:48:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QAiHLCB1b9Tp2kmiKlrL3PjLUEp05CS+ZW+ASsM00nw=;
        b=7LOec+lpHR6bReSBUFqX0JHfDCT1nWepOVgidhZFB0RyBfGflts10qKooL6ba7Z/FG
         N5+VnbMbjAk91Oc0pUUoupngZFCCIGzUucAvmH0NHEumMqkD2ukYVqs0D3/sLf23b8vR
         IH3vL83wnoj9yc9DfnosdmEEYvFM58ibIfECFjhrFYLoQtfixjpo8jFO+XTIKCn5uHV4
         NEuzQrvUivvo1tkN47DflCsHsvF9uiOm28oB9vE4srKnKGN2DVJ8I+4ZXAUlFXqP8Oxu
         XrN/l/pZW10Fkpe3V5DBTlstqTyWxzyxfIyZo+Svu14kxMd9onrZ2VrwiucUUWgzwBjb
         e0JA==
X-Gm-Message-State: ANoB5pk7B8CyBWFrH5je2v+wxKPq6IWt1WDbuRtsf7cojNfd4S9AkRcN
        T1mqS6xb1W1gyRGBRa8++v3b+VL64sRxhUSbJYaeWaESmEPaWH3o2Gq7YnIAeRBdiAT9957fdW1
        AX3SAlk4XenFYGtHS/mHj
X-Received: by 2002:adf:ef0d:0:b0:23a:aa41:8651 with SMTP id e13-20020adfef0d000000b0023aaa418651mr15413865wro.54.1667911705851;
        Tue, 08 Nov 2022 04:48:25 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5j11s3d8iD6DLvWeBjJe0qJXbVbmoTTqp+N63kalsS6r92bGmymGHS0a6rForxGAZtyOS49g==
X-Received: by 2002:adf:ef0d:0:b0:23a:aa41:8651 with SMTP id e13-20020adfef0d000000b0023aaa418651mr15413850wro.54.1667911705525;
        Tue, 08 Nov 2022 04:48:25 -0800 (PST)
Received: from [192.168.9.16] (net-2-34-30-201.cust.vodafonedsl.it. [2.34.30.201])
        by smtp.gmail.com with ESMTPSA id m3-20020a05600c3b0300b003cf47556f21sm15119405wms.2.2022.11.08.04.48.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 04:48:24 -0800 (PST)
Message-ID: <5a786018-559d-b25c-8a64-95968c6c1f44@redhat.com>
Date:   Tue, 8 Nov 2022 13:48:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v4 4/4] tty: serial: 8250: add DFL bus driver for Altera
 16550.
To:     ilpo.jarvinen@linux.intel.com
Cc:     andriy.shevchenko@linux.intel.com,
        basheer.ahmed.muddebihal@intel.com, corbet@lwn.net,
        geert+renesas@glider.be, hao.wu@intel.com, jirislaby@kernel.org,
        johan@kernel.org, linux-doc@vger.kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, lukas@wunner.de, macro@orcam.me.uk,
        marpagan@redhat.com, matthew.gerlach@linux.intel.com,
        mdf@kernel.org, niklas.soderlund+renesas@ragnatech.se,
        russell.h.weight@intel.com, tianfei.zhang@intel.com,
        trix@redhat.com, yilun.xu@intel.com
References: <20221020212610.697729-1-matthew.gerlach@linux.intel.com>
 <20221020212610.697729-5-matthew.gerlach@linux.intel.com>
 <Y11FmiDeVhGir+7z@yilunxu-OptiPlex-7050>
 <alpine.DEB.2.22.394.2210311719460.2680729@rhweight-WRK1>
 <Y2B6kAnd+m3ftWRf@yilunxu-OptiPlex-7050>
 <alpine.DEB.2.22.394.2211010843110.2746019@rhweight-WRK1>
 <1a812bba-6832-36cc-dfed-7d7ddd8f421c@linux.intel.com>
 <alpine.DEB.2.22.394.2211011037420.2746019@rhweight-WRK1>
 <95eaaf28-4472-dfd7-624f-73d58bfccaf@linux.intel.com>
Content-Language: en-US
From:   Marco Pagani <marpagan@redhat.com>
In-Reply-To: <95eaaf28-4472-dfd7-624f-73d58bfccaf@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 2022-11-02 10:57, Ilpo Järvinen wrote:
> On Tue, 1 Nov 2022, matthew.gerlach@linux.intel.com wrote:
> 
>>
>>
>> On Tue, 1 Nov 2022, Ilpo Järvinen wrote:
>>
>>> On Tue, 1 Nov 2022, matthew.gerlach@linux.intel.com wrote:
>>>
>>>>
>>>>
>>>> On Tue, 1 Nov 2022, Xu Yilun wrote:
>>>>
>>>>> On 2022-10-31 at 17:34:39 -0700, matthew.gerlach@linux.intel.com wrote:
>>>>>>
>>>>>>
>>>>>> On Sat, 29 Oct 2022, Xu Yilun wrote:
>>>>>>
>>>>>>> On 2022-10-20 at 14:26:10 -0700, matthew.gerlach@linux.intel.com
>>>>>>> wrote:
>>>>>>>> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>>>>>>>
>>>>>>>> Add a Device Feature List (DFL) bus driver for the Altera
>>>>>>>> 16550 implementation of UART.
>>>>>>>>
>>>>>>>> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>>>>>>> ---
>>>>>>>> v4: use dev_err_probe() everywhere that is appropriate
>>>>>>>>     clean up noise
>>>>>>>>     change error messages to use the word, unsupported
>>>>>>>>     tried again to sort Makefile and KConfig better
>>>>>>>>     reorder probe function for easier error handling
>>>>>>>>     use new dfh_find_param API
>>>>>>>>
>>>>>>>> v3: use passed in location of registers
>>>>>>>>     use cleaned up functions for parsing parameters
>>>>>>>>
>>>>>>>> v2: clean up error messages
>>>>>>>>     alphabetize header files
>>>>>>>>     fix 'missing prototype' error by making function static
>>>>>>>>     tried to sort Makefile and Kconfig better
>>>>>>>> ---
>>>>>>>>  drivers/tty/serial/8250/8250_dfl.c | 149
>>>>>>>> +++++++++++++++++++++++++++++
>>>>>>>>  drivers/tty/serial/8250/Kconfig    |  12 +++
>>>>>>>>  drivers/tty/serial/8250/Makefile   |   1 +
>>>>>>>>  3 files changed, 162 insertions(+)
>>>>>>>>  create mode 100644 drivers/tty/serial/8250/8250_dfl.c
>>>>>>>>
>>>>>>>> diff --git a/drivers/tty/serial/8250/8250_dfl.c
>>>>>>>> b/drivers/tty/serial/8250/8250_dfl.c
>>>>>>>> new file mode 100644
>>>>>>>> index 000000000000..f02f0ba2a565
>>>>>>>> --- /dev/null
>>>>>>>> +++ b/drivers/tty/serial/8250/8250_dfl.c
>>>>>>>> @@ -0,0 +1,149 @@
>>>>>>>> +// SPDX-License-Identifier: GPL-2.0
>>>>>>>> +/*
>>>>>>>> + * Driver for FPGA UART
>>>>>>>> + *
>>>>>>>> + * Copyright (C) 2022 Intel Corporation, Inc.
>>>>>>>> + *
>>>>>>>> + * Authors:
>>>>>>>> + *   Ananda Ravuri <ananda.ravuri@intel.com>
>>>>>>>> + *   Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>>>>>>> + */
>>>>>>>> +
>>>>>>>> +#include <linux/bitfield.h>
>>>>>>>> +#include <linux/dfl.h>
>>>>>>>> +#include <linux/io-64-nonatomic-lo-hi.h>
>>>>>>>> +#include <linux/kernel.h>
>>>>>>>> +#include <linux/module.h>
>>>>>>>> +#include <linux/serial.h>
>>>>>>>> +#include <linux/serial_8250.h>
>>>>>>>> +
>>>>>>>> +struct dfl_uart {
>>>>>>>> +	int line;
>>>>>>>> +};
>>>>>>>> +
>>>>>>>> +static int dfl_uart_get_params(struct dfl_device *dfl_dev, struct
>>>>>>>> uart_8250_port *uart)
>>>>>>>> +{
>>>>>>>> +	struct device *dev = &dfl_dev->dev;
>>>>>>>> +	u64 v, fifo_len, reg_width;
>>>>>>>> +	u64 *p;
>>>>>>>> +
>>>>>>>> +	p = dfh_find_param(dfl_dev, DFHv1_PARAM_ID_CLK_FRQ);
>>>>>>>> +	if (!p)
>>>>>>>> +		return dev_err_probe(dev, -EINVAL, "missing CLK_FRQ
>>>>>>>> param\n");
>>>>>>>> +
>>>>>>>> +	uart->port.uartclk = *p;
>>>>>>>> +	dev_dbg(dev, "UART_CLK_ID %u Hz\n", uart->port.uartclk);
>>>>>>>> +
>>>>>>>> +	p = dfh_find_param(dfl_dev, DFHv1_PARAM_ID_FIFO_LEN);
>>>>>>>> +	if (!p)
>>>>>>>> +		return dev_err_probe(dev, -EINVAL, "missing FIFO_LEN
>>>>>>>> param\n");
>>>>>>>> +
>>>>>>>> +	fifo_len = *p;
>>>>>>>> +	dev_dbg(dev, "UART_FIFO_ID fifo_len %llu\n", fifo_len);
>>>>>>>> +
>>>>>>>> +	switch (fifo_len) {
>>>>>>>> +	case 32:
>>>>>>>> +		uart->port.type = PORT_ALTR_16550_F32;
>>>>>>>> +		break;
>>>>>>>> +
>>>>>>>> +	case 64:
>>>>>>>> +		uart->port.type = PORT_ALTR_16550_F64;
>>>>>>>> +		break;
>>>>>>>> +
>>>>>>>> +	case 128:
>>>>>>>> +		uart->port.type = PORT_ALTR_16550_F128;
>>>>>>>> +		break;
>>>>>>>> +
>>>>>>>> +	default:
>>>>>>>> +		return dev_err_probe(dev, -EINVAL, "unsupported
>>>>>>>> fifo_len %llu\n", fifo_len);
>>>>>>>> +	}
>>>>>>>> +
>>>>>>>> +	p = dfh_find_param(dfl_dev, DFHv1_PARAM_ID_REG_LAYOUT);
>>>>>>>> +	if (!p)
>>>>>>>> +		return dev_err_probe(dev, -EINVAL, "missing REG_LAYOUT
>>>>>>>> param\n");
>>>>>>>> +
>>>>>>>> +	v = *p;
>>>>>>>> +	uart->port.regshift = FIELD_GET(DFHv1_PARAM_ID_REG_SHIFT, v);
>>>>>>>> +	reg_width = FIELD_GET(DFHv1_PARAM_ID_REG_WIDTH, v);
>>>>>>>
>>>>>>> I have concern that the raw layout inside the parameter block is
>>>>>>> still exposed to drivers and need to be parsed by each driver.
>>>>>>
>>>>>> Raw parameter block will always have to be passed to the driver
>>>>>> because HW
>>>>>> specific properties can be defined that will need to be parsed by the
>>>>>> specific driver.
>>>>>
>>>>> So there is a question about the scope of the definitions of these
>>>>> parameter
>>>>> blocks. MSIX seems globally used across all dfl devices. REG_LAYOUT
>>>>> seems specific to uart?
>>>>
>>>> There are definitely two classes of parameter blocks.  One class is HW
>>>> agnostic parameters where the parameters are relevant to many different
>>>> kinds
>>>> of HW components.  MSI-X, and input clock-frequency are certainly HW
>>>> agnostic,
>>>> and it turns out that REG_LAYOUT is not specific to uart.  You can see
>>>> reg_bits and reg_stride in struct regmap_config.  There are also device
>>>> tree
>>>> bindings for reg-shift and reg-io-width.  The second class of parameters
>>>> would
>>>> be specific to HW component.  In the case of this uart driver, all
>>>> parameters
>>>> would be considered HW agnostic parameters.
>>>>
>>>>>
>>>>> If a parameter block is widely used in dfl drivers, duplicate the
>>>>> parsing
>>>>> from HW layout in each driver may not be a good idea. While for device
>>>>> specific parameter block, it's OK.
>>>>
>>>> It sounds like we are in agreement.
>>>>
>>>>>
>>>>> Another concern is the indexing of the parameter IDs. If some parameter
>>>>> blocks should be device specific, then no need to have globally indexed
>>>>> parameter IDs. Index them locally in device is OK. So put the
>>>>> definitions
>>>>> of ID values, HW layout and their parsing operation in each driver.
>>>>
>>>> It may be confusing for two drivers to use the same parameter id that have
>>>> different meanings and data layout.  Since all the parameters for this
>>>> driver
>>>> would be considered HW agnostic, we'd don't need to address this issue
>>>> with
>>>> this patchset.
>>>>
>>>>>>> How about we define HW agnostic IDs for parameter specific fields
>>>>>>> like:
>>>>>>>
>>>>>>> PARAM_ID		FIELD_ID
>>>>>>> ================================
>>>>>>> MSIX			STARTV
>>>>>>> 			NUMV
>>>>>>> --------------------------------
>>>>>>> CLK			FREQ
>>>>>>> --------------------------------
>>>>>>> FIFO			LEN
>>>>>>> --------------------------------
>>>>>>> REG_LAYOUT		WIDTH
>>>>>>> 			SHIFT
>>>>>>>
>>>>>>> And define like u64 dfl_find_param(struct dfl_device *, int
>>>>>>> param_id,
>>>>>>> int field_id)
>>>>>>
>>>>>> I don't think dfl_find_param as defined above adds much value.
>>>>>>
>>>>>>>
>>>>>>> Think further, if we have to define HW agnostic property - value
>>>>>>> pairs,
>>>>>>> why don't we just use "Software nodes for the firmware node", see
>>>>>>> drivers/base/swnode.c. I think this may be a better choice.
>>>>>>
>>>>>> I am looking into "Software nodes for the firmware node", and it can
>>>>>> be
>>>>>> used
>>>>>> for HW agnostic properties.  Each dfl driver will still have to make a
>>>>>> function call to fetch each HW agnostice property value as well as a
>>>>>> function call to find the HW specific parameters and then parse those
>>>>>> parameters.
>>>
>>> Btw, another aspect this discussion has completely overlooked is the
>>> presence of parameter version and how it impacts data layout. Is v1
>>> always going be a subset of v2 or can a later version remove something
>>> v1 had?
>>
>> In general it would be preferable for v1 to be a subset of v2.  This allows
>> for v1 SW to work on v2 HW.
> 
> In that case, shouldn't the minimum acceptable version be part of 
> dfh_find_param() parameters?
> 
> Currently there's no way for the caller to even look what version the 
> parameter is from dfh_find_param()'s return value (except with some 
> negative offset hack to access parameter header).
> 
> 

Why not just checking dfl_dev->dfh_version in dfl_uart_probe() before
calling dfh_find_param()? In general, any dfl_driver could potentially
do this check in its *_probe() function before reading the header to avoid
compatibility issues.

Cheers,
Marco

