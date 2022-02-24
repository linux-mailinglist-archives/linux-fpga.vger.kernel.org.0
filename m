Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E316E4C3413
	for <lists+linux-fpga@lfdr.de>; Thu, 24 Feb 2022 18:54:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232359AbiBXRxD (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 24 Feb 2022 12:53:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbiBXRxD (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 24 Feb 2022 12:53:03 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A52F8BA2;
        Thu, 24 Feb 2022 09:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645725152; x=1677261152;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ybMboQK0jeoBMl9EQRc6Wo0omyQWbrvhNrxnq0NCFP4=;
  b=Awh/x4yAX+ZZSGAlNY4ZMHs4znWUKROApneAUhgtDQj6HD64+geE/9PZ
   nmmR1VsfLI+i4hl40Uy9oLOnROYqr/gmuc+fW8RHH6F6eOVgvW7nCgAAV
   rKiGw2Ob1MN6lfHu/nAQQOuhM2JN/wWXS0GHyC4nRqBihccvL+cDbmgto
   DQ+7Sgkvr6vLQtSr7qEOt8Z5oCJZVVyumbezCoRzBjlUgohZqr5pe9Yg3
   LDjLBn/fxIwaOx8lvDXBNxaVJuncyD48H3mObs2p0ikoI6ae9OQj8Pcx2
   qE0SIiGm+YJaauJeugf41ZWb89ZhhBxjzp8bQRkCnEJToJ/bwN1B6Cxhz
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="313019608"
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="313019608"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 09:52:32 -0800
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="533230044"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.40])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 09:52:32 -0800
Date:   Thu, 24 Feb 2022 09:54:36 -0800 (PST)
From:   matthew.gerlach@linux.intel.com
X-X-Sender: mgerlach@rhweight-WRK1
To:     Tom Rix <trix@redhat.com>
cc:     "Zhang, Tianfei" <tianfei.zhang@intel.com>,
        "Wu, Hao" <hao.wu@intel.com>, "mdf@kernel.org" <mdf@kernel.org>,
        "Xu, Yilun" <yilun.xu@intel.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>, aaron.j.grier@intel.com
Subject: Re: [PATCH v1 7/7] fpga: dfl: pci: Add generic OFS PCI PID
In-Reply-To: <d6cf0f48-e90a-6441-6096-5b87122a0bb6@redhat.com>
Message-ID: <alpine.DEB.2.22.394.2202240932380.634457@rhweight-WRK1>
References: <20220214112619.219761-1-tianfei.zhang@intel.com> <20220214112619.219761-8-tianfei.zhang@intel.com> <ed8f4b5f-5c92-f555-ed2d-c5b8f38d5372@redhat.com> <BN9PR11MB5483BC7EE52A47CEAEFC58A0E3379@BN9PR11MB5483.namprd11.prod.outlook.com>
 <3c9fce03-ef29-d80f-6639-0c237c28cf58@redhat.com> <alpine.DEB.2.22.394.2202210934570.117064@rhweight-WRK1> <e5580849-c137-fb61-0599-198c341bf688@redhat.com> <BN9PR11MB54835A454A34ECE13349B555E33B9@BN9PR11MB5483.namprd11.prod.outlook.com>
 <d6cf0f48-e90a-6441-6096-5b87122a0bb6@redhat.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1521138016-1645725283=:634457"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1521138016-1645725283=:634457
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT



On Tue, 22 Feb 2022, Tom Rix wrote:

