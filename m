Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC7D87CDB00
	for <lists+linux-fpga@lfdr.de>; Wed, 18 Oct 2023 13:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbjJRLu4 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 18 Oct 2023 07:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbjJRLuy (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 18 Oct 2023 07:50:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF945FE
        for <linux-fpga@vger.kernel.org>; Wed, 18 Oct 2023 04:50:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E45C9C433C9;
        Wed, 18 Oct 2023 11:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697629852;
        bh=kBNIDPrUSreLsJMbB6DND0cA6g8RttO/kvegUWF/Zww=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gIhXOwCrj5/lFsPxaBz/E8R1wVfdG17/7CWcV4AYYUFex1kzrSbqLw8I9IU8JLghy
         NMSjJsenagM2W2tFplAcDV8gNlSW/+85zL9wxqrexlSc6se0E5UbtLOTEntYjwIj33
         N93dsACQdYDE+0c5lMrfLuGdess5+Zcqcv7sOrBE=
Date:   Wed, 18 Oct 2023 13:50:50 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Marco Pagani <marpagan@redhat.com>
Cc:     Xu Yilun <yilun.xu@linux.intel.com>, yilun.xu@intel.com,
        linux-fpga@vger.kernel.org, hao.wu@intel.com, mdf@kernel.org
Subject: Re: [GIT PULL] FPGA Manager changes for 6.6-final
Message-ID: <2023101848-smith-tastiness-1459@gregkh>
References: <ZS6hhlvjUcqyv8zL@yilunxu-OptiPlex-7050>
 <2023101730-budding-spree-1471@gregkh>
 <ZS88oHe8T69/Kks7@yilunxu-OptiPlex-7050>
 <2023101825-ligament-undergrad-cc4d@gregkh>
 <e178f915-fc65-48a1-abab-05d1202319a4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e178f915-fc65-48a1-abab-05d1202319a4@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Wed, Oct 18, 2023 at 11:39:01AM +0200, Marco Pagani wrote:
> 
> 
> On 18/10/23 09:50, Greg KH wrote:
> > On Wed, Oct 18, 2023 at 10:02:08AM +0800, Xu Yilun wrote:
> >> On Tue, Oct 17, 2023 at 07:17:29PM +0200, Greg KH wrote:
> >>> On Tue, Oct 17, 2023 at 11:00:22PM +0800, Xu Yilun wrote:
> >>>> The following changes since commit 6465e260f48790807eef06b583b38ca9789b6072:
> >>>>
> >>>>   Linux 6.6-rc3 (2023-09-24 14:31:13 -0700)
> >>>>
> >>>> are available in the Git repository at:
> >>>>
> >>>>   git://git.kernel.org/pub/scm/linux/kernel/git/fpga/linux-fpga tags/fpga-for-6.6-final
> >>>>
> >>>> for you to fetch changes up to 6a935361500a21ef11a82814ee66fc58e59813f7:
> >>>>
> >>>>   fpga: Fix memory leak for fpga_region_test_class_find() (2023-10-12 12:59:29 +0800)
> >>>>
> >>>> ----------------------------------------------------------------
> >>>> FPGA Manager changes for 6.6-final
> >>>>
> >>>> FPGA KUnit test:
> >>>>
> >>>> - Marco's change fixes null-ptr-deref when try_module_get()
> >>>> - Jinjie's change fixes a memory leak issue
> >>>>
> >>>> Intel m10 bmc secure update:
> >>>>
> >>>> - Maintainer change from Russ Weight to Peter Colberg
> >>>>
> >>>> All patches have been reviewed on the mailing list, and have been in the
> >>>> last linux-next releases (as part of our fixes branch)
> >>>>
> >>>> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> >>>>
> >>>> ----------------------------------------------------------------
> >>>> Jinjie Ruan (1):
> >>>>       fpga: Fix memory leak for fpga_region_test_class_find()
> >>>>
> >>>> Marco Pagani (4):
> >>>>       fpga: add helpers for the FPGA KUnit test suites.
> >>>>       fpga: add a platform driver to the FPGA Manager test suite
> >>>>       fpga: add a platform driver to the FPGA Bridge test suite
> >>>>       fpga: add a platform driver to the FPGA Region test suite
> >>>
> >>> Why are all of these test suite patches here?  They are not relevant for
> >>> 6.6-final as they do not resolve anything.
> >>
> >> Maybe the subjects indicate no bug fixing, but they fix null-ptr-deref
> >> issues when modprobe fpga-mgr/bridge/region-test.
> > 
> > That's not obvious, sorry.  So are the tests broken right now so that
> > they don't work at all?
> 
> They were broken only when compiled and run as modules.

Then forbid the ability to compile them as modules.

> >> In fpga-mgr-test, the pdev->dev->driver is not assigned, so when
> >>
> >>   fpga_mgr_test_get()->try_module_get(dev->parent->driver->owner)
> > 
> > That's a horrible line and should be fixed.  How do you know if a device
> > has a parent, or if that parent has a driver?  You don't, that should be
> > fixed instead.
> > 
> > And module_get on a driver pointer is also never a good idea for other
> > reasons, why is this happening at all?  It shouldn't be needed if the
> > code is set up properly (i.e. the unloading of a driver will handle the
> > shutdown and reference counting properly, no need to try to use module
> > references at all.)
> 
> You are right, but fixing the fpga core is outside the scope of my patches.

Which is why I'm not going to take these as you aren't fixing the root
problem here :)

> My intent was to improve the test suite by adding fake drivers irrespective
> of the fpga core quirks. I might try to send an RFC later to improve the
> fpga core.
> 
> > 
> >> NULL ptr is referenced.
> >>
> >> So do fpga-bridge/region-test.
> >>
> >> Patch #1 adds a common helper to generate a platform driver.
> > 
> > Don't abuse platform devices/drivers like this, this is not a platform
> > device or driver.  If you really want to do this, use a real driver and
> > device, not a platform one please.
> 
> Other test suites, like DRM suites, already use fake platform devices and
> drivers. Moreover, many real FPGA IPs, like reconfiguration controllers and
> bridges, are indeed modeled as platform devices. What is the benefit of
> using a real driver and device?

Again, please do not abuse platform devices and drivers when they should
not be used.  I can't catch all abuses, but when I do see them, I do
object to them.

And again, the root problem here isn't even a platform device issue,
it's a "assuming the parent has a driver and we want to increment a
module reference" issue.  That's not ok, nor even needed at all.

thanks,

greg k-h
