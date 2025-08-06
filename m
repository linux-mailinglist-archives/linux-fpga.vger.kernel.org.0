Return-Path: <linux-fpga+bounces-1298-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F5AB1C131
	for <lists+linux-fpga@lfdr.de>; Wed,  6 Aug 2025 09:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75847160611
	for <lists+linux-fpga@lfdr.de>; Wed,  6 Aug 2025 07:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD34B1D63F7;
	Wed,  6 Aug 2025 07:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OoniOKPR"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA0772614
	for <linux-fpga@vger.kernel.org>; Wed,  6 Aug 2025 07:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754464851; cv=none; b=cSGY+uv249qr8get/ONEkPDUppJqb+IG80tm6evSlmBgVz1z5jZxYt7cE07Ak4G5zoZLYecI1IgbwEV1zhNWFPiZ+HP1MsilfLZxsYHy6ZnxarkuOsRcYmqMr6DEdfvcLLYz+YDzjLY1IamUq86hNeJ3nRFNfTaCBImOADklgsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754464851; c=relaxed/simple;
	bh=+QZM6G1oxWPuYeS1sda85op2qGMNuxCzzXW6qd6enf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WB7bjVaSheIFKMXewGMineWKS056dIEGNXZMV7vLIQ2oEM4UBFChNyYx2SveIgyxI2ad2QPpYCdNiMbBWdcnMfIg0XpsYrow8geELNgRqhOZT/glR0vS1Hr/7EB6u9GNtsYBQUCYY2EBb8XuAexyj2j56YCWRoZXpjSojlUUzPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OoniOKPR; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754464850; x=1786000850;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+QZM6G1oxWPuYeS1sda85op2qGMNuxCzzXW6qd6enf0=;
  b=OoniOKPRCc2MGi48ptADArdAnXyVBlZDjRDgpI3rRjJmsCucudBw9UVz
   4O85KMzlFX80lHZ1Hx8XoJ/NiVWZJPjzVzu+MucOifADwdfuAOUaFSM2c
   /YQCT5I76f/LTJux08Xzggn1miHAZDLAnyzavf+tfTZwYRQDN2eDPeUI6
   W3ckTNqT3T2dTXTdYBqP8YTZ94UUokm293zKFvRriBN5GsmfL40GNug1F
   hLxpe8bcocAthCesXufy6AbHx9ph+het34rwJ5XqCtORrh1G1R8m0/uav
   zVvK3zK7nqvqs/6qfz4QvvvSm9PZ7bQZmHCNu7UijP+HVaSlXh5ysyrro
   g==;
X-CSE-ConnectionGUID: zUYaWQMjT2Kfh+aZ4B9tng==
X-CSE-MsgGUID: StBThmVJTwGEbkEf+qbh+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11513"; a="56857148"
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="56857148"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 00:20:50 -0700
X-CSE-ConnectionGUID: 9FQ6EPbWTD69tHM1wnAD6g==
X-CSE-MsgGUID: qS9Exr2dSn2Z7BCb6QpWfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="165067393"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa009.fm.intel.com with ESMTP; 06 Aug 2025 00:20:47 -0700
Date: Wed, 6 Aug 2025 15:11:08 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Pavel Pisa <pisa@fel.cvut.cz>
Cc: Jason Gunthorpe <jgg@nvidia.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	linux-fpga@vger.kernel.org, Michal Simek <michal.simek@amd.com>,
	Xu Yilun <yilun.xu@intel.com>, Pavel Hronek <hronepa1@fel.cvut.cz>,
	Jiri Novak <jnovak@fel.cvut.cz>,
	Ondrej Ille <ondrej.ille@gmail.com>
Subject: Re: AMD/Xilinx Zynq FPGA manager stopped to work after
 6.16.0-g283564a43383
Message-ID: <aJMADNJ7ALUEyaaZ@yilunxu-OptiPlex-7050>
References: <CGME20250804134826eucas1p1350956e17ae463332a69eaa67dc2f8d7@eucas1p1.samsung.com>
 <aJI7juhONZp/8XfI@yilunxu-OptiPlex-7050>
 <20250805185235.GP184255@nvidia.com>
 <202508052140.00023.pisa@fel.cvut.cz>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202508052140.00023.pisa@fel.cvut.cz>

On Tue, Aug 05, 2025 at 09:39:59PM +0200, Pavel Pisa wrote:
> Hello all
> 
> On Tuesday 05 of August 2025 20:52:35 Jason Gunthorpe wrote:
> > On Wed, Aug 06, 2025 at 01:12:46AM +0800, Xu Yilun wrote:
> > > @@ -405,12 +405,12 @@ static int zynq_fpga_ops_write(struct fpga_manager
> > > *mgr, struct sg_table *sgt) }
> > >         }
> > >
> > > -       priv->dma_nelms =
> > > -           dma_map_sgtable(mgr->dev.parent, sgt, DMA_TO_DEVICE, 0);
> > > -       if (priv->dma_nelms == 0) {
> > > +       err = dma_map_sgtable(mgr->dev.parent, sgt, DMA_TO_DEVICE, 0);
> > > +       if (err) {
> > >                 dev_err(&mgr->dev, "Unable to DMA map (TO_DEVICE)\n");
> > > -               return -ENOMEM;
> > > +               return err;
> > >         }
> > > +       priv->dma_nelms = sgt->nents;
> >
> > That looks pretty good, Marek is certainly right the original had a
> > bug.
> >
> > Jason
> 
> Thanks for the fast correction proposal. I have tested the change
> at our kernel build, actual mainline version form midnight
> rebuild with patch now
> 
>   Linux mzapo 6.16.0+ #2 SMP Tue Aug  5 20:59:36 CEST 2025 armv7l GNU/Linux
> 
> and it works correctly, DTBOCFG and FPGA manager is able to load
> CTU CAN FD IP core design and then driver is loaded and its instances
> are setup according to the device tree overlay and driver detects
> CAN controllers implemented in FPGA. I have not run whole CAN test
> sequence but I do not expect problems there. You can add my
> 
> Reported-by: Pavel Pisa <pisa@fel.cvut.cz>
> Tested-by: Pavel Pisa <pisa@fel.cvut.cz>
> 
> Do you have some idea how fast can the change propagate
> into mainline? I would setup automatic patching with

I've sent the patch to Greg, lets see how to fix it.

https://lore.kernel.org/linux-fpga/20250806070605.1920909-1-yilun.xu@linux.intel.com/

Thanks,
Yilun

> the fix if the testing setup is broken for some longer time.
> If the fix can get in mainline in days or week then I would
> spent time on that.
> 
> Best wishes,
> 
>                 Pavel
> 
>                 Pavel Pisa
>     phone:      +420 603531357
>     e-mail:     pisa@cmp.felk.cvut.cz
>     Department of Control Engineering FEE CVUT
>     Karlovo namesti 13, 121 35, Prague 2
>     university: http://control.fel.cvut.cz/
>     personal:   http://cmp.felk.cvut.cz/~pisa
>     social:     https://social.kernel.org/ppisa
>     projects:   https://www.openhub.net/accounts/ppisa
>     CAN related:http://canbus.pages.fel.cvut.cz/
>     RISC-V education: https://comparch.edu.cvut.cz/
>     Open Technologies Research Education and Exchange Services
>     https://gitlab.fel.cvut.cz/otrees/org/-/wikis/home

