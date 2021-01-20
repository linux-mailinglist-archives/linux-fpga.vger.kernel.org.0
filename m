Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E78B42FC89E
	for <lists+linux-fpga@lfdr.de>; Wed, 20 Jan 2021 04:19:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728716AbhATDTL (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 19 Jan 2021 22:19:11 -0500
Received: from mga06.intel.com ([134.134.136.31]:46778 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726590AbhATDTA (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 19 Jan 2021 22:19:00 -0500
IronPort-SDR: WLGwM5rTRnJmQAuxWTsR5FYkCjJu5GBqFSmi14pzQ0JIlOnpT/n3k2qJ7h5O+UMljmOGMgVTlX
 eq+nXQTCV0wA==
X-IronPort-AV: E=McAfee;i="6000,8403,9869"; a="240576459"
X-IronPort-AV: E=Sophos;i="5.79,359,1602572400"; 
   d="scan'208";a="240576459"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2021 19:18:19 -0800
IronPort-SDR: wueZI4YOmOBr9YteD8PRuaouD0JLHSvruJsbYv5YIHpwzM9G07p7vrmzAjNJw7wDmmhKsZ36Pa
 7yY89cfrjunA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,359,1602572400"; 
   d="scan'208";a="355879853"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by fmsmga008.fm.intel.com with ESMTP; 19 Jan 2021 19:18:16 -0800
Date:   Wed, 20 Jan 2021 11:13:52 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        trix@redhat.com, lgoncalv@redhat.com, hao.wu@intel.com
Subject: Re: [PATCH v7 2/2] Documentation: fpga: dfl: Add description for DFL
  UIO support
Message-ID: <20210120031352.GA10151@yilunxu-OptiPlex-7050>
References: <1611110606-10380-1-git-send-email-yilun.xu@intel.com>
 <1611110606-10380-3-git-send-email-yilun.xu@intel.com>
 <4230b792-71e9-842d-ebdf-ad8bac8e11ef@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4230b792-71e9-842d-ebdf-ad8bac8e11ef@infradead.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Jan 19, 2021 at 07:12:24PM -0800, Randy Dunlap wrote:
> Doc suggestions:
> 
> On 1/19/21 6:43 PM, Xu Yilun wrote:
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
> > v7: rebased to next-20210119
> > ---
> >  Documentation/fpga/dfl.rst | 25 +++++++++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> > 
> > diff --git a/Documentation/fpga/dfl.rst b/Documentation/fpga/dfl.rst
> > index c41ac76..f96a6fb 100644
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
> > @@ -530,6 +531,30 @@ Being able to specify more than one DFL per BAR has been considered, but it
> >  was determined the use case did not provide value.  Specifying a single DFL
> >  per BAR simplifies the implementation and allows for extra error checking.
> >  
> > +
> > +Userspace driver support for DFL devices
> > +========================================
> > +The purpose of an FPGA is to be reprogrammed with newly developed hardware
> > +components. New hardware can instantiate a new private feature in the DFL, and
> > +then get a DFL device in their system. In some cases users may need a userspace
> 
>    then present a DFL device in the system.
> 
> > +driver for the DFL device:
> > +
> > +* Users may need to run some diagnostic test for their hardwares.
> 
>                                                           hardware.
> 
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
> 
>    To support a new DFL feature via UIO direct access, its feature id

Thanks for the fixes. Will fix them all.

Yilun
