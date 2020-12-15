Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 034E92DA63C
	for <lists+linux-fpga@lfdr.de>; Tue, 15 Dec 2020 03:30:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbgLOC3y (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 14 Dec 2020 21:29:54 -0500
Received: from mga09.intel.com ([134.134.136.24]:8906 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729586AbgLOC3w (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 14 Dec 2020 21:29:52 -0500
IronPort-SDR: QzVoCD7zGdUTyTZ4s69ZEmkCUEstOXscmYoeOef+zxGF7vXygs9cYXSBiZTOimR7jhMm8n3igV
 H15EKBxu4xYw==
X-IronPort-AV: E=McAfee;i="6000,8403,9835"; a="174958079"
X-IronPort-AV: E=Sophos;i="5.78,420,1599548400"; 
   d="scan'208";a="174958079"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2020 18:26:24 -0800
IronPort-SDR: +Pr6ZxtUHdyPuB11s7UsWmSnQtSDhWPxNpJ+wd8iJ+/mNH4yEiWg0Eg5YzbipDoPrc3WiKeSNd
 6FC0i8B89Vhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,420,1599548400"; 
   d="scan'208";a="450162202"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by fmsmga001.fm.intel.com with ESMTP; 14 Dec 2020 18:26:21 -0800
Date:   Tue, 15 Dec 2020 10:22:06 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Tom Rix <trix@redhat.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        lgoncalv@redhat.com, hao.wu@intel.com
Subject: Re: [PATCH v2 2/2] Documentation: fpga: dfl: Add description for DFL
  UIO support
Message-ID: <20201215022206.GC14854@yilunxu-OptiPlex-7050>
References: <1607916981-14782-1-git-send-email-yilun.xu@intel.com>
 <1607916981-14782-3-git-send-email-yilun.xu@intel.com>
 <4bbaa5ad-b0eb-8ea6-9dc6-c08060450e36@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4bbaa5ad-b0eb-8ea6-9dc6-c08060450e36@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Dec 14, 2020 at 02:14:56PM -0800, Tom Rix wrote:
> 
> On 12/13/20 7:36 PM, Xu Yilun wrote:
> > This patch adds description for UIO support for dfl devices on DFL
> > bus.
> >
> > Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> > ---
> > v2: no doc in v1, add it for v2.
> > ---
> >  Documentation/fpga/dfl.rst | 23 +++++++++++++++++++++++
> >  1 file changed, 23 insertions(+)
> Should add your self in the authors list.

OK.

> >
> > diff --git a/Documentation/fpga/dfl.rst b/Documentation/fpga/dfl.rst
> > index 0404fe6..a15e81e 100644
> > --- a/Documentation/fpga/dfl.rst
> > +++ b/Documentation/fpga/dfl.rst
> > @@ -502,6 +502,29 @@ FME Partial Reconfiguration Sub Feature driver (see drivers/fpga/dfl-fme-pr.c)
> >  could be a reference.
> >  
> >  
> > +UIO support for DFL devices
> > +===========================
> > +The FPGA is open for users to be reprogramed with newly developed hardware
> 
> The purpose of an FPGA is to be reprogrammed with newly developed hardware
> 
> components.  New hardware can

Will change it.

> 
> > +components. They could instantiate a new private feature in the DFL, and then
> > +get a DFL device in their system. In some cases users may need a userspace
> > +driver for the DFL device:
> > +
> > +* Users may need to run some diagnostic test for their hardwares.
> * Users may prototype the kernel driver in user space.

Could we just add the line rather than replacing the previous line? I think this
comment is describing a different usecase.

> > +* Some hardware is designed for specific purposes and does not fit into one of
> > +  the standard kernel subsystems.
> > +
> > +This requires the direct access to the MMIO space and interrupt handling in
> > +userspace. We implemented a dfl-uio-pdev module which exposes the UIO device
> The dfl-uio-pdev module exposes

Will change it.

> > +interfaces. It adds the uio_pdrv_genirq platform device with the resources of
> > +the DFL device, and let the generic UIO platform device driver provide UIO
> the DLF device, and lets

Will change it.

> > +support to userspace.
> Use FPGA_DFL_UIO_PDEV to enable this feature.

I didn't get your idea for this.

> > +
> > +The DFL UIO driver has a special matching algorithem. It will match any DFL
> > +device which could not be handled by other DFL drivers. In this way, it will
> > +not impact the functionality of the features which are already supported by the
> > +system.
> (not sure if this section is needed)

I think we may keep it.

Thanks,
Yilun
