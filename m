Return-Path: <linux-fpga+bounces-1371-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD40BBCFE6
	for <lists+linux-fpga@lfdr.de>; Mon, 06 Oct 2025 05:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEDD33B164F
	for <lists+linux-fpga@lfdr.de>; Mon,  6 Oct 2025 03:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096CF1519A6;
	Mon,  6 Oct 2025 03:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rf1HUhv7"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABEF182B4
	for <linux-fpga@vger.kernel.org>; Mon,  6 Oct 2025 03:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759719763; cv=none; b=mURnttwe6Y+uJYd7IwlG4wNdSfFtMOVo8HmG9OJTYSF5qpmS6T6zpmvWHcIIdJ9B45fhPnPyXj4Q7+DJUNppVipRwatMJfYt6VyL/ulxQIqg9RnB3WGpwoXKmapCy28sB6tuG/illgyWNO17zBpKfvbUmIBysuRret05HKClvgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759719763; c=relaxed/simple;
	bh=7/MzfAKKPR3x+xwvBADz1ifl1hhM3/QIpIlt+fOr6no=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kQ/uSXtUXQiLmm6cg6cjgrnpFNCfais5p5nuiW2luScskddXiUCyem63YX38ylQBBGmL+de1HhkG701/x2AsClhN0Zuka+mIWwDEOPl4/w8CblFmr5bZB2CMKaZqS4Rr3zGibx3sm+K9zV185bDjM5Ax3DBq1MVMrGoKr9QRYVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rf1HUhv7; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759719763; x=1791255763;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7/MzfAKKPR3x+xwvBADz1ifl1hhM3/QIpIlt+fOr6no=;
  b=Rf1HUhv7rERaxkaeIfDti+hAERkUBBZSs5Sa8GaGMlD6cRrhQ5ygdE8W
   7v5R47wMhNVVWKt51LqXGN6Nn1NGpjuzokm+zlSteDIByGiNS6FdESU97
   hYOqm73G8m7WahKJmuHOhGRVrp/OI/yg7fb7ClqeRCtHBJdvMh3RETvB7
   WjqLW7vEkFa7/xqoo9MRdAyO4Sv618F+N6NRSyd5D1tmtABqk9SmS7kJz
   VSMQVx7wif4VmY5oiXYlQDHaw6LeqH5+n54jY/+QGCApR+F7uLAhHQTWe
   YT5N2ddVcwAkmJR/oEGT0gRwmL8pi2eJDcIyfOsPNCUuQ+BLD3P2XqaY9
   A==;
X-CSE-ConnectionGUID: hyDn1m1nR4G+/RH5RO68OQ==
X-CSE-MsgGUID: ZzifGWUNQ+KVq5PkfAMF+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="65722625"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="65722625"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2025 20:02:42 -0700
X-CSE-ConnectionGUID: 52w3dXQBTnOWDO8P+R1x5w==
X-CSE-MsgGUID: xqSSA5saT/Csq7YS19odSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,319,1751266800"; 
   d="scan'208";a="210737547"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa001.fm.intel.com with ESMTP; 05 Oct 2025 20:02:39 -0700
Date: Mon, 6 Oct 2025 10:50:01 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Koen Beel <koen.beel@b-kalm.com>
Cc: Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>, Michal Simek <michal.simek@amd.com>,
	linux-fpga@vger.kernel.org
Subject: Re: [PATCH] fpga: zynq-fpga: fix setting pcap to max speed
Message-ID: <aOMuWfxDkkjdfNGt@yilunxu-OptiPlex-7050>
References: <aN5zF8iaKlPqL9pZ@nuc>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aN5zF8iaKlPqL9pZ@nuc>

On Thu, Oct 02, 2025 at 02:41:59PM +0200, Koen Beel wrote:
> The PCAP interface should be set to max speed if the bitstream is not
> encrypted.
> The code comments mention this should be done, but it wasn't the case.

Use 'fixes' tag and Cc stable kernel if it is a BUG.

> On my board, this fixes failure of programming the (non-encrypted)
> bitstream.

Could you elaborate on the details of the failure, rather than just "on
my board it fails".

> 
> Signed-off-by: Koen Beel <koen.beel@b-kalm.com>
> ---
>  drivers/fpga/zynq-fpga.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
> index b7629a0e4813..1872ce05b566 100644
> --- a/drivers/fpga/zynq-fpga.c
> +++ b/drivers/fpga/zynq-fpga.c
> @@ -354,8 +354,8 @@ static int zynq_fpga_ops_write_init(struct fpga_manager *mgr,
>  				 | CTRL_PCAP_RATE_EN_MASK | ctrl));
>  	else
>  		zynq_fpga_write(priv, CTRL_OFFSET,
> -				(CTRL_PCAP_PR_MASK | CTRL_PCAP_MODE_MASK
> -				 | ctrl));
> +				(CTRL_PCAP_PR_MASK | CTRL_PCAP_MODE_MASK | ctrl)
> +				 & ~CTRL_PCAP_RATE_EN_MASK);

So do you mean the CTRL_PCAP_RATE_EN_MASK bit is already set in 'ctrl' when
you read it out?

And it is harder for me to always check all masks for both
encrypted/non-encrypted cases.  Only the CTRL_PCAP_RATE_EN_MASK is
different so if the following works for you:

------------8<--------------
diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
index b7629a0e4813..497ed4958b0a 100644
--- a/drivers/fpga/zynq-fpga.c
+++ b/drivers/fpga/zynq-fpga.c
@@ -348,15 +348,10 @@ static int zynq_fpga_ops_write_init(struct fpga_manager *mgr,
         * - set CPU in user mode
         */
        ctrl = zynq_fpga_read(priv, CTRL_OFFSET);
-       if (info->flags & FPGA_MGR_ENCRYPTED_BITSTREAM)
-               zynq_fpga_write(priv, CTRL_OFFSET,
-                               (CTRL_PCAP_PR_MASK | CTRL_PCAP_MODE_MASK
-                                | CTRL_PCAP_RATE_EN_MASK | ctrl));
-       else
-               zynq_fpga_write(priv, CTRL_OFFSET,
-                               (CTRL_PCAP_PR_MASK | CTRL_PCAP_MODE_MASK
-                                | ctrl));
-
+       ctrl |= CTRL_PCAP_PR_MASK | CTRL_PCAP_MODE_MASK;
+       FIELD_MODIFY(CTRL_PCAP_RATE_EN_MASK, &ctrl,
+                    (info->flags & FPGA_MGR_ENCRYPTED_BITSTREAM) ? 1 : 0);
+       zynq_fpga_write(priv, CTRL_OFFSET, ctrl);

        /* We expect that the command queue is empty right now. */
        status = zynq_fpga_read(priv, STATUS_OFFSET);

>  
>  
>  	/* We expect that the command queue is empty right now. */
> -- 
> 2.51.0
> 
> 

