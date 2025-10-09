Return-Path: <linux-fpga+bounces-1373-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A15ABC7C61
	for <lists+linux-fpga@lfdr.de>; Thu, 09 Oct 2025 09:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB4CF1889E05
	for <lists+linux-fpga@lfdr.de>; Thu,  9 Oct 2025 07:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E13B92DF68;
	Thu,  9 Oct 2025 07:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g6CuS2R6"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4C834BA49
	for <linux-fpga@vger.kernel.org>; Thu,  9 Oct 2025 07:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759996229; cv=none; b=BAh9su53y803o3o/0UAkbeyefiCfUbnfrW3/3vzm9pgdpTDsk2bnSk237ac1dsL1KH3SC5J2BflCeF95bcwgEADWX+4eQDSRYVtVnPWrWJqjXAd895Fs1glMdnsEMkgAZ1FedWUMQbhot4IturGx+qtntS05BT0//U3Vz4T6ZOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759996229; c=relaxed/simple;
	bh=WCJLGRS+hSgZI9givwSs8DJW5iJo4PI+tXh6R/Iz7Mw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JFA6EUOD1m+LYYMZPnYnAUGZ4CBpJMyGykh18gVpMWSBR+rbATuWOx9r3mEC2dj9IOHGw47PivZDIUY4fKdwOoSugqdzk0EvHfesQCLsAbAubUvErmiZ9WcyLCRB9R+CuuSVnbT4FNG7XVSIEOaX0SHhKxXa/pqtCYnDAf7ucWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g6CuS2R6; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759996227; x=1791532227;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=WCJLGRS+hSgZI9givwSs8DJW5iJo4PI+tXh6R/Iz7Mw=;
  b=g6CuS2R62FRnasW8/L6ftu/MlguZhTCk4JW7wYxY1U8M1h+RkSkbNtqt
   xwRAjq8Z3T3mEgcY91Xifwt5AIrs85xmY3CBvRGantHWNi4zPGZrbl0zw
   QJgWDQdLCzGmY7uNHcFF7VQECuONArw5WYwubMymLnLgr8hT8ADYzVzPG
   I8iKchFjFVGUrxuxqeI2TdtGIkjl9WM1t2DCNh/Pa064HghUA6fFEyFOC
   Pvu/XG7YPLkGXNRiBPRrmxzAvuzPZMty7mfL/GVa/QE2LNLVB2L7mcvii
   R1T54nOD4YA1V+BFy8dTQogDESh7deP47p6IZhQ/irTGP30jW6P6pYIRj
   g==;
X-CSE-ConnectionGUID: nsFjt2XXRHqLN9LlXfnioA==
X-CSE-MsgGUID: GMpCBvxXQwuxM0edVrr2zA==
X-IronPort-AV: E=McAfee;i="6800,10657,11576"; a="62105531"
X-IronPort-AV: E=Sophos;i="6.19,215,1754982000"; 
   d="scan'208";a="62105531"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2025 00:50:27 -0700
X-CSE-ConnectionGUID: CtIkTI4NSfqFM/MrTbIQJQ==
X-CSE-MsgGUID: BGs5uT7ITjqaaPlKI5em1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,215,1754982000"; 
   d="scan'208";a="180463625"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa007.jf.intel.com with ESMTP; 09 Oct 2025 00:50:25 -0700
Date: Thu, 9 Oct 2025 15:37:36 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Koen Beel <koen.beel@b-kalm.com>
Cc: Michal Simek <michal.simek@amd.com>, Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
	linux-fpga@vger.kernel.org
Subject: Re: [PATCH] fpga: zynq-fpga: fix setting pcap to max speed
Message-ID: <aOdmQDEt7WkimwlE@yilunxu-OptiPlex-7050>
References: <aN5zF8iaKlPqL9pZ@nuc>
 <aOMuWfxDkkjdfNGt@yilunxu-OptiPlex-7050>
 <CACaJORV1ZtLcTmUnDgDBafZ5RtbUnkphUr-=QvLL23A2kLC2xQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACaJORV1ZtLcTmUnDgDBafZ5RtbUnkphUr-=QvLL23A2kLC2xQ@mail.gmail.com>

