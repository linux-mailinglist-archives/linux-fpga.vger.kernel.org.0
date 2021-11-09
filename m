Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E68C444B2DC
	for <lists+linux-fpga@lfdr.de>; Tue,  9 Nov 2021 19:49:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242685AbhKISwf (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 9 Nov 2021 13:52:35 -0500
Received: from mga01.intel.com ([192.55.52.88]:53766 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242639AbhKISwe (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 9 Nov 2021 13:52:34 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10163"; a="256200216"
X-IronPort-AV: E=Sophos;i="5.87,221,1631602800"; 
   d="scan'208";a="256200216"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2021 10:49:47 -0800
X-IronPort-AV: E=Sophos;i="5.87,221,1631602800"; 
   d="scan'208";a="503635086"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.40])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2021 10:49:47 -0800
Date:   Tue, 9 Nov 2021 10:51:33 -0800 (PST)
From:   matthew.gerlach@linux.intel.com
X-X-Sender: mgerlach@rhweight-WRK1
To:     Tom Rix <trix@redhat.com>
cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>
Subject: Re: [PATCH v1 1/1] fpga: dfl: pci: Use pci_find_vsec_capability()
 when looking for DFL
In-Reply-To: <39ac1f40-66ab-6c7e-0042-8fcdc062ed00@redhat.com>
Message-ID: <alpine.DEB.2.22.394.2111091044060.1548144@rhweight-WRK1>
References: <20211109154127.18455-1-andriy.shevchenko@linux.intel.com> <8ccc133a-fb47-4548-fee3-d57775a5166d@redhat.com> <YYq4fSRoyzFE4Vei@smile.fi.intel.com> <39ac1f40-66ab-6c7e-0042-8fcdc062ed00@redhat.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On Tue, 9 Nov 2021, Tom Rix wrote:

>
> On 11/9/21 10:05 AM, Andy Shevchenko wrote:
>> On Tue, Nov 09, 2021 at 07:55:43AM -0800, Tom Rix wrote:
>>> On 11/9/21 7:41 AM, Andy Shevchenko wrote:
>>>> Currently the find_dfls_by_vsec() opens code pci_find_vsec_capability().
>>>> Refactor the former to use the latter. No functional change intended.
>> Thanks for review, my answers below.
>> 
>> ...
>> 
>>>> +	u16 voff;
>>> The later use of voff in pci_read_config_dword is of type 'int', it may be
>>> better to keep voff as an int.
>> I don't think so. The rule of thumb that the types should match the value 
>> they
>> got in the first place. In this case it's u16. Compiler will implicitly 
>> cast it
>> to whatever is needed as long as the type is good for integer promotion.
>>

I think u16 is more precise than int, but I think it'll get promoted to an 
int anywhen when used with calls to pci_read_config_dword().  Was this 
change tested on real or emulated HW?

>> ...
>> 
>>>> +	voff = pci_find_vsec_capability(dev, PCI_VENDOR_ID_INTEL, 
>>>> PCI_VSEC_ID_INTEL_DFLS);
>>> This may be a weakness in the origin code, but intel isn't the exclusive
>>> user of DFL.
>> This does not change the original code. If you think so, this can be 
>> extended
>> later on.
>
> I would rather see this fixed now or explained why this isn't a problem.

I agree that a single Vendor/VSEC id being supported is a problem, 
but I think fixing it should be a separate patch.  Do we need to change 
this a table lookup of Vendor/VSEC id's, or do we need to reserve a more 
generic Vendor/VSEC pair?

>
> Tom
>
>>
>>>>    	if (!voff) {
>>>>    		dev_dbg(&pcidev->dev, "%s no DFL VSEC found\n", __func__);
>>>>    		return -ENODEV;
>
>
