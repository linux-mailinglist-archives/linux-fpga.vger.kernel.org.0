Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD372DA766
	for <lists+linux-fpga@lfdr.de>; Tue, 15 Dec 2020 06:22:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725816AbgLOFUT (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 15 Dec 2020 00:20:19 -0500
Received: from mga06.intel.com ([134.134.136.31]:36810 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725843AbgLOFUH (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 15 Dec 2020 00:20:07 -0500
IronPort-SDR: /TJ+ZNnog8bH/TvfCAPsLKwqf/6ssiGsMacf/9mm2bY1SgvU7paSgBIY8IDkkBV9zA2LEEn1O6
 HBFQfo6QIWxQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9835"; a="236412676"
X-IronPort-AV: E=Sophos;i="5.78,420,1599548400"; 
   d="scan'208";a="236412676"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2020 21:19:26 -0800
IronPort-SDR: aXuzYJO+sEpdxJj5Xhf6lsbTjN6bv6yNVel6E8yTR8m1EogcqZ7B6Fxv8hwUw+0Qteh8hiCy8o
 j3n2bL8zQNFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,420,1599548400"; 
   d="scan'208";a="368005501"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by orsmga008.jf.intel.com with ESMTP; 14 Dec 2020 21:19:24 -0800
Date:   Tue, 15 Dec 2020 13:15:09 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Tom Rix <trix@redhat.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        lgoncalv@redhat.com, hao.wu@intel.com
Subject: Re: [PATCH v2 2/2] Documentation: fpga: dfl: Add description for DFL
  UIO support
Message-ID: <20201215051509.GD14854@yilunxu-OptiPlex-7050>
References: <1607916981-14782-1-git-send-email-yilun.xu@intel.com>
 <1607916981-14782-3-git-send-email-yilun.xu@intel.com>
 <4bbaa5ad-b0eb-8ea6-9dc6-c08060450e36@redhat.com>
 <20201215022206.GC14854@yilunxu-OptiPlex-7050>
 <97d06583-ca99-67ae-55e1-ff714b47f8cb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97d06583-ca99-67ae-55e1-ff714b47f8cb@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Dec 14, 2020 at 08:43:31PM -0800, Tom Rix wrote:
> 
> On 12/14/20 6:22 PM, Xu Yilun wrote:
> > On Mon, Dec 14, 2020 at 02:14:56PM -0800, Tom Rix wrote:
> >> On 12/13/20 7:36 PM, Xu Yilun wrote:
> >>> This patch adds description for UIO support for dfl devices on DFL
> >>> bus.
> >>>
> >>> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> >>> ---
> >>> v2: no doc in v1, add it for v2.
> >>> ---
> >>
> >>> +components. They could instantiate a new private feature in the DFL, and then
> >>> +get a DFL device in their system. In some cases users may need a userspace
> >>> +driver for the DFL device:
> >>> +
> >>> +* Users may need to run some diagnostic test for their hardwares.
> >> * Users may prototype the kernel driver in user space.
> > Could we just add the line rather than replacing the previous line? I think this
> > comment is describing a different usecase.
> 
> Yes, this is what i ment, please use your original.
> 
> I am offering another usecase, one I will use.
> 
> Add mine as well, if you want.

I'll add your usecase.

> 
> >
> >>> +* Some hardware is designed for specific purposes and does not fit into one of
> >>> +  the standard kernel subsystems.
> >>> +
> >>> +This requires the direct access to the MMIO space and interrupt handling in
> >>> +userspace. We implemented a dfl-uio-pdev module which exposes the UIO device
> >> The dfl-uio-pdev module exposes
> > Will change it.
> >
> >>> +interfaces. It adds the uio_pdrv_genirq platform device with the resources of
> >>> +the DFL device, and let the generic UIO platform device driver provide UIO
> >> the DLF device, and lets
> > Will change it.
> >
> >>> +support to userspace.
> >> Use FPGA_DFL_UIO_PDEV to enable this feature.
> > I didn't get your idea for this.
> 
> I wanted the user to know which kconfig controls this feature.

Understood. I'll add it.

Thanks,
Yilun
