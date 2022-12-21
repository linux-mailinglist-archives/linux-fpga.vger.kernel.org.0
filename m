Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52C12653741
	for <lists+linux-fpga@lfdr.de>; Wed, 21 Dec 2022 20:55:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232026AbiLUTxT (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 21 Dec 2022 14:53:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbiLUTxS (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 21 Dec 2022 14:53:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D526E1DF1C
        for <linux-fpga@vger.kernel.org>; Wed, 21 Dec 2022 11:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671652356;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RCRroI44SL1bzd88GS4250dP0iBh1wXxtn3imTbgqCw=;
        b=UcCnyRStAIRHDsd3EBK9m+GT3HNQVfmyThFE7+h1vHZwLtv35cpYZ6t043yfCMB/HiD8Ck
        zVhFFH4EARCG1fgMRiW9XUFdog1fKsPdB8gT9fhMyotPnW9dDuTD3bIa71jNvbznhOSnvf
        RZEWytPmvXqi5RPf58TPXXTT2W3zv1I=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-611-SSmbZQUJP-Kp_i_GQ37GYw-1; Wed, 21 Dec 2022 14:52:35 -0500
X-MC-Unique: SSmbZQUJP-Kp_i_GQ37GYw-1
Received: by mail-wm1-f72.google.com with SMTP id c7-20020a1c3507000000b003d355c13ba8so4682853wma.6
        for <linux-fpga@vger.kernel.org>; Wed, 21 Dec 2022 11:52:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RCRroI44SL1bzd88GS4250dP0iBh1wXxtn3imTbgqCw=;
        b=L1MBTnxcaC19CtNhNad/COk5x+3+H4h2X7eFw7zVB/fycrM24Ch5ukE0tA1sFMqAnX
         fz3VRG095o+SIqU5GGuiCFgq1iLsDUo95S99MRQvFB8LXHLnNphNlEUTGUyIU2GNG8tq
         5e55irWkFKv812LZEoUC1kdCwnk+VV6dPJXZviiQh+KWe6dlAf01TNJQBxYIaIZvCpSD
         iXGnlro39eRmD+vCmwXAs2MeU6XliXPPculdTcelND7JJ+u+zQW8AADsk0QzccrN8Ew5
         bS5ffQdzxyqjg58ON+g3+LMOe+8rb2DdFVvvfdMRdQWiU83f684yR53zYJigns3egYk7
         8X2Q==
X-Gm-Message-State: AFqh2kqd6B7h3cbqiJ9f+Zo++dtlmxfQfef4TG5H9dTs5DCnFGv4lxe9
        zufagHciSF5czhuy7KMrZ++Ehy7PfHksF6pWOw+uAHzxSN3GCFC+xOxwYaNST1oB2lozvx8PXl2
        mhqOwjvhIe3aWZSmKFHeZ
X-Received: by 2002:adf:e68e:0:b0:242:46f1:1d90 with SMTP id r14-20020adfe68e000000b0024246f11d90mr2006901wrm.64.1671652354616;
        Wed, 21 Dec 2022 11:52:34 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsYTsLQroYHNhvkvJ8N4wSAZ8lt8zgb+cx3Jled8AKwHjoG1PTmnLW9Nq9JA9jIVolC/TUIHw==
X-Received: by 2002:adf:e68e:0:b0:242:46f1:1d90 with SMTP id r14-20020adfe68e000000b0024246f11d90mr2006880wrm.64.1671652354430;
        Wed, 21 Dec 2022 11:52:34 -0800 (PST)
Received: from [192.168.9.16] (net-2-34-28-158.cust.vodafonedsl.it. [2.34.28.158])
        by smtp.gmail.com with ESMTPSA id m16-20020adfe0d0000000b0025d9d13c7e1sm12930371wri.105.2022.12.21.11.52.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Dec 2022 11:52:34 -0800 (PST)
Message-ID: <70c7daf8-379e-1479-aba5-4476c4a93b9f@redhat.com>
Date:   Wed, 21 Dec 2022 20:52:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v7 4/4] tty: serial: 8250: add DFL bus driver for Altera
 16550.
Content-Language: en-US
From:   Marco Pagani <marpagan@redhat.com>
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
 <d34b021c-eec4-905e-f352-734db2d8338a@redhat.com>
In-Reply-To: <d34b021c-eec4-905e-f352-734db2d8338a@redhat.com>
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


On 2022-12-21 18:26, Marco Pagani wrote:
> 
> 
> On 2022-12-20 18:09, Andy Shevchenko wrote:
>> On Tue, Dec 20, 2022 at 08:36:52AM -0800, matthew.gerlach@linux.intel.com wrote:
>>> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>>
>>> Add a Device Feature List (DFL) bus driver for the Altera
>>> 16550 implementation of UART.
>>
>> In general the code here looks good to me, but one thing to discuss due to
>> comment to the previous patch(es).
>>
>> ...
>>
>>> +	u64 *p;
>>> +
>>> +	p = dfh_find_param(dfl_dev, DFHv1_PARAM_ID_CLK_FRQ);
>>> +	if (!p)
>>> +		return dev_err_probe(dev, -EINVAL, "missing CLK_FRQ param\n");
>>> +
>>> +	p++;
>>> +	uart->port.uartclk = *p;
>>
>> So, here and the below is using always the second u64 from the returned data.
>> Does it mean:
>> - we always skip the first u64 from the returned buffer and hence... (see below)
>> - we may actually return the second u64 as a plain number (not a pointer) from
>>   (an additional?) API? In such case we would not need to take care about this
>>   p++; lines here and there.
>> - we have fixed length of the data, returned by find_param(), i.e. 2 u64 words?
>>
> 
> I also had the impression that this method of getting and incrementing a pointer
> to the beginning of the parameter block is a bit more error-prone than necessary.
> Since parameter blocks are now standardized, wouldn't be easier and safer to wrap
> the access logic into a helper function like:
> 
> u16 dfh_get_param_data(struct dfl_device *dfl_dev, u16 param_id, u64 *data)
> 
> that directly provides a copy of the parameter's data into a pointer provided by
> the caller and returns the parameter version or an error if not found?

Please ignore the last part of my reply. The diagram in the documentation made
me think that parameter data are always 64-bit wide. Since the parameter data
"payload" size depends on the version and ID, an eventual helper function could
then return a pointer to the data payload and the version number to the caller.

Thanks,
Marco
 

