Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FBD64C7F27
	for <lists+linux-fpga@lfdr.de>; Tue,  1 Mar 2022 01:24:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbiCAAXn (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 28 Feb 2022 19:23:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiCAAXm (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 28 Feb 2022 19:23:42 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4DEE2A266;
        Mon, 28 Feb 2022 16:22:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646094179; x=1677630179;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=XUmmuHjG8G/Dw4YcsSBZoSmwvfmIIN75R1y/yRMIssk=;
  b=OdwjHFtAtp466VNc7gwPerSsgNihQ4xP9p+j4QKdTsfOjFsP4GVHinDg
   vXWFJIE6q/ZCn6jwYR9rolDW7PpsGfh4jEtKXnh3KPJmXeraT1iYKaGrU
   9uUDGCEuexyk3FlJFjCtgZJcgueqz4VP+waFMoXajSWC2xL1yQGAg6wV0
   uyYZYqhqf3LcZxut/QW7jM1aZDhU770ygNvFnih8+n0jM0T81cAJjrsMN
   oNgMpJ+IcOWMlXDvvbW3igVXutOauvKnBq+z/6TIV/KaGIU+zTlHSSIjP
   ZblNG8wAlOj/+7QuPrzssR2w8mqKNIS0wJqDtTckT52aEFbcI69rwUBuG
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="277682743"
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="277682743"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 16:22:59 -0800
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="510296877"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.40])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 16:22:59 -0800
Date:   Mon, 28 Feb 2022 16:25:03 -0800 (PST)
From:   matthew.gerlach@linux.intel.com
X-X-Sender: mgerlach@rhweight-WRK1
To:     "Wu, Hao" <hao.wu@intel.com>
cc:     Tom Rix <trix@redhat.com>,
        "Zhang, Tianfei" <tianfei.zhang@intel.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "Xu, Yilun" <yilun.xu@intel.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "Grier, Aaron J" <aaron.j.grier@intel.com>
Subject: RE: [PATCH v1 7/7] fpga: dfl: pci: Add generic OFS PCI PID
In-Reply-To: <DM6PR11MB38194BD59EBFE97F125A37B685019@DM6PR11MB3819.namprd11.prod.outlook.com>
Message-ID: <alpine.DEB.2.22.394.2202281618480.103377@rhweight-WRK1>
References: <20220214112619.219761-1-tianfei.zhang@intel.com> <20220214112619.219761-8-tianfei.zhang@intel.com> <ed8f4b5f-5c92-f555-ed2d-c5b8f38d5372@redhat.com> <BN9PR11MB5483BC7EE52A47CEAEFC58A0E3379@BN9PR11MB5483.namprd11.prod.outlook.com>
 <3c9fce03-ef29-d80f-6639-0c237c28cf58@redhat.com> <alpine.DEB.2.22.394.2202210934570.117064@rhweight-WRK1> <e5580849-c137-fb61-0599-198c341bf688@redhat.com> <BN9PR11MB54835A454A34ECE13349B555E33B9@BN9PR11MB5483.namprd11.prod.outlook.com>
 <d6cf0f48-e90a-6441-6096-5b87122a0bb6@redhat.com> <alpine.DEB.2.22.394.2202240932380.634457@rhweight-WRK1> <DM6PR11MB38194BD59EBFE97F125A37B685019@DM6PR11MB3819.namprd11.prod.outlook.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-604420537-1646094309=:103377"
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-604420537-1646094309=:103377
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT



On Mon, 28 Feb 2022, Wu, Hao wrote:

