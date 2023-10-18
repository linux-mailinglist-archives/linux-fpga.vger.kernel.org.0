Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6698A7CD21A
	for <lists+linux-fpga@lfdr.de>; Wed, 18 Oct 2023 04:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbjJRCDR (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 17 Oct 2023 22:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjJRCDR (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 17 Oct 2023 22:03:17 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D5010E
        for <linux-fpga@vger.kernel.org>; Tue, 17 Oct 2023 19:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697594595; x=1729130595;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MfwTbJTA5SAQ8AIfWMUPV8WQpqZLFNIQf7nk6NraGjA=;
  b=bzMLPa80CpXKxlpYSOrEcXSeHqYs9SCcVit3XEXPc3lWEldnMRuMiqye
   LSdkfAhry2TUxiNaBfVRkDBMjD4XadEcdg6cLtcCi0dBkYAef9Nv6n2JV
   RcMUtlMcKL2YNDhbeWAogxzekTc2yIC9sBhUUfsoS6IVqN/YervIVxWXw
   J2BCiVC5W9cja0+qDUon2sMcrGNRGN3j/anBH/1rgn+U/Cnh9sSvwX8Sq
   RrsdHDETnVPpEDKq3TVxdYps8jJdi+j6CPymjf3htHlO1sqs1FYd5c07g
   ZwqoikY5HcSRoGh7T2Pk1fV1gmq5J5qa76uRAwvcExGzbg0IKwKpePUQM
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="450139553"
X-IronPort-AV: E=Sophos;i="6.03,233,1694761200"; 
   d="scan'208";a="450139553"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 19:03:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="791420422"
X-IronPort-AV: E=Sophos;i="6.03,233,1694761200"; 
   d="scan'208";a="791420422"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orsmga001.jf.intel.com with ESMTP; 17 Oct 2023 19:03:12 -0700
Date:   Wed, 18 Oct 2023 10:02:08 +0800
From:   Xu Yilun <yilun.xu@linux.intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     yilun.xu@intel.com, linux-fpga@vger.kernel.org, hao.wu@intel.com,
        mdf@kernel.org
Subject: Re: [GIT PULL] FPGA Manager changes for 6.6-final
Message-ID: <ZS88oHe8T69/Kks7@yilunxu-OptiPlex-7050>
References: <ZS6hhlvjUcqyv8zL@yilunxu-OptiPlex-7050>
 <2023101730-budding-spree-1471@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023101730-budding-spree-1471@gregkh>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Oct 17, 2023 at 07:17:29PM +0200, Greg KH wrote:
> On Tue, Oct 17, 2023 at 11:00:22PM +0800, Xu Yilun wrote:
> > The following changes since commit 6465e260f48790807eef06b583b38ca9789b6072:
> > 
> >   Linux 6.6-rc3 (2023-09-24 14:31:13 -0700)
> > 
> > are available in the Git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/fpga/linux-fpga tags/fpga-for-6.6-final
> > 
> > for you to fetch changes up to 6a935361500a21ef11a82814ee66fc58e59813f7:
> > 
> >   fpga: Fix memory leak for fpga_region_test_class_find() (2023-10-12 12:59:29 +0800)
> > 
> > ----------------------------------------------------------------
> > FPGA Manager changes for 6.6-final
> > 
> > FPGA KUnit test:
> > 
> > - Marco's change fixes null-ptr-deref when try_module_get()
> > - Jinjie's change fixes a memory leak issue
> > 
> > Intel m10 bmc secure update:
> > 
> > - Maintainer change from Russ Weight to Peter Colberg
> > 
> > All patches have been reviewed on the mailing list, and have been in the
> > last linux-next releases (as part of our fixes branch)
> > 
> > Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> > 
> > ----------------------------------------------------------------
> > Jinjie Ruan (1):
> >       fpga: Fix memory leak for fpga_region_test_class_find()
> > 
> > Marco Pagani (4):
> >       fpga: add helpers for the FPGA KUnit test suites.
> >       fpga: add a platform driver to the FPGA Manager test suite
> >       fpga: add a platform driver to the FPGA Bridge test suite
> >       fpga: add a platform driver to the FPGA Region test suite
> 
> Why are all of these test suite patches here?  They are not relevant for
> 6.6-final as they do not resolve anything.

Maybe the subjects indicate no bug fixing, but they fix null-ptr-deref
issues when modprobe fpga-mgr/bridge/region-test.

In fpga-mgr-test, the pdev->dev->driver is not assigned, so when

  fpga_mgr_test_get()->try_module_get(dev->parent->driver->owner)

NULL ptr is referenced.

So do fpga-bridge/region-test.

Patch #1 adds a common helper to generate a platform driver.
Patch #2/3/4 fix the issues by matching the driver to pdev.

See:
Closes: https://lore.kernel.org/linux-fpga/4d51e87f-830a-adae-d6f7-6aed9433fdc6@huawei.com/
Closes: https://lore.kernel.org/linux-fpga/f2b30203-1a67-4533-eddc-b380044e2e68@huawei.com/
Closes: https://lore.kernel.org/linux-fpga/d557b4ee-4b3a-8747-bdda-0ed480212a63@huawei.com/

Thanks,
Yilun

> 
> I can see the memory leak being relevant, and also:
> 
> > Russ Weight (1):
> >       fpga: m10bmc-sec: Change contact for secure update driver
> 
> That one, but why the testing code?  What bug/regression are they
> fixing?
> 
> thanks,
> 
> greg k-h
