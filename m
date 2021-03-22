Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6412C344955
	for <lists+linux-fpga@lfdr.de>; Mon, 22 Mar 2021 16:34:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbhCVPeG (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 22 Mar 2021 11:34:06 -0400
Received: from mga07.intel.com ([134.134.136.100]:17396 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230229AbhCVPeA (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 22 Mar 2021 11:34:00 -0400
IronPort-SDR: ckA9H0KO5OdwDIsbma8IajrB+TLWu5lGFngnUus+SPQ6dhirQZnovqnzItbdR4Nsz4TUJH7zIU
 0UlNQN5El6YA==
X-IronPort-AV: E=McAfee;i="6000,8403,9931"; a="254292624"
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; 
   d="scan'208";a="254292624"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2021 08:33:59 -0700
IronPort-SDR: 8HQFG+oKBmQepwYUgnNp1PcZbF9HCd04pO/u4Uj7DX1yWIYL653rKeV+39dVyucxwDsUmlC7VI
 PTAjd2mVD8fA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; 
   d="scan'208";a="441225140"
Received: from marshy.an.intel.com (HELO [10.122.105.143]) ([10.122.105.143])
  by fmsmga002.fm.intel.com with ESMTP; 22 Mar 2021 08:33:58 -0700
Subject: Re: FW: [PATCHv5 0/7] Extend Intel service layer, FPGA manager and
 region
To:     Tom Rix <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <1612909233-13867-1-git-send-email-richard.gong@linux.intel.com>
 <MWHPR11MB001577B17723C8A046398249879E9@MWHPR11MB0015.namprd11.prod.outlook.com>
 <21a8817a-e63e-6029-69a6-6bae5398439a@linux.intel.com>
 <1d7fd02b-4ef2-8d11-fba7-87a698699978@redhat.com>
 <MWHPR11MB0015516D86D02A0FE5423D6387669@MWHPR11MB0015.namprd11.prod.outlook.com>
 <7ef6739f-e2f6-d457-5498-1c6ed8ba2075@linux.intel.com>
 <f7a0c3fb-84f6-073c-ac41-45ce249cfa1e@redhat.com>
From:   Richard Gong <richard.gong@linux.intel.com>
Message-ID: <a7e19748-b8a0-430e-a1ea-dcdaa0d25853@linux.intel.com>
Date:   Mon, 22 Mar 2021 10:53:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <f7a0c3fb-84f6-073c-ac41-45ce249cfa1e@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org




Hi Tom,

On 3/22/21 8:53 AM, Tom Rix wrote:
> 
> On 3/21/21 2:05 PM, Richard Gong wrote:
>>
>> Hi Tom >>
>>>
>>>
>>> On 3/19/21 4:22 PM, Richard Gong wrote:
>>>>
>>>> Hi Moritz,
>>>>
>>>> Thanks for approving the 1st patch of my version 5 patchest, which submitted on 02/09/21.
>>>
>>> This change
>>>
>>> e23bd83368af ("firmware: stratix10-svc: fix kernel-doc markups")
>>
>> This patch e23bd83368af is not from my version 5 patch set.
> 
> Correct.
> 
> But since it is already in char-misc-next, your version 5 patchset will conflict with it.
> 
> I could not apply this patchset to my unoffical fpga-testing.
> 
> I am suggesting you do a test application of your patchset against char-misc-next.
> 
> And if you find there are issues, rebase your patchset.
> 

I tried to apply my patchset to the top of char-misc-next, but I didn't 
see any conflicts.

c7582d1 fpga: stratix10-soc: extend driver for bitstream authentication
2c9ecd3 dt-bindings: fpga: add authenticate-fpga-config property
6244115 fpga: of-fpga-region: add authenticate-fpga-config property
da274c9 fpga: fpga-mgr: add FPGA_MGR_BITSTREAM_AUTHENTICATE flag
9f93cad firmware: stratix10-svc: extend SVC driver to get the firmware 
version
eda6b51 firmware: stratix10-svc: add COMMAND_AUTHENTICATE_BITSTREAM flag
91aff09 firmware: stratix10-svc: reset COMMAND_RECONFIG_FLAG_PARTIAL to 0
83be46e Merge v5.12-rc3 into char-misc-next

Regards,
Richard

>>>
>>> Makes a lot of formatting changes in the same files as this patchset, including the first patch.
>>>
>>> It would be good to try applying this patchset to char-misc-next and resubmit if there are conflicts.
>>>
>>>>
>>>> Can you help review the remaining 6 patches from the same version 5 patchset? I need your ACKs to move forward, or please let me know if additional work is need.
>>>
>>> These changes look good to me.
>>>
>>> I was looking at the patchset again seeing if the firmware/ parts could be split out.
>>
>> No, we can't split out the firmware parts.
> 
> ok
> 
> Tom
> 
>>>
>>> Even though stratix10 is a fpga, from the MAINTAINERS file it is not clear to me if linux-fpga owns them and they come in on Moritz's branch.  I think this change is needed to the MAINTAINERS file to make that clearer.
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index aa84121c5611..1f68e9ff76de 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -9193,7 +9193,8 @@ F:    tools/power/x86/intel-speed-select/
>>>      INTEL STRATIX10 FIRMWARE DRIVERS
>>>    M:    Richard Gong <richard.gong@linux.intel.com>
>>> -L:    linux-kernel@vger.kernel.org
>>> +R:    Tom Rix <trix@redhat.com>
>>> +L:    linux-fpga@vger.kernel.org
>>>    S:    Maintained
>>>    F:    Documentation/ABI/testing/sysfs-devices-platform-stratix10-rsu
>>>    F:    Documentation/devicetree/bindings/firmware/intel,stratix10-svc.txt
>>>
>>> I also added myself as a reviewer because I want to help out.
>>>
>>> Tom
>>>
>>
>> Regards,
>> Richard
>>
>>>
>>>>
>>>> Many thanks for your time again!
>>>>
>>>> Regards,
>>>> Richard
>>>>
>>>>
>>>> On 2/25/21 7:07 AM, Gong, Richard wrote:
>>>>> Hi Moritz,
>>>>>
>>>>> Sorry for asking.
>>>>>
>>>>> When you have chance, can you help review the version 5 patchset submitted on 02/09/21?
>>>>>
>>>>> Regards,
>>>>> Richard
>>>>>
>>>>> -----Original Message-----
>>>>> From: richard.gong@linux.intel.com <richard.gong@linux.intel.com>
>>>>> Sent: Tuesday, February 9, 2021 4:20 PM
>>>>> To: mdf@kernel.org; trix@redhat.com; gregkh@linuxfoundation.org; linux-fpga@vger.kernel.org; linux-kernel@vger.kernel.org
>>>>> Cc: Gong, Richard <richard.gong@intel.com>
>>>>> Subject: [PATCHv5 0/7] Extend Intel service layer, FPGA manager and region
>>>>>
>>>>> From: Richard Gong <richard.gong@intel.com>
>>>>>
>>>>> This is 5th submission of Intel service layer and FPGA patches, which includes the missing standalone patch in the 4th submission.
>>>>>
>>>>> This submission includes additional changes for Intel service layer driver to get the firmware version running at FPGA SoC device. Then FPGA manager driver, one of Intel service layer driver's client, can decide whether to handle the newly added bitstream authentication function based on the retrieved firmware version. So that we can maintain FPGA manager driver the back compatible.
>>>>>
>>>>> Bitstream authentication makes sure a signed bitstream has valid signatures.
>>>>>
>>>>> The customer sends the bitstream via FPGA framework and overlay, the firmware will authenticate the bitstream but not program the bitstream to device. If the authentication passes, the bitstream will be programmed into QSPI flash and will be expected to boot without issues.
>>>>>
>>>>> Extend Intel service layer, FPGA manager and region drivers to support the bitstream authentication feature.
>>>>>
>>>>> Richard Gong (7):
>>>>>      firmware: stratix10-svc: reset COMMAND_RECONFIG_FLAG_PARTIAL to 0
>>>>>      firmware: stratix10-svc: add COMMAND_AUTHENTICATE_BITSTREAM flag
>>>>>      firmware: stratix10-svc: extend SVC driver to get the firmware version
>>>>>      fpga: fpga-mgr: add FPGA_MGR_BITSTREAM_AUTHENTICATE flag
>>>>>      fpga: of-fpga-region: add authenticate-fpga-config property
>>>>>      dt-bindings: fpga: add authenticate-fpga-config property
>>>>>      fpga: stratix10-soc: extend driver for bitstream authentication
>>>>>
>>>>>     .../devicetree/bindings/fpga/fpga-region.txt       | 10 ++++
>>>>>     drivers/firmware/stratix10-svc.c                   | 12 ++++-
>>>>>     drivers/fpga/of-fpga-region.c                      | 24 ++++++---
>>>>>     drivers/fpga/stratix10-soc.c                       | 62 +++++++++++++++++++---
>>>>>     include/linux/firmware/intel/stratix10-smc.h       | 21 +++++++-
>>>>>     .../linux/firmware/intel/stratix10-svc-client.h    | 11 +++-
>>>>>     include/linux/fpga/fpga-mgr.h                      |  3 ++
>>>>>     7 files changed, 125 insertions(+), 18 deletions(-)
>>>>>
>>>>> -- 
>>>>> 2.7.4
>>>>>
>>>>
>>>
>>
> 