>>>
>>> On 2/21/22 7:11 PM, Zhang, Tianfei wrote:
>>>>
>>>>> -----Original Message-----
>>>>> From: Tom Rix <trix@redhat.com>
>>>>> Sent: Tuesday, February 22, 2022 2:10 AM
>>>>> To: matthew.gerlach@linux.intel.com
>>>>> Cc: Zhang, Tianfei <tianfei.zhang@intel.com>; Wu, Hao
>> <hao.wu@intel.com>;
>>>>> mdf@kernel.org; Xu, Yilun <yilun.xu@intel.com>;
>>>>> linux-fpga@vger.kernel.org;
>>>>> linux-doc@vger.kernel.org; linux-kernel@vger.kernel.org; corbet@lwn.net
>>>>> Subject: Re: [PATCH v1 7/7] fpga: dfl: pci: Add generic OFS PCI PID
>>>>>
>>>>>
>>>>> On 2/21/22 9:50 AM, matthew.gerlach@linux.intel.com wrote:
>>>>>>
>>>>>> On Fri, 18 Feb 2022, Tom Rix wrote:
>>>>>>
>>>>>>> On 2/18/22 1:03 AM, Zhang, Tianfei wrote:
>>>>>>>>> -----Original Message-----
>>>>>>>>> From: Tom Rix <trix@redhat.com>
>>>>>>>>> Sent: Wednesday, February 16, 2022 12:16 AM
>>>>>>>>> To: Zhang, Tianfei <tianfei.zhang@intel.com>; Wu, Hao
>>>>>>>>> <hao.wu@intel.com>; mdf@kernel.org; Xu, Yilun <yilun.xu@intel.com>;
>>>>>>>>> linux-fpga@vger.kernel.org; linux-doc@vger.kernel.org;
>>>>>>>>> linux-kernel@vger.kernel.org
>>>>>>>>> Cc: corbet@lwn.net; Matthew Gerlach
>>>>>>>>> <matthew.gerlach@linux.intel.com>
>>>>>>>>> Subject: Re: [PATCH v1 7/7] fpga: dfl: pci: Add generic OFS PCI PID
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> On 2/14/22 3:26 AM, Tianfei zhang wrote:
>>>>>>>>>> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>>>>>>>>>
>>>>>>>>>> Add the PCI product id for an Open FPGA Stack PCI card.
>>>>>>>>> Is there a URL to the card ?
>>>>>>>> This PCIe Device IDs have registered by Intel.
>>>>>>> A URL is useful to introduce the board, Is there one ?
>>>>>>>>>> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>>>>>>>>> Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
>>>>>>>>>> ---
>>>>>>>>>>     drivers/fpga/dfl-pci.c | 4 ++++
>>>>>>>>>>     1 file changed, 4 insertions(+)
>>>>>>>>>>
>>>>>>>>>> diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c index
>>>>>>>>>> 83b604d6dbe6..cb2fbf3eb918 100644
>>>>>>>>>> --- a/drivers/fpga/dfl-pci.c
>>>>>>>>>> +++ b/drivers/fpga/dfl-pci.c
>>>>>>>>>> @@ -76,12 +76,14 @@ static void cci_pci_free_irq(struct pci_dev
>>>>>>>>>> *pcidev)
>>>>>>>>>>     #define PCIE_DEVICE_ID_INTEL_PAC_D5005        0x0B2B
>>>>>>>>>>     #define PCIE_DEVICE_ID_SILICOM_PAC_N5010    0x1000
>>>>>>>>>>     #define PCIE_DEVICE_ID_SILICOM_PAC_N5011    0x1001
>>>>>>>>>> +#define PCIE_DEVICE_ID_INTEL_OFS        0xbcce
>>>>>>>>> INTEL_OFS is a generic name, pci id's map to specific cards
>>>>>>>>>
>>>>>>>>> Is there a more specific name for this card ?
>>>>>>>> I think using INTEL_OFS is better, because INTEL_OFS is the Generic
>>>>>>>> development platform can support multiple cards which using OFS
>>>>>>>> specification, like Intel PAC N6000 card.
>>>>>>> I would prefer something like PCIE_DEVICE_ID_INTEL_PAC_N6000
>> because
>>>>>>> it follows an existing pattern.  Make it easy on a developer, they
>>>>>>> will look at their board or box, see X and try to find something
>>>>>>> similar in the driver source.
>>>>>>>
>>>>>>> To use OSF_ * the name needs a suffix to differentiate it from future
>>>>>>> cards that will also use ofs.
>>>>>>>
>>>>>>> If this really is a generic id please explain in the doc patch how
>>>>>>> every future board with use this single id and how a driver could
>>>>>>> work around a hw problem in a specific board with a pci id covering
>>>>>>> multiple boards.
>>>>>>>
>>>>>>> Tom
>>>>>> Hi Tom,
>>>>>>
>>>>>> The intent is to have a generic device id that can be used with many
>>>>>> different boards.  Currently, we have FPGA implementations for 3
>>>>>> different boards using this generic id.  We may need a better name for
>>>>>> device id than OFS.  More precisely this generic device id means a PCI
>>>>>> function that is described by a Device Feature List (DFL).  How about
>>>>>> PCIE_DEVICE_ID_INTEL_DFL?
>>>>>>
>>>>>> With a DFL device id, the functionality of the PF/VF is determined by
>>>>>> the contents of the DFL.  Each Device Feature Header (DFH) in the DFL
>>>>>> has a revision field that can be used identify "broken" hw, or new
>>>>>> functionality added to a feature.  Additionally, since the DFL is
>>>>>> typically used in a FPGA, the broken hardware, can and should be fixed
>>>>>> in most cases.
>>>>> How is lspci supposed to work ?
>>>> There is an example for one card using IOFS and DFL.
>>>>
>>>> # lspci | grep acc
>>>> b1:00.0 Processing accelerators: Intel Corporation Device bcce (rev 01)
>>>> b1:00.1 Processing accelerators: Intel Corporation Device bcce
>>>> b1:00.2 Processing accelerators: Intel Corporation Device bcce
>>>> b1:00.3 Processing accelerators: Red Hat, Inc. Virtio network device
>>>> b1:00.4 Processing accelerators: Intel Corporation Device bcce
>>>>
>>>> Note: There 5 PFs in this card, it exports the management functions via
>>>> PF0(b1:00.0),
>>>> Other PFs like b1:00.1, b1:00.2, b1:00.4, are using for testing, which
>>>> depends on RTL designer
>>>> or project requirement. The PF3 instance a VirtIO net device for example,
>>>> will bind with virtio-net driver
>>>> presenting itself as a network interface to the OS.
>>
>> Hi Tom,
>>
>> These are very good questions, and the answers will be addressed in the
>> documentation associated with a v2 submission of this patch.
>>
>>>
>>> What I mean there is heterogeneous set of cards in one machine, how do you
>>> tell which card is which ?
>>
>> If the PCI PID/VID is generic, indicating only that there is one or more
>> DFL, then some other mechanism must be used to differentiate the cards.
>> One could use unique PCI sub-PID/sub-VIDs to differentiate specific
>> implementations.  One could also use some register in BAR space to help
>> identify the card, or one could use PCI Vital Product Data (VPD) to
>> provide detailed information about the running FPGA design on the card.
>
> Ideally DFL has different scope than PCI. DFL is a higher layer concept than
> PCI, as DFL can be applied to PCI device, platform device or even other devices.
> If some PCI level quirks need to be applied before accessing BAR for one card,
> then DFL may not be able to help at all. Use PCI level solution should be better,
> and different VID/DID may be the easiest solution.
>
> Hao