>
> On 2/21/22 7:11 PM, Zhang, Tianfei wrote:
>> 
>>> -----Original Message-----
>>> From: Tom Rix <trix@redhat.com>
>>> Sent: Tuesday, February 22, 2022 2:10 AM
>>> To: matthew.gerlach@linux.intel.com
>>> Cc: Zhang, Tianfei <tianfei.zhang@intel.com>; Wu, Hao <hao.wu@intel.com>;
>>> mdf@kernel.org; Xu, Yilun <yilun.xu@intel.com>; 
>>> linux-fpga@vger.kernel.org;
>>> linux-doc@vger.kernel.org; linux-kernel@vger.kernel.org; corbet@lwn.net
>>> Subject: Re: [PATCH v1 7/7] fpga: dfl: pci: Add generic OFS PCI PID
>>> 
>>> 
>>> On 2/21/22 9:50 AM, matthew.gerlach@linux.intel.com wrote:
>>>> 
>>>> On Fri, 18 Feb 2022, Tom Rix wrote:
>>>> 
>>>>> On 2/18/22 1:03 AM, Zhang, Tianfei wrote:
>>>>>>> -----Original Message-----
>>>>>>> From: Tom Rix <trix@redhat.com>
>>>>>>> Sent: Wednesday, February 16, 2022 12:16 AM
>>>>>>> To: Zhang, Tianfei <tianfei.zhang@intel.com>; Wu, Hao
>>>>>>> <hao.wu@intel.com>; mdf@kernel.org; Xu, Yilun <yilun.xu@intel.com>;
>>>>>>> linux-fpga@vger.kernel.org; linux-doc@vger.kernel.org;
>>>>>>> linux-kernel@vger.kernel.org
>>>>>>> Cc: corbet@lwn.net; Matthew Gerlach
>>>>>>> <matthew.gerlach@linux.intel.com>
>>>>>>> Subject: Re: [PATCH v1 7/7] fpga: dfl: pci: Add generic OFS PCI PID
>>>>>>> 
>>>>>>> 
>>>>>>> On 2/14/22 3:26 AM, Tianfei zhang wrote:
>>>>>>>> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>>>>>>> 
>>>>>>>> Add the PCI product id for an Open FPGA Stack PCI card.
>>>>>>> Is there a URL to the card ?
>>>>>> This PCIe Device IDs have registered by Intel.
>>>>> A URL is useful to introduce the board, Is there one ?
>>>>>>>> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>>>>>>> Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
>>>>>>>> ---
>>>>>>>>     drivers/fpga/dfl-pci.c | 4 ++++
>>>>>>>>     1 file changed, 4 insertions(+)
>>>>>>>> 
>>>>>>>> diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c index
>>>>>>>> 83b604d6dbe6..cb2fbf3eb918 100644
>>>>>>>> --- a/drivers/fpga/dfl-pci.c
>>>>>>>> +++ b/drivers/fpga/dfl-pci.c
>>>>>>>> @@ -76,12 +76,14 @@ static void cci_pci_free_irq(struct pci_dev
>>>>>>>> *pcidev)
>>>>>>>>     #define PCIE_DEVICE_ID_INTEL_PAC_D5005        0x0B2B
>>>>>>>>     #define PCIE_DEVICE_ID_SILICOM_PAC_N5010    0x1000
>>>>>>>>     #define PCIE_DEVICE_ID_SILICOM_PAC_N5011    0x1001
>>>>>>>> +#define PCIE_DEVICE_ID_INTEL_OFS        0xbcce
>>>>>>> INTEL_OFS is a generic name, pci id's map to specific cards
>>>>>>> 
>>>>>>> Is there a more specific name for this card ?
>>>>>> I think using INTEL_OFS is better, because INTEL_OFS is the Generic
>>>>>> development platform can support multiple cards which using OFS
>>>>>> specification, like Intel PAC N6000 card.
>>>>> I would prefer something like PCIE_DEVICE_ID_INTEL_PAC_N6000 because
>>>>> it follows an existing pattern.  Make it easy on a developer, they
>>>>> will look at their board or box, see X and try to find something
>>>>> similar in the driver source.
>>>>> 
>>>>> To use OSF_ * the name needs a suffix to differentiate it from future
>>>>> cards that will also use ofs.
>>>>> 
>>>>> If this really is a generic id please explain in the doc patch how
>>>>> every future board with use this single id and how a driver could
>>>>> work around a hw problem in a specific board with a pci id covering
>>>>> multiple boards.
>>>>> 
>>>>> Tom
>>>> Hi Tom,
>>>> 
>>>> The intent is to have a generic device id that can be used with many
>>>> different boards.  Currently, we have FPGA implementations for 3
>>>> different boards using this generic id.  We may need a better name for
>>>> device id than OFS.  More precisely this generic device id means a PCI
>>>> function that is described by a Device Feature List (DFL).  How about
>>>> PCIE_DEVICE_ID_INTEL_DFL?
>>>> 
>>>> With a DFL device id, the functionality of the PF/VF is determined by
>>>> the contents of the DFL.  Each Device Feature Header (DFH) in the DFL
>>>> has a revision field that can be used identify "broken" hw, or new
>>>> functionality added to a feature.  Additionally, since the DFL is
>>>> typically used in a FPGA, the broken hardware, can and should be fixed
>>>> in most cases.
>>> How is lspci supposed to work ?
>> There is an example for one card using IOFS and DFL.
>> 
>> # lspci | grep acc
>> b1:00.0 Processing accelerators: Intel Corporation Device bcce (rev 01)
>> b1:00.1 Processing accelerators: Intel Corporation Device bcce
>> b1:00.2 Processing accelerators: Intel Corporation Device bcce
>> b1:00.3 Processing accelerators: Red Hat, Inc. Virtio network device
>> b1:00.4 Processing accelerators: Intel Corporation Device bcce
>> 
>> Note: There 5 PFs in this card, it exports the management functions via 
>> PF0(b1:00.0),
>> Other PFs like b1:00.1, b1:00.2, b1:00.4, are using for testing, which 
>> depends on RTL designer
>> or project requirement. The PF3 instance a VirtIO net device for example, 
>> will bind with virtio-net driver
>> presenting itself as a network interface to the OS.

