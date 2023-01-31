Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 487A2682BAE
	for <lists+linux-fpga@lfdr.de>; Tue, 31 Jan 2023 12:42:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbjAaLka (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 31 Jan 2023 06:40:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbjAaLk3 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 31 Jan 2023 06:40:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1007A4B76A
        for <linux-fpga@vger.kernel.org>; Tue, 31 Jan 2023 03:40:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E37B8B81BE2
        for <linux-fpga@vger.kernel.org>; Tue, 31 Jan 2023 11:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1670BC4339C;
        Tue, 31 Jan 2023 11:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675165223;
        bh=pGHitAxKHz3tv4AlitXXVjPCHFkLeohjYif2kAeh3VQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r+EIwSNR/vkb0e/tCvmpvvMUZ5yipAzWc84LXhFh5PebyReAfbELrOBzVywTiuPmg
         xjHULlBHSlYEAcC7F7muT/LHZlQmUfzzAXYBIcY3lEj+NEkk2sFu4pxUzjuUXvVSPV
         US1Hl2EdNOrQc7h64TZutcC414lMZWyAwcKEG3r8=
Date:   Tue, 31 Jan 2023 12:40:20 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Lee Jones <lee@kernel.org>
Cc:     Xu Yilun <yilun.xu@intel.com>, linux-fpga@vger.kernel.org,
        hao.wu@intel.com, mdf@kernel.org
Subject: Re: [PATCH 1/1] fpga: m10bmc-sec: Add support for N6000
Message-ID: <Y9j+JDLgJ4eSc3LH@kroah.com>
References: <20230131024121.940195-1-yilun.xu@intel.com>
 <20230131024121.940195-2-yilun.xu@intel.com>
 <Y9jak/PLJLfDY1Pl@google.com>
 <Y9jmJ2jhL+PlBNYf@yilunxu-OptiPlex-7050>
 <Y9j0TxqTMrDBpmyO@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y9j0TxqTMrDBpmyO@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Jan 31, 2023 at 10:58:23AM +0000, Lee Jones wrote:
> On Tue, 31 Jan 2023, Xu Yilun wrote:
> 
> > On 2023-01-31 at 09:08:35 +0000, Lee Jones wrote:
> > > On Tue, 31 Jan 2023, Xu Yilun wrote:
> > > 
> > > > From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > > > 
> > > > Add support for PMCI-based flash access path and N6000 sec update
> > > > support. Access to flash staging area is different for N6000 from that
> > > > of the SPI interfaced counterparts.
> > > > 
> > > > Introduce intel_m10bmc_flash_bulk_ops to allow interface specific
> > > > differentiations for the flash access path for sec update and make
> > > > m10bmc_sec_read/write() in sec update driver to use the new operations.
> > > > The .flash_mutex serializes read/read. Flash update (erase+write) must
> > > > use ->lock/unlock_write() to prevent reads during update (reads would
> > > > timeout on setting flash MUX as BMC will prevent it).
> > > > 
> > > > Create a type specific RSU status reg handler for N6000 because the
> > > > field has moved from doorbell to auth result register.
> > > > 
> > > > If a failure is detected while altering the flash MUX, it seems safer
> > > > to try to set it back and doesn't seem harmful. Likely there are enough
> > > > troubles in that case anyway so setting it back fails too (which is
> > > > harmless sans the small extra delay) or just confirms that the value
> > > > wasn't changed.
> > > > 
> > > > Co-developed-by: Tianfei zhang <tianfei.zhang@intel.com>
> > > > Signed-off-by: Tianfei zhang <tianfei.zhang@intel.com>
> > > > Co-developed-by: Russ Weight <russell.h.weight@intel.com>
> > > > Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> > > > Acked-by: Xu Yilun <yilun.xu@intel.com>
> > > > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > > > Signed-off-by: Lee Jones <lee@kernel.org>
> > > > Link: https://lore.kernel.org/r/20230116100845.6153-12-ilpo.jarvinen@linux.intel.com
> > > > ---
> > > >  drivers/fpga/intel-m10-bmc-sec-update.c |  51 ++++-
> > > >  drivers/mfd/intel-m10-bmc-pmci.c        | 242 +++++++++++++++++++++++-
> > > >  include/linux/mfd/intel-m10-bmc.h       |  51 +++++
> > > >  3 files changed, 336 insertions(+), 8 deletions(-)
> > > 
> > > I'm confused, what are you trying to achieve?
> > 
> > I'm trying to submit the last patch to Greg's char-misc-next for
> > v6.3-rc1. The first 10 patches in this series have been accepted by him
> > in this cycle.
> > 
> > This is the only one patch so I just send it rather than making an extra
> > pull request.
> 
> That doesn't work with commits being routed in via multiple subsystems
> simultaneously.  You'll end up with complications due to differing
> commit SHAs.
> 
> If you really need this patch to be applied to FPGA (hint: I don't think
> it matters), then Greg will need to pull v2 [0] of the immutable topic
> branch.
> 
> However, the whole set is being routed in via (at least) MFD anyway, so
> I think we can just leave it as it is for now.
> 
> [0] https://lore.kernel.org/linux-fpga/Y9d9MmttFUqnCyCs@google.com/

Ok, I'll drop this from my review queue, but I thought I had the branch
already pulled into my tree, but who knows anymore :)

Maybe this should all just be resent after 6.3-rc1 is out as things will
be cleared up by then?

thanks,

greg k-h
