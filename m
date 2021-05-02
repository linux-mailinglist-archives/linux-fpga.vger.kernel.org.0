Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B81CB370E95
	for <lists+linux-fpga@lfdr.de>; Sun,  2 May 2021 20:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbhEBSn5 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 2 May 2021 14:43:57 -0400
Received: from mail-pg1-f172.google.com ([209.85.215.172]:43604 "EHLO
        mail-pg1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbhEBSn5 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 2 May 2021 14:43:57 -0400
Received: by mail-pg1-f172.google.com with SMTP id p12so2166398pgj.10;
        Sun, 02 May 2021 11:43:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=l/vwSrN0JaNGGibpJY8/O2zej4SM1m+juGfyVrtRwyQ=;
        b=igMmRaKS+lMOVwDvq+/vJyktgvcUhdh8EutlGZpPGzMD1sOA9kLCgFLeccbWly/DYv
         SlDwpROQToJRD6DWz8m0Nkb6kxd1LI7xVHJoEBkjGNSzNo3Hb0U7xtF0MltKZhdURWpc
         Zdl1ZVilqhHC+grWW9BxXxoxf56oNFH5iFOfvFm8na3phFzmDu41aL1VPhFEgOI0ITJ9
         Coo0rLwDUwf00ZE1SZ2TooN89txdwfUczi6fuhs7v2n2fy7j8DIbXklM4UBOVC5hYSiV
         zTOGl6OsCb7ANeeTi0IpnfmfE9PVFZCqIePPYa3ZZYxgG1A0NZbMmLh6fBEnnGG2Rlcq
         AM6Q==
X-Gm-Message-State: AOAM5307MvdffxSUqcoKqReXr9eS/bXVyw7PVHYB1BTEqYy7qLqlgHLL
        t5vRAm7AS6n8jlpWgLjUh/s=
X-Google-Smtp-Source: ABdhPJzdSlQEQXfe5HqTUQ6Z9M22G6wvGkR8Ftrdfugpg/5JN0DRAU8YGMw/URksgME/VSi7mm306w==
X-Received: by 2002:a05:6a00:228a:b029:264:1ec7:7c3 with SMTP id f10-20020a056a00228ab02902641ec707c3mr15616825pfe.2.1619980985552;
        Sun, 02 May 2021 11:43:05 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id k7sm3911763pfc.16.2021.05.02.11.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 May 2021 11:43:04 -0700 (PDT)
Date:   Sun, 2 May 2021 11:43:04 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Russ Weight <russell.h.weight@intel.com>
Cc:     Moritz Fischer <mdf@kernel.org>, Tom Rix <trix@redhat.com>,
        "Gong, Richard" <richard.gong@intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "richard.gong@linux.intel.com" <richard.gong@linux.intel.com>
Subject: Re: [PATCHv5 0/7] Extend Intel service layer, FPGA manager and region
Message-ID: <YI7yuD194KUOscLx@epycbox.lan>
References: <1612909233-13867-1-git-send-email-richard.gong@linux.intel.com>
 <MWHPR11MB001577B17723C8A046398249879E9@MWHPR11MB0015.namprd11.prod.outlook.com>
 <YF90y3Di4RbuJvr0@epycbox.lan>
 <496aa871-cfb0-faf4-4b1c-b53e56b58030@redhat.com>
 <YGC619DmLM0AAQ5p@epycbox.lan>
 <6c741ab7-1ee6-cbf1-94fa-818dd7f4c5c5@intel.com>
 <YGT0t/7PEemH7iAI@epycbox.lan>
 <edb1507e-194e-e4b8-1136-3bdba64f3c4e@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <edb1507e-194e-e4b8-1136-3bdba64f3c4e@intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Wed, Apr 07, 2021 at 04:27:03PM -0700, Russ Weight wrote:
> Hi Moritz,
> 
> On 3/31/21 3:16 PM, Moritz Fischer wrote:
> > Hi Russ,
> > On Wed, Mar 31, 2021 at 11:47:26AM -0700, Russ Weight wrote:
> >> Moritz,
> >>
> >> On 3/28/21 10:20 AM, Moritz Fischer wrote:
> >>> Tom,
> >>>
> >>> On Sun, Mar 28, 2021 at 08:40:24AM -0700, Tom Rix wrote:
> >>>> On 3/27/21 11:09 AM, Moritz Fischer wrote:
> >>>>> Hi Richard, Russ,
> >>>>>
> >>>>> On Thu, Feb 25, 2021 at 01:07:14PM +0000, Gong, Richard wrote:
> >>>>>> Hi Moritz,
> >>>>>>
> >>>>>> Sorry for asking.
> >>>>>>
> >>>>>> When you have chance, can you help review the version 5 patchset submitted on 02/09/21?
> >>>>>>
> >>>>>> Regards,
> >>>>>> Richard
> >>>>>>
> >>>>>> -----Original Message-----
> >>>>>> From: richard.gong@linux.intel.com <richard.gong@linux.intel.com> 
> >>>>>> Sent: Tuesday, February 9, 2021 4:20 PM
> >>>>>> To: mdf@kernel.org; trix@redhat.com; gregkh@linuxfoundation.org; linux-fpga@vger.kernel.org; linux-kernel@vger.kernel.org
> >>>>>> Cc: Gong, Richard <richard.gong@intel.com>
> >>>>>> Subject: [PATCHv5 0/7] Extend Intel service layer, FPGA manager and region
> >>>>>>
> >>>>>> From: Richard Gong <richard.gong@intel.com>
> >>>>>>
> >>>>>> This is 5th submission of Intel service layer and FPGA patches, which includes the missing standalone patch in the 4th submission.
> >>>>>>
> >>>>>> This submission includes additional changes for Intel service layer driver to get the firmware version running at FPGA SoC device. Then FPGA manager driver, one of Intel service layer driver's client, can decide whether to handle the newly added bitstream authentication function based on the retrieved firmware version. So that we can maintain FPGA manager driver the back compatible.
> >>>>>>
> >>>>>> Bitstream authentication makes sure a signed bitstream has valid signatures.
> >>>>>>
> >>>>>> The customer sends the bitstream via FPGA framework and overlay, the firmware will authenticate the bitstream but not program the bitstream to device. If the authentication passes, the bitstream will be programmed into QSPI flash and will be expected to boot without issues.
> >>>>>>
> >>>>>> Extend Intel service layer, FPGA manager and region drivers to support the bitstream authentication feature. 
> >>>>>>
> >>>>>> Richard Gong (7):
> >>>>>>   firmware: stratix10-svc: reset COMMAND_RECONFIG_FLAG_PARTIAL to 0
> >>>>>>   firmware: stratix10-svc: add COMMAND_AUTHENTICATE_BITSTREAM flag
> >>>>>>   firmware: stratix10-svc: extend SVC driver to get the firmware version
> >>>>>>   fpga: fpga-mgr: add FPGA_MGR_BITSTREAM_AUTHENTICATE flag
> >>>>>>   fpga: of-fpga-region: add authenticate-fpga-config property
> >>>>>>   dt-bindings: fpga: add authenticate-fpga-config property
> >>>>>>   fpga: stratix10-soc: extend driver for bitstream authentication
> >>>>>>
> >>>>>>  .../devicetree/bindings/fpga/fpga-region.txt       | 10 ++++
> >>>>>>  drivers/firmware/stratix10-svc.c                   | 12 ++++-
> >>>>>>  drivers/fpga/of-fpga-region.c                      | 24 ++++++---
> >>>>>>  drivers/fpga/stratix10-soc.c                       | 62 +++++++++++++++++++---
> >>>>>>  include/linux/firmware/intel/stratix10-smc.h       | 21 +++++++-
> >>>>>>  .../linux/firmware/intel/stratix10-svc-client.h    | 11 +++-
> >>>>>>  include/linux/fpga/fpga-mgr.h                      |  3 ++
> >>>>>>  7 files changed, 125 insertions(+), 18 deletions(-)
> >>>>>>
> >>>>>> --
> >>>>>> 2.7.4
> >>>>>>
> >>>>> Apologies for the epic delay in getting back to this, I took another
> >>>>> look at this patchset and Russ' patchset.
> >>>>>
> >>>>> TL;DR I'm not really a fan of using device-tree overlays for this (and
> >>>>> again, apologies, I should've voiced this earlier ...).
> >>>>>
> >>>>> Anyways, let's find a common API for this and Russ' work, they're trying
> >>>>> to achieve the same / similar thing, they should use the same API.
> >>>>>
> >>>>> I'd like to re-invetigate the possiblity to extend FPGA Manager with
> >>>>> 'secure update' ops that work for both these use-cases (and I susspect
> >>>>> hte XRT patchset will follow with a similar requirement, right after).
> >> Richard and I had an initial conversation today. I'll start looking at how secure operations can be integrated into the fpga manager.
> >>
> >> More to come...
> > Great, feel free to send RFCs ahead.
> >
> > Cheers,
> > Moritz
> I have completed a comparison of the security manager and the FPGA manager
> to see how the secure update functions can be integrated into the FPGA
> manager. I'll send that out separately as an RFC document (it is about 150
> lines).
> 
> FYI: In my conversations with Richard, we have learned that what we are
> trying to accomplish is not as similar as it seemed. Richard is effectively
> wanting to do a "dry-run" of an existing FPGA Manager function to verify
> authentication of an image. Based on the results, higher-level code may
> choose to write the image to flash.

Ok, as mentioned on the other thread. Let's replace the overlay code
with a sysfs entry for dry-run or verify-image or something of that
sort.

I don't see what the overlay mechanism adds in this case since we're not
trying to load drivers.

- Moritz
