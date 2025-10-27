Return-Path: <linux-fpga+bounces-1393-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D338C0BB95
	for <lists+linux-fpga@lfdr.de>; Mon, 27 Oct 2025 04:05:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C42173B5C26
	for <lists+linux-fpga@lfdr.de>; Mon, 27 Oct 2025 03:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 952CC1AC88A;
	Mon, 27 Oct 2025 03:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GoJqlj8I"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64ECE153598
	for <linux-fpga@vger.kernel.org>; Mon, 27 Oct 2025 03:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761534307; cv=none; b=TxTU1oXDVCJHkh4Qa/7zwo4qJjbuzsX7DAGd14G+Bl33N1OXbYI+BmKJz29nGLOhrjbWl0Yb0odJTJswvpkFSN73hARncDGzm0pHqA9zNxunuWAKH9P07n6tkDGwQhRwaLoOmC+G/J/+vowlXKLnuBaMiLltbwGHb+l2UcHsjW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761534307; c=relaxed/simple;
	bh=/8ps546V95G2iuJaZo95YS1yBEjVmIgioBsefI9iZ4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uvwz3PTmkIeM2vzLakt9IU4SrvxVo96NppEDSQPTSxzsYtpOTYkyzy/J4/n67Ni5gNBKIWpDJlKjPWXSGVDBjGOPIGJOU+/V20rXwve78Kpa52QV29F/KwBh5sb+DzbvPTEZpZYEPJSZ80maaCwP0HpYHlRNT8qrGEsZ+Jpo8hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GoJqlj8I; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761534305; x=1793070305;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/8ps546V95G2iuJaZo95YS1yBEjVmIgioBsefI9iZ4w=;
  b=GoJqlj8IYqX4M4DaUBGB2QTJiDA4XsRgmgesKB59YzuUKqOsg9fkPI+Q
   GMlUbJfpZPM5kx+tiwYczPc98kFEbldOy6ua9QosMC0knRqM+nSr5andS
   EcOpVJVj5TvDf3GBvTe72i+TaYgUMdBBR+JtjTGNWrj2Nvye0n4ZUb5cv
   kdysKZQe05XOE01VwjZ5I1otEgvuqeHXkDfi8RpFlETIzq5HWEtoR9L8S
   zNHbtAPegvutFAFeo/QGbvT4LAN9Vkai392/o6q12HZfhrkNCchnQ4GmF
   NGA55KCcLeksbX126g7VxSVrjtuOhqHbO27MxgTNqpCAaYBwvA5hTY1Th
   w==;
X-CSE-ConnectionGUID: voRlxOlySRy1l2kSvGksvA==
X-CSE-MsgGUID: g6zu2qJkTXimnBDbDS8ELg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="66225846"
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; 
   d="scan'208";a="66225846"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2025 20:05:04 -0700
X-CSE-ConnectionGUID: LQWCzKrQT9mWgA0zARSERQ==
X-CSE-MsgGUID: ZPByidxpTym3+GwCv9zTyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; 
   d="scan'208";a="184822231"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa006.fm.intel.com with ESMTP; 26 Oct 2025 20:05:02 -0700
Date: Mon, 27 Oct 2025 10:51:22 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Koen Beel <koen.beel@b-kalm.com>
Cc: Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>, Michal Simek <michal.simek@amd.com>,
	linux-fpga@vger.kernel.org
Subject: Re: [PATCH v2] fpga: zynq-fpga: fix setting pcap to max speed
Message-ID: <aP7eKgFWIYGbJU5z@yilunxu-OptiPlex-7050>
References: <aPucBU9cUsUmbMRI@nuc>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPucBU9cUsUmbMRI@nuc>

On Fri, Oct 24, 2025 at 05:32:21PM +0200, Koen Beel wrote:
> The PCAP interface should be set to max speed if the bitstream is not

Imperative mood please.

> encrypted. The code comments also show this was the original intended
> behavior.

Please explicitly state your change in the first paragraph, even if it
is already stated in your subject.

> 
> According to the "Zynq 7000 SoC Technical Reference Manual (UG585)" the

Add the Link please.

> reset value of the devcfg control register (XDCFG_CTRL_OFFSET) should be
> 0x0C006000,

Delete the magic number, no value to reviewers.

> so CTRL_PCAP_RATE_EN_MASK (bit 25) should be 0 (= max speed)
> at bootup.
> However, the devcfg control register reset value seems to be different
> in reality, and CTRL_PCAP_RATE_EN_MASK seems to be 1 (= reduced speed)
> at bootup.

seems to be? Please be confirmative. And be clear what happens, why the
difference.

And please state what's the issue because of the difference?

> 
> On top, I don't think it's sane for the driver to just assume a register

Again, imperative mood and avoid avoid pronouns.

Please read the Documentation/process/ to gain a general understanding
for upstreaming, thanks.

> has a certain initial value and depend on it.

According to the code comment below, I don't see the intent of "assume
& depend on the initial value". Anyway, no need to bother about that. Just
say the fact, it fails to clear the CTRL_PCAP_RATE_EN_MASK bit when not
encrypted.

> 
> Fixes: 37784706bf9e ("fpga manager: Adding FPGA Manager support for Xilinx Zynq 7000")
> Cc: stable@vger.kernel.org
> Signed-off-by: Koen Beel <koen.beel@b-kalm.com>
> ---
>  drivers/fpga/zynq-fpga.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
> index b7629a0e4813..83030ec1f376 100644
> --- a/drivers/fpga/zynq-fpga.c
> +++ b/drivers/fpga/zynq-fpga.c
> @@ -344,19 +344,14 @@ static int zynq_fpga_ops_write_init(struct fpga_manager *mgr,
>  
>  	/* set configuration register with following options:
>  	 * - enable PCAP interface
> -	 * - set throughput for maximum speed (if bistream not encrypted)
> +	 * - set throughput for maximum speed (if bitstream not encrypted)
>  	 * - set CPU in user mode
>  	 */
>  	ctrl = zynq_fpga_read(priv, CTRL_OFFSET);
> -	if (info->flags & FPGA_MGR_ENCRYPTED_BITSTREAM)
> -		zynq_fpga_write(priv, CTRL_OFFSET,
> -				(CTRL_PCAP_PR_MASK | CTRL_PCAP_MODE_MASK
> -				 | CTRL_PCAP_RATE_EN_MASK | ctrl));
> -	else
> -		zynq_fpga_write(priv, CTRL_OFFSET,
> -				(CTRL_PCAP_PR_MASK | CTRL_PCAP_MODE_MASK
> -				 | ctrl));
> -
> +	ctrl |= CTRL_PCAP_PR_MASK | CTRL_PCAP_MODE_MASK;
> +	FIELD_MODIFY(CTRL_PCAP_RATE_EN_MASK, &ctrl,

Do we need the head file?

Thanks,
Yilun

> +		     (info->flags & FPGA_MGR_ENCRYPTED_BITSTREAM) ? 1 : 0);
> +	zynq_fpga_write(priv, CTRL_OFFSET, ctrl);
>  
>  	/* We expect that the command queue is empty right now. */
>  	status = zynq_fpga_read(priv, STATUS_OFFSET);
> -- 
> 2.51.0
> 
> 
> 
> 
> 
> 

