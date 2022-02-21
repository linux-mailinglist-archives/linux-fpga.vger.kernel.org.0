Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7AC54BEA11
	for <lists+linux-fpga@lfdr.de>; Mon, 21 Feb 2022 19:09:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbiBURzc (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 21 Feb 2022 12:55:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbiBURwj (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 21 Feb 2022 12:52:39 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C73DB53;
        Mon, 21 Feb 2022 09:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645465689; x=1677001689;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=vDI+NG/dV4Z+g4ONPVVEn1Ifl6BUxDwHQGb78BJ5Tuc=;
  b=mutujD4gjSs35DQNyhBm6gZItJlCHFk/wZn5eoQlAgZrXIcybvxu+Eag
   mRwdPoBvGqX2lIfUzvRaP9EQ0QP61m+M9CgwVx0GNimDS9c8QwUXeycYI
   KI/9lgiNqQytPMELV1IzC8/yUUy3TkbpZQdq+r4GYkjUThuKRwptR2aI/
   OZMaTDfDq0K3XPmy6PllhrD1eKF7QjeG84ukiCPh56VdR927U/aVoNyzE
   28je5BLFurfIQg8E2jmVd8S7Fz3sGcwQni2bVevj8nNFBecP7vFX87siu
   DTAB/eDAeLvFJa5VyrUwAExfFS9KmBz/PUznLUefRE4zyzWmRuXFutxCL
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10265"; a="235089642"
X-IronPort-AV: E=Sophos;i="5.88,386,1635231600"; 
   d="scan'208";a="235089642"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 09:48:08 -0800
X-IronPort-AV: E=Sophos;i="5.88,386,1635231600"; 
   d="scan'208";a="547415122"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.40])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 09:48:08 -0800
Date:   Mon, 21 Feb 2022 09:50:20 -0800 (PST)
From:   matthew.gerlach@linux.intel.com
X-X-Sender: mgerlach@rhweight-WRK1
To:     Tom Rix <trix@redhat.com>
cc:     "Zhang, Tianfei" <tianfei.zhang@intel.com>,
        "Wu, Hao" <hao.wu@intel.com>, "mdf@kernel.org" <mdf@kernel.org>,
        "Xu, Yilun" <yilun.xu@intel.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>
Subject: Re: [PATCH v1 7/7] fpga: dfl: pci: Add generic OFS PCI PID
In-Reply-To: <3c9fce03-ef29-d80f-6639-0c237c28cf58@redhat.com>
Message-ID: <alpine.DEB.2.22.394.2202210934570.117064@rhweight-WRK1>
References: <20220214112619.219761-1-tianfei.zhang@intel.com> <20220214112619.219761-8-tianfei.zhang@intel.com> <ed8f4b5f-5c92-f555-ed2d-c5b8f38d5372@redhat.com> <BN9PR11MB5483BC7EE52A47CEAEFC58A0E3379@BN9PR11MB5483.namprd11.prod.outlook.com>
 <3c9fce03-ef29-d80f-6639-0c237c28cf58@redhat.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1306219232-1645465820=:117064"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1306219232-1645465820=:117064
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT



On Fri, 18 Feb 2022, Tom Rix wrote:

