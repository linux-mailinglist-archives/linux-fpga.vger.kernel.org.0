Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 252243506A8
	for <lists+linux-fpga@lfdr.de>; Wed, 31 Mar 2021 20:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233934AbhCaSrj (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 31 Mar 2021 14:47:39 -0400
Received: from mga09.intel.com ([134.134.136.24]:63656 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234832AbhCaSr3 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 31 Mar 2021 14:47:29 -0400
IronPort-SDR: MPjX/IdaYe5cBrJjLg4bLkJXU9Q7E5M6QXvWtxsZqR3QuSft1ExOlnQ4UhBdh6koQSxMez1tiq
 QA5pmABdBfOQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9940"; a="192173746"
X-IronPort-AV: E=Sophos;i="5.81,293,1610438400"; 
   d="scan'208";a="192173746"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2021 11:47:29 -0700
IronPort-SDR: nhzEm/WpLjQ3qSieIgLCYQuYDZ60wYt+hnbZfwjY4QU5recG3vnulsZsB9jQU5gNO4r3aG52OJ
 DbqHWkqW3DTQ==
X-IronPort-AV: E=Sophos;i="5.81,293,1610438400"; 
   d="scan'208";a="394150559"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO [10.0.2.4]) ([10.209.66.43])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2021 11:47:28 -0700
Subject: Re: [PATCHv5 0/7] Extend Intel service layer, FPGA manager and region
To:     Moritz Fischer <mdf@kernel.org>, Tom Rix <trix@redhat.com>
Cc:     "Gong, Richard" <richard.gong@intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "richard.gong@linux.intel.com" <richard.gong@linux.intel.com>
References: <1612909233-13867-1-git-send-email-richard.gong@linux.intel.com>
 <MWHPR11MB001577B17723C8A046398249879E9@MWHPR11MB0015.namprd11.prod.outlook.com>
 <YF90y3Di4RbuJvr0@epycbox.lan>
 <496aa871-cfb0-faf4-4b1c-b53e56b58030@redhat.com>
 <YGC619DmLM0AAQ5p@epycbox.lan>
From:   Russ Weight <russell.h.weight@intel.com>
Message-ID: <6c741ab7-1ee6-cbf1-94fa-818dd7f4c5c5@intel.com>
Date:   Wed, 31 Mar 2021 11:47:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YGC619DmLM0AAQ5p@epycbox.lan>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Moritz,

On 3/28/21 10:20 AM, Moritz Fischer wrote:
> Tom,
>
> On Sun, Mar 28, 2021 at 08:40:24AM -0700, Tom Rix wrote:
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
>>>>   firmware: stratix10-svc: reset COMMAND_RECONFIG_FLAG_PARTIAL to 0
>>>>   firmware: stratix10-svc: add COMMAND_AUTHENTICATE_BITSTREAM flag
>>>>   firmware: stratix10-svc: extend SVC driver to get the firmware version
>>>>   fpga: fpga-mgr: add FPGA_MGR_BITSTREAM_AUTHENTICATE flag
>>>>   fpga: of-fpga-region: add authenticate-fpga-config property
>>>>   dt-bindings: fpga: add authenticate-fpga-config property
>>>>   fpga: stratix10-soc: extend driver for bitstream authentication
>>>>
>>>>  .../devicetree/bindings/fpga/fpga-region.txt       | 10 ++++
>>>>  drivers/firmware/stratix10-svc.c                   | 12 ++++-
>>>>  drivers/fpga/of-fpga-region.c                      | 24 ++++++---
>>>>  drivers/fpga/stratix10-soc.c                       | 62 +++++++++++++++++++---
>>>>  include/linux/firmware/intel/stratix10-smc.h       | 21 +++++++-
>>>>  .../linux/firmware/intel/stratix10-svc-client.h    | 11 +++-
>>>>  include/linux/fpga/fpga-mgr.h                      |  3 ++
>>>>  7 files changed, 125 insertions(+), 18 deletions(-)
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

Richard and I had an initial conversation today. I'll start looking at how secure operations can be integrated into the fpga manager.

More to come...

Thanks,
- Russ

>> The xrt patchset makes heavy use of device trees.
>>
>> What is the general guidance for device tree usage ?
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
> TL;DR the firmware parts to authenticate the bitstream look fine to me, the
> way we tie it into the FPGA region I'm not a fan of.
>
> - Moritz

