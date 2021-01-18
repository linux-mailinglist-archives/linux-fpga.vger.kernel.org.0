Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE8272F9814
	for <lists+linux-fpga@lfdr.de>; Mon, 18 Jan 2021 04:15:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731455AbhARDPh (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 17 Jan 2021 22:15:37 -0500
Received: from mga18.intel.com ([134.134.136.126]:34603 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729621AbhARDPg (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Sun, 17 Jan 2021 22:15:36 -0500
IronPort-SDR: ZJRwwSSMLArl6wx/SczQ+9ZFTuAlaIswDgxfqBeJfwXZsYy1IJBYAwis2caD+1tfnHkWUY8auh
 rpPRjg+Al0ZA==
X-IronPort-AV: E=McAfee;i="6000,8403,9867"; a="166419926"
X-IronPort-AV: E=Sophos;i="5.79,355,1602572400"; 
   d="scan'208";a="166419926"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2021 19:14:53 -0800
IronPort-SDR: mqExlmr67IaatKIyEDPpdYgz0d9PxrRx+xZjSKdljhzefdMM2uBPKu0kL0TbhDdaXNWLHYYoo+
 f5RV9uo/z40Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,355,1602572400"; 
   d="scan'208";a="365205613"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by orsmga002.jf.intel.com with ESMTP; 17 Jan 2021 19:14:51 -0800
Date:   Mon, 18 Jan 2021 11:10:30 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Moritz Fischer <mdf@kernel.org>
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, trix@redhat.com, lgoncalv@redhat.com,
        hao.wu@intel.com, yilun.xu@intel.com
Subject: Re: [PATCH v6 2/2] Documentation: fpga: dfl: Add description for DFL
  UIO support
Message-ID: <20210118031030.GB8153@yilunxu-OptiPlex-7050>
References: <1610502848-30345-1-git-send-email-yilun.xu@intel.com>
 <1610502848-30345-3-git-send-email-yilun.xu@intel.com>
 <YAO1vA6DWxTdjBOz@epycbox.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YAO1vA6DWxTdjBOz@epycbox.lan>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Sat, Jan 16, 2021 at 07:57:48PM -0800, Moritz Fischer wrote:
> Hi Xu,
> 
> On Wed, Jan 13, 2021 at 09:54:08AM +0800, Xu Yilun wrote:
> > This patch adds description for UIO support for dfl devices on DFL
> > bus.
> > 
> > Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> > ---
> > v2: no doc in v1, add it for v2.
> > v3: some documentation fixes.
> > v4: documentation change since the driver matching is changed.
> > v5: no change.
> > v6: improve the title of the userspace driver support section.
> >     some word improvement.
> > ---
> >  Documentation/fpga/dfl.rst | 24 ++++++++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> > 
> > diff --git a/Documentation/fpga/dfl.rst b/Documentation/fpga/dfl.rst
> > index 0404fe6..c33b6d0 100644
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
> > +Userspace driver support for DFL devices
> > +========================================
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
> > +This requires direct access to MMIO space and interrupt handling from
> > +userspace. The dfl-uio-pdev module exposes the UIO device interfaces for this
> > +purpose. It adds the uio_pdrv_genirq platform device with the resources of
> > +the DFL feature, and lets the generic UIO platform device driver provide UIO
> > +support to userspace.
> > +
> > +FPGA_DFL_UIO_PDEV should be selected to enable the dfl-uio-pdev module driver.
> > +To support a new DFL feature been directly accessed via UIO, its feature id
> > +should be added to the driver's id_table.
> > +
> > +
> >  Open discussion
> >  ===============
> >  FME driver exports one ioctl (DFL_FPGA_FME_PORT_PR) for partial reconfiguration
> > -- 
> > 2.7.4
> > 
> 
> Looks fine to me, can you resend with changes for the other patch?

Yes, I will. I may wait for a while to check more comments from Greg.

Thanks,
Yilun
