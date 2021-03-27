Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02F2934B8C7
	for <lists+linux-fpga@lfdr.de>; Sat, 27 Mar 2021 19:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbhC0SJe (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 27 Mar 2021 14:09:34 -0400
Received: from mail-pf1-f175.google.com ([209.85.210.175]:36850 "EHLO
        mail-pf1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbhC0SJS (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 27 Mar 2021 14:09:18 -0400
Received: by mail-pf1-f175.google.com with SMTP id g15so7103735pfq.3;
        Sat, 27 Mar 2021 11:09:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6xzGou6bWJ4Gep7bD4N9u8hoZ/Sp4FfRVspKGhRyZg8=;
        b=qg8BuyGVqkKNwL1/F8u5xyKPvvh4V8jXXpP/qwUyYC2x2Y1O756Kf8guZeNtDT19dB
         KHHSHSez25RTvnrc6pDP8l7mLrW+USgbTytAnGeDv3CHyu/SMzbj4g+S9qsBz1XcUA7/
         50eKl8cUYNwGnmOrAT/FXG38EfHAimJJq1pvGoCGK701kuUrK7YY1fvgr3ckfK5xXQ53
         xJAuUFF3YAfQfR5XRrlmKXDQqGs7w9v6VjRdu6zDp4kZGHFKFsZ89HDazSyETg6qmNyq
         9g8s/BnWOAnNPWQPCj6X7oOFsc23sTUr2Vn/cyXwZ5z2wl6/yX/AzlJOcjhyaQl+WTq3
         gE7A==
X-Gm-Message-State: AOAM5329+plUslMaz1leXeThTl2PGPDz9NAtJofphE+PsavYl82Vf5l/
        XXlWwJd8Y9YXEe6BoZONPHA=
X-Google-Smtp-Source: ABdhPJwsgsIFOm3+hoYJqrvQh22TXbObIKVxoRiEqmlUME0BBFyC6JhVOs09msVHyUjleQ2n1fvsFQ==
X-Received: by 2002:a62:2cce:0:b029:21d:97da:833e with SMTP id s197-20020a622cce0000b029021d97da833emr17787235pfs.40.1616868557584;
        Sat, 27 Mar 2021 11:09:17 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id x22sm2233141pfc.163.2021.03.27.11.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Mar 2021 11:09:16 -0700 (PDT)
Date:   Sat, 27 Mar 2021 11:09:15 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     "Gong, Richard" <richard.gong@intel.com>
Cc:     "mdf@kernel.org" <mdf@kernel.org>,
        "trix@redhat.com" <trix@redhat.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "richard.gong@linux.intel.com" <richard.gong@linux.intel.com>,
        russell.h.weight@intel.com
Subject: Re: [PATCHv5 0/7]  Extend Intel service layer, FPGA manager and
 region
Message-ID: <YF90y3Di4RbuJvr0@epycbox.lan>
References: <1612909233-13867-1-git-send-email-richard.gong@linux.intel.com>
 <MWHPR11MB001577B17723C8A046398249879E9@MWHPR11MB0015.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR11MB001577B17723C8A046398249879E9@MWHPR11MB0015.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Richard, Russ,

On Thu, Feb 25, 2021 at 01:07:14PM +0000, Gong, Richard wrote:
> Hi Moritz,
> 
> Sorry for asking.
> 
> When you have chance, can you help review the version 5 patchset submitted on 02/09/21?
> 
> Regards,
> Richard
> 
> -----Original Message-----
> From: richard.gong@linux.intel.com <richard.gong@linux.intel.com> 
> Sent: Tuesday, February 9, 2021 4:20 PM
> To: mdf@kernel.org; trix@redhat.com; gregkh@linuxfoundation.org; linux-fpga@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: Gong, Richard <richard.gong@intel.com>
> Subject: [PATCHv5 0/7] Extend Intel service layer, FPGA manager and region
> 
> From: Richard Gong <richard.gong@intel.com>
> 
> This is 5th submission of Intel service layer and FPGA patches, which includes the missing standalone patch in the 4th submission.
> 
> This submission includes additional changes for Intel service layer driver to get the firmware version running at FPGA SoC device. Then FPGA manager driver, one of Intel service layer driver's client, can decide whether to handle the newly added bitstream authentication function based on the retrieved firmware version. So that we can maintain FPGA manager driver the back compatible.
> 
> Bitstream authentication makes sure a signed bitstream has valid signatures.
> 
> The customer sends the bitstream via FPGA framework and overlay, the firmware will authenticate the bitstream but not program the bitstream to device. If the authentication passes, the bitstream will be programmed into QSPI flash and will be expected to boot without issues.
> 
> Extend Intel service layer, FPGA manager and region drivers to support the bitstream authentication feature. 
> 
> Richard Gong (7):
>   firmware: stratix10-svc: reset COMMAND_RECONFIG_FLAG_PARTIAL to 0
>   firmware: stratix10-svc: add COMMAND_AUTHENTICATE_BITSTREAM flag
>   firmware: stratix10-svc: extend SVC driver to get the firmware version
>   fpga: fpga-mgr: add FPGA_MGR_BITSTREAM_AUTHENTICATE flag
>   fpga: of-fpga-region: add authenticate-fpga-config property
>   dt-bindings: fpga: add authenticate-fpga-config property
>   fpga: stratix10-soc: extend driver for bitstream authentication
> 
>  .../devicetree/bindings/fpga/fpga-region.txt       | 10 ++++
>  drivers/firmware/stratix10-svc.c                   | 12 ++++-
>  drivers/fpga/of-fpga-region.c                      | 24 ++++++---
>  drivers/fpga/stratix10-soc.c                       | 62 +++++++++++++++++++---
>  include/linux/firmware/intel/stratix10-smc.h       | 21 +++++++-
>  .../linux/firmware/intel/stratix10-svc-client.h    | 11 +++-
>  include/linux/fpga/fpga-mgr.h                      |  3 ++
>  7 files changed, 125 insertions(+), 18 deletions(-)
> 
> --
> 2.7.4
> 

Apologies for the epic delay in getting back to this, I took another
look at this patchset and Russ' patchset.

TL;DR I'm not really a fan of using device-tree overlays for this (and
again, apologies, I should've voiced this earlier ...).

Anyways, let's find a common API for this and Russ' work, they're trying
to achieve the same / similar thing, they should use the same API.

I'd like to re-invetigate the possiblity to extend FPGA Manager with
'secure update' ops that work for both these use-cases (and I susspect
hte XRT patchset will follow with a similar requirement, right after).

- Moritz
