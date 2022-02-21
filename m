Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C83AF4BE230
	for <lists+linux-fpga@lfdr.de>; Mon, 21 Feb 2022 18:54:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381632AbiBURU5 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 21 Feb 2022 12:20:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381645AbiBURUu (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 21 Feb 2022 12:20:50 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C14CFB;
        Mon, 21 Feb 2022 09:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645464027; x=1677000027;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=EldFeMO1JNlmFZXwAPC3sgE5GEkGvYBt67wpkTkIudo=;
  b=Sr33qjWxAPXhDIZjEIhYg7GsLhYFNA2b6Rt6mhIB/FcqWG41/l/rBSrH
   6zOS5+kRYn8yLL07h5SXlmP0iUwOGVGIKPrEI24PxlANxZJ7ewfwPvr9b
   P/sNDB2nNQjm9RPmaZdAAqiG3iiWmM+Z4Oli3FDafBccWY7ZuKM2tZylo
   02MYBo74JkB2b3HQ3hd6MqxiOIYxalPIo/b0S6jtX8epkM3jzGu0pt9sD
   L3E+TIM89eMAiWrTh/anKwhRd8tf/tp9mhW9a3LmbHHMqfgUoRZNnUv52
   e+R/cWZDIQGYxup8UwRgZutd9wmJCVaSnYoNw+C6J5I2ZTrqjWJaGfJ2Y
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10265"; a="251497629"
X-IronPort-AV: E=Sophos;i="5.88,386,1635231600"; 
   d="scan'208";a="251497629"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 09:20:26 -0800
X-IronPort-AV: E=Sophos;i="5.88,386,1635231600"; 
   d="scan'208";a="627429277"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.40])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 09:20:25 -0800
Date:   Mon, 21 Feb 2022 09:22:29 -0800 (PST)
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
Subject: Re: [PATCH v1 3/7] fpga: dfl: Allow for ports with no local bar
 space.
In-Reply-To: <efee5ac0-4c3a-085d-9b9d-0c8ade022f30@redhat.com>
Message-ID: <alpine.DEB.2.22.394.2202210912260.117064@rhweight-WRK1>
References: <20220214112619.219761-1-tianfei.zhang@intel.com> <20220214112619.219761-4-tianfei.zhang@intel.com> <0fdd3d0d-d280-8104-eccc-8fa8d8a992c2@redhat.com> <BN9PR11MB548314968CBC0CA5E446B366E3379@BN9PR11MB5483.namprd11.prod.outlook.com>
 <efee5ac0-4c3a-085d-9b9d-0c8ade022f30@redhat.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On Fri, 18 Feb 2022, Tom Rix wrote:

