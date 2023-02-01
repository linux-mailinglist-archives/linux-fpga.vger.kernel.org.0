Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FDAD685D2F
	for <lists+linux-fpga@lfdr.de>; Wed,  1 Feb 2023 03:11:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbjBACKL (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 31 Jan 2023 21:10:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231663AbjBACKF (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 31 Jan 2023 21:10:05 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD86552AF
        for <linux-fpga@vger.kernel.org>; Tue, 31 Jan 2023 18:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675217385; x=1706753385;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Bm29XgERlSx3b/RcSBPpYUe70IWGCRCGkI0tKQc1Qjo=;
  b=PAdwGl/1Xw880rV0YMeA/lKdBpZu45kU6TnH35yQpjqTDkgPlBgoEuPb
   lNtp3zWkUnp185/GiH10tMQiYSYF0A4E68yQj8WEOMelozodLvZHRye5I
   bMachGIEG34ehO3C2WdhhnlQC+gIi9ymY9ZfwOTaaJOvxlg4kFougxY32
   wJjZrf7LwctGEDHcqTu9rt/47oRfPV94lCqRSpHJxsVnEv3ycFMw/ak+O
   DveFvoNggZDXjlqspcg7+FG0GcCxIQ3dtqmr+5U3PvDSwpaoKkRUe4oCi
   RNQVBO54EZNs7/p8xbGFr7Bx5uMJ7T7fh52jjBRDvuzqd9QWwgqSfi1/h
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="308360398"
X-IronPort-AV: E=Sophos;i="5.97,263,1669104000"; 
   d="scan'208";a="308360398"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 18:09:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="788662197"
X-IronPort-AV: E=Sophos;i="5.97,263,1669104000"; 
   d="scan'208";a="788662197"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orsmga004.jf.intel.com with ESMTP; 31 Jan 2023 18:09:22 -0800
Date:   Wed, 1 Feb 2023 09:58:44 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Lee Jones <lee@kernel.org>
Cc:     gregkh@linuxfoundation.org, linux-fpga@vger.kernel.org,
        hao.wu@intel.com, mdf@kernel.org
Subject: Re: [PATCH 1/1] fpga: m10bmc-sec: Add support for N6000
Message-ID: <Y9nHVLSRzG/iga+5@yilunxu-OptiPlex-7050>
References: <20230131024121.940195-1-yilun.xu@intel.com>
 <20230131024121.940195-2-yilun.xu@intel.com>
 <Y9jak/PLJLfDY1Pl@google.com>
 <Y9jmJ2jhL+PlBNYf@yilunxu-OptiPlex-7050>
 <Y9j0TxqTMrDBpmyO@google.com>
 <Y9j+JDLgJ4eSc3LH@kroah.com>
 <Y9kGrHByyDyWxU5S@google.com>
 <Y9k1GJI49EqJDWg5@yilunxu-OptiPlex-7050>
 <Y9lMKUsbs/oXXnga@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y9lMKUsbs/oXXnga@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2023-01-31 at 17:13:13 +0000, Lee Jones wrote:
> On Tue, 31 Jan 2023, Xu Yilun wrote:
> 
> > On 2023-01-31 at 12:16:44 +0000, Lee Jones wrote:
> > > On Tue, 31 Jan 2023, Greg KH wrote:
> > > 
> > > > On Tue, Jan 31, 2023 at 10:58:23AM +0000, Lee Jones wrote:
> > > > > On Tue, 31 Jan 2023, Xu Yilun wrote:
> > > > > 
> > > > > > On 2023-01-31 at 09:08:35 +0000, Lee Jones wrote:
> > > > > > > On Tue, 31 Jan 2023, Xu Yilun wrote:
> > > > > > > 
> > > > > > > > From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > > > > > > > 
> > > > > > > > Add support for PMCI-based flash access path and N6000 sec update
> > > > > > > > support. Access to flash staging area is different for N6000 from that
> > > > > > > > of the SPI interfaced counterparts.
> > > > > > > > 
> > > > > > > > Introduce intel_m10bmc_flash_bulk_ops to allow interface specific
> > > > > > > > differentiations for the flash access path for sec update and make
> > > > > > > > m10bmc_sec_read/write() in sec update driver to use the new operations.
> > > > > > > > The .flash_mutex serializes read/read. Flash update (erase+write) must
> > > > > > > > use ->lock/unlock_write() to prevent reads during update (reads would
> > > > > > > > timeout on setting flash MUX as BMC will prevent it).
> > > > > > > > 
> > > > > > > > Create a type specific RSU status reg handler for N6000 because the
> > > > > > > > field has moved from doorbell to auth result register.
> > > > > > > > 
> > > > > > > > If a failure is detected while altering the flash MUX, it seems safer
> > > > > > > > to try to set it back and doesn't seem harmful. Likely there are enough
> > > > > > > > troubles in that case anyway so setting it back fails too (which is
> > > > > > > > harmless sans the small extra delay) or just confirms that the value
> > > > > > > > wasn't changed.
> > > > > > > > 
> > > > > > > > Co-developed-by: Tianfei zhang <tianfei.zhang@intel.com>
> > > > > > > > Signed-off-by: Tianfei zhang <tianfei.zhang@intel.com>
> > > > > > > > Co-developed-by: Russ Weight <russell.h.weight@intel.com>
> > > > > > > > Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> > > > > > > > Acked-by: Xu Yilun <yilun.xu@intel.com>
> > > > > > > > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > > > > > > > Signed-off-by: Lee Jones <lee@kernel.org>
> > > > > > > > Link: https://lore.kernel.org/r/20230116100845.6153-12-ilpo.jarvinen@linux.intel.com
> > > > > > > > ---
> > > > > > > >  drivers/fpga/intel-m10-bmc-sec-update.c |  51 ++++-
> > > > > > > >  drivers/mfd/intel-m10-bmc-pmci.c        | 242 +++++++++++++++++++++++-
> > > > > > > >  include/linux/mfd/intel-m10-bmc.h       |  51 +++++
> > > > > > > >  3 files changed, 336 insertions(+), 8 deletions(-)
> > > > > > > 
> > > > > > > I'm confused, what are you trying to achieve?
> > > > > > 
> > > > > > I'm trying to submit the last patch to Greg's char-misc-next for
> > > > > > v6.3-rc1. The first 10 patches in this series have been accepted by him
> > > > > > in this cycle.
> > > > > > 
> > > > > > This is the only one patch so I just send it rather than making an extra
> > > > > > pull request.
> > > > > 
> > > > > That doesn't work with commits being routed in via multiple subsystems
> > > > > simultaneously.  You'll end up with complications due to differing
> > > > > commit SHAs.
> > > > > 
> > > > > If you really need this patch to be applied to FPGA (hint: I don't think
> > > > > it matters), then Greg will need to pull v2 [0] of the immutable topic
> > 
> > It doesn't matter.
> > 
> > When I received the pull request v1, I thought Lee want the immutable topic
> > branch be merged to fpga tree. So I pulled and submitted them to Greg
> > along with other fpga patches. Sorry for the misunderstanding.
> 
> Maintainer => maintainer pull-requests are optional.  They're super
> useful if you want to keep developing a particular driver that has been
> changed elsewhere, since they ensure the avoidance of merge-conflicts at
> merge time.
> 
> If you're not attempting to make further changes, there shouldn't be any
> requirement to pull them.

OK. Thanks for your explanation.

Yilun

>  
> > I'm not sure if this makes trouble for Greg to pull v2 or MFD tree.
> 
> Honesty, I'd just leave it as it is.  It would have been more
> problematic if a patch which appears earlier in the set was missing,
> since this may hurt bisectability or render a tree un-buildable.  As it
> stands, it's the last patch, which no other patch in the series should
> depend on.
> 
> -- 
> Lee Jones [李琼斯]
