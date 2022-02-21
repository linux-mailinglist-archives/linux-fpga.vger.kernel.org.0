Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 008F54BEA1D
	for <lists+linux-fpga@lfdr.de>; Mon, 21 Feb 2022 19:09:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbiBUSBE (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 21 Feb 2022 13:01:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231965AbiBUR7H (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 21 Feb 2022 12:59:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B5A5012AD7
        for <linux-fpga@vger.kernel.org>; Mon, 21 Feb 2022 09:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645465919;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uR7SiZmKCUIFK/y/tnK8VR20eBceG4PVTblPsXxfzUo=;
        b=FYMx+9KkY46/b0Bd10lgmO3nVAOjSxjFebiz9jlWUil7IQfQT/S0PuqKxd+QeKIihgz1mu
        CoweTlrytRqnIHXjkYW+ZUWiqcZ7cdy/mhSwibzKWOx4BC/0fzg7VA4R1LSm5a7yGtDMky
        5l8VEj+3bCPJ3nezXzkEf5jrBsfhNF8=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-150-pP5ZRaSLMUyWaCzMln8nKQ-1; Mon, 21 Feb 2022 12:51:58 -0500
X-MC-Unique: pP5ZRaSLMUyWaCzMln8nKQ-1
Received: by mail-qv1-f72.google.com with SMTP id i20-20020a056214031400b0043185095fe2so5715146qvu.10
        for <linux-fpga@vger.kernel.org>; Mon, 21 Feb 2022 09:51:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=uR7SiZmKCUIFK/y/tnK8VR20eBceG4PVTblPsXxfzUo=;
        b=C1P8fgr6SiteCcQbcdcNzApDt3aQSrDFHzcwTaqMoC/iowwgvpgXmyIbmsUEudSIms
         6vWt1G8XGp46+3Wry7MffLPI75vqGeS9cyndTZkQjLjpE2rho6NbFAcoua/z7GRgyB75
         +FHzW5B3AYJZm1bMBYFCUgNcaXFIYulp5jG3OJIB8xYhm3Z7T5CFKsboIdcnCDr9mdjE
         Hm7bWWELpoRyty5X22NKGWvmefcQG1vNXJ9rojLSVeLMakBapu2r3untnJ/G9S6zjbkH
         rLK1SDnMCjKlQrPFO64cKT8S+xWpwN/OhKepZ8cvDOhATlg5SYDG2OerKVHUHtcAmX+d
         pDvA==
X-Gm-Message-State: AOAM530avNpPX2Wxsr2G1p5ghIUrGCf/f7ANThgB7czUnKB+W90LTeIA
        gH4nM5xomi9feTcPg2Xe05rvi5MbwrSW09BrkzSOOxC1fX/X7Qd6T+IlitAQk7Wl8wnICk8SiHC
        HgXbMXTLj+sqNxO5vzsCg3w==
X-Received: by 2002:a05:620a:178d:b0:648:e091:6ddc with SMTP id ay13-20020a05620a178d00b00648e0916ddcmr3932718qkb.553.1645465918289;
        Mon, 21 Feb 2022 09:51:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxmyRGXkrF9r8dCEx8lShg4bsx5h4lZbJMdcKGnZA6fcMkMJIP3gjOKXVy3WZoU33xbu9ZRiw==
X-Received: by 2002:a05:620a:178d:b0:648:e091:6ddc with SMTP id ay13-20020a05620a178d00b00648e0916ddcmr3932703qkb.553.1645465918085;
        Mon, 21 Feb 2022 09:51:58 -0800 (PST)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id x83sm7541757qkb.68.2022.02.21.09.51.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Feb 2022 09:51:57 -0800 (PST)
Subject: Re: [PATCH v1 3/7] fpga: dfl: Allow for ports with no local bar
 space.
To:     matthew.gerlach@linux.intel.com
Cc:     "Zhang, Tianfei" <tianfei.zhang@intel.com>,
        "Wu, Hao" <hao.wu@intel.com>, "mdf@kernel.org" <mdf@kernel.org>,
        "Xu, Yilun" <yilun.xu@intel.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>
References: <20220214112619.219761-1-tianfei.zhang@intel.com>
 <20220214112619.219761-4-tianfei.zhang@intel.com>
 <0fdd3d0d-d280-8104-eccc-8fa8d8a992c2@redhat.com>
 <BN9PR11MB548314968CBC0CA5E446B366E3379@BN9PR11MB5483.namprd11.prod.outlook.com>
 <efee5ac0-4c3a-085d-9b9d-0c8ade022f30@redhat.com>
 <alpine.DEB.2.22.394.2202210912260.117064@rhweight-WRK1>
From:   Tom Rix <trix@redhat.com>
Message-ID: <8137a208-43e3-3843-eca9-f6ec627e8d0e@redhat.com>
Date:   Mon, 21 Feb 2022 09:51:55 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2202210912260.117064@rhweight-WRK1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 2/21/22 9:22 AM, matthew.gerlach@linux.intel.com wrote:
>
>
> On Fri, 18 Feb 2022, Tom Rix wrote:
>
>>
>> On 2/17/22 11:31 PM, Zhang, Tianfei wrote:
>>>
>>>> -----Original Message-----
>>>> From: Tom Rix <trix@redhat.com>
>>>> Sent: Tuesday, February 15, 2022 11:06 PM
>>>> To: Zhang, Tianfei <tianfei.zhang@intel.com>; Wu, Hao 
>>>> <hao.wu@intel.com>;
>>>> mdf@kernel.org; Xu, Yilun <yilun.xu@intel.com>; 
>>>> linux-fpga@vger.kernel.org;
>>>> linux-doc@vger.kernel.org; linux-kernel@vger.kernel.org
>>>> Cc: corbet@lwn.net; Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>>> Subject: Re: [PATCH v1 3/7] fpga: dfl: Allow for ports with no 
>>>> local bar space.
>>>>
>>>>
>>>> On 2/14/22 3:26 AM, Tianfei zhang wrote:
>>>>> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>>>>
>>>>>   From a fpga partial reconfiguration standpoint, a port may not be
>>>>> connected any local BAR space.  The port could be connected to a
>>>>> different PCIe Physical Function (PF) or Virtual Function (VF), in
>>>>> which case another driver instance would manage the endpoint.
>>>> It is not clear if this is part of iofs or a bug fix.
>>> This is the new implementation/feature of IOFS.
>>> On IOFS support multiple methods to access the AFU.
>>> 1. Legacy Model. This is used for N3000 and N5000 card.
>>> In this model the entire AFU region is a unit of PR, and there is a 
>>> Port device connected to this AFU.
>>> On DFL perspective, there is "Next AFU" point to the AFU, and the 
>>> "BarID" is  the PCIe Bar ID of AFU.
>>> In this model, we can use the AFU APIs to access the entire AFU 
>>> resource, like MMIO.
>>> 2. Micro-Personas in AFU.
>>> IOFS intruding new model for PR and AFU access.
>>> Micro-Personas allow the RTL developer to designate their own 
>>> AFU-defined PR regions.
>>> In this model the unit of PR is not the entire AFU, instead
>>> the unit of PR can be any size block or blocks inside the AFU.
>>> 3. Multiple VFs per PR slot.
>>> In this method, we can instance multiple VFs over SRIOV for one PR 
>>> slot, and access the AFU resource
>>> by different VFs in virtualization usage. In this case, the Port 
>>> device would not connected to AFU (the BarID of Port device
>>> should be set to invalid), so this patch want to support this use 
>>> model.
>>
>> What I am looking for is how the older cards using (my term) dfl 1 
>> will still work with dfl 2 and vice versa.
>>
>> No where do I see a version check for dfl 2 nor a pci id check so 
>> either this just works or backward compatibility has not be considered.
>>
>> Please add a backward compatibility section to the doc patch
>>
>>>
>>>>> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>>>> Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
>>>>> ---
>>>>>    drivers/fpga/dfl-pci.c | 8 ++++++++
>>>>>    1 file changed, 8 insertions(+)
>>>>>
>>>>> diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c index
>>>>> 4d68719e608f..8abd9b408403 100644
>>>>> --- a/drivers/fpga/dfl-pci.c
>>>>> +++ b/drivers/fpga/dfl-pci.c
>>>>> @@ -243,6 +243,7 @@ static int find_dfls_by_default(struct pci_dev 
>>>>> *pcidev,
>>>>>            v = readq(base + FME_HDR_CAP);
>>>>>            port_num = FIELD_GET(FME_CAP_NUM_PORTS, v);
>>>>>
>>>>> +        dev_info(&pcidev->dev, "port_num = %d\n", port_num);
>>>>>            WARN_ON(port_num > MAX_DFL_FPGA_PORT_NUM);
>>>>>
>>>>>            for (i = 0; i < port_num; i++) {
>>>>> @@ -258,6 +259,13 @@ static int find_dfls_by_default(struct 
>>>>> pci_dev *pcidev,
>>>>>                 */
>>>>>                bar = FIELD_GET(FME_PORT_OFST_BAR_ID, v);
>>>>>                offset = FIELD_GET(FME_PORT_OFST_DFH_OFST, v);
>>>>> +            if (bar >= PCI_STD_NUM_BARS) {
>>>> Is bar set to a better magic number that pci_std_num_bars ? maybe 
>>>> 0xff's
>>>>
>>>> How do you tell between this case and broken hw ?
>>> Yes, I agree that magic number is better, Currently the RTL using 
>>> PCI_STD_NUM_BARS for an invalid PCIe bar number.
>>
>> How do you tell between this case and broken hw ?
>>
>> Tom
>
> The field, FME_PORT_OFST_BAR_ID, is a three bit field, which is pretty 
> common for BARs on PCI.  PCI_STD_NUM_BARS is defined as 6. Current HW 
> implementations are filing this field with the value, 7, which is 
> close to the suggestion of 0xff's.  How about we define the following 
> magic number?
> #define NO_LOCAL_PORT_BAR    7
>
> We should also change the dev_info to be a dev_dbg and more precise to 
> something like the following:
>
>     if (bar == NO_LOCAL_PORT_BAR) {
>         dev_dbg(&pcidev->dev, "No local port BAR space.\n");
>         continue;
>     }

What I am looking for is way generally is to tell if this is an old 
framework or a new one.

Maybe a flag and/or version added to dfl_fpga_cdev on probing ?

(The meaning of released_port_num likely needs to change there as well)

So in this case you could check if this was the new framework before 
doing the bar check.

Similar checks other places where ofs stuff is being fit it.

My concern is the fitting in without checking will break the old stuff.

And why I wanted to see a probing writeup in the dfl.rst doc

Tom

>
>>
>>>> Move up a line and skip getting an offset that will not be used.
>>> Yes, this line is not necessary, I will remove it on next version 
>>> patch.
>>>
>>>>> + dev_info(&pcidev->dev, "skipping port without
>>>> local BAR space %d\n",
>>>>> +                     bar);
>>>>> +                continue;
>>>>> +            } else {
>>>>> +                dev_info(&pcidev->dev, "BAR %d offset %u\n",
>>>> bar, offset);
>>>>> +            }
>>>>>                start = pci_resource_start(pcidev, bar) + offset;
>>>>>                len = pci_resource_len(pcidev, bar) - offset;
>>>>>
>>>> Is similar logic needed for else-if (port) block below this ?
>>> I think, the else-if is not necessary. I will remove it on next 
>>> version patch.
>>>> Tom
>>
>>
>

