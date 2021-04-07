Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 202DC35787F
	for <lists+linux-fpga@lfdr.de>; Thu,  8 Apr 2021 01:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbhDGX1U (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 7 Apr 2021 19:27:20 -0400
Received: from mga02.intel.com ([134.134.136.20]:45337 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229459AbhDGX1R (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 7 Apr 2021 19:27:17 -0400
IronPort-SDR: FR3/vT6Jpb4KLOV1JfBJPV6kre5IOOJ7g3WEqf5KMnBmOtAus36xh1WRtYs8qlOqKElcLL/EH4
 PHOT4BCkjNMQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9947"; a="180551807"
X-IronPort-AV: E=Sophos;i="5.82,204,1613462400"; 
   d="scan'208";a="180551807"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2021 16:27:06 -0700
IronPort-SDR: ggpX5wZSd964Qxk8Y20dF+DJBD416fjHe1xZacPhwXn0XtHzPpwfa7xgfutHSJipODTRbydQ0z
 wEYfaW8H1v/w==
X-IronPort-AV: E=Sophos;i="5.82,204,1613462400"; 
   d="scan'208";a="380016727"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO [10.0.2.4]) ([10.251.24.78])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2021 16:27:06 -0700
Subject: Re: [PATCHv5 0/7] Extend Intel service layer, FPGA manager and region
To:     Moritz Fischer <mdf@kernel.org>
Cc:     Tom Rix <trix@redhat.com>,
        "Gong, Richard" <richard.gong@intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "richard.gong@linux.intel.com" <richard.gong@linux.intel.com>
References: <1612909233-13867-1-git-send-email-richard.gong@linux.intel.com>
 <MWHPR11MB001577B17723C8A046398249879E9@MWHPR11MB0015.namprd11.prod.outlook.com>
 <YF90y3Di4RbuJvr0@epycbox.lan>
 <496aa871-cfb0-faf4-4b1c-b53e56b58030@redhat.com>
 <YGC619DmLM0AAQ5p@epycbox.lan>
 <6c741ab7-1ee6-cbf1-94fa-818dd7f4c5c5@intel.com>
 <YGT0t/7PEemH7iAI@epycbox.lan>
From:   Russ Weight <russell.h.weight@intel.com>
Message-ID: <edb1507e-194e-e4b8-1136-3bdba64f3c4e@intel.com>
Date:   Wed, 7 Apr 2021 16:27:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YGT0t/7PEemH7iAI@epycbox.lan>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Moritz,

On 3/31/21 3:16 PM, Moritz Fischer wrote:
> Hi Russ,
> On Wed, Mar 31, 2021 at 11:47:26AM -0700, Russ Weight wrote:
>> Moritz,
>>
>> On 3/28/21 10:20 AM, Moritz Fischer wrote:
>>> Tom,
>>>
>>> On Sun, Mar 28, 2021 at 08:40:24AM -0700, Tom Rix wrote:
>>>> On 3/27/21 11:09 AM, Moritz Fischer wrote:
>>>>> Hi Richard, Russ,
>>>>>
>>>>> On Thu, Feb 25, 2021 at 01:07:14PM +0000, Gong, Richard wrote:
>>>>>> Hi Moritz,
>>>>>>
>>>>>> Sorry for asking.
>>>>>>
>>>>>> When you have chance, can you help review the version 5 patchset submitted on 02/09/21?
>>>>>>
>>>>>> Regards,
>>>>>> Richard
>>>>>>
>>>>>> -----Original Message-----
>>>>>> From: richard.gong@linux.intel.com <richard.gong@linux.intel.com> 
>>>>>> Sent: Tuesday, February 9, 2021 4:20 PM
>>>>>> To: mdf@kernel.org; trix@redhat.com; gregkh@linuxfoundation.org; linux-fpga@vger.kernel.org; linux-kernel@vger.kernel.org
>>>>>> Cc: Gong, Richard <richard.gong@intel.com>
>>>>>> Subject: [PATCHv5 0/7] Extend Intel service layer, FPGA manager and region
>>>>>>
>>>>>> From: Richard Gong <richard.gong@intel.com>
>>>>>>
>>>>>> This is 5th submission of Intel service layer and FPGA patches, which includes the missing standalone patch in the 4th submission.
>>>>>>
>>>>>> This submission includes additional changes for Intel service layer driver to get the firmware version running at FPGA SoC device. Then FPGA manager driver, one of Intel service layer driver's client, can decide whether to handle the newly added bitstream authentication function based on the retrieved firmware version. So that we can maintain FPGA manager driver the back compatible.
>>>>>>
>>>>>> Bitstream authentication makes sure a signed bitstream has valid signatures.
>>>>>>
>>>>>> The customer sends the bitstream via FPGA framework and overlay, the firmware will authenticate the bitstream but not program the bitstream to device. If the authentication passes, the bitstream will be programmed into QSPI flash and will be expected to boot without issues.
>>>>>>
>>>>>> Extend Intel service layer, FPGA manager and region drivers to support the bitstream authentication feature. 
>>>>>>
>>>>>> Richard Gong (7):
>>>>>>   firmware: stratix10-svc: reset COMMAND_RECONFIG_FLAG_PARTIAL to 0
>>>>>>   firmware: stratix10-svc: add COMMAND_AUTHENTICATE_BITSTREAM flag
>>>>>>   firmware: stratix10-svc: extend SVC driver to get the firmware version
>>>>>>   fpga: fpga-mgr: add FPGA_MGR_BITSTREAM_AUTHENTICATE flag
>>>>>>   fpga: of-fpga-region: add authenticate-fpga-config property
>>>>>>   dt-bindings: fpga: add authenticate-fpga-config property
>>>>>>   fpga: stratix10-soc: extend driver for bitstream authentication
>>>>>>
>>>>>>  .../devicetree/bindings/fpga/fpga-region.txt       | 10 ++++
>>>>>>  drivers/firmware/stratix10-svc.c                   | 12 ++++-
>>>>>>  drivers/fpga/of-fpga-region.c                      | 24 ++++++---
>>>>>>  drivers/fpga/stratix10-soc.c                       | 62 +++++++++++++++++++---
>>>>>>  include/linux/firmware/intel/stratix10-smc.h       | 21 +++++++-
>>>>>>  .../linux/firmware/intel/stratix10-svc-client.h    | 11 +++-
>>>>>>  include/linux/fpga/fpga-mgr.h                      |  3 ++
>>>>>>  7 files changed, 125 insertions(+), 18 deletions(-)
>>>>>>
>>>>>> --
>>>>>> 2.7.4
>>>>>>
>>>>> Apologies for the epic delay in getting back to this, I took another
>>>>> look at this patchset and Russ' patchset.
>>>>>
>>>>> TL;DR I'm not really a fan of using device-tree overlays for this (and
>>>>> again, apologies, I should've voiced this earlier ...).
>>>>>
>>>>> Anyways, let's find a common API for this and Russ' work, they're trying
>>>>> to achieve the same / similar thing, they should use the same API.
>>>>>
>>>>> I'd like to re-invetigate the possiblity to extend FPGA Manager with
>>>>> 'secure update' ops that work for both these use-cases (and I susspect
>>>>> hte XRT patchset will follow with a similar requirement, right after).
>> Richard and I had an initial conversation today. I'll start looking at how secure operations can be integrated into the fpga manager.
>>
>> More to come...
> Great, feel free to send RFCs ahead.
>
> Cheers,
> Moritz
I have completed a comparison of the security manager and the FPGA manager
to see how the secure update functions can be integrated into the FPGA
manager. I'll send that out separately as an RFC document (it is about 150
lines).

FYI: In my conversations with Richard, we have learned that what we are
trying to accomplish is not as similar as it seemed. Richard is effectively
wanting to do a "dry-run" of an existing FPGA Manager function to verify
authentication of an image. Based on the results, higher-level code may
choose to write the image to flash.

The security manager is all about providing a common user API (sysfs
interface) for tranferring an image to an FPGA card while managing a
completion time (including authentication and FLASH) of up to 40 minutes.

- Russ

