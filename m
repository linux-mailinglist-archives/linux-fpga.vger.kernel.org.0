Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00B9934BD87
	for <lists+linux-fpga@lfdr.de>; Sun, 28 Mar 2021 19:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbhC1RUz (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 28 Mar 2021 13:20:55 -0400
Received: from mail-pj1-f54.google.com ([209.85.216.54]:41871 "EHLO
        mail-pj1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbhC1RU0 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 28 Mar 2021 13:20:26 -0400
Received: by mail-pj1-f54.google.com with SMTP id nh23-20020a17090b3657b02900c0d5e235a8so4827362pjb.0;
        Sun, 28 Mar 2021 10:20:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0CdNKJndfJrBqi8zf8ffL/DDeiGdWrF+QOsUqJFXedA=;
        b=EEB44jbWG5niHeJlZLe7muR+t1oksq84ne5Ubicw7KXLGPO03ZYIxp0YaDzmOv+MkU
         kkeTyINNajsERuOERktlSe3OlUvie0SItffGo6RvGF5tXCgBErNHYHUkbbLI7GbowHnb
         UHBlnLJskCx3iah+VRCdbG1wBd5Ry7ccdEjJ9NSqHXnaZOdxX8EL+cII/LGLc50yOpQs
         SE/hz2xQSMPF+wOOffQrulziwVotz9UpgjC1Qlt9uSKjI/PI99pQNSeffgNB9oJewSgS
         nzRLlje09gJeAg+BIkVtEKTKe+3M/jrBgk3FTC/nzaODxtqlJUzM3QjYvKI9ERWiQXpm
         QAaA==
X-Gm-Message-State: AOAM531w2BTkfgxy4Xux5qnPbbbERsm+RwIHmuuJ0uAMv2HdvOve8tA2
        NyWVpPMP4cZfYRdh8/uOb3k=
X-Google-Smtp-Source: ABdhPJz0uxxYoHOsbILzzRen7JKz9aIUf5n4aqJIcZF9vt/tHMaVN/KV6+NN8bIhHV/NUHgVVPYWNw==
X-Received: by 2002:a17:90a:9413:: with SMTP id r19mr13337158pjo.236.1616952026015;
        Sun, 28 Mar 2021 10:20:26 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id k21sm15471182pfi.28.2021.03.28.10.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 10:20:25 -0700 (PDT)
Date:   Sun, 28 Mar 2021 10:20:23 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Tom Rix <trix@redhat.com>
Cc:     Moritz Fischer <mdf@kernel.org>,
        "Gong, Richard" <richard.gong@intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "richard.gong@linux.intel.com" <richard.gong@linux.intel.com>,
        russell.h.weight@intel.com
Subject: Re: [PATCHv5 0/7] Extend Intel service layer, FPGA manager and region
Message-ID: <YGC619DmLM0AAQ5p@epycbox.lan>
References: <1612909233-13867-1-git-send-email-richard.gong@linux.intel.com>
 <MWHPR11MB001577B17723C8A046398249879E9@MWHPR11MB0015.namprd11.prod.outlook.com>
 <YF90y3Di4RbuJvr0@epycbox.lan>
 <496aa871-cfb0-faf4-4b1c-b53e56b58030@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <496aa871-cfb0-faf4-4b1c-b53e56b58030@redhat.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Tom,

On Sun, Mar 28, 2021 at 08:40:24AM -0700, Tom Rix wrote:
> 
> On 3/27/21 11:09 AM, Moritz Fischer wrote:
> > Hi Richard, Russ,
> >
> > On Thu, Feb 25, 2021 at 01:07:14PM +0000, Gong, Richard wrote:
> >> Hi Moritz,
> >>
> >> Sorry for asking.
> >>
> >> When you have chance, can you help review the version 5 patchset submitted on 02/09/21?
> >>
> >> Regards,
> >> Richard
> >>
> >> -----Original Message-----
> >> From: richard.gong@linux.intel.com <richard.gong@linux.intel.com> 
> >> Sent: Tuesday, February 9, 2021 4:20 PM
> >> To: mdf@kernel.org; trix@redhat.com; gregkh@linuxfoundation.org; linux-fpga@vger.kernel.org; linux-kernel@vger.kernel.org
> >> Cc: Gong, Richard <richard.gong@intel.com>
> >> Subject: [PATCHv5 0/7] Extend Intel service layer, FPGA manager and region
> >>
> >> From: Richard Gong <richard.gong@intel.com>
> >>
> >> This is 5th submission of Intel service layer and FPGA patches, which includes the missing standalone patch in the 4th submission.
> >>
> >> This submission includes additional changes for Intel service layer driver to get the firmware version running at FPGA SoC device. Then FPGA manager driver, one of Intel service layer driver's client, can decide whether to handle the newly added bitstream authentication function based on the retrieved firmware version. So that we can maintain FPGA manager driver the back compatible.
> >>
> >> Bitstream authentication makes sure a signed bitstream has valid signatures.
> >>
> >> The customer sends the bitstream via FPGA framework and overlay, the firmware will authenticate the bitstream but not program the bitstream to device. If the authentication passes, the bitstream will be programmed into QSPI flash and will be expected to boot without issues.
> >>
> >> Extend Intel service layer, FPGA manager and region drivers to support the bitstream authentication feature. 
> >>
> >> Richard Gong (7):
> >>   firmware: stratix10-svc: reset COMMAND_RECONFIG_FLAG_PARTIAL to 0
> >>   firmware: stratix10-svc: add COMMAND_AUTHENTICATE_BITSTREAM flag
> >>   firmware: stratix10-svc: extend SVC driver to get the firmware version
> >>   fpga: fpga-mgr: add FPGA_MGR_BITSTREAM_AUTHENTICATE flag
> >>   fpga: of-fpga-region: add authenticate-fpga-config property
> >>   dt-bindings: fpga: add authenticate-fpga-config property
> >>   fpga: stratix10-soc: extend driver for bitstream authentication
> >>
> >>  .../devicetree/bindings/fpga/fpga-region.txt       | 10 ++++
> >>  drivers/firmware/stratix10-svc.c                   | 12 ++++-
> >>  drivers/fpga/of-fpga-region.c                      | 24 ++++++---
> >>  drivers/fpga/stratix10-soc.c                       | 62 +++++++++++++++++++---
> >>  include/linux/firmware/intel/stratix10-smc.h       | 21 +++++++-
> >>  .../linux/firmware/intel/stratix10-svc-client.h    | 11 +++-
> >>  include/linux/fpga/fpga-mgr.h                      |  3 ++
> >>  7 files changed, 125 insertions(+), 18 deletions(-)
> >>
> >> --
> >> 2.7.4
> >>
> > Apologies for the epic delay in getting back to this, I took another
> > look at this patchset and Russ' patchset.
> >
> > TL;DR I'm not really a fan of using device-tree overlays for this (and
> > again, apologies, I should've voiced this earlier ...).
> >
> > Anyways, let's find a common API for this and Russ' work, they're trying
> > to achieve the same / similar thing, they should use the same API.
> >
> > I'd like to re-invetigate the possiblity to extend FPGA Manager with
> > 'secure update' ops that work for both these use-cases (and I susspect
> > hte XRT patchset will follow with a similar requirement, right after).
> 
> The xrt patchset makes heavy use of device trees.
> 
> What is the general guidance for device tree usage ?

I'm not generally against using device tree, it has its place. To
describe hardware (and hardware *changes* with overlays) :)

What I don't like about this particular implementation w.r.t device-tree
usage is that it uses DT overlays as a mechanism to program the flash --
in place of having an API to do so.

One could add device-nodes during the DT overlay application, while the
FPGA doesn't actually get programmed with a new runtime image -- meaning
live DT and actual hardware state diverged -- worst case it'd crash.

So when roughly at the same time (from the same company even) we have two
patchsets that do similar things with radically different APIs I think
we should pause, and reflect on whether we can come up with something
that works for both :)

TL;DR the firmware parts to authenticate the bitstream look fine to me, the
way we tie it into the FPGA region I'm not a fan of.

- Moritz
