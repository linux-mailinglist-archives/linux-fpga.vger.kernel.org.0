Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE4232CC631
	for <lists+linux-fpga@lfdr.de>; Wed,  2 Dec 2020 20:08:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731085AbgLBTHD (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 2 Dec 2020 14:07:03 -0500
Received: from mga05.intel.com ([192.55.52.43]:33486 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731083AbgLBTHC (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 2 Dec 2020 14:07:02 -0500
IronPort-SDR: ZWlBNZ+QgWOvlSTE4aznrqgtX90nsdngl+u7GlJunvadPuXjU9mRlkPmU1zHMSuUKj6QBm6cde
 2KRG4Q06VNog==
X-IronPort-AV: E=McAfee;i="6000,8403,9823"; a="257781885"
X-IronPort-AV: E=Sophos;i="5.78,387,1599548400"; 
   d="scan'208";a="257781885"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2020 11:05:22 -0800
IronPort-SDR: X8I+Gymkt1GuI1zfBEuedFDmrHZIOEby8/Za/1MiqBLcaMrQOmFpoECBHjfK3nEuS6ff0wwYSq
 WdZ0WxjtVZ8w==
X-IronPort-AV: E=Sophos;i="5.78,387,1599548400"; 
   d="scan'208";a="481669396"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.140])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2020 11:05:21 -0800
Date:   Wed, 2 Dec 2020 11:06:30 -0800 (PST)
From:   matthew.gerlach@linux.intel.com
X-X-Sender: mgerlach@rhweight-WRK1
To:     "Wu, Hao" <hao.wu@intel.com>
cc:     Moritz Fischer <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "trix@redhat.com" <trix@redhat.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>
Subject: RE: [PATCH v3 2/2] fpga: dfl: look for vendor specific capability
In-Reply-To: <DM6PR11MB38191CF23533B7C1B44B56EA85F30@DM6PR11MB3819.namprd11.prod.outlook.com>
Message-ID: <alpine.DEB.2.22.394.2012021105500.1157625@rhweight-WRK1>
References: <20201124155658.700976-1-matthew.gerlach@linux.intel.com> <20201124155658.700976-3-matthew.gerlach@linux.intel.com> <DM6PR11MB38191D8C5E27E6E04B8DAA1A85F70@DM6PR11MB3819.namprd11.prod.outlook.com> <alpine.DEB.2.22.394.2011301614040.1050045@rhweight-WRK1>
 <X8aR36hGoV9SsPDw@archbook> <DM6PR11MB38191CF23533B7C1B44B56EA85F30@DM6PR11MB3819.namprd11.prod.outlook.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On Wed, 2 Dec 2020, Wu, Hao wrote:

>> Subject: Re: [PATCH v3 2/2] fpga: dfl: look for vendor specific capability
>>
>> Hi Matthew,
>>
>> On Mon, Nov 30, 2020 at 04:45:20PM -0800,
>> matthew.gerlach@linux.intel.com wrote:
>>>
>>>
>>> On Sat, 28 Nov 2020, Wu, Hao wrote:
>>>
>>>>> Subject: [PATCH v3 2/2] fpga: dfl: look for vendor specific capability
>>>>
>>>> Maybe we can change the title a little bit, what about
>>>> fpga: dfl-pci: locate DFLs by PCIe vendor specific capability
>>>>
>>>>>
>>>>> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>>>>
>>>>> A DFL may not begin at offset 0 of BAR 0.  A PCIe vendor
>>>>> specific capability can be used to specify the start of a
>>>>> number of DFLs.
>>>>
>>>> A PCIe vendor specific extended capability is introduced by Intel to
>>>> specify the start of a number of DFLs.
>>>
>>> Your suggestion is more precise.
>>>>
>>>>
>>>>>
>>>>> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>>>> ---
>>>>> v3: Add text and ascii art to documentation.
>>>>>     Ensure not to exceed PCIe config space in loop.
>>>>>
>>>>> v2: Update documentation for clarity.
>>>>>     Clean up  macro names.
>>>>>     Use GENMASK.
>>>>>     Removed spurious blank lines.
>>>>>     Changed some calls from dev_info to dev_dbg.
>>>>>     Specifically check for VSEC not found, -ENODEV.
>>>>>     Ensure correct pci vendor id.
>>>>>     Remove check for page alignment.
>>>>>     Rename find_dfl_in_cfg to find_dfls_by_vsec.
>>>>>     Initialize target memory of pci_read_config_dword to invalid values
>> before
>>>>> use.
>>>>> ---
>>>>>  Documentation/fpga/dfl.rst | 25 +++++++++++
>>>>>  drivers/fpga/dfl-pci.c     | 91
>> +++++++++++++++++++++++++++++++++++++-
>>>>>  2 files changed, 115 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/Documentation/fpga/dfl.rst b/Documentation/fpga/dfl.rst
>>>>> index 0404fe6ffc74..fa0da884a818 100644
>>>>> --- a/Documentation/fpga/dfl.rst
>>>>> +++ b/Documentation/fpga/dfl.rst
>>>>> @@ -501,6 +501,31 @@ Developer only needs to provide a sub feature
>>>>> driver with matched feature id.
>>>>>  FME Partial Reconfiguration Sub Feature driver (see drivers/fpga/dfl-
>> fme-
>>>>> pr.c)
>>>>>  could be a reference.
>>>>>
>>>>> +Location of DFLs on a PCI Device
>>>>> +===========================
>>>>> +There are two ways of locating DFLs on a PCI Device.  The original
>>>>
>>>> I found this new VSEC is only for PCIe device, correct? If so, let's make
>>>> sure descriptions are accurate. E.g. default method for all devices
>>>> and a new method for PCIe device.
>>>
>>> Yes, the default method can be used with PCI and PCIe device, and the
>> VSEC
>>> approach is PCIe, only.  Documentation can be made more precise.
>>>
>>>>
>>>>> +method assumed the start of the first DFL to offset 0 of bar 0.
>>>>> +If the first node of the DFL is an FME, then further DFLs
>>>>> +in the port(s) are specified in FME header registers.
>>>>> +Alternatively, a vendor specific capability structure can be used to
>> Maybe: a vendor specific extended capability (VSEC) ...
>>>>> +specify the location of all the DFLs on the device, providing flexibility
>>>>> +for the type of starting node in the DFL.  Intel has reserved the
>>>>> +VSEC ID of 0x43 for this purpose.  The vendor specific
>>>>> +data begins with a 4 byte vendor specific register for the number of
>> DFLs
>>>>> followed 4 byte
>>>>> +Offset/BIR vendor specific registers for each DFL. Bits 2:0 of Offset/BIR
>>>>> register
>>>>
>>>> Do we have a defined register name here? or it's named as Offset/BIR
>> register?
>>>> Sounds a little wired, and I see you defined it as DFLS_RES?
>>>
>>> The Offset/BIR terminology is also used in the MSI-X capability structure.
>>
>> Yeah, this intuitively made sense to me having worked with PCIe :)
>
> I just feel that it's better to use the same register name defined in the code
> below. So people can find matched information in both code and doc easily. : )

I think this makes sense.  I can change the name of the variable to bir to 
match the documentation.

>
> Thanks
> Hao
>
