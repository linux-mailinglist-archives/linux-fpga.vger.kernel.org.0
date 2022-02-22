Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ABEB4BFE37
	for <lists+linux-fpga@lfdr.de>; Tue, 22 Feb 2022 17:13:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233893AbiBVQLw (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 22 Feb 2022 11:11:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbiBVQLv (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 22 Feb 2022 11:11:51 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0FAF5165C20
        for <linux-fpga@vger.kernel.org>; Tue, 22 Feb 2022 08:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645546285;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q/F/MVRVsTXPiEmPkOpNXGwvpePHO5WGa1Rhgl2MILM=;
        b=UGuZQL8Czw3Y1uoZILCS9rVamUwWBQ+geDmZrlUcUZFH6GxRxaWhsXFDTek/q6coJmK3h+
        MbjESMGGgjQ9b7/9q0KaPYLgEaeNFmwsS/wSr7yvfVQCpMLT0HOnbYCfcxQtm1Xtakntpt
        snFP9x6AwQcTyPy6DPtaZXmX+8OrEmY=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-358-a7GbRoiyNzCuQWhFftyCrg-1; Tue, 22 Feb 2022 11:11:22 -0500
X-MC-Unique: a7GbRoiyNzCuQWhFftyCrg-1
Received: by mail-qk1-f200.google.com with SMTP id p67-20020a378d46000000b0062adb7627edso39785qkd.8
        for <linux-fpga@vger.kernel.org>; Tue, 22 Feb 2022 08:11:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Q/F/MVRVsTXPiEmPkOpNXGwvpePHO5WGa1Rhgl2MILM=;
        b=HpqxD7DpgPRUhARa6G5DLnFT3NyS1J0sU9qM9NUzBQt40BBQA6XwtWYEGzjM0HLTcJ
         99AcRx1wmMFLUhp90UN7iXw7X3ZvecI2E2Xadw3XlrBV/JcZnBpRETGxLFL3RUtc3SG4
         yPriHG5/XYS8OFxaY3tN2bKoomrP864tx6lCAn4WH/D8UE/5fm2c5aStGgOh745VOTgK
         0fqGS9Q0IqH6KmgVsxR2P2fuBkegjoWgSBoD8ch1H5OoRpgRA6sCz93hjQqkmo0PQM3W
         ElWUXYoiU9czTK+wTy8Lvj4NuLMruNZES+SBvj4rwCxmC9t2xCOPsUN5pswR1dmOejrw
         bVEA==
X-Gm-Message-State: AOAM532dUDv41CrUXrqWu1bABpj7G9NbkcJRa7GXlUdZQm8uSUKvVuwH
        LFE7lyPLcCbKyQ15DVwqDYy0uimnD6dU6rEYU6QCVaV5GF92YPRpoyteQ5IltO/hJFNrtdCDynh
        WObnMQdMqQyxDx1nVY5cGqQ==
X-Received: by 2002:a05:622a:1742:b0:2de:15f5:3174 with SMTP id l2-20020a05622a174200b002de15f53174mr9829658qtk.120.1645546281626;
        Tue, 22 Feb 2022 08:11:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzpwBsgebxfkzUv4rYUBVSMsVhHz9GRzj2DoZFSt26b26CuEaSKZesdNrMyIyb9ZTDYkGtRiA==
X-Received: by 2002:a05:622a:1742:b0:2de:15f5:3174 with SMTP id l2-20020a05622a174200b002de15f53174mr9829629qtk.120.1645546281336;
        Tue, 22 Feb 2022 08:11:21 -0800 (PST)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id r3sm14288qkm.56.2022.02.22.08.11.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Feb 2022 08:11:20 -0800 (PST)
Subject: Re: [PATCH v1 7/7] fpga: dfl: pci: Add generic OFS PCI PID
To:     "Zhang, Tianfei" <tianfei.zhang@intel.com>,
        "matthew.gerlach@linux.intel.com" <matthew.gerlach@linux.intel.com>
Cc:     "Wu, Hao" <hao.wu@intel.com>, "mdf@kernel.org" <mdf@kernel.org>,
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
 <e5580849-c137-fb61-0599-198c341bf688@redhat.com>
 <BN9PR11MB54835A454A34ECE13349B555E33B9@BN9PR11MB5483.namprd11.prod.outlook.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <d6cf0f48-e90a-6441-6096-5b87122a0bb6@redhat.com>
Date:   Tue, 22 Feb 2022 08:11:18 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <BN9PR11MB54835A454A34ECE13349B555E33B9@BN9PR11MB5483.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 2/21/22 7:11 PM, Zhang, Tianfei wrote:
>
>> -----Original Message-----
>> From: Tom Rix <trix@redhat.com>
>> Sent: Tuesday, February 22, 2022 2:10 AM
>> To: matthew.gerlach@linux.intel.com
>> Cc: Zhang, Tianfei <tianfei.zhang@intel.com>; Wu, Hao <hao.wu@intel.com>;
>> mdf@kernel.org; Xu, Yilun <yilun.xu@intel.com>; linux-fpga@vger.kernel.org;
>> linux-doc@vger.kernel.org; linux-kernel@vger.kernel.org; corbet@lwn.net
>> Subject: Re: [PATCH v1 7/7] fpga: dfl: pci: Add generic OFS PCI PID
>>
>>
>> On 2/21/22 9:50 AM, matthew.gerlach@linux.intel.com wrote:
>>>
>>> On Fri, 18 Feb 2022, Tom Rix wrote:
>>>
>>>> On 2/18/22 1:03 AM, Zhang, Tianfei wrote:
>>>>>> -----Original Message-----
>>>>>> From: Tom Rix <trix@redhat.com>
>>>>>> Sent: Wednesday, February 16, 2022 12:16 AM
>>>>>> To: Zhang, Tianfei <tianfei.zhang@intel.com>; Wu, Hao
>>>>>> <hao.wu@intel.com>; mdf@kernel.org; Xu, Yilun <yilun.xu@intel.com>;
>>>>>> linux-fpga@vger.kernel.org; linux-doc@vger.kernel.org;
>>>>>> linux-kernel@vger.kernel.org
>>>>>> Cc: corbet@lwn.net; Matthew Gerlach
>>>>>> <matthew.gerlach@linux.intel.com>
>>>>>> Subject: Re: [PATCH v1 7/7] fpga: dfl: pci: Add generic OFS PCI PID
>>>>>>
>>>>>>
>>>>>> On 2/14/22 3:26 AM, Tianfei zhang wrote:
>>>>>>> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>>>>>>
>>>>>>> Add the PCI product id for an Open FPGA Stack PCI card.
>>>>>> Is there a URL to the card ?
>>>>> This PCIe Device IDs have registered by Intel.
>>>> A URL is useful to introduce the board, Is there one ?
>>>>>>> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>>>>>> Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
>>>>>>> ---
>>>>>>>     drivers/fpga/dfl-pci.c | 4 ++++
>>>>>>>     1 file changed, 4 insertions(+)
>>>>>>>
>>>>>>> diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c index
>>>>>>> 83b604d6dbe6..cb2fbf3eb918 100644
>>>>>>> --- a/drivers/fpga/dfl-pci.c
>>>>>>> +++ b/drivers/fpga/dfl-pci.c
>>>>>>> @@ -76,12 +76,14 @@ static void cci_pci_free_irq(struct pci_dev
>>>>>>> *pcidev)
>>>>>>>     #define PCIE_DEVICE_ID_INTEL_PAC_D5005        0x0B2B
>>>>>>>     #define PCIE_DEVICE_ID_SILICOM_PAC_N5010    0x1000
>>>>>>>     #define PCIE_DEVICE_ID_SILICOM_PAC_N5011    0x1001
>>>>>>> +#define PCIE_DEVICE_ID_INTEL_OFS        0xbcce
>>>>>> INTEL_OFS is a generic name, pci id's map to specific cards
>>>>>>
>>>>>> Is there a more specific name for this card ?
>>>>> I think using INTEL_OFS is better, because INTEL_OFS is the Generic
>>>>> development platform can support multiple cards which using OFS
>>>>> specification, like Intel PAC N6000 card.
>>>> I would prefer something like PCIE_DEVICE_ID_INTEL_PAC_N6000 because
>>>> it follows an existing pattern.  Make it easy on a developer, they
>>>> will look at their board or box, see X and try to find something
>>>> similar in the driver source.
>>>>
>>>> To use OSF_ * the name needs a suffix to differentiate it from future
>>>> cards that will also use ofs.
>>>>
>>>> If this really is a generic id please explain in the doc patch how
>>>> every future board with use this single id and how a driver could
>>>> work around a hw problem in a specific board with a pci id covering
>>>> multiple boards.
>>>>
>>>> Tom
>>> Hi Tom,
>>>
>>> The intent is to have a generic device id that can be used with many
>>> different boards.  Currently, we have FPGA implementations for 3
>>> different boards using this generic id.  We may need a better name for
>>> device id than OFS.  More precisely this generic device id means a PCI
>>> function that is described by a Device Feature List (DFL).  How about
>>> PCIE_DEVICE_ID_INTEL_DFL?
>>>
>>> With a DFL device id, the functionality of the PF/VF is determined by
>>> the contents of the DFL.  Each Device Feature Header (DFH) in the DFL
>>> has a revision field that can be used identify "broken" hw, or new
>>> functionality added to a feature.  Additionally, since the DFL is
>>> typically used in a FPGA, the broken hardware, can and should be fixed
>>> in most cases.
>> How is lspci supposed to work ?
> There is an example for one card using IOFS and DFL.
>
> # lspci | grep acc
> b1:00.0 Processing accelerators: Intel Corporation Device bcce (rev 01)
> b1:00.1 Processing accelerators: Intel Corporation Device bcce
> b1:00.2 Processing accelerators: Intel Corporation Device bcce
> b1:00.3 Processing accelerators: Red Hat, Inc. Virtio network device
> b1:00.4 Processing accelerators: Intel Corporation Device bcce
>
> Note: There 5 PFs in this card, it exports the management functions via PF0(b1:00.0),
> Other PFs like b1:00.1, b1:00.2, b1:00.4, are using for testing, which depends on RTL designer
> or project requirement. The PF3 instance a VirtIO net device for example, will bind with virtio-net driver
> presenting itself as a network interface to the OS.

What I mean there is heterogeneous set of cards in one machine, how do 
you tell which card is which ?

Or in a datacenter where the machines are all remote and admin has to 
flash just the n6000's ?

How could she find just the n6000's with lspci ?

How would the driver know ?

Tom

>
>> A dfl set can change with fw updates and in theory different boards could have
>> the same set.
>>
>> Tom
>>
>>> Matthew
>>>>>> Tom
>>>>>>
>>>>>>>     /* VF Device */
>>>>>>>     #define PCIE_DEVICE_ID_VF_INT_5_X        0xBCBF
>>>>>>>     #define PCIE_DEVICE_ID_VF_INT_6_X        0xBCC1
>>>>>>>     #define PCIE_DEVICE_ID_VF_DSC_1_X        0x09C5
>>>>>>>     #define PCIE_DEVICE_ID_INTEL_PAC_D5005_VF    0x0B2C
>>>>>>> +#define PCIE_DEVICE_ID_INTEL_OFS_VF        0xbccf
>>>>>>>
>>>>>>>     static struct pci_device_id cci_pcie_id_tbl[] = {
>>>>>>>         {PCI_DEVICE(PCI_VENDOR_ID_INTEL,
>>>>>>> PCIE_DEVICE_ID_PF_INT_5_X),},
>>>>>> @@
>>>>>>> -95,6 +97,8 @@ static struct pci_device_id cci_pcie_id_tbl[] = {
>>>>>>>         {PCI_DEVICE(PCI_VENDOR_ID_INTEL,
>>>>>> PCIE_DEVICE_ID_INTEL_PAC_D5005_VF),},
>>>>>>> {PCI_DEVICE(PCI_VENDOR_ID_SILICOM_DENMARK,
>>>>>> PCIE_DEVICE_ID_SILICOM_PAC_N5010),},
>>>>>>> {PCI_DEVICE(PCI_VENDOR_ID_SILICOM_DENMARK,
>>>>>>> PCIE_DEVICE_ID_SILICOM_PAC_N5011),},
>>>>>>> +    {PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_INTEL_OFS),},
>>>>>>> +    {PCI_DEVICE(PCI_VENDOR_ID_INTEL,
>>>>>> PCIE_DEVICE_ID_INTEL_OFS_VF),},
>>>>>>>         {0,}
>>>>>>>     };
>>>>>>>     MODULE_DEVICE_TABLE(pci, cci_pcie_id_tbl);
>>>>