>
> On 2/18/22 1:03 AM, Zhang, Tianfei wrote:
>> 
>>> -----Original Message-----
>>> From: Tom Rix <trix@redhat.com>
>>> Sent: Wednesday, February 16, 2022 12:16 AM
>>> To: Zhang, Tianfei <tianfei.zhang@intel.com>; Wu, Hao <hao.wu@intel.com>;
>>> mdf@kernel.org; Xu, Yilun <yilun.xu@intel.com>; 
>>> linux-fpga@vger.kernel.org;
>>> linux-doc@vger.kernel.org; linux-kernel@vger.kernel.org
>>> Cc: corbet@lwn.net; Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>> Subject: Re: [PATCH v1 7/7] fpga: dfl: pci: Add generic OFS PCI PID
>>> 
>>> 
>>> On 2/14/22 3:26 AM, Tianfei zhang wrote:
>>>> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>>> 
>>>> Add the PCI product id for an Open FPGA Stack PCI card.
>>> Is there a URL to the card ?
>> This PCIe Device IDs have registered by Intel.
> A URL is useful to introduce the board, Is there one ?
>> 
>>>> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>>> Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
>>>> ---
>>>>    drivers/fpga/dfl-pci.c | 4 ++++
>>>>    1 file changed, 4 insertions(+)
>>>> 
>>>> diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c index
>>>> 83b604d6dbe6..cb2fbf3eb918 100644
>>>> --- a/drivers/fpga/dfl-pci.c
>>>> +++ b/drivers/fpga/dfl-pci.c
>>>> @@ -76,12 +76,14 @@ static void cci_pci_free_irq(struct pci_dev *pcidev)
>>>>    #define PCIE_DEVICE_ID_INTEL_PAC_D5005		0x0B2B
>>>>    #define PCIE_DEVICE_ID_SILICOM_PAC_N5010	0x1000
>>>>    #define PCIE_DEVICE_ID_SILICOM_PAC_N5011	0x1001
>>>> +#define PCIE_DEVICE_ID_INTEL_OFS		0xbcce
>>> INTEL_OFS is a generic name, pci id's map to specific cards
>>> 
>>> Is there a more specific name for this card ?
>> I think using INTEL_OFS is better, because INTEL_OFS is the Generic 
>> development platform can support multiple cards which using OFS 
>> specification,
>> like Intel PAC N6000 card.
>
> I would prefer something like PCIE_DEVICE_ID_INTEL_PAC_N6000 because it 
> follows an existing pattern.  Make it easy on a developer, they will look at 
> their board or box, see X and try to find something similar in the driver 
> source.
>
> To use OSF_ * the name needs a suffix to differentiate it from future cards 
> that will also use ofs.
>
> If this really is a generic id please explain in the doc patch how every 
> future board with use this single id and how a driver could work around a hw 
> problem in a specific board with a pci id covering multiple boards.
>
> Tom

Hi Tom,

The intent is to have a generic device id that can be used with many 
different boards.  Currently, we have FPGA implementations for 3 different 
boards using this generic id.  We may need a better name for device id 
than OFS.  More precisely this generic device id means a PCI function that 
is described by a Device Feature List (DFL).  How about 
PCIE_DEVICE_ID_INTEL_DFL?

With a DFL device id, the functionality of the PF/VF is determined by the 
contents of the DFL.  Each Device Feature Header (DFH) in the DFL has a 
revision field that can be used identify "broken" hw, or new functionality 
added to a feature.  Additionally, since the DFL is typically used in a 
FPGA, the broken hardware, can and should be fixed in most cases.

Matthew
>
>> 
>>> Tom
>>>
>>>>    /* VF Device */
>>>>    #define PCIE_DEVICE_ID_VF_INT_5_X		0xBCBF
>>>>    #define PCIE_DEVICE_ID_VF_INT_6_X		0xBCC1
>>>>    #define PCIE_DEVICE_ID_VF_DSC_1_X		0x09C5
>>>>    #define PCIE_DEVICE_ID_INTEL_PAC_D5005_VF	0x0B2C
>>>> +#define PCIE_DEVICE_ID_INTEL_OFS_VF		0xbccf
>>>>
>>>>    static struct pci_device_id cci_pcie_id_tbl[] = {
>>>>    	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_PF_INT_5_X),},
>>> @@
>>>> -95,6 +97,8 @@ static struct pci_device_id cci_pcie_id_tbl[] = {
>>>>    	{PCI_DEVICE(PCI_VENDOR_ID_INTEL,
>>> PCIE_DEVICE_ID_INTEL_PAC_D5005_VF),},
>>>>    	{PCI_DEVICE(PCI_VENDOR_ID_SILICOM_DENMARK,
>>> PCIE_DEVICE_ID_SILICOM_PAC_N5010),},
>>>>    	{PCI_DEVICE(PCI_VENDOR_ID_SILICOM_DENMARK,
>>>> PCIE_DEVICE_ID_SILICOM_PAC_N5011),},
>>>> +	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_INTEL_OFS),},
>>>> +	{PCI_DEVICE(PCI_VENDOR_ID_INTEL,
>>> PCIE_DEVICE_ID_INTEL_OFS_VF),},
>>>>    	{0,}
>>>>    };
>>>>    MODULE_DEVICE_TABLE(pci, cci_pcie_id_tbl);
>
>
--8323328-1306219232-1645465820=:117064--