On Mon, Oct 06, 2025 at 07:06:29PM +0200, Koen Beel wrote:
>    Hi Xu,
>    Thanks for the feedback.

Please don't top posting, instead reply inline.

> 
>    I just checked, and this bug has always been there in zynq-fpga.c
>    So I could add:
>        Fixes: 37784706bf9e ("fpga manager: Adding FPGA Manager support for
>    Xilinx Zynq 7000")
>    but does this make it any more clear? It just feels kind of strange to add
>    a fixes tag for such an old commit (that was the initial commit for this
>    driver).
>    This commit will be 10 years old next week, so I honestly doubt this patch
>    fixes a critical bug that needs to go into stable.

It's not about the time. The driver is in stable so should be
maintained if there is a BUG.

> 
>    Some more details about the failure:
>    Fpga programming for non-secure bitstreams is broken, unless some
>    bootloader changes the reset value of PCAP_RATE_EN.
>    This is the error I get (after which the bitstream is _not_ programmed):
>        # echo fpga.bin > /sys/class/fpga_manager/fpga0/firmware
>        fpga_manager fpga0: writing fpga.bin to Xilinx Zynq FPGA Manager
>        fpga_manager fpga0: Error after writing image data to FPGA
>        sh: write error: Connection timed out

As you are contributing to the driver code, please tell what's the
failure inside the driver.

> 
>    My board is a Trenz TE0715 + custom carrier board.
>    Now also tested on a standard ZedBoard. Same bug behavior and patch also
>    fixes this.
>    Can't test secure bitstreams here (don't have any).
> 
>    According to the "Zynq 7000 SoC Technical Reference Manual (UG585)" the
>    reset value of the register XDCFG_CTRL_OFFSET (0xF8007000) should be
>    0x0C006000
>    So XDCFG_CTRL_PCAP_RATE_EN_MASK should have a reset value of 0.
>    However, I tested on both my board and ZedBoard, and the actual reset
>    value of this register seems to be 0x4E00E07F ... (strange, AMD?)
>    So this PCA_RATE_EN_MASK (bit 25) is actually already set (=1) at bootup.
>    (I don't have a hardware debugger, but print this value very early in
>    uboot SPL, right after debug_uart init, and have checked this register
>    value is not overwritten by ps7_init).
> 
>    And yes, this bit is also still set when reading XDCFG_CTRL_OFFSET in
>    zynq-fpga.c
>    Ok, the problem I have is a timeout when writing the bitstream, and this
>    timeout should not happen even if the bitstream write speed is reduced to
>    25% (PCAP_RATE_EN = 1 does this), unless it's a HW problem.
>    So this timeout may be another bug to look into, but at least this fix is
>    a workaround for that timeout, and it's also a valid fix for an actual bug
>    imo.
> 
>    Someone else able to test this? And test with secure bitstreams?
> 
>    No idea if this timeout has always been there, but I assume things have
>    ever worked without this timeout problem for zynq-fpga.
>    And I assume I'm not the only one having this problem, but I know Xilinx
>    FSBL does reset this bit (=0) when writing a bitstream before starting
>    uboot. And doing this hides this bug in zynq-fpga. No idea who is using
>    xlnx fsbl and use it to write a bitstream before uboot, but I assume many
>    people, since this is the "default option".
> 
>    Anyway, I don't think it's sane to just assume a register has a certain
>    value and just depend on it.

Yeah, this is the problem I see and want it fixed. It tries to zero the
bit in non-encrypted case but failed to do so.

> 
>    I'm ok with the proposed change. That's indeed more clear. Should I send a
>    v2?

Yes, please.

Thanks,
Yilun

