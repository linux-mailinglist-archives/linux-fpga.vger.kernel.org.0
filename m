Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5646F350A19
	for <lists+linux-fpga@lfdr.de>; Thu,  1 Apr 2021 00:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232690AbhCaWQv (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 31 Mar 2021 18:16:51 -0400
Received: from mail-pg1-f169.google.com ([209.85.215.169]:33356 "EHLO
        mail-pg1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232917AbhCaWQZ (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 31 Mar 2021 18:16:25 -0400
Received: by mail-pg1-f169.google.com with SMTP id f3so321055pgv.0;
        Wed, 31 Mar 2021 15:16:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lAfgYSpdkPzGY4sGqjGful9TAMROlVKPNJVMCA9R3EU=;
        b=ibLALJ5PkojGG4++2sbSyobESzV2k4icIRVt8tl/tKNYqT3C62PHjcFMxKgigUlyj0
         IpINKdAvvmiYTM2xkpxiEVlAvhPQ2NT/K4cd1VIdhMyIHQOlMxfWH6G5A38bdl6alVwk
         MamxYSmAS4CoGI7lwvLcbhvdsJ83eC2UVC4PNhU74vYmdEtDXft+FI4jokeSIKmelF1b
         uyF9gfPGGRyxu1lQ+J2Nn0gAfV6Wc0O86Ma6HwIZayVIA7lp+bj4gN/LoOUlR/HveX6T
         8PviduD4pGygkJOLhrJ5ckSelLnSIZbVIDbuhhNTB2cpwlAWvJzZ4Vrdr18WDlCS5CEo
         zLXw==
X-Gm-Message-State: AOAM532bTkTQWxlWGT2VHd58EUs9gaObwPPwWPXFBYhqPhnPicQcokeK
        j+FNdnFr7zS9Gap1cyBo1ikK/X0brHE=
X-Google-Smtp-Source: ABdhPJwCocLn0BTPGo4npIQn4N6y8qUO+z0QmR4ZVHFSCy4m31+99tvlH/Ha/oT3NcZpx2bstdOJLg==
X-Received: by 2002:a63:1c48:: with SMTP id c8mr3928144pgm.234.1617228985028;
        Wed, 31 Mar 2021 15:16:25 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id u4sm3019505pfk.131.2021.03.31.15.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 15:16:24 -0700 (PDT)
Date:   Wed, 31 Mar 2021 15:16:23 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Russ Weight <russell.h.weight@intel.com>
Cc:     Moritz Fischer <mdf@kernel.org>, Tom Rix <trix@redhat.com>,
        "Gong, Richard" <richard.gong@intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "richard.gong@linux.intel.com" <richard.gong@linux.intel.com>
Subject: Re: [PATCHv5 0/7] Extend Intel service layer, FPGA manager and region
Message-ID: <YGT0t/7PEemH7iAI@epycbox.lan>
References: <1612909233-13867-1-git-send-email-richard.gong@linux.intel.com>
 <MWHPR11MB001577B17723C8A046398249879E9@MWHPR11MB0015.namprd11.prod.outlook.com>
 <YF90y3Di4RbuJvr0@epycbox.lan>
 <496aa871-cfb0-faf4-4b1c-b53e56b58030@redhat.com>
 <YGC619DmLM0AAQ5p@epycbox.lan>
 <6c741ab7-1ee6-cbf1-94fa-818dd7f4c5c5@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c741ab7-1ee6-cbf1-94fa-818dd7f4c5c5@intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Russ,
On Wed, Mar 31, 2021 at 11:47:26AM -0700, Russ Weight wrote:
> Moritz,
> 
> On 3/28/21 10:20 AM, Moritz Fischer wrote:
> > Tom,
> >
> > On Sun, Mar 28, 2021 at 08:40:24AM -0700, Tom Rix wrote:
> >> On 3/27/21 11:09 AM, Moritz Fischer wrote:
> >>> Hi Richard, Russ,
> >>>
> >>> On Thu, Feb 25, 2021 at 01:07:14PM +0000, Gong, Richard wrote:
> >>>> Hi Moritz,
> >>>>
> >>>> Sorry for asking.
> >>>>
> >>>> When you have chance, can you help review the version 5 patchset submitted on 02/09/21?
> >>>>
> >>>> Regards,
> >>>> Richard
> >>>>
> >>>> -----Original Message-----
> >>>> From: richard.gong@linux.intel.com <richard.gong@linux.intel.com> 
> >>>> Sent: Tuesday, February 9, 2021 4:20 PM
> >>>> To: mdf@kernel.org; trix@redhat.com; gregkh@linuxfoundation.org; linux-fpga@vger.kernel.org; linux-kernel@vger.kernel.org
> >>>> Cc: Gong, Richard <richard.gong@intel.com>
> >>>> Subject: [PATCHv5 0/7] Extend Intel service layer, FPGA manager and region
> >>>>
> >>>> From: Richard Gong <richard.gong@intel.com>
> >>>>
> >>>> This is 5th submission of Intel service layer and FPGA patches, which includes the missing standalone patch in the 4th submission.
> >>>>
> >>>> This submission includes additional changes for Intel service layer driver to get the firmware version running at FPGA SoC device. Then FPGA manager driver, one of Intel service layer driver's client, can decide whether to handle the newly added bitstream authentication function based on the retrieved firmware version. So that we can maintain FPGA manager driver the back compatible.
> >>>>
> >>>> Bitstream authentication makes sure a signed bitstream has valid signatures.
> >>>>
> >>>> The customer sends the bitstream via FPGA framework and overlay, the firmware will authenticate the bitstream but not program the bitstream to device. If the authentication passes, the bitstream will be programmed into QSPI flash and will be expected to boot without issues.
> >>>>
> >>>> Extend Intel service layer, FPGA manager and region drivers to support the bitstream authentication feature. 
> >>>>
> >>>> Richard Gong (7):
> >>>>   firmware: stratix10-svc: reset COMMAND_RECONFIG_FLAG_PARTIAL to 0
> >>>>   firmware: stratix10-svc: add COMMAND_AUTHENTICATE_BITSTREAM flag
> >>>>   firmware: stratix10-svc: extend SVC driver to get the firmware version
> >>>>   fpga: fpga-mgr: add FPGA_MGR_BITSTREAM_AUTHENTICATE flag
> >>>>   fpga: of-fpga-region: add authenticate-fpga-config property
> >>>>   dt-bindings: fpga: add authenticate-fpga-config property
> >>>>   fpga: stratix10-soc: extend driver for bitstream authentication
> >>>>
> >>>>  .../devicetree/bindings/fpga/fpga-region.txt       | 10 ++++
> >>>>  drivers/firmware/stratix10-svc.c                   | 12 ++++-
> >>>>  drivers/fpga/of-fpga-region.c                      | 24 ++++++---
> >>>>  drivers/fpga/stratix10-soc.c                       | 62 +++++++++++++++++++---
> >>>>  include/linux/firmware/intel/stratix10-smc.h       | 21 +++++++-
> >>>>  .../linux/firmware/intel/stratix10-svc-client.h    | 11 +++-
> >>>>  include/linux/fpga/fpga-mgr.h                      |  3 ++
> >>>>  7 files changed, 125 insertions(+), 18 deletions(-)
> >>>>
> >>>> --
> >>>> 2.7.4
> >>>>
> >>> Apologies for the epic delay in getting back to this, I took another
> >>> look at this patchset and Russ' patchset.
> >>>
> >>> TL;DR I'm not really a fan of using device-tree overlays for this (and
> >>> again, apologies, I should've voiced this earlier ...).
> >>>
> >>> Anyways, let's find a common API for this and Russ' work, they're trying
> >>> to achieve the same / similar thing, they should use the same API.
> >>>
> >>> I'd like to re-invetigate the possiblity to extend FPGA Manager with
> >>> 'secure update' ops that work for both these use-cases (and I susspect
> >>> hte XRT patchset will follow with a similar requirement, right after).
> 
> Richard and I had an initial conversation today. I'll start looking at how secure operations can be integrated into the fpga manager.
> 
> More to come...

Great, feel free to send RFCs ahead.

Cheers,
Moritz
