Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF2E44BEA9D
	for <lists+linux-fpga@lfdr.de>; Mon, 21 Feb 2022 20:36:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbiBUSUp (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 21 Feb 2022 13:20:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232707AbiBUSSk (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 21 Feb 2022 13:18:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 65309E019
        for <linux-fpga@vger.kernel.org>; Mon, 21 Feb 2022 10:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645466995;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QOSDSgS25PuGDC+NGKfa0oAA8l6jTmg9zjUlxbJquUg=;
        b=XOO+X7EbNx+0uJohmDqSdXtcA0MgQA5tqisbn8yOtP7wz+wDc7IreCKF4wlPHIMvAWFRpM
        N3765rLu9zrCo1I3iEuz6Rriu5u4F5MOY0JQEGQMAmkztQtB3zGpAToIEUQo9YbatSeuHZ
        74vuvatMM+/ad2JGzySgWFs1uX1M6h0=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-438-sBOpX0cVM5OHVSyclFSUxA-1; Mon, 21 Feb 2022 13:09:54 -0500
X-MC-Unique: sBOpX0cVM5OHVSyclFSUxA-1
Received: by mail-qv1-f72.google.com with SMTP id g2-20020a0562141cc200b004123b0abe18so18047273qvd.2
        for <linux-fpga@vger.kernel.org>; Mon, 21 Feb 2022 10:09:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=QOSDSgS25PuGDC+NGKfa0oAA8l6jTmg9zjUlxbJquUg=;
        b=ze87iVxL9xTxe3JNaChdWWEj++PI93BzlhB1lHVWnmYyniVG2ZNDxZ6IeOQ7W8zRP8
         HqyNgA4nZjBQc5aaXS+p8TBwWgl8/lWKoqkvNkFCwDWpj9756DYycmA7L90G+G9tC3W9
         mj09g2W3xuvCzElTf6rnO22m6MA24bUe4SLkTBURGZ6syYzpcvuG3CLCH/qrrAq69xbU
         N3TaciaXDRKoEH6hGnvC+44svj4fFniIR9jlLYNWoCBRZKUO+UlQt6VDvtWuoJdYezZA
         VkoNPrb4lLTcX3sKiy2XcYCSSw1CHPy3COrNEyL8V28Up/w+5FUsjaCtAGQpBy5S4nuS
         Mqjw==
X-Gm-Message-State: AOAM532p4Q3rGjqrWdwgWl7IrHut3vJuMtQwvHGWqyMMcjQNsgSPTaeQ
        YXaQozSGdlMCCeFBfEyeqBKpjG2FkbO7VnqiSnFw1baFrdjVxQiP39AgkUXo6a9UvacRnZ3yUWn
        jPXtkLJQTYRMJSSX1FO9BrA==
X-Received: by 2002:a37:917:0:b0:62c:e550:bc3e with SMTP id 23-20020a370917000000b0062ce550bc3emr9286080qkj.677.1645466993988;
        Mon, 21 Feb 2022 10:09:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwqiDx3JKkP0zev/JNDSJKk0tyXEgKVEjQZmbq7opi50Pgswv2JqQzW1FesSvHB04BQh9/6kg==
X-Received: by 2002:a37:917:0:b0:62c:e550:bc3e with SMTP id 23-20020a370917000000b0062ce550bc3emr9286067qkj.677.1645466993785;
        Mon, 21 Feb 2022 10:09:53 -0800 (PST)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id s11sm31054348qtk.82.2022.02.21.10.09.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Feb 2022 10:09:53 -0800 (PST)
Subject: Re: [PATCH v1 7/7] fpga: dfl: pci: Add generic OFS PCI PID
To:     matthew.gerlach@linux.intel.com
Cc:     "Zhang, Tianfei" <tianfei.zhang@intel.com>,
        "Wu, Hao" <hao.wu@intel.com>, "mdf@kernel.org" <mdf@kernel.org>,
        "Xu, Yilun" <yilun.xu@intel.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>
References: <20220214112619.219761-1-tianfei.zhang@intel.com>
 <20220214112619.219761-8-tianfei.zhang@intel.com>
 <ed8f4b5f-5c92-f555-ed2d-c5b8f38d5372@redhat.com>
 <BN9PR11MB5483BC7EE52A47CEAEFC58A0E3379@BN9PR11MB5483.namprd11.prod.outlook.com>
 <3c9fce03-ef29-d80f-6639-0c237c28cf58@redhat.com>
 <alpine.DEB.2.22.394.2202210934570.117064@rhweight-WRK1>
From:   Tom Rix <trix@redhat.com>
Message-ID: <e5580849-c137-fb61-0599-198c341bf688@redhat.com>
Date:   Mon, 21 Feb 2022 10:09:50 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2202210934570.117064@rhweight-WRK1>
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


On 2/21/22 9:50 AM, matthew.gerlach@linux.intel.com wrote:
>
>
> On Fri, 18 Feb 2022, Tom Rix wrote:
>
>>
>> On 2/18/22 1:03 AM, Zhang, Tianfei wrote:
>>>
>>>> -----Original Message-----
>>>> From: Tom Rix <trix@redhat.com>
>>>> Sent: Wednesday, February 16, 2022 12:16 AM
>>>> To: Zhang, Tianfei <tianfei.zhang@intel.com>; Wu, Hao 
>>>> <hao.wu@intel.com>;
>>>> mdf@kernel.org; Xu, Yilun <yilun.xu@intel.com>; 
>>>> linux-fpga@vger.kernel.org;
>>>> linux-doc@vger.kernel.org; linux-kernel@vger.kernel.org
>>>> Cc: corbet@lwn.net; Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>>> Subject: Re: [PATCH v1 7/7] fpga: dfl: pci: Add generic OFS PCI PID
>>>>
>>>>
>>>> On 2/14/22 3:26 AM, Tianfei zhang wrote:
>>>>> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>>>>
>>>>> Add the PCI product id for an Open FPGA Stack PCI card.
>>>> Is there a URL to the card ?
>>> This PCIe Device IDs have registered by Intel.
>> A URL is useful to introduce the board, Is there one ?
>>>
>>>>> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>>>> Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
>>>>> ---
>>>>>    drivers/fpga/dfl-pci.c | 4 ++++
>>>>>    1 file changed, 4 insertions(+)
>>>>>
>>>>> diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c index
>>>>> 83b604d6dbe6..cb2fbf3eb918 100644
>>>>> --- a/drivers/fpga/dfl-pci.c
>>>>> +++ b/drivers/fpga/dfl-pci.c
>>>>> @@ -76,12 +76,14 @@ static void cci_pci_free_irq(struct pci_dev 
>>>>> *pcidev)
>>>>>    #define PCIE_DEVICE_ID_INTEL_PAC_D5005        0x0B2B
>>>>>    #define PCIE_DEVICE_ID_SILICOM_PAC_N5010    0x1000
>>>>>    #define PCIE_DEVICE_ID_SILICOM_PAC_N5011    0x1001
>>>>> +#define PCIE_DEVICE_ID_INTEL_OFS        0xbcce
>>>> INTEL_OFS is a generic name, pci id's map to specific cards
>>>>
>>>> Is there a more specific name for this card ?
>>> I think using INTEL_OFS is better, because INTEL_OFS is the Generic 
>>> development platform can support multiple cards which using OFS 
>>> specification,
>>> like Intel PAC N6000 card.
>>
>> I would prefer something like PCIE_DEVICE_ID_INTEL_PAC_N6000 because 
>> it follows an existing pattern.  Make it easy on a developer, they 
>> will look at their board or box, see X and try to find something 
>> similar in the driver source.
>>
>> To use OSF_ * the name needs a suffix to differentiate it from future 
>> cards that will also use ofs.
>>
>> If this really is a generic id please explain in the doc patch how 
>> every future board with use this single id and how a driver could 
>> work around a hw problem in a specific board with a pci id covering 
>> multiple boards.
>>
>> Tom
>
> Hi Tom,
>
> The intent is to have a generic device id that can be used with many 
> different boards.  Currently, we have FPGA implementations for 3 
> different boards using this generic id.  We may need a better name for 
> device id than OFS.  More precisely this generic device id means a PCI 
> function that is described by a Device Feature List (DFL).  How about 
> PCIE_DEVICE_ID_INTEL_DFL?
>
> With a DFL device id, the functionality of the PF/VF is determined by 
> the contents of the DFL.  Each Device Feature Header (DFH) in the DFL 
> has a revision field that can be used identify "broken" hw, or new 
> functionality added to a feature.  Additionally, since the DFL is 
> typically used in a FPGA, the broken hardware, can and should be fixed 
> in most cases.

How is lspci supposed to work ?

A dfl set can change with fw updates and in theory different boards 
could have the same set.

Tom

>
> Matthew
>>
>>>
>>>> Tom
>>>>
>>>>>    /* VF Device */
>>>>>    #define PCIE_DEVICE_ID_VF_INT_5_X        0xBCBF
>>>>>    #define PCIE_DEVICE_ID_VF_INT_6_X        0xBCC1
>>>>>    #define PCIE_DEVICE_ID_VF_DSC_1_X        0x09C5
>>>>>    #define PCIE_DEVICE_ID_INTEL_PAC_D5005_VF    0x0B2C
>>>>> +#define PCIE_DEVICE_ID_INTEL_OFS_VF        0xbccf
>>>>>
>>>>>    static struct pci_device_id cci_pcie_id_tbl[] = {
>>>>>        {PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_PF_INT_5_X),},
>>>> @@
>>>>> -95,6 +97,8 @@ static struct pci_device_id cci_pcie_id_tbl[] = {
>>>>>        {PCI_DEVICE(PCI_VENDOR_ID_INTEL,
>>>> PCIE_DEVICE_ID_INTEL_PAC_D5005_VF),},
>>>>> {PCI_DEVICE(PCI_VENDOR_ID_SILICOM_DENMARK,
>>>> PCIE_DEVICE_ID_SILICOM_PAC_N5010),},
>>>>> {PCI_DEVICE(PCI_VENDOR_ID_SILICOM_DENMARK,
>>>>> PCIE_DEVICE_ID_SILICOM_PAC_N5011),},
>>>>> +    {PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_INTEL_OFS),},
>>>>> +    {PCI_DEVICE(PCI_VENDOR_ID_INTEL,
>>>> PCIE_DEVICE_ID_INTEL_OFS_VF),},
>>>>>        {0,}
>>>>>    };
>>>>>    MODULE_DEVICE_TABLE(pci, cci_pcie_id_tbl);
>>
>>

