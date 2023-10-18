Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 547AE7CE1BC
	for <lists+linux-fpga@lfdr.de>; Wed, 18 Oct 2023 17:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232214AbjJRPuu (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 18 Oct 2023 11:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232129AbjJRPuq (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 18 Oct 2023 11:50:46 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7923F132
        for <linux-fpga@vger.kernel.org>; Wed, 18 Oct 2023 08:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697644244; x=1729180244;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GuJ1f1bjJF6OZ+GE1vLTgaUuXZg46euMxpklR4EiUCs=;
  b=RwhGrlHxL7LN221jKwyQzsMloAXIjBf9iaaSKUoBKUh479SqK8Tpco3l
   wdIMPUxX2HT960eCf3ckfKzEjig/hJXMN1OFYv2rxgMHwNmjoCgr06gxN
   Ucc2HSdcIYlYGKMBEe6zdPHIUwFLVacRc9+AJCAwmE+/plFqLO3M3ODSh
   VSWvmt0bCiHWLntOFZUkD6P45CA2EUxRgiJcqZf68md9GomVN5mvHqOu2
   MYVdW1XcUaagmE7mnItAE92KbLNuNbwzRPHlAjEqWeP7GjBYQN2j2SWP1
   GM+8j8harJd19iv/VPBe/i+nGE5pS7T6IM6mG6NUUCU8n7JN2+YyyHhAs
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="365392440"
X-IronPort-AV: E=Sophos;i="6.03,235,1694761200"; 
   d="scan'208";a="365392440"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 08:50:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="756632306"
X-IronPort-AV: E=Sophos;i="6.03,235,1694761200"; 
   d="scan'208";a="756632306"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orsmga002.jf.intel.com with ESMTP; 18 Oct 2023 08:50:41 -0700
Date:   Wed, 18 Oct 2023 23:49:36 +0800
From:   Xu Yilun <yilun.xu@linux.intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     yilun.xu@intel.com, linux-fpga@vger.kernel.org, hao.wu@intel.com,
        mdf@kernel.org
Subject: Re: [GIT PULL] FPGA Manager changes for 6.6-final
Message-ID: <ZS/+kM3dT2Sg4QkG@yilunxu-OptiPlex-7050>
References: <ZS6hhlvjUcqyv8zL@yilunxu-OptiPlex-7050>
 <2023101730-budding-spree-1471@gregkh>
 <ZS88oHe8T69/Kks7@yilunxu-OptiPlex-7050>
 <2023101825-ligament-undergrad-cc4d@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023101825-ligament-undergrad-cc4d@gregkh>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Wed, Oct 18, 2023 at 09:50:37AM +0200, Greg KH wrote:
> On Wed, Oct 18, 2023 at 10:02:08AM +0800, Xu Yilun wrote:
> > On Tue, Oct 17, 2023 at 07:17:29PM +0200, Greg KH wrote:
> > > On Tue, Oct 17, 2023 at 11:00:22PM +0800, Xu Yilun wrote:
> > > > The following changes since commit 6465e260f48790807eef06b583b38ca9789b6072:
> > > > 
> > > >   Linux 6.6-rc3 (2023-09-24 14:31:13 -0700)
> > > > 
> > > > are available in the Git repository at:
> > > > 
> > > >   git://git.kernel.org/pub/scm/linux/kernel/git/fpga/linux-fpga tags/fpga-for-6.6-final
> > > > 
> > > > for you to fetch changes up to 6a935361500a21ef11a82814ee66fc58e59813f7:
> > > > 
> > > >   fpga: Fix memory leak for fpga_region_test_class_find() (2023-10-12 12:59:29 +0800)
> > > > 
> > > > ----------------------------------------------------------------
> > > > FPGA Manager changes for 6.6-final
> > > > 
> > > > FPGA KUnit test:
> > > > 
> > > > - Marco's change fixes null-ptr-deref when try_module_get()
> > > > - Jinjie's change fixes a memory leak issue
> > > > 
> > > > Intel m10 bmc secure update:
> > > > 
> > > > - Maintainer change from Russ Weight to Peter Colberg
> > > > 
> > > > All patches have been reviewed on the mailing list, and have been in the
> > > > last linux-next releases (as part of our fixes branch)
> > > > 
> > > > Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> > > > 
> > > > ----------------------------------------------------------------
> > > > Jinjie Ruan (1):
> > > >       fpga: Fix memory leak for fpga_region_test_class_find()
> > > > 
> > > > Marco Pagani (4):
> > > >       fpga: add helpers for the FPGA KUnit test suites.
> > > >       fpga: add a platform driver to the FPGA Manager test suite
> > > >       fpga: add a platform driver to the FPGA Bridge test suite
> > > >       fpga: add a platform driver to the FPGA Region test suite
> > > 
> > > Why are all of these test suite patches here?  They are not relevant for
> > > 6.6-final as they do not resolve anything.
> > 
> > Maybe the subjects indicate no bug fixing, but they fix null-ptr-deref
> > issues when modprobe fpga-mgr/bridge/region-test.
> 
> That's not obvious, sorry.  So are the tests broken right now so that
> they don't work at all?
> 
> > In fpga-mgr-test, the pdev->dev->driver is not assigned, so when
> > 
> >   fpga_mgr_test_get()->try_module_get(dev->parent->driver->owner)
> 
> That's a horrible line and should be fixed.  How do you know if a device
> has a parent, or if that parent has a driver?  You don't, that should be
> fixed instead.
> 
> And module_get on a driver pointer is also never a good idea for other
> reasons, why is this happening at all?  It shouldn't be needed if the
> code is set up properly (i.e. the unloading of a driver will handle the
> shutdown and reference counting properly, no need to try to use module
> references at all.)
> 
> > NULL ptr is referenced.
> > 
> > So do fpga-bridge/region-test.
> > 
> > Patch #1 adds a common helper to generate a platform driver.
> 
> Don't abuse platform devices/drivers like this, this is not a platform
> device or driver.  If you really want to do this, use a real driver and
> device, not a platform one please.
> 
> > Patch #2/3/4 fix the issues by matching the driver to pdev.
> > 
> > See:
> > Closes: https://lore.kernel.org/linux-fpga/4d51e87f-830a-adae-d6f7-6aed9433fdc6@huawei.com/
> > Closes: https://lore.kernel.org/linux-fpga/f2b30203-1a67-4533-eddc-b380044e2e68@huawei.com/
> > Closes: https://lore.kernel.org/linux-fpga/d557b4ee-4b3a-8747-bdda-0ed480212a63@huawei.com/
> 
> Want to just disable all of these from the build entirely for now and
> then fix them up properly for 6.7?

I'm OK this way.

Macro, could you send a patch to Greg for diabling them? And let's do
proper fix up in FPGA core for 6.7.

Thanks,
Yilun

> 
> thanks,
> 
> greg k-h
