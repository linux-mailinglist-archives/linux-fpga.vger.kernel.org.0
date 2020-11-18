Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 830A52B835C
	for <lists+linux-fpga@lfdr.de>; Wed, 18 Nov 2020 18:49:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgKRRsq (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 18 Nov 2020 12:48:46 -0500
Received: from mga14.intel.com ([192.55.52.115]:63212 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726547AbgKRRsp (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 18 Nov 2020 12:48:45 -0500
IronPort-SDR: Z09j0oN4DuxJZ3uo9MxXQ9e890e15O2tlhyi2TqU+0EnpfGT8DSrz/2oanXmT5lIw7RF+EK8ru
 x6GnS6sT0kkQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9809"; a="170374318"
X-IronPort-AV: E=Sophos;i="5.77,488,1596524400"; 
   d="scan'208";a="170374318"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2020 09:48:44 -0800
IronPort-SDR: 75b4MMWvGFm/tIxeLpMDnHiz3+HVFR2GHiMxm9Izlvywo2dylZuzEwjvMK/LamwEQpFeJ2Kx+c
 XXO+U7Z/5jiA==
X-IronPort-AV: E=Sophos;i="5.77,488,1596524400"; 
   d="scan'208";a="544633974"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.140])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2020 09:48:43 -0800
Date:   Wed, 18 Nov 2020 09:49:55 -0800 (PST)
From:   matthew.gerlach@linux.intel.com
X-X-Sender: mgerlach@rhweight-WRK1
To:     "Wu, Hao" <hao.wu@intel.com>
cc:     "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "trix@redhat.com" <trix@redhat.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>
Subject: RE: [PATCH 2/2] fpga: dfl: look for vendor specific capability
In-Reply-To: <DM6PR11MB3819B7E06DB9A4BC7FBDABD285E10@DM6PR11MB3819.namprd11.prod.outlook.com>
Message-ID: <alpine.DEB.2.22.394.2011180948060.353557@rhweight-WRK1>
References: <20201117012552.262149-1-matthew.gerlach@linux.intel.com> <20201117012552.262149-3-matthew.gerlach@linux.intel.com> <DM6PR11MB381979D8AEDC1F4EA8B4C2BC85E20@DM6PR11MB3819.namprd11.prod.outlook.com> <alpine.DEB.2.22.394.2011171144310.296481@rhweight-WRK1>
 <DM6PR11MB3819B7E06DB9A4BC7FBDABD285E10@DM6PR11MB3819.namprd11.prod.outlook.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On Wed, 18 Nov 2020, Wu, Hao wrote:

>> On Tue, 17 Nov 2020, Wu, Hao wrote:
>
> [...]
>
>>>>  Open discussion
>>>>  ===============
>>>> diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
>>>> index b1b157b41942..5418e8bf2496 100644
>>>> --- a/drivers/fpga/dfl-pci.c
>>>> +++ b/drivers/fpga/dfl-pci.c
>>>> @@ -27,6 +27,13 @@
>>>>  #define DRV_VERSION	"0.8"
>>>>  #define DRV_NAME	"dfl-pci"
>>>>
>>>> +#define PCI_VNDR_ID_DFLS 0x43
>>>
>>> What about PCI_VSEC_ID_INTEL_DFLS?
>>>
>>> Is it possible a different ID chosen by different vendor?
>>
>> I think another vendor could choose their own ID.
>
> If another vendor could choose their own ID, so should we
> check vendor id as well?

Yes, the vendor id should be checked.  I will add it to v2.
>
> [...]
>
>>>> +	for (i = 0; i < dfl_cnt; i++) {
>>>> +		dfl_res_off = voff + PCI_VNDR_DFLS_RES_OFFSET +
>>>> +				      (i * sizeof(dfl_res));
>>>> +		pci_read_config_dword(pcidev, dfl_res_off, &dfl_res);
>>>> +
>>>> +		dev_dbg(&pcidev->dev, "dfl_res 0x%x\n", dfl_res);
>>>> +
>>>> +		bar = dfl_res & PCI_VND_DFLS_RES_BAR_MASK;
>>>> +
>>>> +		if (bar >= PCI_STD_NUM_BARS) {
>>>> +			dev_err(&pcidev->dev, "%s bad bar number %d\n",
>>>> +				__func__, bar);
>>>> +			return -EINVAL;
>>>> +		}
>>>> +
>>>> +		len = pci_resource_len(pcidev, bar);
>>>> +
>>>
>>> Remove this blank line.
>> OK, v2.
>>
>>>
>>>> +		if (len == 0) {
>>>> +			dev_err(&pcidev->dev, "%s unmapped bar
>>>> number %d\n",
>>>
>>> Why "unmapped bar"?
>>
>> How about, "zero length bar"?
>
> I think this checking can be covered by below one, right?
> if (offset >= len)
> ...

I agree. I will make the change in v2.
>
>>
>>>
>>>> +				__func__, bar);
>>>> +			return -EINVAL;
>>>> +		}
>>>> +
>>>> +		offset = dfl_res & ~PCI_VND_DFLS_RES_BAR_MASK;
>>>> +
>>>
>>> Remove this blank line.
>>
>> OK, v2.
>>
>>>
>>>> +		if (offset >= len) {
>>>> +			dev_err(&pcidev->dev, "%s bad offset %u >= %llu\n",
>>>> +				__func__, offset, len);
>>>> +			return -EINVAL;
>>>> +		}
>>>> +
>
> [....]
>
>>>> +
>>>> +		start = pci_resource_start(pcidev, bar) + offset;
>>>> +		len -= offset;
>>>> +
>>>> +		if (!PAGE_ALIGNED(start)) {
>>>
>>> Is this a hard requirement? Or offset should be page aligned per VSEC
>> definition?
>>> Or this is just the requirement from driver point of view. Actually we don't
>> like
>>> to add rules only in driver, so it's better we have this requirement in VSEC
>> definition
>>> with proper documentation.
>>
>> The DFL parsing code ioremaps the memory bounded by start/len.  I thought
>> this would require the start to be page aligned.
>
> If consider mmap the region to userspace, it requires page aligned, but do we
> need to apply this rule for everyone?

I will remove this check in v2.

>
> Thanks
> Hao
>
>