>
> On 2/17/22 11:31 PM, Zhang, Tianfei wrote:
>> 
>>> -----Original Message-----
>>> From: Tom Rix <trix@redhat.com>
>>> Sent: Tuesday, February 15, 2022 11:06 PM
>>> To: Zhang, Tianfei <tianfei.zhang@intel.com>; Wu, Hao <hao.wu@intel.com>;
>>> mdf@kernel.org; Xu, Yilun <yilun.xu@intel.com>; 
>>> linux-fpga@vger.kernel.org;
>>> linux-doc@vger.kernel.org; linux-kernel@vger.kernel.org
>>> Cc: corbet@lwn.net; Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>> Subject: Re: [PATCH v1 3/7] fpga: dfl: Allow for ports with no local bar 
>>> space.
>>> 
>>> 
>>> On 2/14/22 3:26 AM, Tianfei zhang wrote:
>>>> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>>>
>>>>   From a fpga partial reconfiguration standpoint, a port may not be
>>>> connected any local BAR space.  The port could be connected to a
>>>> different PCIe Physical Function (PF) or Virtual Function (VF), in
>>>> which case another driver instance would manage the endpoint.
>>> It is not clear if this is part of iofs or a bug fix.
>> This is the new implementation/feature of IOFS.
>> On IOFS support multiple methods to access the AFU.
>> 1. Legacy Model. This is used for N3000 and N5000 card.
>> In this model the entire AFU region is a unit of PR, and there is a Port 
>> device connected to this AFU.
>> On DFL perspective, there is "Next AFU" point to the AFU, and the "BarID" 
>> is  the PCIe Bar ID of AFU.
>> In this model, we can use the AFU APIs to access the entire AFU resource, 
>> like MMIO.
>> 2. Micro-Personas in AFU.
>> IOFS intruding new model for PR and AFU access.
>> Micro-Personas allow the RTL developer to designate their own AFU-defined 
>> PR regions.
>> In this model the unit of PR is not the entire AFU, instead
>> the unit of PR can be any size block or blocks inside the AFU.
>> 3. Multiple VFs per PR slot.
>> In this method, we can instance multiple VFs over SRIOV for one PR slot, 
>> and access the AFU resource
>> by different VFs in virtualization usage. In this case, the Port device 
>> would not connected to AFU (the BarID of Port device
>> should be set to invalid), so this patch want to support this use model.
>
> What I am looking for is how the older cards using (my term) dfl 1 will still 
> work with dfl 2 and vice versa.
>
> No where do I see a version check for dfl 2 nor a pci id check so either this 
> just works or backward compatibility has not be considered.
>
> Please add a backward compatibility section to the doc patch
>
>> 
>>>> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>>> Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
>>>> ---
>>>>    drivers/fpga/dfl-pci.c | 8 ++++++++
>>>>    1 file changed, 8 insertions(+)
>>>> 
>>>> diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c index
>>>> 4d68719e608f..8abd9b408403 100644
>>>> --- a/drivers/fpga/dfl-pci.c
>>>> +++ b/drivers/fpga/dfl-pci.c
>>>> @@ -243,6 +243,7 @@ static int find_dfls_by_default(struct pci_dev 
>>>> *pcidev,
>>>>    		v = readq(base + FME_HDR_CAP);
>>>>    		port_num = FIELD_GET(FME_CAP_NUM_PORTS, v);
>>>> 
>>>> +		dev_info(&pcidev->dev, "port_num = %d\n", port_num);
>>>>    		WARN_ON(port_num > MAX_DFL_FPGA_PORT_NUM);
>>>>
>>>>    		for (i = 0; i < port_num; i++) {
>>>> @@ -258,6 +259,13 @@ static int find_dfls_by_default(struct pci_dev 
>>>> *pcidev,
>>>>    			 */
>>>>    			bar = FIELD_GET(FME_PORT_OFST_BAR_ID, v);
>>>>    			offset = FIELD_GET(FME_PORT_OFST_DFH_OFST, v);
>>>> +			if (bar >= PCI_STD_NUM_BARS) {
>>> Is bar set to a better magic number that pci_std_num_bars ? maybe 0xff's
>>> 
>>> How do you tell between this case and broken hw ?
>> Yes, I agree that magic number is better, Currently the RTL using 
>> PCI_STD_NUM_BARS for an invalid PCIe bar number.
>
> How do you tell between this case and broken hw ?
>
> Tom

The field, FME_PORT_OFST_BAR_ID, is a three bit field, which is pretty 
common for BARs on PCI.  PCI_STD_NUM_BARS is defined as 6.  Current HW 
implementations are filing this field with the value, 7, which is close to 
the suggestion of 0xff's.  How about we define the following magic 
number?
#define NO_LOCAL_PORT_BAR	7

We should also change the dev_info to be a dev_dbg and more precise to 
something like the following:

 	if (bar == NO_LOCAL_PORT_BAR) {
 		dev_dbg(&pcidev->dev, "No local port BAR space.\n");
 		continue;
 	}

>
>>> Move up a line and skip getting an offset that will not be used.
>> Yes, this line is not necessary, I will remove it on next version patch.
>> 
>>>> +				dev_info(&pcidev->dev, "skipping port without
>>> local BAR space %d\n",
>>>> +					 bar);
>>>> +				continue;
>>>> +			} else {
>>>> +				dev_info(&pcidev->dev, "BAR %d offset %u\n",
>>> bar, offset);
>>>> +			}
>>>>    			start = pci_resource_start(pcidev, bar) + offset;
>>>>    			len = pci_resource_len(pcidev, bar) - offset;
>>>> 
>>> Is similar logic needed for else-if (port) block below this ?
>> I think, the else-if is not necessary. I will remove it on next version 
>> patch.
>>> Tom
>
>
