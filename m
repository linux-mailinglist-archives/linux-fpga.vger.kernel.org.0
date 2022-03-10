Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1402E4D53BF
	for <lists+linux-fpga@lfdr.de>; Thu, 10 Mar 2022 22:43:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343993AbiCJVk2 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 10 Mar 2022 16:40:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344002AbiCJVk0 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 10 Mar 2022 16:40:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE586C116B
        for <linux-fpga@vger.kernel.org>; Thu, 10 Mar 2022 13:39:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B6D25B826A9
        for <linux-fpga@vger.kernel.org>; Thu, 10 Mar 2022 21:39:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02F9BC340E8;
        Thu, 10 Mar 2022 21:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1646948360;
        bh=OHXmHwcOclB79GcpNzxbS1G9ikWR6z8495O9q1LYqlE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=x463AoP9nfPdvzEVWlkDZe77iFmnLhZNR5Pb6yvVKwszFFXTVmgo7DtHXUuo1VNs8
         jvyPx89H+/hjq82ebz9HTtp+5ydntWWEKDrtu7o3isDh5BJ36MeTbslSbPaJBo8x2l
         0pPyDbk0HlXZs6tXE4GQIQWcSNdoKWDAtluhOVxE=
Date:   Thu, 10 Mar 2022 22:39:16 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Moritz Fischer <mdf@kernel.org>
Cc:     linux-fpga@vger.kernel.org
Subject: Re: [GIT PULL] FPGA Manager change for 5.18-rc1
Message-ID: <YipwBCr5AbTDarAp@kroah.com>
References: <Yhv2DnIMuYrleRJK@archbook>
 <YhxUgMvs2XabozMF@kroah.com>
 <Yhx9R+OJ/Q3pwKi5@archbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yhx9R+OJ/Q3pwKi5@archbook>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Sun, Feb 27, 2022 at 11:44:07PM -0800, Moritz Fischer wrote:
> On Mon, Feb 28, 2022 at 05:50:08AM +0100, Greg KH wrote:
> > On Sun, Feb 27, 2022 at 02:07:10PM -0800, Moritz Fischer wrote:
> > > The following changes since commit 21f0a239ecab4b6765269af78904512358beb802:
> > > 
> > >   fpga: dfl: pci: Remove usage of the deprecated "pci-dma-compat.h" API (2022-01-25 11:25:50 -0800)
> > > 
> > > are available in the Git repository at:
> > > 
> > >   git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga.git tags/fpga-for-5.18-rc1
> > > 
> > > for you to fetch changes up to 21f0a239ecab4b6765269af78904512358beb802:
> > > 
> > >   fpga: dfl: pci: Remove usage of the deprecated "pci-dma-compat.h" API (2022-01-25 11:25:50 -0800)
> > > 
> > > ----------------------------------------------------------------
> > > FPGA Manager changes for 5.18-rc1
> > > 
> > > Christophe's patch is part of a larger effort of removing the use of the
> > > deprecated pci-dma-compat API.
> > > 
> > > All patches have been reviewed on the mailing list, and have been in the
> > > last few linux-next releases (as part of our for-next branch) without issues.
> > > 
> > > Signed-off-by: Moritz Fischer <mdf@kernel.org>
> > > 
> > > ----------------------------------------------------------------
> > 
> > No diffstat?
> 
> Ugh, yeah. Turns out there's no diff between fpga-for-5.18-rc1 and
> fpga-for-5.18-rc1.
> 
> I can re-send ... 
> 
> Should've read like this:
> 
> The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07:
> 
>   Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga.git tags/fpga-for-5.18-rc1
> 
> for you to fetch changes up to 21f0a239ecab4b6765269af78904512358beb802:
> 

Sorry for the delay, now pulled and pushed out.

greg k-h
