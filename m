Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2976C2EA32D
	for <lists+linux-fpga@lfdr.de>; Tue,  5 Jan 2021 03:07:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727098AbhAECGQ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 4 Jan 2021 21:06:16 -0500
Received: from mga18.intel.com ([134.134.136.126]:4586 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727096AbhAECGQ (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 4 Jan 2021 21:06:16 -0500
IronPort-SDR: hXJZtgt3T7h2aWGNB8P8eKtYivzLONGo3jzcLXoFqB3VV/rSAJ8mmAsC7wVE7XNoNANB81IsXq
 ILSAKfif1/Pw==
X-IronPort-AV: E=McAfee;i="6000,8403,9854"; a="164739531"
X-IronPort-AV: E=Sophos;i="5.78,475,1599548400"; 
   d="scan'208";a="164739531"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2021 18:05:34 -0800
IronPort-SDR: YujBvvYxnmP0ugdVhTfq3hVFhmxDq6e4A3pa+9hOSnI8qnnag3hlWNpNcP57Xgbp844k4Qv9y0
 BcbIhvsiVKFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,475,1599548400"; 
   d="scan'208";a="496613310"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by orsmga004.jf.intel.com with ESMTP; 04 Jan 2021 18:05:32 -0800
Date:   Tue, 5 Jan 2021 10:00:50 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Russ Weight <russell.h.weight@intel.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        trix@redhat.com, lgoncalv@redhat.com, hao.wu@intel.com
Subject: Re: [PATCH v5 2/2] Documentation: fpga: dfl: Add description for DFL
  UIO support
Message-ID: <20210105020050.GA2296@yilunxu-OptiPlex-7050>
References: <1609557182-20787-1-git-send-email-yilun.xu@intel.com>
 <1609557182-20787-3-git-send-email-yilun.xu@intel.com>
 <0f5c3f7c-f367-086f-cd43-d8b23f9a833e@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f5c3f7c-f367-086f-cd43-d8b23f9a833e@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Jan 04, 2021 at 09:19:24AM -0800, Russ Weight wrote:
> 
> 
> On 1/1/21 7:13 PM, Xu Yilun wrote:
> > This patch adds description for UIO support for dfl devices on DFL
> > bus.
> >
> > Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> > ---
> > v2: no doc in v1, add it for v2.
> > v3: some documentation fixes.
> > v4: documentation change since the driver matching is changed.
> > v5: no change.
> > ---
> >  Documentation/fpga/dfl.rst | 24 ++++++++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> >
> > diff --git a/Documentation/fpga/dfl.rst b/Documentation/fpga/dfl.rst
> > index 0404fe6..b8497f3 100644
> > --- a/Documentation/fpga/dfl.rst
> > +++ b/Documentation/fpga/dfl.rst
> > @@ -7,6 +7,7 @@ Authors:
> >  - Enno Luebbers <enno.luebbers@intel.com>
> >  - Xiao Guangrong <guangrong.xiao@linux.intel.com>
> >  - Wu Hao <hao.wu@intel.com>
> > +- Xu Yilun <yilun.xu@intel.com>
> >  
> >  The Device Feature List (DFL) FPGA framework (and drivers according to
> >  this framework) hides the very details of low layer hardwares and provides
> > @@ -502,6 +503,29 @@ FME Partial Reconfiguration Sub Feature driver (see drivers/fpga/dfl-fme-pr.c)
> >  could be a reference.
> >  
> >  
> > +UIO support for DFL devices
> > +===========================
> > +The purpose of an FPGA is to be reprogrammed with newly developed hardware
> > +components. New hardware can instantiate a new private feature in the DFL, and
> > +then get a DFL device in their system. In some cases users may need a userspace
> > +driver for the DFL device:
> > +
> > +* Users may need to run some diagnostic test for their hardwares.
> > +* Users may prototype the kernel driver in user space.
> > +* Some hardware is designed for specific purposes and does not fit into one of
> > +  the standard kernel subsystems.
> > +
> > +This requires the direct access to the MMIO space and interrupt handling in
> This may be better stated as:
> 
> "This requires direct access to MMIO space and interrupt handling from userspace."

Thanks for the correction, I'll change it.

Yilun
