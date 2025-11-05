Return-Path: <linux-fpga+bounces-1424-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE50C367C6
	for <lists+linux-fpga@lfdr.de>; Wed, 05 Nov 2025 16:53:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFE74189DA21
	for <lists+linux-fpga@lfdr.de>; Wed,  5 Nov 2025 15:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C912686A0;
	Wed,  5 Nov 2025 15:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hTo/7DOc"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8995F2192EA;
	Wed,  5 Nov 2025 15:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762357165; cv=none; b=h8pDFsDoKO6dWuRlRce2tQpqVI0HyMVQg1eIr4xNZePJSwn1UwrTcoRmlKUXW1k9DS6dZ8xPTpB/fLeHndxspu2I1A3t19aVnvHeA/yaxXs+vzF2jZ7Lm9PGB0zv4c3Z3yMlSope1pKI7tJaimx7RY7rFNKCYFWjnXhDY+F3/bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762357165; c=relaxed/simple;
	bh=WukabtLnZGMGot7G3S7/zEVenEgLCJDmSN4BvMbvwBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iIFRpnP0hyir3kn5AvcVfvJO6kk/035alK5HHNHIiiTweNk5XdAoCpLgHgJnBneesUVFrnmbqqiXN6pltU1QfCSrDs1SDCkZyfSOYQGxByYw/i7jnnITuPb5m/ilnYu6bs7hulttFeF4in7IWMn0dYND4tLb0YbxOijJ019nsfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hTo/7DOc; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762357163; x=1793893163;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WukabtLnZGMGot7G3S7/zEVenEgLCJDmSN4BvMbvwBY=;
  b=hTo/7DOckZNZxDx1ausqbOKG5IqtaZDyIGyEcykY4XjGdI0q2ALwTfjN
   AfjY+hMuyY2E5i/jtWjgu4S4vMVaLt1EOC45BU8xKXcH5+v5QKe4b0G0f
   L6/LXJfpZcZWYj09TXsBWxLlenuPLYRuDcBYdfb5MdWh+8XWPiZddCno8
   pDIjDKRHRaXYpfFtZBrUESXAGZtaMP0sp4fzLJr3pvN55Ofd8N4NH9qsH
   8An7aMeF3ZSL8rS+jr4LHb4J3jsN6j378wAJz4wzBSw51fP+ry0AMJjth
   TtJae3azpGndZD1Tx8DbnBgciXswCmy7ioNqRMnVJX4cPmtP9FJ4z949L
   w==;
X-CSE-ConnectionGUID: 6MGoDgfQTaie7ryedQkFDw==
X-CSE-MsgGUID: MbVFUMz+S2KMnZAgBPjHyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64382338"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="64382338"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 07:39:23 -0800
X-CSE-ConnectionGUID: 1sqEtvIURXaUbMV2pWVvEA==
X-CSE-MsgGUID: Ml4wtkr+SF2xVuV9z4J6LQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,282,1754982000"; 
   d="scan'208";a="186735852"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa006.jf.intel.com with ESMTP; 05 Nov 2025 07:39:08 -0800
Date: Wed, 5 Nov 2025 23:24:59 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: "Murugasen Krishnan, Kuhanh" <kuhanh.murugasen.krishnan@altera.com>
Cc: Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>,
	"linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND][PATCH 1/1] fpga: altera-cvp: Limit driver registration
 to specific device ID
Message-ID: <aQtsS378I+4dIRE6@yilunxu-OptiPlex-7050>
References: <cover.1761764670.git.kuhanh.murugasen.krishnan@altera.com>
 <0b6877dd7422e8c797bb42bf071fd85cf8a0af09.1761764670.git.kuhanh.murugasen.krishnan@altera.com>
 <aQhrYucpkGBWI2zL@yilunxu-OptiPlex-7050>
 <6a74af58-3b9b-4a8d-a10f-abbcd545083b@altera.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a74af58-3b9b-4a8d-a10f-abbcd545083b@altera.com>

