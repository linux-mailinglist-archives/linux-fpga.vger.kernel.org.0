Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 566A02CC65F
	for <lists+linux-fpga@lfdr.de>; Wed,  2 Dec 2020 20:17:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbgLBTR1 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 2 Dec 2020 14:17:27 -0500
Received: from mga12.intel.com ([192.55.52.136]:21267 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbgLBTR1 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 2 Dec 2020 14:17:27 -0500
IronPort-SDR: lAjN+e6r5fPIsEWcnhkITLsgvRDowoq2ruRM8373uAdLyYCoEEMZ+6IYD4k758yGbxZGz+rUs5
 1hksupy36zZg==
X-IronPort-AV: E=McAfee;i="6000,8403,9823"; a="152325602"
X-IronPort-AV: E=Sophos;i="5.78,387,1599548400"; 
   d="scan'208";a="152325602"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2020 11:15:45 -0800
IronPort-SDR: Uh9yPqqdb4FzpskxN5HT0WaSIXe9PqQXfA5nynZbX9f5Z2JvtIH00ewQxt3HoY8gLq3jlEN511
 c3HRr8V8jrZA==
X-IronPort-AV: E=Sophos;i="5.78,387,1599548400"; 
   d="scan'208";a="550185358"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.140])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2020 11:15:45 -0800
Date:   Wed, 2 Dec 2020 11:17:01 -0800 (PST)
From:   matthew.gerlach@linux.intel.com
X-X-Sender: mgerlach@rhweight-WRK1
To:     "Wu, Hao" <hao.wu@intel.com>
cc:     "Xu, Yilun" <yilun.xu@intel.com>, Moritz Fischer <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "trix@redhat.com" <trix@redhat.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>
Subject: RE: [PATCH v3 2/2] fpga: dfl: look for vendor specific capability
In-Reply-To: <DM6PR11MB38199A96C6871F1B041694BD85F30@DM6PR11MB3819.namprd11.prod.outlook.com>
Message-ID: <alpine.DEB.2.22.394.2012021110010.1157625@rhweight-WRK1>
References: <20201124155658.700976-1-matthew.gerlach@linux.intel.com> <20201124155658.700976-3-matthew.gerlach@linux.intel.com> <DM6PR11MB38191D8C5E27E6E04B8DAA1A85F70@DM6PR11MB3819.namprd11.prod.outlook.com> <alpine.DEB.2.22.394.2011301614040.1050045@rhweight-WRK1>
 <X8aR36hGoV9SsPDw@archbook> <20201202020003.GB22103@yilunxu-OptiPlex-7050> <DM6PR11MB38199A96C6871F1B041694BD85F30@DM6PR11MB3819.namprd11.prod.outlook.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On Wed, 2 Dec 2020, Wu, Hao wrote:

>>>>>
>>>>>> +		}
>>>>>> +
>>>>>> +		offset = dfl_res & PCI_VNDR_DFLS_RES_OFF_MASK;
>>>>>> +		if (offset >= len) {
>>>>>> +			dev_err(&pcidev->dev, "%s bad
>> offset %u >= %pa\n",
>>>>>> +				__func__, offset, &len);
>>>>>> +			return -EINVAL;
>>>>>> +		}
>>>>>> +
>>>>>> +		dev_dbg(&pcidev->dev, "%s BAR %d offset 0x%x\n",
>>>>>> __func__, bar, offset);
>>>>>> +
>>>>>> +		len -= offset;
>>>>>> +
>>>>>> +		start = pci_resource_start(pcidev, bar) + offset;
>>>>>> +
>>>>>> +		dfl_fpga_enum_info_add_dfl(info, start, len);
>>>>>
>>>>> That means everytime, we pass [start, endofbar] region to dfl core
>>>>> for enumeration, if there are multiple DFLs in one bar, then each range
>>>>> ends at the same endofbar, it seems fine as enumeration can be done
>>>>> one by one, but ideally the best case is that this capability can provide
>>>>> end address or size too, right? It is possible that information can be
>>>>> added to the capability as well? then we don't have such limitation.
>>>>>
>>>>> Hao
>>>>
>>>> I am not sure having more than one DFL in a bar serves any purpose over
>> a
>>>> single DFL.  Regardless, I think the consistency of just having Offset/BIR
>>>> in the VSEC is better than adding more infomation that has little or no
>>>> added value.
>>>
>>> Agreed. Can't you just link the DFLs in that case?
>>
>> I didn't see the value of more DFLs in one bar either. So I think we'd better
>> document it.
>
> Yes, it needs to be documented well, otherwise users may have their own
> choices, e.g. link 100 queues together by modify DFH registers of the
> queues one by one, or just have them done together in the VSEC. I am not
> sure which one is the easier way for logic developer, but at least we need to
> document what driver can support.
>
> Thanks
> Hao
>

I will update the documentation to clarify the basis of the rule of one 
DFL per bar.  Since we have a clearly stated rule, we can enforce the rule 
in the code and perform more error checking.

>>
>> Thanks,
>> Yilun
>