Very good point Hao.  DFL is a higher layer than PCI.  So PCI level quirks 
would need to be handled at the PCI level.  The VID/DID, optionally 
in conjuction with the Subsytem Vendor ID and Substem ID, would be used to 
determine how the quirks were applied.

Matthew


>>
>>>
>>> Or in a datacenter where the machines are all remote and admin has to flash
>>> just the n6000's ?
>>
>> This problem exists with the N3000 cards.  Depending on the FPGA
>> configuration, the line side of the card could be very different (e.g.
>> 4x10Gb or 2x2x25Gb).  The network operator must make sure to update a
>> particular N3000 card with the correct FPGA image type.  In the case of
>> the N3000 there is a register exposed through sysfs containing the
>> "Bitstream ID" which contains the line side configuration of the FPGA.
>>
>>>
>>> How could she find just the n6000's with lspci ?
>>
>> If you only wanted to use lspci to determine the card, then
>> differentiating PCI sub-VID/sub-PID could be used or VPD could be used.
>>
>>>
>>> How would the driver know ?
>>
>> The dfl-pci driver is fairly generic in that it doesn't really care about
>> the PCI PID/VID because all it really does enumerate the DFLs.  It is the
>> individual dfl drivers that may need to know hw differences/bugs for that
>> component IP.
>>
>>>
>>> Tom
>>>
>>>>
>>>>> A dfl set can change with fw updates and in theory different boards could
>>>>> have
>>>>> the same set.
>>>>>
>>>>> Tom
>>>>>
>>>>>> Matthew
>>>>>>>>> Tom
>>>>>>>>>
>>>>>>>>>>     /* VF Device */
>>>>>>>>>>     #define PCIE_DEVICE_ID_VF_INT_5_X        0xBCBF
>>>>>>>>>>     #define PCIE_DEVICE_ID_VF_INT_6_X        0xBCC1
>>>>>>>>>>     #define PCIE_DEVICE_ID_VF_DSC_1_X        0x09C5
>>>>>>>>>>     #define PCIE_DEVICE_ID_INTEL_PAC_D5005_VF    0x0B2C
>>>>>>>>>> +#define PCIE_DEVICE_ID_INTEL_OFS_VF        0xbccf
>>>>>>>>>>
>>>>>>>>>>     static struct pci_device_id cci_pcie_id_tbl[] = {
>>>>>>>>>>         {PCI_DEVICE(PCI_VENDOR_ID_INTEL,
>>>>>>>>>> PCIE_DEVICE_ID_PF_INT_5_X),},
>>>>>>>>> @@
>>>>>>>>>> -95,6 +97,8 @@ static struct pci_device_id cci_pcie_id_tbl[] = {
>>>>>>>>>>         {PCI_DEVICE(PCI_VENDOR_ID_INTEL,
>>>>>>>>> PCIE_DEVICE_ID_INTEL_PAC_D5005_VF),},
>>>>>>>>>> {PCI_DEVICE(PCI_VENDOR_ID_SILICOM_DENMARK,
>>>>>>>>> PCIE_DEVICE_ID_SILICOM_PAC_N5010),},
>>>>>>>>>> {PCI_DEVICE(PCI_VENDOR_ID_SILICOM_DENMARK,
>>>>>>>>>> PCIE_DEVICE_ID_SILICOM_PAC_N5011),},
>>>>>>>>>> +    {PCI_DEVICE(PCI_VENDOR_ID_INTEL,
>> PCIE_DEVICE_ID_INTEL_OFS),},
>>>>>>>>>> +    {PCI_DEVICE(PCI_VENDOR_ID_INTEL,
>>>>>>>>> PCIE_DEVICE_ID_INTEL_OFS_VF),},
>>>>>>>>>>         {0,}
>>>>>>>>>>     };
>>>>>>>>>>     MODULE_DEVICE_TABLE(pci, cci_pcie_id_tbl);
>>>>>>>
>>>
>>>
>
--8323328-604420537-1646094309=:103377--