On Wed, Nov 05, 2025 at 06:29:06AM +0000, Murugasen Krishnan, Kuhanh wrote:
> On 3/11/2025 4:44 pm, Xu Yilun wrote:
> > On Thu, Oct 30, 2025 at 03:05:44AM +0800, Kuhanh Murugasen Krishnan wrote:
> >> From: "Murugasen Krishnan, Kuhanh" <kuhanh.murugasen.krishnan@altera.com>
> > 
> > Is this your first post?
> > 
> > https://lore.kernel.org/all/20250212223553.2717304-1-kuhanh.murugasen.krishnan@intel.com/
> > 
> > Please mark the patch v2 if this patch is for the same issue. And please
> > firstly response the talk and make clear all previous concerns, rather than
> > just sent the patch and left.
> > 
> Thanks Yilun for your review. Yes that was the first post, however I do 
> not have access to my @intel email address anymore and had to resend 
> this with a better commit title and description for clearer explanation 
> of this patch. Apologies for the inconvenience.
> 
> >>
> >> The Altera CvP driver previously used PCI_ANY_ID, which caused it to
> >> bind to all PCIe devices with the Altera vendor ID. This led to
> >> incorrect driver association when multiple PCIe devices with different
> >> device IDs were present on the same platform.
> >>
> >> Update the device ID table to use 0x00 instead of PCI_ANY_ID so that
> >> the driver only attaches to the intended device.
> > 
> > So could you please answer the previous concern here?
> > 
> > Does dev_id 0x00 covers all supported devices? Do you have any DOC for
> > this?
> > 
> Yes it will connect to all supported Altera FPGA devices correctly, 

Because your change is trying to reduce the scope of devices the driver
could support. I want to be cautious and ask for Public Documentation
for reference. I don't want to see someone later yells "Oh, my device is
broken!".

Please also add the Link of the Documentation in changelog.

> there was a bug previously which caused incorrect driver association 

So this is a bug, please tag with "fixes:" and Cc stable kernel.

> with the use of PCI_ANY_ID. Limiting the driver registration to 0x00 
> allows the driver to attach to the intended Altera FPGA device correctly 
> since the FPGA default address is 0x00. Using PCI_ANY_ID could 
> potentially allow the CVP driver to associate to other PCI devices.
> 
> >>
> >> Reviewed-by: Dinh Nguyen <dinguyen@kernel.org>
> > 
> > I didn't see where the tag is from. Generally we don't prefer a
> > Reviewed-by tag firstly appear from other than the person named.
> > 
> > Thanks,
> > Yilun
> > 
> This patch was reviewed internally by Dinh and the tag was added. Should 
> I send a v2 patch with this "Reviewed-by" removed?

Yes, fix previous comments in your v2, and removes the Reviewed-by.
Reviewed-by is welcomed but should be publicly originated from the
named person.

Thanks,
Yilun

> 
> >> Signed-off-by: Ang Tien Sung <tien.sung.ang@altera.com>
> >> Signed-off-by: Murugasen Krishnan, Kuhanh <kuhanh.murugasen.krishnan@altera.com>
> >> ---
> >>   drivers/fpga/altera-cvp.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
> >> index 5af0bd33890c..97e9d4d981ad 100644
> >> --- a/drivers/fpga/altera-cvp.c
> >> +++ b/drivers/fpga/altera-cvp.c
> >> @@ -560,7 +560,7 @@ static int altera_cvp_probe(struct pci_dev *pdev,
> >>   static void altera_cvp_remove(struct pci_dev *pdev);
> >>   
> >>   static struct pci_device_id altera_cvp_id_tbl[] = {
> >> -	{ PCI_VDEVICE(ALTERA, PCI_ANY_ID) },
> >> +	{ PCI_VDEVICE(ALTERA, 0x00) },
> >>   	{ }
> >>   };
> >>   MODULE_DEVICE_TABLE(pci, altera_cvp_id_tbl);
> >> -- 
> >> 2.25.1
> >>
> >>
> 

