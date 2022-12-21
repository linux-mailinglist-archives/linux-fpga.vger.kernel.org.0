Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28FE6653531
	for <lists+linux-fpga@lfdr.de>; Wed, 21 Dec 2022 18:29:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234660AbiLUR1j (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 21 Dec 2022 12:27:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbiLUR1i (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 21 Dec 2022 12:27:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B12D863FF
        for <linux-fpga@vger.kernel.org>; Wed, 21 Dec 2022 09:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671643611;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NuanpIiit3pxf0DfbjP3/X8tU6mOQsYwFdbXpF1jEBw=;
        b=DvVylG8l1CN6snTGw6dp0XduVpbL2wxCPbaVcXtUqsLgmcdw/q3QLky/dxZXSqhldOwz7V
        MfJCJ4m2kWO0HKAaSm2CAdyGXIZif8xeHkUHd1ynMAXJ9h5EgsdA91M+pxbrG1uJcHhjAt
        lkw9A7vqvdPxuuJQVls82nyG7siJa7Q=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-257-v9GAWC4tORaBAjkbmrDDlg-1; Wed, 21 Dec 2022 12:26:50 -0500
X-MC-Unique: v9GAWC4tORaBAjkbmrDDlg-1
Received: by mail-wr1-f72.google.com with SMTP id x1-20020adfbb41000000b002426b33b618so3102462wrg.7
        for <linux-fpga@vger.kernel.org>; Wed, 21 Dec 2022 09:26:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NuanpIiit3pxf0DfbjP3/X8tU6mOQsYwFdbXpF1jEBw=;
        b=jOWOAbDh4T+T2iOFAUuh7P/kr0zeYWJvsLD0tIGZqT2ssyBmguj9rK732H1SxFPX4R
         5AsQqPQuiMy3GlqY6BYVUgPi16r5SpaP2EO+Bnw3rJLjoF3C9S8ED1+ggitfBcaOieHE
         so/W0hsICif8FT8DZd0AefbSpGfZovIDzTzHCA6hLiszYDwEBCrLu0ymhfvO3fAXGM/7
         Po563QKliAHtBPJh3BSqkK+rWZ7qUT9phSJXqtBk+DahHbj3ntyi6J0JGIl/k6Zy8X5m
         iR+n+BmXLqGwFHbFUD4UYCg+IqnC0xw9u9y8EwA4dQQgqnOhwK2LbPYPPYbdSHc/oQDD
         dNSg==
X-Gm-Message-State: AFqh2kp+lOY4/bboI+axwu6iavQwOLcCu8g0G/bfqzcZUWVhNDPyP7tv
        BtRpl+Bcbo0b0ZZL7i6Bd3aZ+GEnlcc+7FxAw2xrToLPO84nEkCnfGdcaU2ZJKUh+VMoTMu7p64
        8n0uKJgN2oYDiAmeQYKug
X-Received: by 2002:a05:600c:1f12:b0:3cf:8155:2adc with SMTP id bd18-20020a05600c1f1200b003cf81552adcmr2334943wmb.33.1671643609285;
        Wed, 21 Dec 2022 09:26:49 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtmCCrwZo4nu1X4aGkuZsQZJ+WKxm5A/pgzSMDNUisKMUrHcMJkTIyFUzoV5mJaknfoOilw9A==
X-Received: by 2002:a05:600c:1f12:b0:3cf:8155:2adc with SMTP id bd18-20020a05600c1f1200b003cf81552adcmr2334924wmb.33.1671643609137;
        Wed, 21 Dec 2022 09:26:49 -0800 (PST)
Received: from [192.168.9.16] (net-2-34-28-158.cust.vodafonedsl.it. [2.34.28.158])
        by smtp.gmail.com with ESMTPSA id g15-20020a05600c310f00b003b47e75b401sm3174983wmo.37.2022.12.21.09.26.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Dec 2022 09:26:48 -0800 (PST)
Message-ID: <d34b021c-eec4-905e-f352-734db2d8338a@redhat.com>
Date:   Wed, 21 Dec 2022 18:26:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v7 4/4] tty: serial: 8250: add DFL bus driver for Altera
 16550.
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        matthew.gerlach@linux.intel.com
Cc:     hao.wu@intel.com, yilun.xu@intel.com, russell.h.weight@intel.com,
        basheer.ahmed.muddebihal@intel.com, trix@redhat.com,
        mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        tianfei.zhang@intel.com, corbet@lwn.net,
        gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        jirislaby@kernel.org, geert+renesas@glider.be,
        niklas.soderlund+renesas@ragnatech.se, macro@orcam.me.uk,
        johan@kernel.org, lukas@wunner.de, ilpo.jarvinen@linux.intel.com,
        bagasdotme@gmail.com
References: <20221220163652.499831-1-matthew.gerlach@linux.intel.com>
 <20221220163652.499831-5-matthew.gerlach@linux.intel.com>
 <Y6HsQJQMDnHgTesF@smile.fi.intel.com>
Content-Language: en-US
From:   Marco Pagani <marpagan@redhat.com>
In-Reply-To: <Y6HsQJQMDnHgTesF@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 2022-12-20 18:09, Andy Shevchenko wrote:
> On Tue, Dec 20, 2022 at 08:36:52AM -0800, matthew.gerlach@linux.intel.com wrote:
>> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>
>> Add a Device Feature List (DFL) bus driver for the Altera
>> 16550 implementation of UART.
> 
> In general the code here looks good to me, but one thing to discuss due to
> comment to the previous patch(es).
> 
> ...
> 
>> +	u64 *p;
>> +
>> +	p = dfh_find_param(dfl_dev, DFHv1_PARAM_ID_CLK_FRQ);
>> +	if (!p)
>> +		return dev_err_probe(dev, -EINVAL, "missing CLK_FRQ param\n");
>> +
>> +	p++;
>> +	uart->port.uartclk = *p;
> 
> So, here and the below is using always the second u64 from the returned data.
> Does it mean:
> - we always skip the first u64 from the returned buffer and hence... (see below)
> - we may actually return the second u64 as a plain number (not a pointer) from
>   (an additional?) API? In such case we would not need to take care about this
>   p++; lines here and there.
> - we have fixed length of the data, returned by find_param(), i.e. 2 u64 words?
> 

I also had the impression that this method of getting and incrementing a pointer
to the beginning of the parameter block is a bit more error-prone than necessary.
Since parameter blocks are now standardized, wouldn't be easier and safer to wrap
the access logic into a helper function like:

u16 dfh_get_param_data(struct dfl_device *dfl_dev, u16 param_id, u64 *data)

that directly provides a copy of the parameter's data into a pointer provided by
the caller and returns the parameter version or an error if not found?

Thanks,
Marco

