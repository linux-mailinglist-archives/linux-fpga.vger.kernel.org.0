Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE886829FD
	for <lists+linux-fpga@lfdr.de>; Tue, 31 Jan 2023 11:11:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbjAaKJD (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 31 Jan 2023 05:09:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbjAaKIo (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 31 Jan 2023 05:08:44 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F14D5589
        for <linux-fpga@vger.kernel.org>; Tue, 31 Jan 2023 02:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675159720; x=1706695720;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=SHojmfFycSXctHReVmzwl1ZA5Ictin1uBopOKyAIZZ4=;
  b=SNYGaTOoH3Z1iuqfKVaeZEgUZFVb0c8SDigPAbZa72T/YsY9PxnS8FBA
   p9FU4JeCq5j3AzPrr+swtKmvYbIw8zH5IuIl/Txkm5a3JixReNjqsnqkH
   WpVPLgHLgt8SDwhmAzos2zGjmpX5h059FQ52/NuyNV7p7gOUBnqW7ORL7
   XYDlbZnfZJvhdwcJB+6gxt13kfEhv7GKwDOqXyDKKz22XykInTU/ZGa6g
   z9KS5UJIOxP5bnuvehJ0bh5JOp7p/MG8V1mc0k4O6sY3sVNivvK5vhzZk
   XBZWN5s2xcr/vkjQ07wJyz4gCaKjoE8RGbkdNaA51qeYXffpbKq1c+JPy
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="315762368"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="315762368"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 02:08:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="753177598"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="753177598"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by FMSMGA003.fm.intel.com with ESMTP; 31 Jan 2023 02:08:36 -0800
Date:   Tue, 31 Jan 2023 17:57:59 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Lee Jones <lee@kernel.org>
Cc:     gregkh@linuxfoundation.org, linux-fpga@vger.kernel.org,
        hao.wu@intel.com, mdf@kernel.org
Subject: Re: [PATCH 1/1] fpga: m10bmc-sec: Add support for N6000
Message-ID: <Y9jmJ2jhL+PlBNYf@yilunxu-OptiPlex-7050>
References: <20230131024121.940195-1-yilun.xu@intel.com>
 <20230131024121.940195-2-yilun.xu@intel.com>
 <Y9jak/PLJLfDY1Pl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y9jak/PLJLfDY1Pl@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2023-01-31 at 09:08:35 +0000, Lee Jones wrote:
> On Tue, 31 Jan 2023, Xu Yilun wrote:
> 
> > From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > 
> > Add support for PMCI-based flash access path and N6000 sec update
> > support. Access to flash staging area is different for N6000 from that
> > of the SPI interfaced counterparts.
> > 
> > Introduce intel_m10bmc_flash_bulk_ops to allow interface specific
> > differentiations for the flash access path for sec update and make
> > m10bmc_sec_read/write() in sec update driver to use the new operations.
> > The .flash_mutex serializes read/read. Flash update (erase+write) must
> > use ->lock/unlock_write() to prevent reads during update (reads would
> > timeout on setting flash MUX as BMC will prevent it).
> > 
> > Create a type specific RSU status reg handler for N6000 because the
> > field has moved from doorbell to auth result register.
> > 
> > If a failure is detected while altering the flash MUX, it seems safer
> > to try to set it back and doesn't seem harmful. Likely there are enough
> > troubles in that case anyway so setting it back fails too (which is
> > harmless sans the small extra delay) or just confirms that the value
> > wasn't changed.
> > 
> > Co-developed-by: Tianfei zhang <tianfei.zhang@intel.com>
> > Signed-off-by: Tianfei zhang <tianfei.zhang@intel.com>
> > Co-developed-by: Russ Weight <russell.h.weight@intel.com>
> > Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> > Acked-by: Xu Yilun <yilun.xu@intel.com>
> > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > Signed-off-by: Lee Jones <lee@kernel.org>
> > Link: https://lore.kernel.org/r/20230116100845.6153-12-ilpo.jarvinen@linux.intel.com
> > ---
> >  drivers/fpga/intel-m10-bmc-sec-update.c |  51 ++++-
> >  drivers/mfd/intel-m10-bmc-pmci.c        | 242 +++++++++++++++++++++++-
> >  include/linux/mfd/intel-m10-bmc.h       |  51 +++++
> >  3 files changed, 336 insertions(+), 8 deletions(-)
> 
> I'm confused, what are you trying to achieve?

I'm trying to submit the last patch to Greg's char-misc-next for
v6.3-rc1. The first 10 patches in this series have been accepted by him
in this cycle.

This is the only one patch so I just send it rather than making an extra
pull request.

Thanks,
Yilun

> 
> Who are you sending this to?
> 
> -- 
> Lee Jones [李琼斯]