Hi Tom,

These are very good questions, and the answers will be addressed in the 
documentation associated with a v2 submission of this patch.

>
> What I mean there is heterogeneous set of cards in one machine, how do you 
> tell which card is which ?

If the PCI PID/VID is generic, indicating only that there is one or more 
DFL, then some other mechanism must be used to differentiate the cards. 
One could use unique PCI sub-PID/sub-VIDs to differentiate specific 
implementations.  One could also use some register in BAR space to help 
identify the card, or one could use PCI Vital Product Data (VPD) to 
provide detailed information about the running FPGA design on the card.

>
> Or in a datacenter where the machines are all remote and admin has to flash 
> just the n6000's ?

This problem exists with the N3000 cards.  Depending on the FPGA 
configuration, the line side of the card could be very different (e.g. 
4x10Gb or 2x2x25Gb).  The network operator must make sure to update a 
particular N3000 card with the correct FPGA image type.  In the case of 
the N3000 there is a register exposed through sysfs containing the 
"Bitstream ID" which contains the line side configuration of the FPGA.

>
> How could she find just the n6000's with lspci ?

If you only wanted to use lspci to determine the card, then 
differentiating PCI sub-VID/sub-PID could be used or VPD could be used.

>
> How would the driver know ?

The dfl-pci driver is fairly generic in that it doesn't really care about 
the PCI PID/VID because all it really does enumerate the DFLs.  It is the 
individual dfl drivers that may need to know hw differences/bugs for that 
component IP.

>
> Tom
>
>> 
>>> A dfl set can change with fw updates and in theory different boards could 
>>> have
>>> the same set.
>>> 
>>> Tom
>>> 
>>>> Matthew
>>>>>>> Tom
>>>>>>>
>>>>>>>>     /* VF Device */
>>>>>>>>     #define PCIE_DEVICE_ID_VF_INT_5_X        0xBCBF
>>>>>>>>     #define PCIE_DEVICE_ID_VF_INT_6_X        0xBCC1
>>>>>>>>     #define PCIE_DEVICE_ID_VF_DSC_1_X        0x09C5
>>>>>>>>     #define PCIE_DEVICE_ID_INTEL_PAC_D5005_VF    0x0B2C
>>>>>>>> +#define PCIE_DEVICE_ID_INTEL_OFS_VF        0xbccf
>>>>>>>>
>>>>>>>>     static struct pci_device_id cci_pcie_id_tbl[] = {
>>>>>>>>         {PCI_DEVICE(PCI_VENDOR_ID_INTEL,
>>>>>>>> PCIE_DEVICE_ID_PF_INT_5_X),},
>>>>>>> @@
>>>>>>>> -95,6 +97,8 @@ static struct pci_device_id cci_pcie_id_tbl[] = {
>>>>>>>>         {PCI_DEVICE(PCI_VENDOR_ID_INTEL,
>>>>>>> PCIE_DEVICE_ID_INTEL_PAC_D5005_VF),},
>>>>>>>> {PCI_DEVICE(PCI_VENDOR_ID_SILICOM_DENMARK,
>>>>>>> PCIE_DEVICE_ID_SILICOM_PAC_N5010),},
>>>>>>>> {PCI_DEVICE(PCI_VENDOR_ID_SILICOM_DENMARK,
>>>>>>>> PCIE_DEVICE_ID_SILICOM_PAC_N5011),},
>>>>>>>> +    {PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_INTEL_OFS),},
>>>>>>>> +    {PCI_DEVICE(PCI_VENDOR_ID_INTEL,
>>>>>>> PCIE_DEVICE_ID_INTEL_OFS_VF),},
>>>>>>>>         {0,}
>>>>>>>>     };
>>>>>>>>     MODULE_DEVICE_TABLE(pci, cci_pcie_id_tbl);
>>>>> 
>
>
--8323328-1521138016-1645725283=:634457--
