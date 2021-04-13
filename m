Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD6435D4BD
	for <lists+linux-fpga@lfdr.de>; Tue, 13 Apr 2021 03:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243119AbhDMBWh (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 12 Apr 2021 21:22:37 -0400
Received: from mga07.intel.com ([134.134.136.100]:37026 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235837AbhDMBWg (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 12 Apr 2021 21:22:36 -0400
IronPort-SDR: M0qZKOUr+WRb++ck8ErLZIT2URnQ/yVs8zmyNz2+4C7iUKAYV50NmtlFlv05pgtneyuTzb+5NU
 uRrsXDwwfpGw==
X-IronPort-AV: E=McAfee;i="6200,9189,9952"; a="258286504"
X-IronPort-AV: E=Sophos;i="5.82,216,1613462400"; 
   d="scan'208";a="258286504"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2021 18:22:16 -0700
IronPort-SDR: WgKI/MS8CYjT9EOaRVP21ODABMPhTbLn5dBCj+QNV9HVq2OGrDGvG7FQxhumNKavry00KhFNST
 TAS7RGfcfWvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,216,1613462400"; 
   d="scan'208";a="521403712"
Received: from marshy.an.intel.com (HELO [10.122.105.143]) ([10.122.105.143])
  by fmsmga001.fm.intel.com with ESMTP; 12 Apr 2021 18:22:14 -0700
Subject: Re: [PATCHv5 0/7] Extend Intel service layer, FPGA manager and region
To:     Moritz Fischer <mdf@kernel.org>, Tom Rix <trix@redhat.com>
Cc:     "Gong, Richard" <richard.gong@intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        russell.h.weight@intel.com
References: <1612909233-13867-1-git-send-email-richard.gong@linux.intel.com>
 <MWHPR11MB001577B17723C8A046398249879E9@MWHPR11MB0015.namprd11.prod.outlook.com>
 <YF90y3Di4RbuJvr0@epycbox.lan>
 <496aa871-cfb0-faf4-4b1c-b53e56b58030@redhat.com>
 <YGC619DmLM0AAQ5p@epycbox.lan>
From:   Richard Gong <richard.gong@linux.intel.com>
Message-ID: <8c0fcdde-540b-2ae3-01f2-30cdb87ac037@linux.intel.com>
Date:   Mon, 12 Apr 2021 20:41:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YGC619DmLM0AAQ5p@epycbox.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


Hi Moritz,

On 3/28/21 12:20 PM, Moritz Fischer wrote:
> Tom,
> 
> On Sun, Mar 28, 2021 at 08:40:24AM -0700, Tom Rix wrote:
>>
>> On 3/27/21 11:09 AM, Moritz Fischer wrote:
>>> Hi Richard, Russ,
>>>
>>> On Thu, Feb 25, 2021 at 01:07:14PM +0000, Gong, Richard wrote:
>>>> Hi Moritz,
>>>>
>>>> Sorry for asking.
>>>>
>>>> When you have chance, can you help review the version 5 patchset submitted on 02/09/21?
>>>>
>>>> Regards,
>>>> Richard
>>>>
>>>> -----Original Message-----
>>>> From: richard.gong@linux.intel.com <richard.gong@linux.intel.com>
>>>> Sent: Tuesday, February 9, 2021 4:20 PM
>>>> To: mdf@kernel.org; trix@redhat.com; gregkh@linuxfoundation.org; linux-fpga@vger.kernel.org; linux-kernel@vger.kernel.org
>>>> Cc: Gong, Richard <richard.gong@intel.com>
>>>> Subject: [PATCHv5 0/7] Extend Intel service layer, FPGA manager and region
>>>>
>>>> From: Richard Gong <richard.gong@intel.com>
>>>>
>>>> This is 5th submission of Intel service layer and FPGA patches, which includes the missing standalone patch in the 4th submission.
>>>>
>>>> This submission includes additional changes for Intel service layer driver to get the firmware version running at FPGA SoC device. Then FPGA manager driver, one of Intel service layer driver's client, can decide whether to handle the newly added bitstream authentication function based on the retrieved firmware version. So that we can maintain FPGA manager driver the back compatible.
>>>>
>>>> Bitstream authentication makes sure a signed bitstream has valid signatures.
>>>>
>>>> The customer sends the bitstream via FPGA framework and overlay, the firmware will authenticate the bitstream but not program the bitstream to device. If the authentication passes, the bitstream will be programmed into QSPI flash and will be expected to boot without issues.
>>>>
>>>> Extend Intel service layer, FPGA manager and region drivers to support the bitstream authentication feature.
>>>>
>>>> Richard Gong (7):
>>>>    firmware: stratix10-svc: reset COMMAND_RECONFIG_FLAG_PARTIAL to 0
>>>>    firmware: stratix10-svc: add COMMAND_AUTHENTICATE_BITSTREAM flag
>>>>    firmware: stratix10-svc: extend SVC driver to get the firmware version
>>>>    fpga: fpga-mgr: add FPGA_MGR_BITSTREAM_AUTHENTICATE flag
>>>>    fpga: of-fpga-region: add authenticate-fpga-config property
>>>>    dt-bindings: fpga: add authenticate-fpga-config property
>>>>    fpga: stratix10-soc: extend driver for bitstream authentication
>>>>
>>>>   .../devicetree/bindings/fpga/fpga-region.txt       | 10 ++++
>>>>   drivers/firmware/stratix10-svc.c                   | 12 ++++-
>>>>   drivers/fpga/of-fpga-region.c                      | 24 ++++++---
>>>>   drivers/fpga/stratix10-soc.c                       | 62 +++++++++++++++++++---
>>>>   include/linux/firmware/intel/stratix10-smc.h       | 21 +++++++-
>>>>   .../linux/firmware/intel/stratix10-svc-client.h    | 11 +++-
>>>>   include/linux/fpga/fpga-mgr.h                      |  3 ++
>>>>   7 files changed, 125 insertions(+), 18 deletions(-)
>>>>
>>>> --
>>>> 2.7.4
>>>>
>>> Apologies for the epic delay in getting back to this, I took another
>>> look at this patchset and Russ' patchset.
>>>
>>> TL;DR I'm not really a fan of using device-tree overlays for this (and
>>> again, apologies, I should've voiced this earlier ...).
>>>
>>> Anyways, let's find a common API for this and Russ' work, they're trying
>>> to achieve the same / similar thing, they should use the same API.
>>>
>>> I'd like to re-invetigate the possiblity to extend FPGA Manager with
>>> 'secure update' ops that work for both these use-cases (and I susspect
>>> hte XRT patchset will follow with a similar requirement, right after).
>>
>> The xrt patchset makes heavy use of device trees.
>>
>> What is the general guidance for device tree usage ?
> 
> I'm not generally against using device tree, it has its place. To
> describe hardware (and hardware *changes* with overlays) :)
> 
> What I don't like about this particular implementation w.r.t device-tree
> usage is that it uses DT overlays as a mechanism to program the flash --
> in place of having an API to do so.
> 
> One could add device-nodes during the DT overlay application, while the
> FPGA doesn't actually get programmed with a new runtime image -- meaning
> live DT and actual hardware state diverged -- worst case it'd crash.
> 
> So when roughly at the same time (from the same company even) we have two
> patchsets that do similar things with radically different APIs I think
> we should pause, and reflect on whether we can come up with something
> that works for both :)
>

I discussed with Russ and studies his patches, came to realize that the 
work we had to accomplish was not same or similar. What I want to 
achieve is to verify the identity of the bitstream, which is like doing 
a "dry-run" to FPGA configuration.

Performing FPGA configuration (full or partial) through the device tree 
overlay is a method widely used by our customers.

Russ's approach utilizes a different user API which is a set of sysfs files.

If we depart from device tree overlay, then the end-user must utilize 2 
different mechanism or APIs (device tree overlay is used for 
full/partial configuration, and sysfs is used for bitstream 
authentication). Similarly low-level FPGA manager driver also needs to 
add additional codes. For the end-user the single and simple mechanism 
is always better choice, device tree overlay should be a better way to 
achieve that goal.

Regards,
Richard

> TL;DR the firmware parts to authenticate the bitstream look fine to me, the
> way we tie it into the FPGA region I'm not a fan of.
> 
> - Moritz
> 
